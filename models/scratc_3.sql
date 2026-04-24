{% set database = target.database %}
{% set schema = target.schema %}

    SELECT 
        CASE WHEN table_type = 'VIEW' THEN 'VIEW' ELSE 'TABLE' END AS object_type,
        'DROP ' || CASE WHEN table_type = 'VIEW' THEN 'VIEW' ELSE 'TABLE' END || ' IF EXISTS ' || '{{database}}' || '.' || table_schema || '.' || table_name || ';' AS drop_statement
    FROM {{ database }}.information_schema.tables
    WHERE table_schema = upper('{{ schema }}')
    AND date(last_altered) <= date(dateadd('day', -7, current_date()))