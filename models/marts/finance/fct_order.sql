with orders as (
    select * from {{ ref('stg_jaffle_shop_orders') }}
),
payments as (
    select * from {{ ref('stg_stripe__payments') }}
),

orders_payments as (

    select 
       order_id,
       sum(case when status = 'succeeded' then amount else 0 end) as amount
    from payments 
),
final as (

    select 
        o.order_id,
        o.customer_id,
        o.order_date,
        coalesce(op.amount, 0) as amount
    from orders o 
    left join orders_payments op on o.order_id = op.order_id

)
select * from final