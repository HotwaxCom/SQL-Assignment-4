select
	ra.return_adjustment_id,
	ri.order_id,
	ri.order_item_seq_id,
	ra.amount as refund_amount,
	ri.return_reason_id as refund_reason_code,
	rs.status_datetime as refund_date,
	rh.from_party_id as customer_id
from return_header rh
join return_adjustment ra
	on rh.return_id = ra.return_id
join return_item ri
	on ri.return_id = rh.return_id
join return_status rs
	on rs.return_id = rh.return_id
	where rs.status_id = "RETURN_COMPLETED"
	and rs.status_datetime between "2024-07-01" and "2024-07-31"
	and ra.return_adjustment_type_id = "RET_SHIPPING_ADJ";


-- Only the returns completed have to be taken into account and so the status was "return_completed", also
-- a date filter is applied to get the return detail from the previous month, rest retrived and applied join
-- for fields in table return_header, return_adjustment, return_item. Lastly, since we wanted total value of shipping refunds therefore I
-- I kept return_adjustment_type_id as "RET_SHIPPING_ADJ"

-- Execution Cost: 509.66
