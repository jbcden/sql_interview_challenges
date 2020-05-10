select
  month,
  count,
  lag(month, 1) over w as previous_month,
  coalesce(round(100.0 * (count - lag(count, 1) over w) / lag(count, 1) over w, 2), 0.0) as mau
from (
  select
    count(id) as count,
    date_trunc('year', created_at) as year,
    date_trunc('month', created_at) as month
  from users u
  group by year, month
  order by year, month
) t
window w as (order by t.year, t.month asc)
order by year, month

