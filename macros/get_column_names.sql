{% macro get_column_names(schema, table) %}
    {{ log("Running macro get_column_names with arguments: schema: " ~ schema ~ ", table: " ~ table) }}

    {%- call statement('column_names', fetch_result=True) -%}

        SELECT *
        FROM information_schema.columns
        WHERE table_schema = '{{schema}}'
        AND table_name = '{{table}}'

    {%- endcall -%}

    {{ return(parse_result(load_result('column_names'), 'column_name')) }}
{% endmacro %}