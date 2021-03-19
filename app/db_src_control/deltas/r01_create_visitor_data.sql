DROP TABLE IF EXISTS visitor_session_events;

CREATE TABLE visitor_session_events(
   event_id UUID  NOT NULL,
   event_datetime TIMESTAMP,
   user_fingerprint BIGINT NULL,
   domain_userid CHAR(20),
   network_userid CHAR(38),
   page_url CHAR(255)
);