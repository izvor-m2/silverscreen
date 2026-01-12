with source as (

    select *
    from {{ source('silverscreen', 'NJ_001') }}

),

prepared as (

    select
        MOVIE_ID as movie_id,
        date_trunc('month', TIMESTAMP) as month,
        'NJ_001' as location,
        TICKET_AMOUNT as tickets_sold,
        TRANSACTION_TOTAL as revenue
    from source

)

select
    movie_id,
    month,
    location,
    sum(tickets_sold) as tickets_sold,
    sum(revenue) as revenue
from prepared
group by
    movie_id,
    month,
    location
