app_config = {
    "source_url": {
        "clicks": "https://s3-eu-west-1.amazonaws.com/gousto-hiring-test/data-engineer",
        "pimps": "https://s3-eu-west-1.amazonaws.com/gousto-hiring-test/data-engineer",
        "pageviews": ""
    },
    "file_mask": "events.gz"
}

property_meta = {"col_list": ['event_id', 'event_datetime', 'user_fingerprint', 'domain_userid', 'network_userid',"page_url"],
                 "column_def": [{
                     "name": "event_id",
                     "type": "varchar",
                     "description": "A UUID for each event"
                     },
                     {
                         "name": "event_datetime",
                         "type": "timestamp",
                         "description": "event timestamp"
                     },
                     {
                         "name": "user_fingerprint",
                         "type": "int",
                         "description": "fingerprint based on Useragent device details etc. "
                     },
                     {
                         "name": "domain_userid",
                         "type": "varchar",
                         "description": "User ID set by Snowplow using 1st party cookie"
                     },
                     {
                         "name": "network_userid",
                         "type": "varchar",
                         "description": "User ID set by Snowplow using 3rd party cookie"
                     },
                     {
                         "name": "page_url",
                         "type": "varchar",
                         "description": "Page Impression url"
                     }
                 ],
                 "natural_keys": ["domain_userid", "network_userid", "page_url"],
                 "primarykey_keys": ["event_id"]
                 }
