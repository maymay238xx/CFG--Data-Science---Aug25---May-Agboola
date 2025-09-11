"""
Assignment 2 — Beginner Friendly Version
API: Jikan (Naruto episodes) https://api.jikan.moe/v4
How to run:
    pip install -r requirements.txt
    python assignment_2.py
"""
#importing our modules
import requests
from rich.console import Console
from rich.table import Table

resp = requests.get("https://api.jikan.moe/v4/anime/20/episodes")
data = resp.json()
print(resp.json())
episodes = data["data"]  # Jikan returns episodes under "data"
print("Number of episodes:", len(episodes))

for ep in episodes[:5]:  # preview first 5
    print(f"Ep {ep['mal_id']}: {ep['title']} | Aired: {ep['aired']} | Score: {ep['score']} | Filler: {ep['filler']}")

# Save results to a text file (basic version)
file = open("episodes.txt", "w", encoding="utf-8")

for ep in episodes:
    file.write("Episode " + str(ep["mal_id"]) + ": " + ep["title"] + "\n")
file.close()

print("Episodes saved to episodes.txt ✅")
# These are the Naruto IDs in Jikan
NARUTO_ID = 20
SHIPPUDEN_ID = 1735


def get_episodes(anime_id):
    """Fetch one page of episodes for the anime ID and return as a list."""
    url = f"https://api.jikan.moe/v4/anime/{anime_id}/episodes"
    response = requests.get(url, timeout=30)
    response.raise_for_status()
    data = response.json()
    return data["data"]  # list of episode dictionaries


choice = input("Choose Naruto (1) or Shippuden (2): ").strip()

if choice == "1" or choice.lower() == "naruto":
    anime_id = NARUTO_ID
    print("You chose the best 😁 Naruto ✅")
elif choice == "2" or choice.lower() == "shippuden":
    anime_id = SHIPPUDEN_ID
    print("You chose Naruto Shippuden ✅")
else:
    anime_id = NARUTO_ID
    print("You're not serious 😕, defaulting to Naruto")

episodes = get_episodes(anime_id)
print("Number of episodes in first page:", len(episodes))

for ep in episodes[:5]:
    print(f"Ep {ep['mal_id']}: {ep['title']} | Aired: {ep['aired']} | Score: {ep['score']} | Filler: {ep['filler']}")

#Display a nice table in the terminal using rich
console = Console()
table = Table(title="Episodes Preview")

table.add_column("ID", style="cyan", no_wrap=True)
table.add_column("Title", style="magenta")
table.add_column("Aired", style="green")
table.add_column("Score", justify="right")
table.add_column("Filler", justify="center")

for ep in episodes[:5]:
    table.add_row(
        str(ep["mal_id"]),
        ep["title"],
        ep["aired"],
        str(ep["score"]),
        "✅" if ep["filler"] else "❌")

console.print(table)