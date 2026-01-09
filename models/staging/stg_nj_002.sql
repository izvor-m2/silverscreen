with source as (

    select *
    from {{ source('silverscreen', 'NJ_002') }}

),

prepared as (

    select
        MOVIE_ID as movie_id,
        date_trunc('month', DATE) as month,
        'NJ_002' as location,
        TICKET_AMOUNT as tickets_sold,
        TOTAL_EARNED as revenue
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
