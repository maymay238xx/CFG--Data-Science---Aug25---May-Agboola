## Assignment 4 - Game Rental API 🎮

***Game Rental Shop*** where users can rent titles for consoles.

---

### What the demo should do hopefully 😅 (Honestly this assignment has broken me with so many syntax errors 😭)
Flask app connects to a MySQL database called `gamerentals` and allows you to:

- List all games (Switch, PS4 Xbox)
- View the top 5 most popular games
- Rent a game (mark it as rented and record customer info)

_It uses and requires_:
- **Flask** - for building the API
- **MySQL** - for database storing games and rentals
-  **mysql-connector-python** - to connect Flask to MySQL
- **requests** package- to run the basic main script

    ### ▶️ How to Run:
- A copy of the databases sql (assignment-4.sql) has been made available for you to download for the script
  - First, run the 'app.py' script to open the sequence in PyCharm or alternative
  - Second, run the 'main.py' script so it can communicate with the 'app.py' and will begin the API opening greeting menu in the terminal
  - Lastly, once the user inputs their info, it will store this in the database.
  
### 🔧 Install Requirements
- **MySQL** Workbench (up to date)
- **Flask** install if you don't already have
- **Tabulate** install if you don't already have
- **Terminal** any incl Pycharm

```bash
pip install Flask mysql-connector-python requests tabulate
```