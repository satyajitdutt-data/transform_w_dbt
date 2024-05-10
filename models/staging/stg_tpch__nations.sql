-- write staging model following best practices and coventions outlined in style guide
SELECT * FROM {{ source('tpch_sf1', 'nation') }}
-- be sure to also update any downstream dependencies