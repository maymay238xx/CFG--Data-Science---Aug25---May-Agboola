## Assignment 3 - Gym Studio SQL Database 🏋🏾‍♀️


### What the Database should hopefully do 🤞🏾
From interacting you'll observe that:
- Session timetable will be ordered Mon - Sun, then by time
- Joined view of member bookings with class session names
- Booked vs remaining spots per class using `COUNT` + `CASE`
- Total bookings `GROUPED BY` _Weekday_
- Uppercased active member names `UPPER` with `ORDER BY` join date
- _In additon_: Members with no bookings will be revealed using `LEFT JOIN`...`IS NULL`

### ▶️ How to Run:
You can run the whole script from top-to-bottom and it works in MySQL workbench or the mysql command-line

Download the `assignment-3.sql` file available on the homepage.

### 🔧 Requirements:
- Stable current version of MySQL Workbench
- Download the script `assignment-3.sql`