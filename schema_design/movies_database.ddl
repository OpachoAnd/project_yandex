CREATE SCHEMA IF NOT EXISTS content;

CREATE TABLE IF NOT EXISTS content.film_work
(
    id uuid NOT NULL,
    title text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    creation_date date,
    rating double precision,
    type text COLLATE pg_catalog."default" NOT NULL,
    created timestamp with time zone,
    modified timestamp with time zone,
    CONSTRAINT film_work_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS content.genre
(
    id uuid NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    created timestamp with time zone,
    modified timestamp with time zone,
    CONSTRAINT genre_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS content.genre_film_work
(
    id uuid NOT NULL,
    genre_id uuid,
    film_work_id uuid,
    created timestamp with time zone,
    CONSTRAINT genre_film_work_pkey PRIMARY KEY (id),
    CONSTRAINT genre_film_work_film_work_id_fkey FOREIGN KEY (film_work_id)
        REFERENCES content.film_work (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT genre_film_work_genre_id_fkey FOREIGN KEY (genre_id)
        REFERENCES content.genre (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS content.person
(
    id uuid NOT NULL,
    full_name text COLLATE pg_catalog."default" NOT NULL,
    created timestamp with time zone,
    modified timestamp with time zone,
    CONSTRAINT person_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS content.person_film_work
(
    id uuid NOT NULL,
    person_id uuid,
    film_work_id uuid,
    role text COLLATE pg_catalog."default",
    created timestamp with time zone,
    CONSTRAINT person_film_work_pkey PRIMARY KEY (id),
    CONSTRAINT person_film_work_film_work_id_fkey FOREIGN KEY (film_work_id)
        REFERENCES content.film_work (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT person_film_work_person_id_fkey FOREIGN KEY (person_id)
        REFERENCES content.person (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE UNIQUE INDEX genre_film_work_idx ON content.genre_film_work (film_work_id, genre_id);
CREATE UNIQUE INDEX person_film_work_idx ON content.person_film_work (film_work_id, person_id);

CREATE INDEX full_name_person_idx ON content.person (full_name);
CREATE INDEX title_film_idx ON content.film_work (title);
