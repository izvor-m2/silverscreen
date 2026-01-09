select *
from {{ ref('stg_nj_001') }}

union all

select *
from {{ ref('stg_nj_002') }}

union all

select *
from {{ ref('stg_nj_003') }}
