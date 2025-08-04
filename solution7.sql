select 
    os.order_id,
    os.shipment_id,
    count(os.order_item_seq_id) AS total_order_items,
    oisg.facility_id,
    ss.status_date AS shipment_date,
    os1.status_datetime AS order_completion_date
from order_shipment os
join order_item_ship_group oisg 
    on os.order_id = oisg.order_id
    and os.ship_group_seq_id = oisg.ship_group_seq_id
join shipment_status ss 
    on ss.shipment_id = os.shipment_id
join order_status os1
    on os1.order_id = os.order_id
join facility f
    on f.facility_id = oisg.facility_id
WHERE 
    ss.status_id = "SHIPMENT_SHIPPED"
    and os1.status_id = "ORDER_COMPLETED"
    and f.facility_type_id like '%WAREHOUSES'
    and ss.status_date between date_format(curdate() - interval 1 month, '%Y-%m-01')
                           AND last_day(curdate() - interval 1 month)
group by os.order_id, os.shipment_id, oisg.facility_id, ss.status_date, os1.status_datetime
having 
    count(os.order_item_seq_id) = 1;

-- The details were retrieved from their respective tables as asked, a join was applied with facility to
-- get facility_id which are warehouses. Also, fulfilled orders were asked so shipment should be shipped,
-- for order_completion_date the status for order_id should be order_completed and a function was used 
-- to get previous month's single item order fulfilled by the warehouse.

-- Execution Cost: 27,750.62





