import logging
import sys
import requests
import os
from datetime import datetime
from app.config.pimps_config import pimps_meta, app_config, sql_config
from app.db_src_control.postgres_helper import db_helper
import csv
import pandas as pd
import hashlib

logging.basicConfig(stream=sys.stdout, level=logging.INFO)


def get_visitor_data(data, date):
    # setup variables
    script_dir = os.path.dirname(__file__)
    app_data_loc = "/data/"
    target_file_path = app_data_loc + "pimps_events.csv.gz"
    source_url = app_config["source_url"][data]
    source_file = app_config["file_mask"]
    sql_file_path = script_dir + "/db_src_control/deltas/"
    database_name = "edw_dev"

    logging.info("Creating db")

    db = db_helper("localhost", 5432)

    db.create_db(database_name, None, drop_create=True)

    # create tables and deltas
    db.execute_sqlscript(sql_file_path + sql_config["events"]["sql_schema_file"])

    # download csv files
    r = requests.get(source_url + source_file)
    open(target_file_path, "wb").write(r.content)

    db.bulk_exec(target_file_path, "visitor_session_events")

    report = open(script_dir + "/pimps_report_sql/visitor_count_report.sql", "rt").read()

    conn = db.connect_db()
    cur = conn.cursor()

    cur.execute(report.replace("{}", str(date)))
    conn.commit()

    cur.execute('''select * from visitors_count_report''')

    result = cur.fetchall()[0]

    logging.info("innactive_user = ", result[0])
    logging.info("re-activeated_user = ", result[1])
    logging.info("active_user = ", result[2])
    logging.info("churned_user = ", result[3])


if __name__ == "__main__":
    get_visitor_data("pimps", datetime.strptime("2014-10-29", '%Y-%m-%d'))
