with source as (

    select * from {{ source('stripe', 'payment') }}

),

renamed as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        {{ cents_to_dollars('amount') }} as amount,
        status,
        created as created_at,
        _batched_at

    from source

)

select * from renamed