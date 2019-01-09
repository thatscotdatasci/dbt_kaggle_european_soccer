{%- set locations = get_ref_column_data(ref('match_categories'), 'category')  -%}

select player_api_id, match_api_id, date::date as date, team_api_id, opposition_team_api_id, home, result from (
{% for location in locations %}
    {% for position in player_numbers() %}
        (select {{location}}_player_{{position}} as player_api_id,
        match_api_id, date,
        {{ location }}_team_api_id as team_api_id,
        {{ 'away' if location == 'home' else 'home' }}_team_api_id as opposition_team_api_id,
        {{ 1 if location == 'home' else 0 }} as home,
        {{ determine_match_result(location) }} as result
        from "Match")
        {% if not loop.last %}union all{% endif %}
    {% endfor %}{% if not loop.last %} union all {% endif %}
{% endfor %}
) r
where player_api_id is not null