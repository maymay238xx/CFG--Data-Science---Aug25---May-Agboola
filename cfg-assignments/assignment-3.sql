-- ==============================================================
-- Assignment 3 - Gym Studio Booking Database System - Incl guide to my script explaining what I did
-- What you'll observe:
 -- Session timetable ordered Mon-Sun, then by time
 -- Joined view of member bookings with class session names
 -- Booked vs remaining spots per class using COUNT + CASE
 -- Total bookings grouped by weekday
 -- Uppercased active member names (UPPER) with order by join date
 -- To snitch: Members with no bookings will be revealed using LEFT JOIN...IS NULL and the use of UNIQUE to prevent duplicates
-- =============================================================
-- You can run the whole script top-to-bottom and works in MySQL workbench or a mysql command-line
--  RESET -----------------------------------------------------
DROP DATABASE IF EXISTS maysgym_db; -- Because I've been testing this db a million times and for the sake of avoiding the annoying duplicate error msg we want to delete any old copy
CREATE DATABASE maysgym_db CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci; -- To save the stress of reliance on perfect character format inputs we're using this bit to treat every character as uniform
USE maysgym_db;

-- TABLES ----------------------------------------------------
-- I will set IDs by hand (1,2,3...)

-- Members Table    -- I will insert 1,2,3...
CREATE TABLE members (
  member_id INT PRIMARY KEY,               -- member_id will be our assigned unique identifier as a primary key
  first_name VARCHAR(50) NOT NULL,		   -- Using NOT NULL because we can't have these empty obvs so we enforce the rule that no blanks are allowed for such columns
  last_name  VARCHAR(50) NOT NULL,         -- Using VARCHAR 50 for shorter characters as we dont expect names to be super long
  email      VARCHAR(120) NOT NULL UNIQUE, -- no duplicates allowed on email, as two different members shouldn't share the same account email address cause we're stingy like that lol
  join_date  DATE NOT NULL,                -- Mandatory that join_date have values filled
  status     VARCHAR(10) NOT NULL          -- ACTIVE / SUSPENDED / CANCELLED, the longest word is 9 characters, so VARCHAR 10
);

-- Classes Table     -- I will insert 1,2,3
CREATE TABLE classes (
  class_id INT PRIMARY KEY, -- class_id will be our assigned unique identifier as a primary key
  class_name VARCHAR (80) NOT NULL,
  weekday    VARCHAR(3) NOT NULL,          -- Mon, Tue, Wed
  start_time TIME NOT NULL,
  capacity   INT NOT NULL,
  CHECK (capacity > 0)                     -- simple CHECK constraint
);

-- Bookings (links a member to a class) -- I will insert 1,2,3
CREATE TABLE bookings (
  booking_id INT PRIMARY KEY,              -- booking_id will be our assigned unique identifier as a primary key
  member_id  INT NOT NULL,
  class_id   INT NOT NULL,
  booked_at  DATETIME NOT NULL,
  status     VARCHAR(10) NOT NULL,         -- BOOKED / CANCELLED / ATTENDED
  CONSTRAINT fk_bookings_member FOREIGN KEY (member_id) -- Here we're defining our foreign key for member bookings ourselves using CONSTRAINT and calling it fk_.. so its easier to remember
  REFERENCES members(member_id) -- The references bit ensures it must match a valid member_id if the user inserts one that doesnt exist, MySQL will reject
    ON UPDATE CASCADE ON DELETE CASCADE, -- This bit essentially means that if member_id changes in the members table then update it automatically in the bookings table, and if deleted then all bookings will be deleted also, keepying the data clean and in sync
  CONSTRAINT fk_bookings_class  FOREIGN KEY (class_id)
  REFERENCES classes(class_id)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- DATA ---------------------------------

-- Members (IDs 1..8)
INSERT INTO members VALUES
(1,'Emily','Stone', 'emily@mayisthebest.ie','2025-01-12','ACTIVE'),
(2,'Naruto','Uzamaki', 'naruto@mayissupercool.com','2025-02-03','ACTIVE'),
(3,'Kemi','Adebayo','kemi@mayisawesome.co.uk','2025-02-19','ACTIVE'),
(4,'Will','Smith','P@mayismay.com','2025-03-01','SUSPENDED '),
(5,'Priya','Patel', 'priya@mayslayy.com','2025-03-18','ACTIVE'),
(6,'Ruby','King' ,'ruby@shesjustagirl.co.uk','2025-04-02','ACTIVE'),
(7,'Monkey', 'D.Luffy','monkey@shesacutie.com','2025-04-20','ACTIVE'),
(8,'Boris','Johnson','boris@mayiseverything.co.uk','2025-05-05','CANCELLED');

-- Classes (IDs 1..8)
INSERT INTO classes VALUES
(1,'Morning HIIT','Mon','07:00',20),
(2,'Boxing Basics','Tue','18:00',16),
(3,'Power Yoga', 'Wed','19:30',18),
(4,'Spin Express','Thu','07:30', 22),
(5, 'Strength 101', 'Fri','17:30',15),
(6,'Pilates Core', 'Sat','10:00',14),
(7,'Mobility & Stretch','Sun', '09:00',25),
(8,'CrossFit','Wed','06:30', 12);

-- Bookings (IDs 1..10)
INSERT INTO bookings VALUES
(1,1, 1,'2025-06-01 08:00:00','BOOKED'), -- the booking would display as booking_id,member_id and class_id which in this case is 1,1,1
(2,1,3,'2025-06-03 19:00:00','ATTENDED'),
(3, 2,1,'2025-06-02 07:30:00', 'BOOKED'),
(4,2,5,'2025-06-06 17:00:00', 'ATTENDED'),
(5,3,2, '2025-06-04 18:00:00','BOOKED'),
(6,4,4,'2025-06-05 07:00:00','CANCELLED'),
(7,5,7, '2025-06-08 08:30:00', 'BOOKED'),
(8,6,8,'2025-06-09 06:00:00','BOOKED'),
(9,7,8,'2025-06-10 06:00:00','BOOKED'),
(10,7,5, '2025-06-13 17:00:00', 'ATTENDED');

-- BASIC DML  ---------------------------------
-- INSERT: add a new member : May (#9) and her booking (#11)
INSERT INTO members VALUES (9,'May','Agboola','may@thegoat.com','2025-06-15','ACTIVE');
INSERT INTO bookings VALUES (11,9,3,'2025-06-15 10:00:00','BOOKED');

-- UPDATE: suspend Naruto by email ID
UPDATE members
SET status='SUSPENDED'
WHERE email='naruto@mayissupercool.com';

-- DELETE: remove old CANCELLED bookings before 2025-06-05
DELETE FROM bookings
WHERE status='CANCELLED'
AND booked_at < '2025-06-05 00:00:00'
AND booking_id > 0; -- this bit was key because for some reason it wouldn't let me delete because of safemode so clocked that I needed to include the primary key booking_id in WHERE

-- SELECT QUERIES ----------------------

-- Timetable format ordered by weekday then time (ORDER BY + time format function for nice display of time)
SELECT class_id, class_name, weekday, TIME_FORMAT(start_time,'%H:%i') AS starts_at, capacity
FROM classes
ORDER BY FIELD(weekday,'Mon','Tue','Wed','Thu','Fri','Sat','Sun'), start_time;

-- Who booked what? (JOIN members-->bookings-->classes)
SELECT b.booking_id,
       CONCAT(m.first_name,' ',m.last_name) AS member, c.class_name,
       DATE_FORMAT(b.booked_at,'%Y-%m-%d %H:%i') AS booked_at, b.status
FROM bookings b
JOIN members m ON m.member_id=b.member_id -- Matches up bookings with member who made them
JOIN classes c ON c.class_id=b.class_id -- Matches booking with class they booked
ORDER BY b.booked_at DESC; -- Sorts results by booking time, newest first

-- How many spots are booked per class? (Aggregate COUNT)
SELECT c.class_name,
       COUNT(CASE WHEN b.status= 'BOOKED' THEN 1 END) AS booked_slots, -- we're counting only the booked rows per class
       c.capacity,
       (c.capacity - COUNT(CASE WHEN b.status= 'BOOKED' THEN 1 END)) AS remaining -- capacity is the total seats for the class, remaining= capacity - booked_slots (no. of free slots left)
FROM classes c
LEFT JOIN bookings b ON b.class_id=c.class_id -- we can't use inner join because it would hide classes with zero bookings, so left keeps them
GROUP BY c.class_id, c.class_name, c.capacity -- collapses the row by class and computes COUNT per class
ORDER BY remaining DESC; -- show classes with most free seats first

-- Members with NO bookings yet (LEFT JOIN + IS NULL) -- It should be 'Boris Johnson' as a disclaimer
SELECT m.member_id, CONCAT(m.first_name,' ',m.last_name) AS member
FROM members m
LEFT JOIN bookings b ON b.member_id=m.member_id -- if a member has bookings you'll see their matches, if they've none then you'll still get member row but with NULL in the column
WHERE b.booking_id IS NULL -- filters results with members with no bookings displaying a NULL output
ORDER BY member; -- sorts the output alphabetically by their concatenated name

-- Total bookings per weekday (Aggregate)
SELECT c.weekday, COUNT(*) AS total_bookings
FROM classes c
JOIN bookings b ON b.class_id=c.class_id -- we're joining classes with bookings so we can connect each booking to the class it belongs to
GROUP BY c.weekday -- collapse the rows by weekday and count them
ORDER BY total_bookings DESC; -- sorts the grouped results by busiest to least

-- Active members in UPPERCASE (Function UPPER) -- This makes it visually easier to see who's ACTIVELY got membership by spelling their name out in CAPS
SELECT m.member_id, UPPER(CONCAT(m.first_name,' ',m.last_name)) AS member_name, m.status, m.join_date -- e.g NARUTO UZAMAKI
FROM members m
WHERE m.status='ACTIVE'
ORDER BY m.join_date DESC; -- displays membership from newest to oldest


-- STORED PROCEDURE ----------------------
-- To create a booking only if the class is not full and the member is ACTIVE.
DELIMITER //
CREATE PROCEDURE try_book_simple( -- I'll be using signal for this procedure otherwise without it the procedure would just keep running or could silently fail without notifying
  IN p_booking_id INT,
  IN p_member_id INT,-- the use of P_.. will be short for 'parameter' to remind me that its not a column because this assignment has been long lol
  IN p_class_id  INT,
  IN p_when DATETIME
)
BEGIN -- v_status will temporarily hold a members status
  DECLARE v_status   VARCHAR(10); -- here i'll be creating local variables inside the procedure using DECLARE v_.. for the sole purpose of the procedure call
  DECLARE v_capacity INT; -- v_capacity will temporarily hold classes seat limit, this way we can compare how many seats vs booked capacity

  -- Member must exist & be ACTIVE
  SELECT status INTO v_status  -- here I'll be using SELECT INTO so that it not only shows the results but stores them into a variable that can be used later
  FROM members
  WHERE member_id = p_member_id;
  IF v_status IS NULL OR v_status <> 'ACTIVE' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Member must exist and be ACTIVE'; -- using SIGNAL SQLSTATE is a way to manually raise an error within the stored procedure choosing 45000 error code for user-defined error inputs
  END IF;

  -- Class must exist
  SELECT capacity INTO v_capacity
  FROM classes
  WHERE class_id = p_class_id;
  IF v_capacity IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Class not found';
  END IF;

  --  Capacity check (count BOOKED inline; no extra variable)
  IF (SELECT COUNT(*)
  FROM bookings
  WHERE class_id = p_class_id AND status = 'BOOKED') >= v_capacity THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Class is full';
  END IF;

  -- Do the booking
  INSERT INTO bookings(booking_id, member_id, class_id, booked_at, status)
  VALUES (p_booking_id, p_member_id, p_class_id, p_when, 'BOOKED');
END //
DELIMITER ;


-- Example call:
-- CALL try_book(12,1,1, '2025-06-16 07:00:00');

-- finito my brain has been well and truly fried :(

