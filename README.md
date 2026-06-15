# CFG Degree – Data Science Foundation Module 📊
**May Agboola**

A portfolio of four project assignments completed as part of the CFG Degree Foundation Module, progressing from Git fundamentals through to a full Flask REST API backed by a relational database.

---

## Project Notes 🗒️ ‼️

- All data and scenarios are **illustrative/demo** — built for learning and demonstration purposes.
- **_Each assignment builds on the last: the repo moves from version control fundamentals, to consuming a public REST API, to designing a relational database from scratch, to building and serving a REST API with Flask and MySQL._**
- This project demonstrates: **Git/GitHub workflow** (branching, pull requests, `.gitignore`), **REST API consumption** with `requests` and JSON parsing, **relational database design** with MySQL (JOINs, stored procedures, aggregate functions), **Flask API development** with GET/POST endpoints, and **Python fundamentals** including string manipulation, boolean logic, and file I/O.

---

## Assignments at a Glance 📁

| # | Assignment | Key Tech |
|---|-----------|---------|
| 1 | GitHub Best Practices | Git, GitHub, `.gitignore`, `requirements.txt` |
| 2 | Anime API Recall Tool (Jikan API) | Python, `requests`, REST API, JSON, `rich` |
| 3 | Gym Studio SQL Database | MySQL, JOINs, stored procedures, aggregations |
| 4 | Game Rental Shop Flask API | Flask, MySQL, `mysql-connector-python`, GET/POST |

---

## Assignment 1 – GitHub Best Practices

A practical walkthrough of a real Git workflow: initialising a local repo, connecting it to GitHub, working with branches, and managing a pull request through to merge.

**Demonstrated:**
- Creating and switching feature branches
- Staging, committing, and pushing changes (`git add`, `git commit`, `git push`)
- Renaming and moving files with `git mv`
- Using `.gitignore` to exclude virtual environments and temporary files
- Creating and pinning a `requirements.txt`
- Tracking progress with `git status` and `git log`
- Opening and documenting a Pull Request on GitHub

**How to run:** ▶️
```bash
git clone https://github.com/maymay238xx/CFG--Data-Science---Aug25---May-Agboola.git
pip install -r requirements.txt
python "github best practices.py"
```

---

## Assignment 2 – Anime API Recall Tool (Jikan API) 🥷🏾

Consumes the [Jikan public API](https://jikan.moe) (no API key required) to fetch and report on Naruto episode data.

**What it does:**
- Prompts the user to choose between *Naruto* or *Naruto: Shippuden*
- Calls the Jikan v4 API and parses the JSON response
- Builds a report per episode: number, shortened title (string slicing, first 20 characters), and a filler flag (`if/else` boolean check)
- Prints the total episode count using `len()`
- Saves results to `episodes.txt`
- Outputs a formatted table using the `rich` library

**How to run:** ▶️
```bash
pip install -r requirements.txt
python "Anime API recall tool.py"
```

**Requirements:** Python 3.13+, `requests==2.31.0`, `rich==13.7.1`

> Note: `requests` is the Python package used to make HTTP calls. The Jikan API version (v4.0.0) is a web service version, visible in the URL — not a pip-installable package.

---

## Assignment 3 – Gym Studio SQL Database 🏋🏾‍♀️

A relational MySQL database for a gym studio, designed and queried from scratch.

**What it demonstrates:**
- Session timetable ordered Mon–Sun then by time
- Joined view of member bookings with class session names
- Booked vs remaining spots per class using `COUNT` + `CASE`
- Total bookings `GROUP BY` weekday
- Active member names uppercased with `UPPER`, ordered by join date
- Members with no bookings surfaced using `LEFT JOIN ... IS NULL`
- A stored procedure that books a spot only if the class is not full and the member is active

**How to run:** ▶️

Download `assignment-3.sql` and run the script top-to-bottom in MySQL Workbench or the MySQL command line.

**Requirements:** MySQL Workbench (current stable) or any MySQL-compatible CLI

---

## Assignment 4 – Game Rental Shop Flask API 🎮

A two-file Flask application that connects to a MySQL database and exposes a simple REST API for a game rental shop.

**What it does:**
- Lists all available games (Switch, PS4, Xbox)
- Returns the top 5 most popular games
- Allows a user to rent a game: marks it as rented and records customer info in the database

**Architecture:** 🛠️
- `app.py` — Flask app defining the API routes (GET/POST), connected to MySQL via `mysql-connector-python`
- `main.py` — client script that communicates with the API and presents a terminal menu

**How to run:** ▶️
```bash
pip install Flask mysql-connector-python requests tabulate
```
1. Run `app.py` to start the Flask server
2. Run `main.py` to interact with the API via the terminal menu
3. Customer data is stored in the `gamerentals` MySQL database

**Requirements:** MySQL Workbench (current), Python 3, Flask, `mysql-connector-python`, `tabulate`

---

## Dependencies ⚙️

```bash
pip install -r requirements.txt
```

| Package | Version | Purpose |
|--------|---------|---------|
| `requests` | 2.31.0 | HTTP requests to external APIs |
| `rich` | 13.7.1 | Formatted terminal table output |

**Flask API dependencies installed separately — see Assignment 4 above.**
