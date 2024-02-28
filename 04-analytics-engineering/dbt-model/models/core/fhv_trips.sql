{{
    config(
        materialized='table'
    )
}}

with fhv_tripdata as (
    select 
        * 
    from 
        {{ ref('stg_fhv_tripdata') }}
), 
dim_zones as (
    select 
        * 
    from 
        {{ ref('dim_zones') }}
    where borough != 'Unknown'
)

select 
    f.dispatching_base_num,
    f.pickup_datetime,
    f.pickup_locationid,
    p.borough as pickup_borough, 
    p.zone as pickup_zone, 
    p.service_zone as pickup_service_zone,
    f.dropoff_datetime,
    f.dropoff_locationid,
    d.borough as dropoff_borough, 
    d.zone as dropoff_zone, 
    d.service_zone as dropoff_service_zone,
    f.sr_flag,
    f.affiliated_base_number
from    
    fhv_tripdata as f
inner join 
    dim_zones as p on f.pickup_locationid = p.locationid
inner join 
    dim_zones as d on f.dropoff_locationid = d.locationid