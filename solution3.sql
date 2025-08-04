select 
	monthname(ss.status_date) as month,
	count(s.shipment_id)/count(distinct(s.origin_facility_id)) as average_shipments
from shipment s
join shipment_status ss on ss.shipment_id = ss.shipment_id
where ss.status_id = "SHIPMENT_SHIPPED"
and ss.status_date between "2022-01-01" and "2022-03-31"
group by month;

-- We were required to find out average shipments per month till march, so for retrieving month I used the 
-- monthname function and since operations needs to find shipments per month so for this we take shipment to be
-- completed or shipped as so we used the shipment_status table and used status_date field. Then, at the end
-- used group by month to get the average shipments for each month.

-- Execution Cost: 25,934,978.66


