import logging
import sys
import requests
import os
import datetime
from app.config.pimps_config import property_meta, app_config
from app.db_src_control.postgres_helper import db_helper
import pandas as pd
import hashlib

logging.basicConfig(stream=sys.stdout, level=logging.INFO)


def get_visitor_data(data):
    #setup variables
    script_dir = os.path.dirname(__file__)
    app_data_loc = "/data/"
    pimps_file_name = app_config["file_mask"]
    file_path = os.path.join(script_dir, app_data_loc, pimps_file_name)
    source_url = app_config["source_url"][data]
    database_name= "edw_dev"

    logging.info("Creating db")

    db=db_helper("localhost", 5432)

    db.create_db(database_name, None, drop_create=True)


    logging.info("Downloading  file")



if __name__ == "__main__":
    get_visitor_data("pimps")
