-- Drop and recreate the database because I've tested this a million times and it creates errors if I dont
DROP DATABASE IF EXISTS gamerentals;
CREATE DATABASE gamerentals CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Drop and recreate the database user because of the multiple tests I've conducted else it creates errors
DROP USER IF EXISTS 'rentuser'@'localhost';
CREATE USER 'rentuser'@'localhost' IDENTIFIED BY 'STRONG_PASSWORD';

-- Give the user basic permissions for this database only
GRANT SELECT, INSERT, UPDATE, DELETE ON gamerentals.* TO 'rentuser'@'localhost';
FLUSH PRIVILEGES;

USE gamerentals;
DROP TABLE IF EXISTS rentals;
DROP Table IF EXISTS games;

-- Create table for games
CREATE TABLE games (
  id INT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  platform VARCHAR(50) NOT NULL,
  is_top TINYINT NOT NULL DEFAULT 0,  -- 1 = Top 5 popular list
  status VARCHAR(20) NOT NULL DEFAULT 'available',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- Create table for rentals
CREATE TABLE rentals (
  rental_id INT PRIMARY KEY,
  game_id INT NOT NULL,
  customer_name VARCHAR(255) NOT NULL,
  rented_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  returned_at TIMESTAMP NULL,
  FOREIGN KEY (game_id) REFERENCES games(id)
);

-- sample games
INSERT INTO games (id, title, platform, is_top, status) VALUES
  (1, 'The Legend of Zelda: Breath of the Wild', 'Switch', 1, 'available'),
  (2, 'Mario Kart 8 Deluxe', 'Switch', 1, 'available'),
  (3, 'God of War (2018)', 'PS4', 1, 'available'),
  (4, 'Red Dead Redemption 2', 'PS4', 1, 'available'),
  (5, 'Halo: The Master Chief Collection', 'Xbox', 1, 'available'),
  (6, 'Animal Crossing: New Horizons', 'Switch', 0, 'available'),
  (7, 'Gran Turismo Sport', 'PS4', 0, 'available'),
  (8, 'Gears 5', 'Xbox', 0, 'available');