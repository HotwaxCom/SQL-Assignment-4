select 
	s.shipment_id,
	s.primary_order_id as order_id,
	srs.tracking_id_number as tracking_number,
	s.created_date as shipment_date,
	s.carrier_party_id,
	s.status_id as shipment_status
from shipment s
join shipment_route_segment srs on srs.shipment_id = s.shipment_id;

-- Here, we were required to look up for tracking number for shipments so I took basic details about shipment
-- from the shipment table itself which includes, the shipment_id, primary_order_id, created_date, carrier_party_id
-- and shipment_id. Applied a join to shipment_route_segment to retrieve the tracking_id_number. Since we should be able to find
-- the shipments at any stage so we did not put any constraint related to the status.

-- Execution Cost: 18,851.23

	

