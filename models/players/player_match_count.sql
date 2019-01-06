{%- set results = get_ref_column_data(ref('result_categories'), 'result')  -%}

select r.player_api_id, r.match_count, r.first_played, r.last_played,
{% for result in results %}
    {{ result }}.{{ result }}{%- if not loop.last %}, {% endif %}{% if loop.last -%} {%- endif -%}
{% endfor %}
from (
    select player_api_id, count(player_api_id) as match_count, min(date)::date as first_played, max(date)::date as last_played
    from {{ ref('match_players') }}
    group by player_api_id
) r
{% for result in results %}
    left join (
        select player_api_id, count(player_api_id) as {{ result }} from {{ ref('match_players') }}
        where result = (select category from {{ ref('result_categories') }} where result = '{{ result }}')
        group by player_api_id
    ) {{ result }}
    on r.player_api_id = {{ result }}.player_api_id
{% endfor %}
