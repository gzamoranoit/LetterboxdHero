\echo '--- Starting Data Type Conversion ---'

\echo 'Converting year columns in name_basics...'
ALTER TABLE public.name_basics
    ALTER COLUMN "birthYear" TYPE INTEGER USING ("birthYear"::integer),
    ALTER COLUMN "deathYear" TYPE INTEGER USING ("deathYear"::integer);

\echo 'Converting columns in title_basics...'
ALTER TABLE public.title_basics
    ALTER COLUMN "startYear" TYPE INTEGER USING ("startYear"::integer),
    ALTER COLUMN "endYear" TYPE INTEGER USING ("endYear"::integer),
    ALTER COLUMN "runtimeMinutes" TYPE INTEGER USING ("runtimeMinutes"::integer);

\echo 'Converting columns in title_ratings...'
ALTER TABLE public.title_ratings
    ALTER COLUMN "averageRating" TYPE DECIMAL(3,1) USING ("averageRating"::decimal),
    ALTER COLUMN "numVotes" TYPE INTEGER USING ("numVotes"::integer);


\echo '--- Data Type Conversion Complete ---'