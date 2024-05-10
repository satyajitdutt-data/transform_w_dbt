SELECT 
    customers.c_custkey, 
    customers.c_name, 
    SUM(line_items.extended_price * (1 - line_items.discount_amount_usd)) AS revenue, 
    customers.c_acctbal, 
    nations.n_name, 
    customers.c_address, 
    customers.c_phone
FROM {{ ref('stg_tpch__customers')}} customers 
LEFT JOIN {{ ref('stg_tpch__orders')}} orders 
    ON customers.c_custkey = orders.c_custkey
LEFT JOIN {{ ref('stg_tpch__line_items')}} line_items 
    ON orders.order_key = line_items.order_key 
LEFT JOIN {{ ref('stg_tpch__nations') }} nations 
    ON customers.c_nationkey = nations.n_nationkey 
WHERE orders.order_date < CURRENT_DATE
    AND orders.order_date >= CURRENT_DATE - interval '3' month
    AND line_items.return_flag_code = 'R'
GROUP BY
    customers.c_custkey,
    customers.c_name, 
    customers.c_acctbal, 
    nations.n_name, 
    customers.c_address, 
    customers.c_phone