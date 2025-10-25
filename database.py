import psycopg2
from config import DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASS

def fetch_query_from_file(file_path):
    conn = None
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            port=DB_PORT,
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASS
        )
        print("Database connection successful!")
        with conn.cursor() as cur:
            with open(file_path, 'r') as f:
                sql_query = f.read()
            cur.execute(sql_query)
            print("Query executed successfully.")
            results = cur.fetchall()
            return results

    except psycopg2.Error as e:
        print(f"Database error: {e}")
        return None
    finally:
        if conn:
            conn.close()
            print("Database connection closed.")
            

def execute_query_from_text(sql_query,params):
    conn = None
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            port=DB_PORT,
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASS
        )
        print("Database connection successful!")
        with conn.cursor() as cur:
            cur.execute(sql_query, params) # type: ignore
            print("Query executed successfully.")
            results = cur.fetchall()
            return results

    except psycopg2.Error as e:
        print(f"Database error: {e}")
        return None
    finally:
        if conn:
            conn.close()
            print("Database connection closed.")            