DROP TABLE IF EXISTS visitor_session_events CASCADE;

CREATE TABLE visitor_session_events(
   event_id UUID  NOT NULL,
   event_datetime TIMESTAMP,
   user_fingerprint BIGINT NULL,
   domain_userid CHAR(20),
   network_userid CHAR(38),
   page_url CHAR(255)
);

drop view if exists visitors_by_day;

create or replace view visitors_by_day as
(select distinct domain_userid, DATE_TRUNC('day', event_datetime) as visit_day
from public.visitor_session_events
order by 2 asc, 1 asc);