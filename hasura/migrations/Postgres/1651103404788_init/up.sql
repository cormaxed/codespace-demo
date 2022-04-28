SET check_function_bodies = false;
CREATE TABLE public.billboard_single_by_year (
    "position" integer NOT NULL,
    year integer NOT NULL,
    title text NOT NULL,
    artist text NOT NULL
);
ALTER TABLE ONLY public.billboard_single_by_year
    ADD CONSTRAINT billboard_single_by_year_pkey PRIMARY KEY (year, title, artist);
