-- MASTER INDEX CREATION SCRIPT (v2 - Complete)
-- This script creates all primary keys and performance-critical indexes
-- after all data has been successfully loaded as TEXT.
-- ====================================================================

\echo '--- STARTING INDEX CREATION ---'

-- Step 1: Set performance parameters for the entire session.
SET maintenance_work_mem = '8GB';
\echo 'Set maintenance_work_mem to 8GB for this session.'

-- ====================================================================
-- Table: name_basics
-- ====================================================================
\echo 'Building Primary Key for name_basics...'
ALTER TABLE public.name_basics ADD CONSTRAINT name_basics_pkey PRIMARY KEY (nconst);

-- ====================================================================
-- Table: title_basics
-- ====================================================================
\echo 'Building Primary Key for title_basics...'
ALTER TABLE public.title_basics ADD CONSTRAINT title_basics_pkey PRIMARY KEY (tconst);

-- ====================================================================
-- Table: title_principals
-- ====================================================================
\echo 'Building Primary Key for title_principals...'
-- NOTE: The primary key here is a composite of tconst and ordering
ALTER TABLE public.title_principals ADD CONSTRAINT title_principals_pkey PRIMARY KEY (tconst, ordering);

\echo 'Building foreign key index on title_principals(nconst)...'
CREATE INDEX ON public.title_principals (nconst);

-- ====================================================================
-- Table: title_ratings
-- ====================================================================
\echo 'Building Primary Key for title_ratings...'
ALTER TABLE public.title_ratings ADD CONSTRAINT title_ratings_pkey PRIMARY KEY (tconst);


\echo '--- INDEX CREATION COMPLETE ---'