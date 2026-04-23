{% macro grant_select(schema= target.schema, role = target.role, database = target.database) %}
    {% set sql %}
        USE DATABASE {{ database }};
        GRANT USAGE ON SCHEMA {{ database }}.{{ schema }} TO {{ role }};
        GRANT SELECT ON ALL TABLES IN SCHEMA {{ database }}.{{ schema }} TO {{ role }}; 
        GRANT SELECT ON ALL VIEWS IN SCHEMA {{ database }}.{{ schema }} TO {{ role }};
    {% endset %}
    {% do log( 'GRANTING SELECT ON SCHEMA' ~ schema ~ ' to  role ' ~ role , info=True) %}
    {% do run_query(sql) %}
    {% do log( 'FINISHED GRANTING SELECT ON SCHEMA' ~ schema ~ ' to  role ' ~ role , info=True) %}
{% endmacro%}