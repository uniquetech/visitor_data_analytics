create or replace view visitors_count_report as
select * from (
select count(distinct domain_userid) as inactive_user
from public.visitors_by_day vbd
where vbd.visit_day < TO_DATE('{}','YYYY-MM-DD') -1
and domain_userid  not in (
select distinct domain_userid
from public.visitor_session_events vse
where domain_userid is not null
and DATE_TRUNC('day', event_datetime) <= TO_DATE('{}','YYYY-MM-DD')
and DATE_TRUNC('day', event_datetime) >= TO_DATE('{}','YYYY-MM-DD') -1)) as inactive_user,
--reactivated users
(
select count(distinct domain_userid) as reactive_user
from public.visitors_by_day vbd
where vbd.visit_day < TO_DATE('{}','YYYY-MM-DD') -1
and domain_userid in (
select distinct domain_userid
from public.visitor_session_events vse
where domain_userid is not null
and DATE_TRUNC('day', event_datetime) = TO_DATE('{}','YYYY-MM-DD')
)
and domain_userid not in (
select distinct domain_userid
from public.visitor_session_events vse
where domain_userid is not null
and DATE_TRUNC('day', event_datetime) = TO_DATE('{}','YYYY-MM-DD') -1)) as reactive_user,
(select count(distinct vs1.domain_userid) as active_users
from public.visitor_session_events vs1
inner join public.visitor_session_events vs2
on vs1.domain_userid = vs2.domain_userid
where DATE_TRUNC('day', vs1.event_datetime) = TO_DATE('{}','YYYY-MM-DD')
and date_trunc('day', vs2.event_datetime) = TO_DATE('{}','YYYY-MM-DD') - 1) as active_users,
--churned users
(select count(distinct domain_userid) as churned_user
from public.visitor_session_events vs
where DATE_TRUNC('day',  event_datetime) = TO_DATE('{}','YYYY-MM-DD') -1
and domain_userid not in
(select distinct domain_userid
from public.visitor_session_events vs
where DATE_TRUNC('day', event_datetime) = TO_DATE('{}','YYYY-MM-DD'))) as churned_user