## Assignment 2 – Naruto Episodes (Jikan API) 🥷🏾

**API**: I will be using an unofficial anime one I found called Jikan (https://jikan.moe) the API of which can be found here: https://docs.api.jikan.moe – no API key required.

**What the demo will do in theory 😅🙏🏾**
- Asks you to choose **Naruto** or **Shippuden**
- Calls the Jikan API to fetch the first page of episodes.
- Goes through each episode and creates a simple report:
  - Episode number
  - Shortened episode title (string slicing: first 20 charachters)
  - Whether it looks like **filler** episode (boolean check using `if/else`).
- Prints the number of episodes to it found (using `len()`).
- Saves the results to a text file called **`episodes.txt`**.


**How to run**
```bash
pip install -r requirements.txt
python assignment_2.py
```


### Requirements:
- Python 3.13 and above
- Install packages with: `pip install -r requirements.txt`

**Note on versions:**  
The Jikan API we call is **v4.0.0**, which you see in the URL (e.g. `https://docs.api.jikan.moe`).  

This is the web service version.

The Python package `requests==2.31.0` will talk to that API.

The module package `rich==13.7.1` will be used to make a nice table output
