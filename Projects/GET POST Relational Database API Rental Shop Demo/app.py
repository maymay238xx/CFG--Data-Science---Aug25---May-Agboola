#This contains the Flask API for the Game Rental store
#I'll be importing the packages below for use
import config
from flask import Flask, request, jsonify
import db_utils

app = Flask(__name__)

# GET /games - list all games
@app.route('/games', methods=['GET'])
def get_games():
    games = db_utils.get_all_games()
    return jsonify(games)

# GET /games/top - show top 5 most popular
@app.route('/games/top', methods=['GET'])
def get_top_games():
    games = db_utils.get_top_games()
    return jsonify(games)

# POST /rent - rent a game
@app.route('/rent', methods=['POST'])
def rent_game():
    data = request.get_json()

    # get data from the JSON body
    game_id = data['game_id']
    customer_name = data['customer_name']

    result = db_utils.rent_game(game_id, customer_name)

    # result = (True, "message") or (False, "message")
    return jsonify({
        "success": result[0],
        "message": result[1]
    })
#This will be the opening greeting if it hopefully runs successfully
def run():
    print("🎮 Game Rentals API running…")
    print("Try these in your browser:")
    print("  Full catalogue  http://localhost:5001/games")
    print("  Top 5  http://localhost:5001/games/top")
    print("Use POST /rent with JSON to rent a game.")
    app.run(port=config.PORT, debug=config.DEBUG)
    app.run(debug=True, port=5001)

if __name__ == "__main__":
    run()