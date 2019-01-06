{% macro player_numbers() %}
    {{ return(range(1,12)) }}
{% endmacro %}

{% macro parse_result(result, column) %}
    {%- if result is none -%}
        {{ return([]) }}
    {%- endif -%}

    {{ return(result.table.columns[column].values()) }}
{% endmacro %}