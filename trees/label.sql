select
  n.node, n.parent, l.node as child_node
from nodes n
left join nodes l on n.node = l.parent
)
select distinct
  node,
  case
  when parent is null then 'ROOT'
  when child_node is null then 'LEAF'
  else 'INNER'
  end as label
from tree
order by node
