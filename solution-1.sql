select 
	s.shipment_id, 
	ss.status_date, 
	s.origin_facility_id as facility_id, 
	s.primary_order_id as order_id  
from shipment s 
join shipment_status ss on ss.shipment_id = s.shipment_id 
where ss.status_id = "SHIPMENT_SHIPPED" and ss.status_date between "2022-01-01" and "2022-01-31" 
order by ss.status_date;

-- Since shipments that came out in 2022 were asked so I first took shipment_status as "shipment_shipped"
-- and the status_date to be between 1st january 2022 - 31st january 2022. Other than this, 
-- took basic details like the shipment_id, facility_id, order_id from the shipment table itself.

-- Execution Cost: 8617.7 
