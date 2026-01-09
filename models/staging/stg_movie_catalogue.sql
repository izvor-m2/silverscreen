with source as (

    select *
    from {{ source('silverscreen', 'MOVIE_CATALOGUE') }}

)

select
    *
from source
