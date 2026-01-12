with source as (

    select *
    from {{ source('silverscreen', 'INVOICES') }}

),

renamed as (

    select
        invoice_id,
        movie_id,
        location_id,
        month,
        weekly_price,
        total_invoice_sum
    from source

)

select * from renamed
