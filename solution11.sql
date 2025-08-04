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

Reason: 


