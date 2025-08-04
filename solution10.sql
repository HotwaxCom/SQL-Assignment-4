select
	rh.return_id,
	ri.order_id,
	rh.return_date,
	rh.from_party_id,
	rh.destination_facility_id as restock_facility_id,
	ri.return_reason_id as return_reason
from return_header rh
join return_item ri 
	on rh.return_id = ri.return_id where rh.destination_facility_id is null
group by rh.return_id, ri.order_id, rh.return_date, rh.from_party_id, rh.destination_facility_id,
ri.return_reason_id;

-- Since we were to find the orders for which restock_facility_id is not available so we check the is null
-- condition for this, accordingly apply joins on table return_header and return_item.

-- Execution Cost: 23.86

