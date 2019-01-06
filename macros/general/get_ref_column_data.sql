{% macro get_ref_column_data(ref, column) %}
    {{ log("Running macro get_ref_column_data with arguments: ref: " ~ ref ~ ", column: " ~ column) }}

    {%- call statement('get_ref_column_data', fetch_result=True) -%}

        SELECT "{{ column }}"
        FROM {{ref}}

    {%- endcall -%}

    {{ return(parse_result(load_result('get_ref_column_data'), column)) }}
{% endmacro %}