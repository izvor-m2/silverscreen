with source as (

    select *
    from {{ source('silverscreen', 'NJ_003') }}

),

tickets_only as (

    select
        date_trunc('month', TIMESTAMP) as month,
        'NJ_003' as location,
        DETAILS as movie_id,
        AMOUNT as tickets_sold,
        TOTAL_VALUE as revenue
    from source
    where lower(PRODUCT_TYPE) = 'ticket'

)

select
    movie_id,
    month,
    location,
    sum(tickets_sold) as tickets_sold,
    sum(revenue) as revenue
from tickets_only
group by
    movie_id,
    month,
    location
