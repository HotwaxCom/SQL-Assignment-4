10. Returns Without Restock Location
Business Problem:
A restock location should be specified when a product is returned, so the item can re-enter the correct facility’s inventory. The business wants to find returns missing this detail.

Fields to Retrieve:

RETURN_ID
ORDER_ID
RETURN_DATE
FROM_PARTY_ID
RESTOCK_FACILITY_ID
RETURN_REASON

select
	rh.return_id,
	ri.order_id,
	rh.return_date,
	rh.from_party_id,
	rh.destination_facility_id as restock_facility_id,
	ri.return_reason_id as return_reason
from return_header rh
join return_item ri 
	on rh.return_id = ri.return_id and rh.destination_facility_id is null
group by rh.return_id, ri.order_id, rh.return_date, rh.from_party_id, rh.destination_facility_id,
ri.return_reason_id;

-- Since we were to find the orders for which restock_facility_id is not available so we check if the destination_facility_id
-- this is null, accordingly apply joins on table return_header and return_item.

-- Execution Cost: 23.86

