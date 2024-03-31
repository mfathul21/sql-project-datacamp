%%sql
with recent_year as(
	select max(public.product_emissions.year)
	from public.product_emissions
)

select 
	public.product_emissions.industry_group,
	count(distinct public.product_emissions.company) 
		as num_companies,
	round(sum(public.product_emissions.carbon_footprint_pcf),1) 
		as total_industry_footprint
		
from public.product_emissions
where public.product_emissions.year = (select * from recent_year)
group by public.product_emissions.industry_group
order by total_industry_footprint desc;
