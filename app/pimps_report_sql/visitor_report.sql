--active users
select count(distinct vs1.domain_userid)
from public.visitor_session_events vs1
inner join public.visitor_session_events vs2
on vs1.domain_userid = vs2.domain_userid
where DATE_TRUNC('day', vs1.event_datetime) = TO_DATE('2014-09-02','YYYY-MM-DD')
and date_trunc('day', vs2.event_datetime) = TO_DATE('2014-09-02','YYYY-MM-DD') - 1