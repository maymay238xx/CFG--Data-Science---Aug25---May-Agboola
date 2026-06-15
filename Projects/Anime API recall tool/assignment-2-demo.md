## Assignment 2 – Naruto Episodes (Jikan API) 🥷🏾

I will be using Jikan (https://jikan.moe) the version of which can be found here: https://docs.api.jikan.moe – no API key required.

### **What the Demo should do in theory 😅🙏🏾**
- Asks you to choose between original Naruto series **Naruto** or **Shippuden** 
- Calls the Jikan API to fetch the first page of episodes.
- Goes through each episode and creates a simple report:
  - Episode number
  - Shortened episode title (string slicing: first 20 characters)
  - Whether it looks like **filler** episode boolean check using `if/else`.
- Prints the number of episodes found using `len()`.
- Saves the results to a text file called **`episodes.txt`**.


### ▶️ How to run:

Enter into the console:
```bash
pip install -r requirements.txt
```
**_Then_**
```bash
python Anime API recall tool.py
```


### 🔧 Requirements:
- Python 3.13 or latest
- Install packages with: `pip install -r requirements.txt`

**Note on versions:**  
The Jikan API we'll call from is **v4.0.0**, which you'll see in the URL (e.g. `https://docs.api.jikan.moe`).  

This is the web service version.

The Python package `requests==2.31.0` will talk to the API.

The module package `rich==13.7.1` located within `requirements.txt`  will be used to make a nice table output
