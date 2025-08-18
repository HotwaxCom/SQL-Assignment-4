2.Shipments by Tracking Number
Business Problem:
Customer Service often needs to look up shipments by tracking number to answer delivery queries quickly.

Fields to Retrieve:

SHIPMENT_ID
ORDER_ID
TRACKING_NUMBER
SHIPMENT_DATE
CARRIER_PARTY_ID
SHIPMENT_STATUS
	
select 
	s.shipment_id,
	s.primary_order_id as order_id,
	srs.tracking_id_number as tracking_number,
	ss.status_date as shipment_date,
	s.carrier_party_id,
	s.status_id as shipment_status
from shipment s
join shipment_route_segment srs on srs.shipment_id = s.shipment_id
join shipment_status ss on ss.shipment_id = s.shipment_id
	where ss.status_id = "SHIPMENT_SHIPPED";

-- Here, we were required to look up for tracking number for shipments so I took basic details about shipment
-- from the shipment table itself which includes, the shipment_id, primary_order_id, created_date, carrier_party_id
-- and shipment_id. Applied a join to shipment_route_segment to retrieve the tracking_id_number. Since we should be able to find
-- the shipments at any stage so we did not put any constraint related to the status.

-- Execution Cost: 84,240.41

	

