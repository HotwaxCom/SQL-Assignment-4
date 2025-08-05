SELECT 
    oisg.facility_id AS facility_id, 
    oh.order_id,
    oh.entry_date AS order_date,
    MIN(s.created_date) AS shipment_date,
    TIMESTAMPDIFF(HOUR, oh.entry_date, MAX(ii.issued_date_time)) AS fulfillment_time,
    AVG(TIMESTAMPDIFF(HOUR, oh.entry_date, ii.issued_date_time)) 
        OVER (PARTITION BY oisg.facility_id) AS average_fulfillment_time
FROM order_header oh
JOIN order_item_ship_group oisg 
    ON oisg.order_id = oh.order_id
JOIN shipment s 
    ON s.primary_order_id = oisg.order_id
JOIN item_issuance ii 
    ON ii.order_id = oh.order_id
GROUP BY oisg.facility_id, oh.order_id, oh.entry_date
ORDER BY fulfillment_time DESC;

-- Since we had to find the average fulfillment time at each facility/store therefore we retrieve the details as required, take oh.entry_date as order date then for fulfillment time we find the difference in units of hours between the entry date of the order and the issued date time from the item issuance table, to find the average we took this difference per facility to find the average fulfillment time per facility.

-- Execution Cost: 196,038.15 


