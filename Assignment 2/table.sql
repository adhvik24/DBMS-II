-- Table: public.author

-- DROP TABLE IF EXISTS public.author;

CREATE TABLE IF NOT EXISTS public.author
(
    author_id integer NOT NULL,
    first_name text COLLATE pg_catalog."default" NOT NULL,
    last_name text COLLATE pg_catalog."default",
    email_id text COLLATE pg_catalog."default",
    CONSTRAINT "Author_pkey" PRIMARY KEY (author_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.author
    OWNER to postgres;



-- Table: public.publication_venue

-- DROP TABLE IF EXISTS public.publication_venue;

CREATE TABLE IF NOT EXISTS public.publication_venue
(
    publisher_id integer NOT NULL,
    venue text COLLATE pg_catalog."default" NOT NULL,
    valid_years integer NOT NULL DEFAULT 10,
    CONSTRAINT "Publication_Venue_pkey" PRIMARY KEY (publisher_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.publication_venue
    OWNER to postgres;



-- Table: public.paper

-- DROP TABLE IF EXISTS public.paper;

CREATE TABLE IF NOT EXISTS public.paper
(
    paper_id integer NOT NULL,
    publication_year integer NOT NULL,
    publisher_id_fk integer NOT NULL,
    main_author_id_fk integer NOT NULL,
    title text COLLATE pg_catalog."default",
    abstract text COLLATE pg_catalog."default",
    CONSTRAINT "Paper_pkey" PRIMARY KEY (paper_id),
    CONSTRAINT "Author_Id_fk" FOREIGN KEY (main_author_id_fk)
        REFERENCES public.author (author_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Publisher_Id_fk" FOREIGN KEY (publisher_id_fk)
        REFERENCES public.publication_venue (publisher_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.paper
    OWNER to postgres;



-- Table: public.citation

-- DROP TABLE IF EXISTS public.citation;

CREATE TABLE IF NOT EXISTS public.citation
(
    main_paper_id_fk integer NOT NULL,
    referred_paper_id_fk integer NOT NULL,
    CONSTRAINT "Paper_Id1_fk" FOREIGN KEY (main_paper_id_fk)
        REFERENCES public.paper (paper_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Paper_Id2_fk" FOREIGN KEY (referred_paper_id_fk)
        REFERENCES public.paper (paper_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.citation
    OWNER to postgres;



-- Table: public.co_author

-- DROP TABLE IF EXISTS public.co_author;

CREATE TABLE IF NOT EXISTS public.co_author
(
    paper_id_fk integer NOT NULL,
    co_author_id_fk integer NOT NULL,
    rank integer,
    CONSTRAINT "Co_Author_Id_fk" FOREIGN KEY (co_author_id_fk)
        REFERENCES public.author (author_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "Paper_Id_fk" FOREIGN KEY (paper_id_fk)
        REFERENCES public.paper (paper_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.co_author
    OWNER to postgres;