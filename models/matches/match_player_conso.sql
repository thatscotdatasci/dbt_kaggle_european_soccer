{%- set match_columns = ["id", "date", "match_api_id", "home_team_api_id", "away_team_api_id", "home_team_goal", "away_team_goal"] -%}
{%- set match_columns_text = match_columns|join(', ') -%}
{%- set match_categories = get_ref_column_data(ref('match_categories'), 'category')  -%}

select {{ match_columns_text }}, player_api_id from (
{%- for side in match_categories %}
    {%- for position in player_numbers() %}
        (select {{ match_columns_text }}, "{{side}}_player_{{position}}" as player_api_id from "Match")
        {% if not loop.last %}union all{% endif %}
    {%- endfor -%}{% if not loop.last %} union all {% endif %}
{%- endfor -%}
) r
where player_api_id is not null