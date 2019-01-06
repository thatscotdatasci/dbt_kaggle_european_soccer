{% macro get_match_results(location) %}
    {{ log("Running macro get_match_results with arguments: location: " ~ location) }}

    {%- set location_not = 'away' if location == 'home' else 'home' -%}

    select match_api_id, date::date,
    {{ location }}_team_api_id as team_api_id,
    {{ 1 if location == 'home' else 0 }} as home,
    {{ location }}_team_goal as goals_scored,
    {{ location_not }}_team_goal as goals_conceded,
    {{ determine_match_result(location) }} as result
    from "Match"
{% endmacro %}

{% macro determine_match_result(location) %}
    {{ log("Running macro determine_match_result with arguments: location: " ~ location) }}

    {%- set location_not = 'away' if location == 'home' else 'home' -%}

    case when {{ location }}_team_goal < {{ location_not }}_team_goal then 0
         when {{ location_not }}_team_goal < {{ location }}_team_goal then 1
         else 2 end
{% endmacro %}