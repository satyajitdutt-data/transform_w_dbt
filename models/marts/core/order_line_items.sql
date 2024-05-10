WITH 
line_items_returns_removed AS (
    SELECT 
        line_item_key, 
        order_key, 
        part_key,
        supplier_key, 
        line_number, 
        item_quantity, 
        extended_price_usd,
        discount_amount_usd, 
        tax_amount_usd, 
        return_flag_code, 
        line_status_code, 
        ship_date
    FROM {{ ref('stg_tpch__line_items') }} 
    -- only select items that haven't been returned and have already been shipped 
    WHERE return_flag_code != 'R'
    AND ship_date < CURRENT_DATE
),

orders_joined_line_items AS (
    SELECT 
        orders.order_key, 
        line_items.line_item_key, 
        orders.order_priority, 
        orders.order_status_code,
        orders.total_price_usd, 
        line_items.item_quantity,
        line_items.return_flag_code,
        line_items.discount_amount_usd,
        line_items.extended_price_usd
    FROM {{ ref('stg_tpch__orders') }}  orders
    LEFT JOIN line_items_returns_removed line_items
        ON orders.order_key = line_items.order_key
),

item_quantity_summed AS (
    SELECT 
        order_key, 
        line_item_key, 
        order_priority, 
        order_status_code, 
        return_flag_code, 
        extended_price_usd * (1 - discount_amount_usd) AS revenue, 
        item_quantity, 
        SUM(item_quantity) OVER(PARTITION BY order_key) AS total_order_items,
        total_price_usd
    FROM orders_joined_line_items
)

SELECT * FROM item_quantity_summed
