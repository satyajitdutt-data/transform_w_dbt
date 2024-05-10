SELECT 
    o_orderkey AS order_key, 
    o_custkey AS customer_key, 
    o_orderstatus AS order_status_code, 
    o_totalprice AS total_price_usd, 
    o_orderdate::date AS order_date,
    o_orderpriority AS order_priority, 
    o_clerk AS clerk, 
    o_shippriority AS ship_priority_code
FROM {{ source('tpch_sf1', 'orders') }}