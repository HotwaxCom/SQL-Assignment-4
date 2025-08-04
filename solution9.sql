select
	count(distinct oa.order_id) as total_orders,
	sum(oa.amount) as total_shipping_revenue,
	date_format('2024-07-01', '%M') as month_name
from
	order_adjustment oa
join order_header oh on
	oh.order_id = oa.order_id
where
	oa.order_adjustment_type_id = 'SHIPPING_CHARGES'
	and oh.order_date between '2024-07-01' and '2024-07-31'
group by
	oa.order_adjustment_type_id;

-- We were asked about the revenue earned because of shipping charges, for the same we first calculated the
-- total number of orders, amount as total_shipping_revenue and calculated it for the previous month. Also,
-- ensured that order_adjustment_type_id remains "SHIPPING_CHARGES"

-- Execution Cost: 31,270.25
