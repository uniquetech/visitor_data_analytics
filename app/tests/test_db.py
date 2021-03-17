import unittest
from app.db_src_control.postgres_helper import db_helper


class MyTestCase(unittest.TestCase):

    def test_db_smoketest(self):
        db = db_helper("localhost", 5432)

        db.create_db("test_db", None, drop_create=True)

        test_conn = db.connect_db()

        cur=test_conn.cursor()

        cur.execute('''select exists(
                            SELECT datname FROM pg_catalog.pg_database WHERE lower(datname) = lower('{}'));'''.format("test_db"))

        self.assertEqual(True, bool(cur.rowcount))


if __name__ == '__main__':
    unittest.main()
