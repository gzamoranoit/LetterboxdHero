# Letterboxd Hero

Letterboxd Hero is a web-based movie trivia game powered by a PostgreSQL database. It leverages the public [IMDb dataset from Kaggle](https://www.kaggle.com/datasets/ashirwadsangwan/imdb-dataset/data) to generate dynamic trivia questions.

Players are challenged to identify the lead actor of a randomly selected film. The game features a progression system where the difficulty (the obscurity of the movie) automatically adjusts based on the player's current score.

I wanted to build something I would have fun playing, and I feel like I largely succeeded.

## Features
*   **Dynamic Questions:** Generates trivia on the fly from a database of over 14 million people and titles.
*   **Progression System:** Logic that serves "Easy" questions (blockbusters) or "Medium/Hard" questions (niche films) based on performance.
*   **Interactive UI:** Features a full game loop with popups, sound effects, and persistent state (score/lives) that survives page reloads.
*   **Automated Pipeline:** Includes a full ETL (Extract, Transform, Load) script to build, clean, convert types, and index the database from raw TSV files.

## Tech Stack
*   **Backend:** Python, Flask
*   **Database:** PostgreSQL 18
*   **Database Driver:** psycopg2
*   **Frontend:** HTML5, CSS3, Vanilla JavaScript
*   **Automation:** Bash scripting

## Setup and Installation

Instructions to set up the project locally.

**Prerequisites:**
*   Python 3.12+
*   A running PostgreSQL 18 server

### 1. Clone the Repository
```bash
git clone https://github.com/gzamoranoit/LetterboxdHero.git
cd LetterboxdHero
```

### 2. Set Up the Virtual Environment
Create and activate a Python virtual environment to keep dependencies isolated.
```bash
python3 -m venv venv
source venv/bin/activate
```

### 3. Install Dependencies
```bash
pip install flask psycopg2-binary
```

### 4. Configure Database Access
The automation scripts use a `.pgpass` file for secure, password-less database access.

1. Create a file named `.pgpass` in your home directory (`~/.pgpass`).
2. Add the following line (replace `your_password` with your actual Postgres password):
   ```text
   localhost:5433:postgres:postgres:your_password
   ```
3. Set the correct permissions so Postgres accepts the file:
   ```bash
   chmod 600 ~/.pgpass
   ```

### 5. Build the Database
**Note:** This project requires the IMDb `.tsv` data files.

1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/ashirwadsangwan/imdb-dataset/data).
2. Place the unzipped `.tsv` files in your `~/Downloads/Archive` folder (or update the `SOURCE_DIR` path in `build_database.sh`).

Run the master build script. This will automatically create the schemas, import the raw data, perform data type conversions (Text -> Integer), and build the primary keys.

```bash
./build_database.sh
```

1. Ensure your virtual environment is active:
   ```bash
   source venv/bin/activate
   ```
2. Start the Flask server:
   ```bash
   python app.py
   ```
3. Open your browser and navigate to:
   `http://localhost:5000`
