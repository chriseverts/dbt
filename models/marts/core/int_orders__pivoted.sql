{%- set payment_method = [' bank_transer', 'coupon', 'credit_card', 'gift_card']-%}

with payments as (
    select * from {{ref('stg_payments')}}
),

pivoted as (
    select 
        orderid, 
        {% for paymentmethod in payment_method-%}
        sum(case when paymentmethod = '{{paymentmethod}}' then amount else 0 end) as {{paymentmethod}}_amount
        {%- if not loop.last-%}
            ,
        
        {%-endif%}
        {%endfor-%}
       
        
    from payments
    where status = 'success'
    group by 1
)

select * from pivoted