{%- set column_names = get_column_names("public", "Player") -%}
{%- set match_categories = get_ref_column_data(ref('match_categories'), 'category')  -%}
{%- set player_numbers = range(1,12) -%}

select m.*,
{%- for side in match_categories -%}
    {%- for position in player_numbers -%}
        {%- for column in column_names -%}
            p_{{side}}_{{position}}.{{column}} as p_{{side}}_{{position}}_{{column}}{%- if not loop.last -%}, {%- endif %}
        {%- endfor -%}
        {% if not loop.last %}, {% endif %}
    {%- endfor -%}
    {% if not loop.last %}, {% endif %}{% if loop.last %} {% endif %}
{%- endfor -%}
from "Match" m
{% for side in match_categories -%}
    {% for position in player_numbers -%}
        left join "Player" p_{{side}}_{{position}}
        on m."{{side}}_player_{{position}}" = p_{{side}}_{{position}}."player_api_id"
    {% endfor -%}
{% endfor -%}