WITH 
orders_returns_removed AS (
    SELECT 
        order_key
    FROM {{ ref('stg_tpch__orders')}} orders
    -- only select orders that don't have items that have been returned
    WHERE NOT EXISTS (
        SELECT 
            1
        FROM {{ ref('stg_tpch__line_items')}} line_items 
        WHERE orders.order_key = line_items.order_key
            AND return_flag_code = 'R'
    )
)
SELECT * FROM orders_returns_removed