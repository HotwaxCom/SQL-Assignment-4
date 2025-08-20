5. Multi-Item Orders (Single Ship Group)
Business Problem:
For analyzing shipping efficiency, some businesses want to know which multi-item orders (more than one product) were fulfilled in one shipment (same ship group).

Fields to Retrieve:

ORDER_ID
TOTAL_ITEMS_IN_ORDER
SHIP_GROUP_SEQ_ID
SHIPMENT_ID
FACILITY_ID
SHIPMENT_DATE

select 
	os.order_id,
	count(os.order_item_seq_id) as total_items_in_order,
	os.ship_group_seq_id,
	os.shipment_id,
	oisg.facility_id,
	ss.status_date as shipment_date
from order_shipment os
join order_item_ship_group oisg on os.order_id = oisg.order_id
join shipment_status ss on ss.shipment_id = os.shipment_id
where ss.status_id = "SHIPMENT_SHIPPED"
group by os.order_id, os.ship_group_seq_id, os.shipment_id, oisg.facility_id;

-- We were to find out multi item orders fulfilled in one shipment, so for this we start by fetching the basic
-- information as asked from the the order shipment table. Also, to find the facility_id, we used order_item_ship_group
-- We were asked about the fulfilled orders and so I applied a constraint as "shipment_shipped" 
-- and applied group by accordingly. 

-- Execution Cost: 131,375.77



	
	
