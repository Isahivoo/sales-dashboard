-- public.vw_sales source

CREATE OR REPLACE VIEW public.vw_sales
AS SELECT oi.order_item_id,
    oi.order_id,
    o.order_date,
    c.customer_id,
    c.first_name,
    c.last_name,
    l.city,
    l.state,
    l.country,
    l.region,
    p.product_name,
    p.category_name,
    oi.order_quantity,
    oi.sales_per_order,
    oi.profit_per_order,
    oi.order_item_discount
   FROM order_items oi
     JOIN orders o ON oi.order_id::text = o.order_id::text
     JOIN customers c ON o.customer_id::text = c.customer_id::text
     JOIN locations l ON c.location_id = l.location_id
     JOIN products p ON oi.product_id = p.product_id;