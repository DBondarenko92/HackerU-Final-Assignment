select customer.customerid
    ,INITCAP(customer.firstname) as first_name
    ,INITCAP(customer.lastname) as last_name
    ,customer.company
    ,customer.address
    ,customer.city
    ,customer.state 
    ,customer.country
    ,customer.postalcode
    ,customer.phone
    ,customer.fax
    ,customer.email
    ,left(substring(customer.email, position('@' in customer.email) + 1), position('.' in substring(customer.email, position('@' in customer.email) + 1))-1) as domain
    ,customer.supportrepid
    ,customer.last_update
    ,'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S") }}'::timestamp as dbt_time
from {{source('stg', 'customer')}}