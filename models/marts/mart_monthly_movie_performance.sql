with ticket_sales as (

    select *
    from {{ ref('int_ticket_sales') }}

),

movies as (

    select
        movie_id,
        studio,
        release_date
    from {{ ref('stg_movie_catalogue') }}

),

invoices as (

    select
        movie_id,
        location_id as location,
        month,
        total_invoice_sum as rental_cost
    from {{ ref('stg_invoices') }}

)

select
    ts.movie_id,
    m.studio,
    m.release_date,
    ts.month,
    ts.location,
    ts.tickets_sold,
    ts.revenue,
    i.rental_cost,
    ts.revenue - coalesce(i.rental_cost, 0) as profit

from ticket_sales ts
left join movies m
    on ts.movie_id = m.movie_id
left join invoices i
    on ts.movie_id = i.movie_id
   and ts.location = i.location
   and ts.month = i.month
