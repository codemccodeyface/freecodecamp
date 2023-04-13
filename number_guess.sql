--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: userinfo; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.userinfo (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games integer,
    best_game integer
);


ALTER TABLE public.userinfo OWNER TO freecodecamp;

--
-- Name: userinfo_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.userinfo_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userinfo_user_id_seq OWNER TO freecodecamp;

--
-- Name: userinfo_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.userinfo_user_id_seq OWNED BY public.userinfo.user_id;


--
-- Name: userinfo user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userinfo ALTER COLUMN user_id SET DEFAULT nextval('public.userinfo_user_id_seq'::regclass);


--
-- Data for Name: userinfo; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.userinfo VALUES (45, 'user_1681353479335', 2, 351);
INSERT INTO public.userinfo VALUES (44, 'user_1681353479336', 5, 227);
INSERT INTO public.userinfo VALUES (43, 'code', 1, 10);
INSERT INTO public.userinfo VALUES (47, 'user_1681353684581', 2, 148);
INSERT INTO public.userinfo VALUES (46, 'user_1681353684582', 4, 32);
INSERT INTO public.userinfo VALUES (49, 'user_1681353745371', 2, 217);
INSERT INTO public.userinfo VALUES (48, 'user_1681353745372', 5, 110);


--
-- Name: userinfo_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.userinfo_user_id_seq', 49, true);


--
-- PostgreSQL database dump complete
--

