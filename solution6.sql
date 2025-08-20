6. Orders Shipped from Stores (25 Days Before New Year)
Business Problem:
Retailers often run holiday promos in late December and need visibility into orders shipped from stores (as opposed to warehouses) for the final 25 days of the year.

Fields to Retrieve:

ORDER_ID
SHIPMENT_ID
FACILITY_ID (store ID)
SHIPMENT_DATE
ORDER_DATE
TOTAL_ITEMS
CUSTOMER_STATE

select
	oh.order_id,
	os.shipment_id,
	oisg.facility_id,
	ss.status_date as shipment_date,
	oh.order_date,
	count(os.order_item_seq_id) as total_items,
	pa.city as customer_state
from order_header oh
join order_shipment os
	on os.order_id = oh.order_id
join order_item_ship_group oisg
	on oisg.order_id = os.order_id
join shipment_status ss
	on ss.shipment_id = os.shipment_id
join order_contact_mech ocm 
	on ocm.order_id = oh.order_id 
join postal_address pa 
	on pa.contact_mech_id = ocm.contact_mech_id
join facility f
	on f.facility_id = oisg.facility_id
where 	
	ss.status_id = "SHIPMENT_SHIPPED"
	and date(ss.status_date) between '2024-12-06' and '2024-12-31'
	and facility_type_id in ('OUTLET_STORE','RETAIL_STORE')
group by oh.order_id, os.shipment_id, oisg.facility_id, ss.status_date, oh.order_date;

-- started from the table order_header to get order_id and then applied joins as required, since only
--  store was asked for facility, added this constraint, then to get customer state applied joins to reach 
-- postal address entity. The order which have been shipped were only asked and since we wanted to know the
--  order shipped from the stores in the last 25 days so added this constraint as well.

-- Execution Cost - 43,463.71

