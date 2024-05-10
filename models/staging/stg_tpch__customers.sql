-- write staging model following best practices and coventions outlined in style guide
SELECT * FROM {{ source('tpch_sf1', 'customer') }}
-- be sure to also update any downstream dependencies