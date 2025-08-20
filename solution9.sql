9. Shipping Revenue (Last Month)
Business Problem:
Finance also needs to know how much was earned from shipping charges in the same period, often a subset of overall revenue.

Fields to Retrieve:

TOTAL ORDER
TOTAL_SHIPPING_REVENUE
MONTH
	
select
	count(distinct oa.order_id) as total_orders,
	sum(oa.amount) as total_shipping_revenue,
	monthname('2024-07-01') as month_name
from
	order_adjustment oa
join order_header oh on
	oh.order_id = oa.order_id
where
	oa.order_adjustment_type_id = 'SHIPPING_CHARGES'
	and date(oh.order_date) between '2024-07-01' and '2024-07-31'
group by
	oa.order_adjustment_type_id;

-- We were asked about the revenue earned because of shipping charges, for the same we first calculated the
-- total number of orders, amount as total_shipping_revenue and calculated it for the previous month. Also,
-- ensured that order_adjustment_type_id remains "SHIPPING_CHARGES"

-- Execution Cost: 62,330.7
