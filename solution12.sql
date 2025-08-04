select 
    p.product_id,
    gi.good_identification_type_id as PRIMARY_ID_TYPE,
    gi.id_value as PRIMARY_ID_VALUE
from product p
join good_identification gi 
    on gi.product_id = p.product_id
when gi.thru_date is null;

-- We were asked about the unique identification code that is used for every product and their respective
-- values as well, so used good_identification table for this and ensured that the thru date is null which 
-- tells that the id remains active.

-- Execution Cost: 598,785.23


