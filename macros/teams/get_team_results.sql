{% macro get_team_results(result) %}
    {{ log("Running macro get_team_results with arguments: result: " ~ result) }}

    select team_api_id, count(result) as {{ result }}
    from {{ ref('match_results') }}
    where result = (select category from {{ ref('result_categories') }} where result = '{{ result }}')
    group by team_api_id

{% endmacro %}
