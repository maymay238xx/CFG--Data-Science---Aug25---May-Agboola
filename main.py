import requests
import json

# I found online that I can download tabulate to make the table look better and not just a long string in the terminal
from tabulate import tabulate

BASE_URL = "http://localhost:5001"

def print_games_table(games):
    """Display games into a neat table."""
    if not games:
        print("(no data)")
        return

    headers = ["ID", "Title", "Platform", "Top", "Status"]
    rows = [[g['id'], g['title'], g['platform'], g['is_top'], g['status']] for g in games]
    print(tabulate(rows, headers=headers, tablefmt="grid"))

def get_all_games(): #Extracts the list from the hosted server
    result = requests.get('http://127.0.0.1:5001/games')
    return result.json()

def rent_game(game_id, customer_name): #Stores the title being rented
    rent_info = {
        "game_id": game_id,
        "customer_name": customer_name
    }
    headers = {'content-type': 'application/json'}
    result = requests.post(
        'http://127.0.0.1:5001/rent', headers=headers, data=json.dumps(rent_info)
    )
    results_json = result.json()
    return results_json

def run(): #Opening greeting to the API menu
    print('############################')
    print(' Welcome to Game Rentals 🎮')
    print('############################')
    print()

    name = str(input('Enter your name: '))
    platform = str(input('Which platform are you interested in (Switch/PS4/Xbox): '))
    print()

    print('####### AVAILABLE GAMES #######')
    print()
    all_games = get_all_games()

    # Next in the script, it will show only games for that platform
    platform_games = []
    for g in all_games:
        if g['platform'].lower() == platform.lower():
            platform_games.append(g)

    if len(platform_games) == 0:
        print('No games found for this platform.')
        return

    print_games_table(platform_games)
    print()
    #After displaying the list of games available based on the user input choice it will ask the user the following below
    rent_answer = str(input('Would you like to rent a game (y/n): '))
    if rent_answer.lower() == 'y':
        game_id = int(input('Enter the ID of the game you want to rent: '))
        rent_result = rent_game(game_id, name)
        print()
        print('Rental request result:')
        print(rent_result.get('message', 'Rental completed.'))
        print()

        print('####### UPDATED AVAILABILITY #######')
        print()
        updated_games = get_all_games()
        print (updated_games)


    print('Thank you for visiting Game Rentals!')


if __name__ == "__main__":
    run()

