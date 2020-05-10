with mau as (
  select
    count(id) as count,
    date_trunc('year', created_at) as year,
    date_trunc('month', created_at) as month
  from users u
  group by year, month
  order by year, month
)
select
  a.month as previous_month,
  a.count as previous_count,
  b.month as current_month,
  b.count as current_count,
  round(100.0 * (current_count - previous_count) / previous_count, 2) as mau
from mau a
join mau b
  on a.year = b.year and a.month = b.month - interval '1 month'
