
SELECT 
    c_custkey, 
    c_name, 
    c_address, 
    c_phone
FROM {{ ref('stg_tpch__customers') }}