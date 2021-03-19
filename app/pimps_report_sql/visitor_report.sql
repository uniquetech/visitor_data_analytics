--active users
select count(distinct vs1.domain_userid)
from public.visitor_session_events vs1
inner join public.visitor_session_events vs2
on vs1.domain_userid = vs2.domain_userid
where DATE_TRUNC('day', vs1.event_datetime) = TO_DATE('{}','YYYY-MM-DD')
and date_trunc('day', vs2.event_datetime) = TO_DATE('{}','YYYY-MM-DD') - 1;

--inactivated user
select count(distinct domain_userid) from public.visitors_by_day vbd
where vbd.visit_day < TO_DATE('2014-09-06','YYYY-MM-DD') -1
and domain_userid  not in (
select distinct domain_userid
from public.visitor_session_events vse
where domain_userid is not null
and DATE_TRUNC('day', event_datetime) <= TO_DATE('2014-09-06','YYYY-MM-DD')
and DATE_TRUNC('day', event_datetime) >= TO_DATE('2014-09-06','YYYY-MM-DD') -1)

--churned user
select count(distinct domain_userid)
from public.visitor_session_events vs
where DATE_TRUNC('day',  event_datetime) = TO_DATE('{}','YYYY-MM-DD') -1
and domain_userid not in
(select distinct domain_userid
from public.visitor_session_events vs
where DATE_TRUNC('day', event_datetime) = TO_DATE('{}','YYYY-MM-DD'));

--reactivated users
select count(distinct domain_userid)
from public.visitors_by_day vbd
where vbd.visit_day < TO_DATE('2014-09-06','YYYY-MM-DD') -1
and domain_userid in (
select distinct domain_userid
from public.visitor_session_events vse
where domain_userid is not null
and DATE_TRUNC('day', event_datetime) = TO_DATE('2014-09-06','YYYY-MM-DD')
)
and domain_userid not in (
select distinct domain_userid
from public.visitor_session_events vse
where domain_userid is not null
and DATE_TRUNC('day', event_datetime) = TO_DATE('2014-09-06','YYYY-MM-DD') -1
)