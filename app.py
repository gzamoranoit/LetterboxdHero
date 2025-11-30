from flask import Flask, render_template, request, jsonify
from database import fetch_query_from_file
from database import execute_query_from_text

app = Flask(__name__)

def generate_easy_trivia_question():
    print("Generating a new trivia question...")
    sql_file = "get_random_easy_question.sql"
    results = fetch_query_from_file(sql_file)
    if results:
        return results[0]
    
def generate_medium_trivia_question():
    print("Generating a new trivia question...")
    sql_file = "get_random_medium_question.sql"
    results = fetch_query_from_file(sql_file)
    if results:
        return results[0]
    
def generate_hard_trivia_question():
    print("Generating a new trivia question...")
    sql_file = "get_random_hard_question.sql"
    results = fetch_query_from_file(sql_file)
    if results:
        return results[0]
                
@app.route('/') 
def menu():
    return render_template('menu.html')


@app.route('/play')
def index():
    score_from_url = request.args.get('score', default=0, type=int)
    print(f"--- New Request --- Score from URL is: {score_from_url}")
    if score_from_url < 5:
        results=generate_easy_trivia_question() 
    elif score_from_url < 10:
        results=generate_medium_trivia_question()   
    else:
        results=generate_hard_trivia_question() 

    movie_title, movie_year, lead_actor = results # type: ignore
    movie_year=int(movie_year)
    results = get_distractor_actors(movie_year,lead_actor)
    actors=[res[0] for res in results] # type: ignore
    print(actors)
    print(results)
    return render_template('index.html', movie=movie_title, year=movie_year, actor=lead_actor, WrongActor1 = actors[0],WrongActor2 = actors[1],WrongActor3 = actors[2])
        

def get_distractor_actors(movie_year,lead_actor):
    min_year = movie_year-100
    max_year = movie_year-10
    params = (min_year,max_year, lead_actor)
    
    sql_query = """
    SELECT N."primaryName"
    FROM public.name_basics as N
    JOIN public.title_principals as P on N.nconst = P.nconst
    JOIN public.title_ratings as R on P.tconst = R.tconst
    WHERE
        N."birthYear" BETWEEN %s and %s
        AND N."primaryName" != %s
        AND P.ordering = '1'
        AND P.category IN ('actor','actress')
        AND R."numVotes" > 50000
    ORDER BY RANDOM()
    LIMIT 3;
    """
    results = execute_query_from_text(sql_query, params)
    return results
    
if __name__ == "__main__":
    app.run(debug=True)