""" Assignment 2 - Incl guide to my script explaining what I did:
API: Jikan (Naruto episodes) https://api.jikan.moe/v4/anime/20/episodes
How to run:
    pip install -r requirements.txt
    python assignment_2.py
"""
#Importing our modules
import requests
from rich.console import Console
from rich.table import Table

#Asks 'Jikan' for episodes thru its json, converts the reply into python, prints then extracts list and then prints output
resp = requests.get("https://api.jikan.moe/v4/anime/20/episodes")
data = resp.json()
print(resp.json())
episodes = data["data"]  # Jikan returns episodes under "data"


# Preview first 5 episodes with f-string
print("Number of episodes:", len(episodes))
for ep in episodes[:5]:
    print(f"Ep {ep['mal_id']}: {ep['title']} | Aired: {ep['aired']} | Score: {ep['score']} | Filler: {ep['filler']}")

# Opening and writing an episodes file with 'w' in the format of UTF-8 standard otherwise emojis etc would scramble lol
file = open("episodes.txt", "w", encoding="utf-8")
for ep in episodes:
    file.write("Episode " + str(ep["mal_id"]) + ": " + ep["title"] + "\n")
file.close()
print("Episodes saved to episodes.txt ✅")

# These are the Naruto IDs from Jikan
NARUTO_ID = 20
SHIPPUDEN_ID = 1735


# List of episode dictionaries
def get_episodes(anime_id):
    """Fetch one page of episodes for the anime ID and return as a list."""
    url = f"https://api.jikan.moe/v4/anime/{anime_id}/episodes"
    response = requests.get(url, timeout=30)# Because the server is huge this tells it that if it takes longer than 30 move on
    response.raise_for_status()
    data = response.json()
    return data["data"]

#Asks the user to choose between either series below we added.strip() to accommodate for all the fat finger ppl lol
choice = input("Choose Naruto (1) or Shippuden (2): ").strip()

#Depending on the users input it will generate either of the below output
if choice == "1" or choice.lower() == "naruto":
    anime_id = NARUTO_ID
    print("You chose the best 😁 Naruto ✅")
elif choice == "2" or choice.lower() == "shippuden":
    anime_id = SHIPPUDEN_ID
    print("You chose Naruto Shippuden ✅")
else:
    anime_id = NARUTO_ID
    print("You're not serious 😑, defaulting to Naruto")

#This bit tells python that when the user picks either option that it should display the below next
episodes = get_episodes(anime_id)
print("Number of episodes in first page:", len(episodes))
for ep in episodes[:5]:
    print(f"Ep {ep['mal_id']}: {ep['title']} | Aired: {ep['aired']} | Score: {ep['score']} | Filler: {ep['filler']}")

#Display a nice table in the terminal
console = Console()
table = Table(title="Episodes Preview")

# Here we set the table column look including colour and format style
table.add_column("ID", style="cyan", no_wrap=True)
table.add_column("Title", style="magenta")
table.add_column("Aired", style="green")
table.add_column("Score", justify="right")
table.add_column("Filler", justify="center")

#This boolean bit determines based on the info whether the episode is a 'filler' or not
for ep in episodes[:5]:
    table.add_row(
        str(ep["mal_id"]),
        ep["title"],
        ep["aired"],
        str(ep["score"]),
        "✅" if ep["filler"] else "❌")

#Finito - after all that faff should hopefully print the table
console.print(table)