import psycopg2
import gzip
import csv
from io import StringIO

class db_helper:

    def __init__(self, host, port):
        self.db_host = host
        self.port = port

    def connect_db(self):
        conn = None
        try:
            conn = psycopg2.connect(
                host=self.db_host,
                port=self.port,
                database="postgres",
                user="postgres",
                password="dbadmin")

        except (Exception, psycopg2.DatabaseError) as error:
            print(error)

        return conn

    def create_db(self, db_name, conn=None, drop_create=False):
        if not conn:
            conn = self.connect_db()

        conn.autocommit = True

        cur = conn.cursor()

        if drop_create:
            cur.execute('''DROP DATABASE IF EXISTS {}'''.format(db_name))

        sql = '''CREATE database {}'''.format(db_name);

        cur.execute(sql)
        print("Database created successfully........")
        conn.close()

    def execute_sqlscript(self, sql_file, conn=None):
        if not conn:
            conn = self.connect_db()

        conn.autocommit = True

        cur = conn.cursor()

        cur.execute(open(sql_file, "r").read())

        conn.close()

    def bulk_exec(self, filenamepath, tablename, conn=None):
        if not conn:
            conn = self.connect_db()

        conn.autocommit = True

        cur = conn.cursor()

        f = csv.reader(gzip.open(filenamepath, "rt"), skipinitialspace=True, quoting=csv.QUOTE_MINIMAL, escapechar='\\')
        buffer = StringIO()
        writer = csv.writer(buffer)
        writer.writerows(f)
        buffer.seek(0)

        cur.copy_from(buffer, tablename, sep=',', null="")

        f.close()
