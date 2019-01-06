{% macro get_team_results(result, location) %}
    {{ log("Running macro get_team_results with arguments: result: " ~ result) }}

    select team_api_id, count(result) as {{ result }}{% if location in ['home', 'away'] %}_{{ location }}{% endif %}
    from {{ ref('match_results') }}
    where result = (select category from {{ ref('result_categories') }} where result = '{{ result }}')
    {% if location in ['home', 'away'] %}
        and home = {{ 1 if location == 'home' else 0 }}
    {% endif %}
    group by team_api_id
{% endmacro %}

{% macro get_team_results_location(result, location, order) %}
    {{ log("Running macro get_team_results_location with arguments: result: " ~ result ~ ", location: " ~ location ~ ", order: " ~ order) }}

    select *
    from
    (
        select team_api_id, match_api_id, date,
        ROW_NUMBER() OVER (PARTITION BY team_api_id ORDER BY date {{ order }}) rn
        from {{ ref('match_results') }}
        where result = (select category from {{ ref('result_categories') }} where result = '{{ result }}')
        and home = {{ 1 if location == 'home' else 0 }}
    ) a
    where rn=1
{% endmacro %}