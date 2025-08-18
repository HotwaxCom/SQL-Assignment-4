4. Brokered but Not Shipped Orders
Business Problem:
Merchandising teams need to track orders that have been brokered (allocated to a facility) but not shipped. They also want to know how long it has been since the order was brokered.

Fields to Retrieve:

ORDER_ID
BROKERED_DATE
BROKERED_FACILITY_ID
SHIPMENT_STATUS
TIME_SINCE_BROKERING

select 
	oisgir.order_id,
	oisgir.reserved_datetime as brokered_date,
	ii.facility_id as brokered_facility_id,
	datediff(curdate(), oisgir.created_datetime) as time_since_brokering
	from order_item_ship_grp_inv_res oisgir
join inventory_item ii on oisgir.inventory_item_id = ii.inventory_item_id
join order_shipment os on os.order_id = oisgir.order_id
join shipment_status ss on ss.shipment_id = os.shipment_id 
where ss.status_id != "SHIPMENT_SHIPPED" or ss.status_id = "SHIPMENT_CANCELLED";
	
-- as soon as the item is brokered a ship group is made for it and so we look into the order item ship grp inv res
-- and take the order_id and brokered date from there, then a facility for the same is mentioned in the inventory item table 
-- accordingly take it from there. To calculate the time_since_brokering I took out the difference between the current date and 
-- created_datetime, applied joins accordingly and added a status constraint as shipment not equals to shipped and if the
-- is cancelled there is no sense of find the time since it has been brokered and not shipped.
	
-- Execution Cost: 192,580.9
