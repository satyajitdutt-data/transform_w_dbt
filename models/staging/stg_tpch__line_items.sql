SELECT 
    -- creates a unique key for line items 
    {{ dbt_utils.generate_surrogate_key(['l_orderkey ', 'l_linenumber']) }} AS line_item_key, 
    l_orderkey AS order_key, 
    l_partkey AS part_key, 
    l_suppkey AS supplier_key, 
    l_linenumber AS line_number, 
    ROUND(l_quantity, 0) AS item_quantity, 
    l_extendedprice AS extended_price_usd,
    l_discount AS discount_amount_usd, 
    l_tax AS tax_amount_usd, 
    l_returnflag AS return_flag_code, 
    l_linestatus AS line_status_code, 
    l_shipdate::date AS ship_date
FROM {{ source('tpch_sf1', 'lineitem') }}