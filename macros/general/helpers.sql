{% macro player_numbers() %}
    {{ return(range(1,12)) }}
{% endmacro %}

{% macro parse_result(result, column) %}
    {%- if result is none -%}
        {{ return([]) }}
    {%- endif -%}

    {{ return(result.table.columns[column].values()) }}
{% endmacro %}

{% macro determine_bmi(col, ref) %}
    case
    when {{ col }} > (select overweight from {{ ref }} limit 1) THEN 'obese'
    when {{ col }} > (select healthy from {{ ref }} limit 1) THEN 'overweight'
    when {{ col }} > (select underweight from {{ ref }} limit 1) THEN 'healthy'
    else 'underweight'
    end
{% endmacro %}