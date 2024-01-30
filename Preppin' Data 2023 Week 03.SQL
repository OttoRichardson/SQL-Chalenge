-- Preppin' Data 2023 Week 03

-- For the transactions file:
    -- Filter the transactions to just look at DSB (help)
        -- These will be transactions that contain DSB in the Transaction Code field
    -- Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values
    -- Change the date to be the quarter (help)
    -- Sum the transaction values for each quarter and for each Type of Transaction (Online or In-Person) (help)
-- For the targets file:
    -- Pivot the quarterly targets so we have a row for each Type of Transaction and each Quarter (help)
    -- Rename the fields
    -- Remove the 'Q' from the quarter field and make the data type numeric (help)
-- Join the two datasets together (help)
    -- You may need more than one join clause!
-- Remove unnecessary fields
-- Calculate the Variance to Target for each row 

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
on  replace(T.quarter, 'Q','')=CTE.quarter and  CTE.online_or_in_person=T.online_or_in_person