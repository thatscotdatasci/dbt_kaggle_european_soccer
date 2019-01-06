{%- set locations = ['home', 'away'] -%}
{%- set results = ['win', 'loss', 'draw'] -%}
{%- set orders = ['asc', 'desc'] -%}

select r.*,
{% for result in results -%}
    r_{{ result }}.{{ result }} as {{ result }},
    {%- for location in locations -%}
        r_{{ result }}_{{ location }}.{{ result }}_{{ location }} as {{ result }}_{{ location }},
        {%- for order in orders -%}
            r_{{ result }}_{{ location }}_{{ order }}.match_api_id as {{ result }}_{{ location }}_{{ order }}_match_api_id,
            r_{{ result }}_{{ location }}_{{ order }}.date::date as {{ result }}_{{ location }}_{{ order }}_date
            {%- if not loop.last %}, {% endif %}{% if loop.last -%} {%- endif -%}
        {%- endfor -%}
        {%- if not loop.last %}, {% endif %}{% if loop.last -%} {%- endif -%}
    {%- endfor -%}
    {%- if not loop.last %}, {% endif %}{% if loop.last -%} {%- endif -%}
{%- endfor %}
from (
    select team_api_id, count(team_api_id) as matches_played, sum(home) as home_matches_played
    from {{ ref('match_results') }}
    group by team_api_id
) r
{% for result in results %}
    join (
        {{ get_team_results(result, '') }}
    ) r_{{ result }}
    on r.team_api_id = r_{{ result }}.team_api_id
    {% for location in locations %}
        join (
            {{ get_team_results(result, location) }}
        ) r_{{ result }}_{{ location }}
        on r.team_api_id = r_{{ result }}_{{ location }}.team_api_id
        {% for order in orders %}
            join (
                {{ get_team_results_location(result, location, order) }}
            ) r_{{ result }}_{{ location }}_{{ order }}
            on r.team_api_id = r_{{ result }}_{{ location }}_{{ order }}.team_api_id
        {% endfor %}
    {% endfor %}
{% endfor %}