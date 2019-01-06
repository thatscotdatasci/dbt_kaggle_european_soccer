{% macro get_match_results(home) %}
    {{ log("Running macro get_match_results with arguments: home: " ~ home) }}

    {%- set location = 'home' if home else 'away' -%}
    {%- set location_not = 'away' if home else 'home' -%}
    {%- set location_bool = 1 if home else 0 -%}

    select match_api_id, date::date,
    {{ location }}_team_api_id as team_api_id,
    {{ location_bool }} as home,
    {{ location }}_team_goal as goals_scored,
    {{ location_not }}_team_goal as goals_conceded,
    case when {{ location }}_team_goal < {{ location_not }}_team_goal then 0
         when {{ location_not }}_team_goal < {{ location }}_team_goal then 1
         else 2 end as result
    from "Match"
{% endmacro %}
