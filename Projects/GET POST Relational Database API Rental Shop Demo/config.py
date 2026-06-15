#The below are the basic settings for the gaming rental db and app

DB_HOST = 'localhost'
DB_USER = 'rentuser'
DB_PORT = 3306 #So after spending hrs trying to figure out was wrong with my config file, I finally realised that the Flask app runs on 5001 (web), MySQL stays on 3306 (database) lol
DB_PASSWORD = 'STRONG_PASSWORD'
DB_NAME = 'gamerentals'

PORT = 5001 #API at https://localhost:5001
DEBUG = True # Tells it to show helpful error pages while developing