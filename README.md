# SQL Chalenge

[Try This Chalenge](https://github.com/wjsutton/preppin-data/blob/main/2023/SQL/2023_week_03.sql)
 
### Solutions

```
with CTE as (

select CASE online_or_in_person when 1 then 'Online' when 2 then 'In-Person' end as online_or_in_person
, date_part('quarter', date(transaction_date , 'dd/MM/yyyy HH24:MI:SS' )) as Quarter
, Sum(value) as Value
from pd2023_wk01
where  split_part(transaction_code,'-',1)='DSB'
GROUP BY online_or_in_person, Quarter
)
Select target ,  T.quarter , T.online_or_in_person,  Value
from pd2023_wk03_targets as T
unpivot(target for quarter in  (Q1,Q2,Q3,Q4) )
inner join CTE
on  replace(T.quarter, 'Q','')=CTE.quarter and  CTE.online_or_in_person=T.online_or_in_
```
