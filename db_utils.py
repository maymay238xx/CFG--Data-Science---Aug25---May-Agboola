# Purpose: to connect MySQL and run a few basic queries for my API
# I'll be importing the below packages required for this API
import mysql.connector
from config import DB_HOST, DB_PORT, DB_USER, DB_PASSWORD, DB_NAME

class DbConnectionError(Exception):
    pass

def _connect_to_db():
    cnx = mysql.connector.connect(
        host=DB_HOST,
        port=DB_PORT,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_NAME
    )
    return cnx

def _map_games(rows):
    mapped = []
    for item in rows:
        # SELECT order: id, title, platform, is_top, status, created_at
        mapped.append({
            "id": item[0],
            "title": item[1],
            "platform": item[2],
            "is_top": bool(item[3]),
            "status": item[4],
            "created_at": str(item[5])
        })
    return mapped

def get_all_games():
    try:
        db_connection = _connect_to_db()
        cursor = db_connection.cursor()
        print("Connected to DB:", DB_NAME)

        query = """
            SELECT id, title, platform, is_top, status, created_at
            FROM games
            ORDER BY is_top DESC, title ASC
        """
        cursor.execute(query)
        results = cursor.fetchall()

        games = _map_games(results)

        cursor.close()

    except Exception:
        raise DbConnectionError("Failed to read DB data")

    finally:
        if db_connection:
            db_connection.close()
            print("DB connection is closed")

    return games

def get_top_games():
    try:
        db_connection = _connect_to_db()
        cursor = db_connection.cursor()
        print("Connected to DB:", DB_NAME)

        query = """
            SELECT id, title, platform, is_top, status, created_at
            FROM games
            WHERE is_top = 1
            ORDER BY title ASC
            LIMIT 5
        """
        cursor.execute(query)
        results = cursor.fetchall()

        games = _map_games(results)

        cursor.close()

    except Exception:
        raise DbConnectionError("Failed to read DB data")

    finally:
        if db_connection:
            db_connection.close()
            print("DB connection is closed")

    return games

def rent_game(game_id, customer_name):
    """
      - check the game exists and is available
      - insert a rental
      - mark game as 'rented'
    Returns (True/False, message)
    """
    try:
        db_connection = _connect_to_db()
        cursor = db_connection.cursor()
        print("Connected to DB:", DB_NAME)

        # check game
        check_query = "SELECT status FROM games WHERE id = {}".format(game_id)
        cursor.execute(check_query)
        row = cursor.fetchone()

        if not row:
            cursor.close()
            return (False, "Game not found.")

        if row[0] != "available":
            cursor.close()
            return (False, "Game is already rented.")

        # insert rental
        insert_query = """
            INSERT INTO rentals (game_id, customer_name)
            VALUES ({}, '{}')
        """.format(game_id, customer_name)
        cursor.execute(insert_query)

        #  update game status
        update_query = "UPDATE games SET status = 'rented' WHERE id = {}".format(game_id)
        cursor.execute(update_query)

        db_connection.commit()
        cursor.close()

    except Exception:
        # if something went wrong after we wrote, try to rollback
        try:
            db_connection.rollback()
        except:
            pass
        raise DbConnectionError("Failed to update DB data")

    finally:
        if db_connection:
            db_connection.close()
            print("DB connection is closed")

    return (True, "Game rented successfully.")

if __name__ == "__main__":
        print(get_all_games())
        print(get_top_games())
        print(rent_game(1, "Test Customer"))