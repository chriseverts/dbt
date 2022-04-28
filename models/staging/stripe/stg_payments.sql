with payments as (
  
  select
        id as payment_id,
        orderid,
        paymentmethod,
        status,

        {{cents_to_dollars('payment_amount', 4) }} amount,
        created

    from raw.stripe.payment

)

select * from payments
