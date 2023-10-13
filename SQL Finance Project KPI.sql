create database finance;
use finance;





select * from finance1;
select * from finance2;


# 	KPI-1 Year wise loan amount Stats

select
    Years,
    sum(Loan_amont) as Loan_amount
from 
	finance1
group by 
	Years;
    
    
# KPI-2 Grade and sub grade wise revol_bal
### I use here left join

select
	f1.Grade,
    f1.Sub_grade,
    sum(f2.revol_bal) as Revol
from 
	finance1 as f1
left join 
	finance2 as f2
on f1.id = f2.id
group by Grade, Sub_grade
order by Grade;

#### I use here full Outer join
(select 
	Grade,
	sub_grade, 
    sum(revol_bal) from finance1 as f1
left join 
	finance2 as f2
on f1.id = f2.id
group by Grade,Sub_grade
order by sub_grade asc)
union
(select
	Grade,
    Sub_grade,
    sum(revol_bal) as Revol
from 
	finance1 as f1
right join 
	finance2 as f2
on f1.id = f2.id
group by Grade,Sub_grade
order by sub_Grade asc);


##### KPI-3  Total Payment for Verified Status Vs Total Payment for Non Verified Status

UPDATE finance1
SET verification_status = REPLACE(verification_status, 'Source Verified', 'Verified');

select 
Verification_status,
count(Verification_status) No_of_Status,
round(sum(f2.total_pymnt),2) as Total_Payment from finance1 as f1
join finance2 as f2
on f1.id = f2.id
group by Verification_status;



######## KPI-4  State wise and month wise loan status


select
    State,
    months,
    Count(loan_Status) as No_Of_Payment_status
from 
	finance1
group by 
	State,Months
order by 
	State asc;
 
 
######## KPI-5 Home ownership Vs last payment date stats

select
    Home_ownership,
    count(last_pymnt_d) as No_Of_Payments
from
	finance1 as f1
inner join 
	finance2 as f2
on f1.ID = f2.ID
group by Home_ownership;

