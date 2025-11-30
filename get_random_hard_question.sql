SELECT
    T."primaryTitle",
    T."startYear",
    N."primaryName"
FROM
    public.title_basics AS T
JOIN
    public.title_ratings AS R ON T.tconst = R.tconst
JOIN
    public.title_principals AS P ON T.tconst = P.tconst
JOIN
    public.name_basics AS N ON P.nconst = N.nconst
WHERE
    T."titleType" = 'movie'
    AND R."numVotes" > 10000
    AND R."numVotes" < 50000
    AND P.ordering = '1'
    AND P.category IN ('actor', 'actress')
ORDER BY
    RANDOM()
LIMIT 1;