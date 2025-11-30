-- ====================================================================
-- This script drops and recreates ALL tables for a clean slate.
-- All tables are created with forgiving TEXT types for the initial load.
-- ====================================================================

\echo '--- STARTING SCHEMA CREATION ---'

-- --- Table: name_basics ---
-- Stores information about people (actors, directors, etc.)
DROP TABLE IF EXISTS public.name_basics;
\echo 'Dropped table public.name_basics (if it existed).'
CREATE TABLE public.name_basics (
    nconst TEXT,            -- Unique identifier for the person
    "primaryName" TEXT,
    "birthYear" TEXT,       -- Imported as TEXT, will be converted later
    "deathYear" TEXT,       -- Imported as TEXT, will be converted later
    "primaryProfession" TEXT,
    "knownForTitles" TEXT   -- A list of tconsts
);
\echo 'Created table public.name_basics.'

-- --- Table: title_basics ---
-- Stores core information about all titles (movies, series, episodes)
DROP TABLE IF EXISTS public.title_basics;
\echo 'Dropped table public.title_basics (if it existed).'
CREATE TABLE public.title_basics (
    tconst TEXT,            -- Unique identifier for the title
    "titleType" TEXT,
    "primaryTitle" TEXT,
    "originalTitle" TEXT,
    "isAdult" TEXT,         -- Imported as TEXT (0 or 1)
    "startYear" TEXT,       -- Imported as TEXT
    "endYear" TEXT,         -- Imported as TEXT
    "runtimeMinutes" TEXT,  -- Imported as TEXT
    genres TEXT
);
\echo 'Created table public.title_basics.'

-- --- Table: title_principals ---
-- The crucial "linking" table. Connects people (nconst) to titles (tconst).
DROP TABLE IF EXISTS public.title_principals;
\echo 'Dropped table public.title_principals (if it existed).'
CREATE TABLE public.title_principals (
    tconst TEXT,            -- The title identifier
    ordering TEXT,          -- A number indicating the order of importance (e.g., lead actor is 1)
    nconst TEXT,            -- The person identifier
    category TEXT,          -- e.g., 'actor', 'director', 'composer'
    job TEXT,
    characters TEXT
);
\echo 'Created table public.title_principals.'

-- --- Table: title_ratings ---
-- Stores the IMDb rating and vote count for titles.
DROP TABLE IF EXISTS public.title_ratings;
\echo 'Dropped table public.title_ratings (if it existed).'
CREATE TABLE public.title_ratings (
    tconst TEXT,            -- The title identifier
    "averageRating" TEXT,   -- Imported as TEXT (e.g., '7.8')
    "numVotes" TEXT         -- Imported as TEXT
);
\echo 'Created table public.title_ratings.'


\echo '--- SCHEMA CREATION COMPLETE ---'