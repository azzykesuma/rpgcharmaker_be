
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;

CREATE TABLE public.element_types (
    element_types_id integer NOT NULL,
    element_types_name public.citext NOT NULL
);


ALTER TABLE public.element_types OWNER TO postgres;

--
-- Name: element_types_element_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.element_types_element_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.element_types_element_types_id_seq OWNER TO postgres;

--
-- Name: element_types_element_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.element_types_element_types_id_seq OWNED BY public.element_types.element_types_id;


--
-- Name: enemy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enemy (
    enemy_id uuid DEFAULT gen_random_uuid() NOT NULL,
    enemy_name character varying NOT NULL,
    enemy_base_hp integer NOT NULL,
    enemy_base_mp integer NOT NULL,
    enemy_base_dex integer NOT NULL,
    enemy_base_constitution integer NOT NULL,
    enemy_base_int integer NOT NULL,
    enemy_resistance integer,
    enemy_weakness integer,
    enemy_image text,
    enemy_image_attack text,
    enemy_image_attacked text
);


ALTER TABLE public.enemy OWNER TO postgres;

--
-- Name: learn; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.learn (
    id integer NOT NULL,
    name character varying(50),
    "time" timestamp without time zone DEFAULT now(),
    age integer,
    checklearn boolean DEFAULT false,
    city character varying(50)
);


ALTER TABLE public.learn OWNER TO postgres;

--
-- Name: learn_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.learn_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.learn_id_seq OWNER TO postgres;

--
-- Name: learn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.learn_id_seq OWNED BY public.learn.id;


--
-- Name: master_class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.master_class (
    class_id integer NOT NULL,
    class_name character varying NOT NULL,
    class_base_dex integer NOT NULL,
    class_base_int integer NOT NULL,
    class_base_hp integer NOT NULL,
    class_base_mp integer NOT NULL,
    class_base_str integer NOT NULL,
    class_main_stat character varying NOT NULL,
    CONSTRAINT check_class_type CHECK (((class_main_stat)::text = ANY ((ARRAY['str'::character varying, 'dex'::character varying, 'int'::character varying])::text[])))
);


ALTER TABLE public.master_class OWNER TO postgres;

--
-- Name: master_class_class_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.master_class_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.master_class_class_id_seq OWNER TO postgres;

--
-- Name: master_class_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.master_class_class_id_seq OWNED BY public.master_class.class_id;


--
-- Name: old_people; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.old_people AS
 SELECT age
   FROM public.learn
  WHERE (age > 100);


ALTER VIEW public.old_people OWNER TO postgres;

--
-- Name: player; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player (
    user_id uuid DEFAULT gen_random_uuid() NOT NULL,
    player_name character varying,
    player_class integer,
    player_weapon integer,
    role character varying(10),
    player_password text
);


ALTER TABLE public.player OWNER TO postgres;

--
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refresh_tokens (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    token character varying(500) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.refresh_tokens OWNER TO postgres;

--
-- Name: resistance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resistance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resistance_id_seq OWNER TO postgres;

--
-- Name: resistances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resistances (
    resistance_id integer NOT NULL,
    resistance_type integer NOT NULL,
    resistance_damage_reduction integer NOT NULL
);


ALTER TABLE public.resistances OWNER TO postgres;

--
-- Name: resistance_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resistance_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resistance_seq OWNER TO postgres;

--
-- Name: resistance_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resistance_seq OWNED BY public.resistances.resistance_id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    user_id uuid NOT NULL,
    session_id integer NOT NULL,
    token text NOT NULL,
    user_agent text,
    login_time time with time zone DEFAULT now(),
    logout_time timestamp without time zone
);


ALTER TABLE public.session OWNER TO postgres;

--
-- Name: session_session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.session_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.session_session_id_seq OWNER TO postgres;

--
-- Name: session_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.session_session_id_seq OWNED BY public.session.session_id;


--
-- Name: weakness; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.weakness (
    weakness_id integer NOT NULL,
    weakness_type integer NOT NULL,
    weakness_damage_mult integer NOT NULL
);


ALTER TABLE public.weakness OWNER TO postgres;

--
-- Name: weakness_weakness_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.weakness_weakness_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.weakness_weakness_id_seq OWNER TO postgres;

--
-- Name: weakness_weakness_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.weakness_weakness_id_seq OWNED BY public.weakness.weakness_id;


--
-- Name: weapon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.weapon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.weapon_id_seq OWNER TO postgres;

--
-- Name: weapon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.weapon (
    weapon_id integer DEFAULT nextval('public.weapon_id_seq'::regclass) NOT NULL,
    weapon_element integer,
    weapon_type integer,
    weapon_base_damage integer,
    weapon_name character varying(20),
    weapon_image text
);


ALTER TABLE public.weapon OWNER TO postgres;

--
-- Name: weapon_master_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.weapon_master_type (
    weapon_type_id bigint NOT NULL,
    weapon_type_name public.citext
);


ALTER TABLE public.weapon_master_type OWNER TO postgres;

--
-- Name: weapon_master_type_weapon_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.weapon_master_type_weapon_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.weapon_master_type_weapon_type_id_seq OWNER TO postgres;

--
-- Name: weapon_master_type_weapon_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.weapon_master_type_weapon_type_id_seq OWNED BY public.weapon_master_type.weapon_type_id;


--
-- Name: element_types element_types_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.element_types ALTER COLUMN element_types_id SET DEFAULT nextval('public.element_types_element_types_id_seq'::regclass);


--
-- Name: learn id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learn ALTER COLUMN id SET DEFAULT nextval('public.learn_id_seq'::regclass);


--
-- Name: master_class class_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.master_class ALTER COLUMN class_id SET DEFAULT nextval('public.master_class_class_id_seq'::regclass);


--
-- Name: resistances resistance_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resistances ALTER COLUMN resistance_id SET DEFAULT nextval('public.resistance_seq'::regclass);


--
-- Name: session session_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session ALTER COLUMN session_id SET DEFAULT nextval('public.session_session_id_seq'::regclass);


--
-- Name: weakness weakness_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weakness ALTER COLUMN weakness_id SET DEFAULT nextval('public.weakness_weakness_id_seq'::regclass);


--
-- Name: weapon_master_type weapon_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon_master_type ALTER COLUMN weapon_type_id SET DEFAULT nextval('public.weapon_master_type_weapon_type_id_seq'::regclass);


--
-- Data for Name: element_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.element_types (element_types_id, element_types_name) FROM stdin;
1	Fire
2	Water
3	Earth
4	Thunder
\.


--
-- Data for Name: enemy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enemy (enemy_id, enemy_name, enemy_base_hp, enemy_base_mp, enemy_base_dex, enemy_base_constitution, enemy_base_int, enemy_resistance, enemy_weakness, enemy_image, enemy_image_attack, enemy_image_attacked) FROM stdin;
37cf22e2-a837-4793-ba57-647fe08c94cf	grunt	200	100	10	80	30	1	2	https://res.cloudinary.com/dmtaew5vg/image/upload/v1756454213/fzy0egmxxtjalgpc6gpl.webp	https://res.cloudinary.com/dmtaew5vg/image/upload/v1756454216/mxpbewdsrdgzotsxlckq.webp	https://res.cloudinary.com/dmtaew5vg/image/upload/v1756454218/rlkzp1s0x733k3m6n7lj.webp
90c83612-b9c4-4707-83b8-17dd3d731d66	Apostate Prophet	170	100	15	80	30	1	2	https://res.cloudinary.com/dmtaew5vg/image/upload/v1756454929/jw9cyyqix7yrkxlapexr.webp	https://res.cloudinary.com/dmtaew5vg/image/upload/v1756454930/omznd3phlxwnda8jel48.webp	https://res.cloudinary.com/dmtaew5vg/image/upload/v1756454931/onve80fljm03szewf3pg.webp
\.


--
-- Data for Name: learn; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.learn (id, name, "time", age, checklearn, city) FROM stdin;
2	Hilary	2025-07-10 00:00:00	93	f	Calango
3	Maryjo	2024-11-19 00:00:00	152	t	San Lorenzo de Esmeraldas
4	Frederigo	2025-03-23 00:00:00	111	t	Leping
5	Shaine	2024-12-03 00:00:00	114	t	Santiago De Compostela
6	Roseanna	2025-04-21 00:00:00	131	t	Xihu
7	Mimi	2025-03-29 00:00:00	199	f	Zushi
8	Katerina	2024-12-10 00:00:00	188	f	Lin‰vo
9	Ericka	2025-05-03 00:00:00	87	t	Reims
10	Anneliese	2024-10-01 00:00:00	160	f	Priargunsk
11	Rosie	2025-07-23 00:00:00	139	f	Karantaba
12	Giuseppe	2024-10-11 00:00:00	161	f	Maunuri
13	Pail	2025-06-08 00:00:00	145	f	Huamu
14	Phyllis	2025-06-22 00:00:00	84	t	Xingfeng
15	Cris	2024-12-06 00:00:00	145	t	Kokk¢nion
16	Kynthia	2025-06-03 00:00:00	108	t	Baoxing
17	Chickie	2025-01-04 00:00:00	200	f	Namasuba
18	Austen	2024-08-13 00:00:00	182	f	Kristiansund N
19	Wilek	2025-01-23 00:00:00	85	t	Buga
20	Trisha	2025-02-07 00:00:00	184	t	Barueri
21	Lucias	2025-04-29 00:00:00	167	f	Aracruz
22	Regine	2024-11-28 00:00:00	90	t	Bondoukou
23	Lisa	2024-10-21 00:00:00	123	f	Lufang
24	Kate	2024-10-15 00:00:00	168	t	Oekefan
25	Ali	2024-09-14 00:00:00	201	f	Sagopshi
26	Adeline	2024-10-29 00:00:00	117	f	Quesada
27	Nicolina	2024-08-22 00:00:00	105	f	Los Angeles
28	Burnard	2025-03-26 00:00:00	81	t	Sumberbaru
29	Piotr	2024-11-29 00:00:00	173	f	Shadui
30	Sisile	2024-10-10 00:00:00	141	f	Vilhelmina
31	Dinny	2024-10-02 00:00:00	183	f	Al Jubayhah
32	Aurora	2025-05-01 00:00:00	129	f	Odemira
33	Antonina	2025-05-28 00:00:00	135	f	Dongshi
34	Aarika	2025-01-20 00:00:00	148	f	Liding”
35	Davine	2025-01-06 00:00:00	89	t	Calamba
36	Lefty	2024-09-30 00:00:00	194	t	Kypero£nta
37	Jarred	2025-06-25 00:00:00	80	t	Elato
38	Hynda	2024-11-03 00:00:00	183	f	Volgo-Kaspiyskiy
39	Deerdre	2024-11-26 00:00:00	193	f	Sulaco
40	Cornie	2025-02-08 00:00:00	195	t	Ituverava
41	Anabella	2025-04-27 00:00:00	81	t	Th? Tr?n B?c H…
42	Katha	2025-03-12 00:00:00	125	t	Payapa
43	Krystal	2025-04-04 00:00:00	119	t	Winong
44	Imogen	2025-01-25 00:00:00	175	f	Xiaoweizhai
45	Elsa	2025-08-07 00:00:00	151	t	Baleber
46	Johan	2024-11-12 00:00:00	165	t	Wangdian
47	Blisse	2024-09-25 00:00:00	180	f	Paseh
48	Idell	2025-02-18 00:00:00	86	f	Penteado
49	Cristabel	2025-02-22 00:00:00	92	t	Ratnapura
50	Mechelle	2025-06-10 00:00:00	177	t	Pa‡o
51	Dynah	2025-05-03 00:00:00	144	f	Ciloa
52	Barnett	2025-03-19 00:00:00	159	t	Petropavlovka
53	Drucill	2024-08-21 00:00:00	177	t	Al Ghariyah
54	Birgit	2025-01-25 00:00:00	124	t	Fundong
55	Dael	2024-12-23 00:00:00	111	f	Sarakhs
56	Cindi	2024-08-12 00:00:00	169	f	Liangting
57	Zebulon	2024-09-24 00:00:00	174	f	Valbo
58	Ahmad	2024-09-23 00:00:00	184	f	Ludbreg
59	Oralee	2025-03-29 00:00:00	193	f	Rochester
60	Corbie	2025-04-22 00:00:00	147	f	Yaviza
61	Sid	2025-06-29 00:00:00	107	t	Zidlochovice
62	Edgardo	2024-12-22 00:00:00	162	t	Xiejiaya
63	Chantalle	2024-11-20 00:00:00	180	f	Khon San
64	Jacklyn	2025-04-29 00:00:00	158	f	Okanagan
65	Charla	2024-12-21 00:00:00	125	t	Dongchong
66	Llywellyn	2024-09-18 00:00:00	119	f	Springfield
67	Brandise	2024-08-27 00:00:00	117	t	Neiba
68	Zsazsa	2025-01-31 00:00:00	149	t	Lashio
69	Alwin	2025-01-21 00:00:00	135	f	™ldziyt
70	Albrecht	2025-04-06 00:00:00	145	t	Sangali
71	Gertie	2025-06-18 00:00:00	188	f	Alegria
72	Lawrence	2025-06-01 00:00:00	180	t	Sula
73	Laurene	2024-11-09 00:00:00	115	f	Djambala
74	Hernando	2024-12-19 00:00:00	102	f	Zhouyuan
75	Twyla	2024-12-26 00:00:00	182	f	Cuman 
76	Prissie	2025-07-11 00:00:00	174	t	Mawang
77	Kristoforo	2024-09-30 00:00:00	115	t	K›benhavn
78	Maisey	2025-01-03 00:00:00	142	t	Kazaure
79	Abra	2024-10-30 00:00:00	145	t	Las Carreras
80	Neala	2025-01-01 00:00:00	80	t	Al Jawadiyah
81	Perry	2025-03-01 00:00:00	131	f	Yakymivka
83	Yardley	2025-05-07 00:00:00	141	f	Prey Veng
84	Hillyer	2025-06-09 00:00:00	178	f	Majie
85	Luelle	2024-12-06 00:00:00	171	t	Kaliuling
86	Dulcie	2025-06-28 00:00:00	93	t	SÆo JoÆo
87	Abdul	2025-07-07 00:00:00	150	t	K”yli”
88	Boot	2024-10-03 00:00:00	161	f	Saint-J‚r“me
89	Ingunna	2025-01-13 00:00:00	156	f	Candel ria
90	Arlette	2024-08-27 00:00:00	92	f	El Suyatal
91	Gardy	2025-02-27 00:00:00	116	t	Solikamsk
92	Derby	2025-06-21 00:00:00	162	f	Novonukutskiy
93	Gunter	2024-11-27 00:00:00	154	f	Zhaxirabdain
94	Marlee	2024-08-31 00:00:00	187	f	Al Bahluliyah
95	Tine	2025-06-10 00:00:00	182	f	Dishna
96	Vernice	2024-12-01 00:00:00	176	f	Yunxi
97	Laraine	2025-06-26 00:00:00	171	f	Rulenge
98	Natasha	2024-10-10 00:00:00	197	f	Xiadu
99	Ashly	2024-11-07 00:00:00	170	t	Bang Krathum
100	Aldwin	2025-01-28 00:00:00	87	t	Weligama
1	begin	2025-04-28 00:00:00	148	f	Vagney
\.


--
-- Data for Name: master_class; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.master_class (class_id, class_name, class_base_dex, class_base_int, class_base_hp, class_base_mp, class_base_str, class_main_stat) FROM stdin;
3	Knight	60	50	90	50	90	str
2	Mage	40	80	70	100	20	int
4	Paladin	60	90	100	80	90	int
5	Monk	90	70	80	90	60	dex
39	Rogue	90	60	70	40	70	dex
\.


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player (user_id, player_name, player_class, player_weapon, role, player_password) FROM stdin;
7769598e-cb3d-4947-8ddb-024493394624	Azzy_1	3	35	player	$2b$10$HgEu9AOXce.womkkmGKeWeTna3bLLNBCrjBtwFxrd.6fQH.gJu40S
2cef14b3-37fc-471b-aa54-ddef7eb291f0	test_user_1	\N	\N	player	$2b$10$epAUowiYyx8oBfu7Pzg1R.k8I94jJvt7AXvP7u8u/88K5YxtEJxa2
7370ea58-d419-4159-bcdf-e1cc9de8f94d	Azzy	4	\N	admin	$2b$10$7FV9Vu76SDXd0ApDkiAU0uVrbR79vDJw4fWd05mJOQUHrJcaZC9im
21fcbbeb-9267-4a7a-a42a-b296094ad101	test_user_2	\N	\N	player	$2b$10$Wx.sgTu2YkMMMBgEKVp.7.rOyf3t0tZkGNqenJ.5v45OIjVYcJUP2
77719a58-094d-48ee-b050-a3dde0ed28fc	Azzy_2	\N	\N	player	$2b$10$5IbEiziQaFghZavORBPX9O9Jc91gIJhlczJ7t6Z1QGtRFQpmgmqjO
a5979cc3-0742-4376-8244-c40612d91c0d	Azzy_3	\N	\N	player	$2b$10$AosiKwEx5bn1ApfmYEX0s.mHPRBhgAppWJYR074TBB6ZAGWKro73O
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh_tokens (id, user_id, token, created_at) FROM stdin;
36983c7c-297a-46a9-9c8f-f298f5326cbc	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsImlhdCI6MTc1NDk4MDY2MSwiZXhwIjoxNzU3NTcyNjYxfQ.2OI92JERmHkY7FJY1OZcpeSqTBOVEyL9AOHSgJld7YU	2025-08-12 13:37:41.580238
6938e3cd-80af-42ff-b1e0-c0edded34bcb	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsImlhdCI6MTc1NDk4MTEwNSwiZXhwIjoxNzU3NTczMTA1fQ.f04te9w9u9MsoAeL5yZ90FNj9l_vSCMGjT3Qou4x1vo	2025-08-12 13:45:05.314762
19d77f7f-0e10-4998-97b0-c67c676375d8	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4MTE0MSwiZXhwIjoxNzU3NTczMTQxfQ.XAbJ28ZPLNR2fqP-zWDd1Oshh5uVJFs1hEItNmrwUr4	2025-08-12 13:45:41.440005
17f7f859-8041-4494-86b3-37164492115c	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4MjE3MSwiZXhwIjoxNzU3NTc0MTcxfQ.DSf3AOWL76HqXBJ7o8yvruCRVe14I_WFdWmEmgxrTTQ	2025-08-12 14:02:51.61519
07f848ff-bd30-4c71-9e8e-098a49d3d387	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4Mjg2MywiZXhwIjoxNzU3NTc0ODYzfQ.fUJQzHuRaUFBS9UZ72aC0CaQFnntxpJotZ7y6sGJcQY	2025-08-12 14:14:23.173795
7e862de6-bedb-49a2-9c84-792fbde844d4	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4Mzc4NCwiZXhwIjoxNzU3NTc1Nzg0fQ.qkSqC1d7z8UUMgZEmxmSbvjNmldxS0mQddRpkCIAmD4	2025-08-12 14:29:44.423241
11bd6e0d-d80f-4830-afc0-96ef6acc3f6e	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4Mzk2MSwiZXhwIjoxNzU3NTc1OTYxfQ.aY2-2J6MBF_6WO4aFIA51-wBuuR793rebRNgNAz6DEQ	2025-08-12 14:32:41.817463
920eeccc-6c45-40dc-8f5c-01f957466e44	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4NTI3MCwiZXhwIjoxNzU3NTc3MjcwfQ.7hXW1ASfYu-ay4cuaY5xV90N8KKGgvqZYkdh443SE5Y	2025-08-12 14:54:30.537454
ff1f322c-31dc-4054-9eea-c6f40a3f1869	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4NjE3NCwiZXhwIjoxNzU3NTc4MTc0fQ.Sz18yH3G4YGm2BHU3gXFjYerS0TJWxqU-UpNnNLgHAM	2025-08-12 15:09:34.53392
bbce595a-fcd1-4554-82f1-3f23244db3a6	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4NzExOSwiZXhwIjoxNzU3NTc5MTE5fQ.30Ryy29mg-nS_6oDy_kbEinRUpE-7rsCg6MKhrm1Z_0	2025-08-12 15:25:19.972971
4186ee27-be2e-4b82-8a95-1d0ec53f9033	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk5MDI1MCwiZXhwIjoxNzU3NTgyMjUwfQ.h6fnODtOLDVPJAlPS6wDhI7_nsKwuJ20ZeAafytI1Z0	2025-08-12 16:17:30.14879
2023a19f-3f05-4394-90b4-d3386ced6b8d	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk5MTQwNSwiZXhwIjoxNzU3NTgzNDA1fQ.L4zaaiss3O_hUrnAX1MRnRtjb995C8qxxTpvmpy9tOI	2025-08-12 16:36:45.910402
15d7e183-33e9-40c1-9c75-e12b14f2f85c	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk5MjQyMCwiZXhwIjoxNzU3NTg0NDIwfQ.dr84ureFLzgHxj6z-2ZT5EgfyC9DHwjFGMCua2jD_Dc	2025-08-12 16:53:40.050127
7655d0b0-ba40-4666-bf55-70e6d7f12f35	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk5NDI5NiwiZXhwIjoxNzU3NTg2Mjk2fQ.i6ewM9keCZwYWaodEv85ECS0qBcJMyorIvaMJ-E5fK0	2025-08-12 17:24:56.495214
1f475f62-1763-439d-b950-aa9b85d9b6fb	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk5NTYyOCwiZXhwIjoxNzU3NTg3NjI4fQ.E5EVrEsDU9242gizdER5xOCnEWL_QvHaRm8dNMDhIbk	2025-08-12 17:47:08.277803
521620d4-bc85-4fef-b3e6-687966500bee	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA0ODczNCwiZXhwIjoxNzU3NjQwNzM0fQ.j24aQqSnW5fVoejzqVObhf6wZ1vc7ZX0XxTl4eSPlhM	2025-08-13 08:32:14.305605
44d6ebbb-65d2-40b1-b1f5-b0e1ad13a16c	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1MDQ2MSwiZXhwIjoxNzU3NjQyNDYxfQ.ipOkXEgSG17ocNArTowupzucYK2AJShI1TBI_BNxOCw	2025-08-13 09:01:01.28504
1b348a77-1538-43f6-8ab4-e0896865b1e6	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1MTQwNywiZXhwIjoxNzU3NjQzNDA3fQ.6SmRLb-LY3eJEsMPOfZvGznzcIlCyLX495QRIccuLxs	2025-08-13 09:16:47.456162
7f089932-4f84-4815-9ca2-f36a5b56521d	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1MjM0MSwiZXhwIjoxNzU3NjQ0MzQxfQ.AifMkb0fXOOX6ohgHBVRsEdQO5iEOLhnZUkEknaFosg	2025-08-13 09:32:21.433862
b2a46d00-34e9-4ea0-a729-a936b2aa10bd	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1MzQ1NSwiZXhwIjoxNzU3NjQ1NDU1fQ.l2mEJiQItaoB4pxlWKekz0Q_6PS7Z9ol7s9Jn_N0UA0	2025-08-13 09:50:55.836194
bdfabb9e-27e0-4891-83af-f23d0e289c38	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1NDQwMiwiZXhwIjoxNzU3NjQ2NDAyfQ.lcTOUSZh88k38LAJnllmMK-b3sBkLzah2sdHbz5kO54	2025-08-13 10:06:42.367345
be23c4ba-5cfa-45fb-b221-f84bca4d2371	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1NTM3MywiZXhwIjoxNzU3NjQ3MzczfQ.gtugfP1II7U7APIK7NusAWLpPwgMYOSVhELykNF3OFA	2025-08-13 10:22:53.287993
bbac7ed5-760a-4c31-b6b0-f114b02852f7	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1OTkyNCwiZXhwIjoxNzU3NjUxOTI0fQ.Bws85daU_DfJwNMk9lIiHaO_2KuCRP6DxHYjq5HdJv4	2025-08-13 11:38:44.037743
ed360ae5-455c-413f-b573-a1b8f69d56fb	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA2MDk5MiwiZXhwIjoxNzU3NjUyOTkyfQ.1CyVIMSq3EnWm5YGnQQLfxNEnTmDS4DjpHfR-4X995U	2025-08-13 11:56:32.429607
12a8ef81-1545-48f8-9864-57405e651f0f	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA2MTkyMCwiZXhwIjoxNzU3NjUzOTIwfQ.BIRCdSeMnxM6Q6GB6GfAfe95TSy3iX5ZsmzVn_JTiIY	2025-08-13 12:12:00.760464
40e7382f-3f19-4442-a6c8-a275bed4f991	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTE1MTE4MywiZXhwIjoxNzU3NzQzMTgzfQ._wLQbGW1yYccF87K1VDOCwgmW9JhI8KWwH8aiZUKz8E	2025-08-14 12:59:43.618733
f7224e69-5a59-4a98-8ff7-5d7f4b358722	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTc3OTI4OCwiZXhwIjoxNzU4MzcxMjg4fQ.qZcBbqxJvB4xKmwJKswqtSDXVtm6wgrJUHD9nqZbMxc	2025-08-21 19:28:08.461984
2e7d5c5c-324b-4733-8521-7bd0691feb9a	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjE4NTQxOCwiZXhwIjoxNzU4Nzc3NDE4fQ.we2r5wauXq-EKzAQehKVwEK_InlTFw8LYJDCDhmvOvY	2025-08-26 12:16:58.812376
edf8458e-656d-450f-843b-01c11a14ebf3	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjE5MjMzNCwiZXhwIjoxNzU4Nzg0MzM0fQ.IgQ5NqId8XT2A17_NAH9x6gkKNDbQ-wixXqIhDsFmxw	2025-08-26 14:12:14.159894
936638af-b980-4662-9daf-e74c658736d5	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjE5NDgxNSwiZXhwIjoxNzU4Nzg2ODE1fQ.MLQM50gil_AeutA6zwcpN0IEFgsECvR2Ne3uaBnVYeo	2025-08-26 14:53:35.483201
85619d48-a88a-469e-90fd-f81b472e6a1c	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjE5NTc5MywiZXhwIjoxNzU4Nzg3NzkzfQ.fCT0ui4ZQLQvvlG3viDSyjUMnh2lDNq-lkg0AMj6ihI	2025-08-26 15:09:53.536399
e5586d13-18be-4767-bf55-10dab00ead4d	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjE5Njg0MCwiZXhwIjoxNzU4Nzg4ODQwfQ.6ndDTXtz8xJwP_547UAPUDPxyO2VTjKYzOnBrfQhBTk	2025-08-26 15:27:20.237912
435f66b2-8d47-4063-84e6-36c59b162fcc	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI2NTI2MiwiZXhwIjoxNzU4ODU3MjYyfQ.yZflHNl7UpC3KIEPyjTBCa3my7fCvE5UF151b-iLQ3s	2025-08-27 10:27:42.366069
ca16df21-0747-40aa-89dc-5d8007e6e7b8	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI2Njg1NCwiZXhwIjoxNzU4ODU4ODU0fQ.r9agA5PxujBMFEjKOdVU4zGWc7eiSHkP2S2PozQhy0w	2025-08-27 10:54:14.860875
2aa430a3-270f-4ae2-9ab7-9ab8ae7ae824	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI2ODYyOCwiZXhwIjoxNzU4ODYwNjI4fQ.XHriYws4bQ2ny2TBdR135yIyVdbLqkw5DOHrhSHDj5Y	2025-08-27 11:23:48.969656
24347f75-1b17-4dcd-a3b6-c42a1c1e75d1	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI2OTU0NywiZXhwIjoxNzU4ODYxNTQ3fQ.zvdhQxQUtwGM4QYkOc2rcUt3T70NDO6MMw8GqydgP8M	2025-08-27 11:39:07.912648
16d1dbee-4687-44fc-90ea-6962a5a1d621	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI3MDQ2MywiZXhwIjoxNzU4ODYyNDYzfQ.guCojxJqB89kFyO42FYxiQiMcn6s25jsXqEMf2Zf0dU	2025-08-27 11:54:23.144472
273ff17c-cfc2-40b9-8608-1a0da4200c31	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI3MTkzNiwiZXhwIjoxNzU4ODYzOTM2fQ.5vnsalMRdTuykSKD53fCkOshhrHyxqJGC7Hs7vmpdBo	2025-08-27 12:18:56.447448
43a9063b-0d5f-4949-b3da-06805c6f63ef	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI3NjQxMCwiZXhwIjoxNzU4ODY4NDEwfQ.TPO8-gQVAi0Mm5xJwLt_qe5qLo1ANVMZAHAnVu3VdII	2025-08-27 13:33:30.891201
bae9a547-8583-459f-8104-9554504d221e	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI3NzQxNCwiZXhwIjoxNzU4ODY5NDE0fQ.wCt6ZO4ptwsZORqP9YZWPGYfqAzIvRXOyiM8ipm0o9I	2025-08-27 13:50:14.259865
7f3b1f34-8f5a-4acf-b56f-5067438dc8e9	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI3ODQzNywiZXhwIjoxNzU4ODcwNDM3fQ._y5oICcmldH_zjfC9dc-EdhkZAT_yBi-ZitVXi_EErc	2025-08-27 14:07:17.997119
2222e8ee-4727-455c-9785-140bfee43d5e	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4MDA5MCwiZXhwIjoxNzU4ODcyMDkwfQ.mI_tZTR4e97O8hSoWTM_Qs93l99Pb1lOQ1Y9AQ87moo	2025-08-27 14:34:50.938322
b99e6d8e-f652-418c-889c-cc0b5477f43c	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4Mjg2MSwiZXhwIjoxNzU4ODc0ODYxfQ.o4FMvluUP3nMZRJczZBCXzqc3FzSWZPo2cdmIE41y7c	2025-08-27 15:21:01.917534
b1ec8eea-4cbc-478e-a1ee-1ecc81df8f8c	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4Mzk2MCwiZXhwIjoxNzU4ODc1OTYwfQ.qT4o_kgSUN2qZJCLMXrYAeW77BEbc1c8VaEZAzVd9XI	2025-08-27 15:39:20.013165
ee0f4afc-134c-499c-a841-34de1769f5c4	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4NzUzNCwiZXhwIjoxNzU4ODc5NTM0fQ.6lgG3swBS63ytxo0ENf_eEDPYMBP2ub-5XsEe_vJ8CI	2025-08-27 16:38:54.862385
ed906ced-fedf-44dd-81c6-65bc9f9527ef	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4NzkxNywiZXhwIjoxNzU4ODc5OTE3fQ.6bUVGFrN_EC5HTcsSdK5IPvv9xvmk-n4u-SEL2aw5GA	2025-08-27 16:45:17.631535
0f7b7153-965a-497e-8fb7-e1cad8db692b	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4NzkzNywiZXhwIjoxNzU4ODc5OTM3fQ.4vcNk1V2z1Q3CnuDO_VHEXQXUvmV9roVa0lXuPk6uRM	2025-08-27 16:45:37.787784
01b5a0eb-eb9b-493a-b54a-fe9a60e55641	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4Nzk1NywiZXhwIjoxNzU4ODc5OTU3fQ.jNFIHUkgA6dJiHiqOVP9bZReQXFXMNg6wqYMa1O6vGk	2025-08-27 16:45:57.893792
fcc91da7-9ecb-4293-bb40-2d926e1e21e1	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4ODcyMywiZXhwIjoxNzU4ODgwNzIzfQ.J0MqS-rUu1Wzsy21OSHZZXJ9IKHXUUaLWHZpTtMm3KU	2025-08-27 16:58:43.526195
32fef743-8701-4c35-b978-87187d9be12c	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjI5MDQwNywiZXhwIjoxNzU4ODgyNDA3fQ.M9TINvSNGOBGyzfEcxuGb6cutMx7TySCcja5CIFbrRk	2025-08-27 17:26:47.097079
e7579e5b-4e68-44ea-8068-f20b8bfa3b60	77719a58-094d-48ee-b050-a3dde0ed28fc	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3NzE5YTU4LTA5NGQtNDhlZS1iMDUwLWEzZGRlMGVkMjhmYyIsInVzZXJuYW1lIjoiQXp6eV8yIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjI5MDQ3NSwiZXhwIjoxNzU4ODgyNDc1fQ.ljBS0nivoyp705SxCqU1Kv2qh6CV9YSqR1yBdof9xRk	2025-08-27 17:27:55.978562
b952e3e6-134a-48a1-b294-7ba943ea3e3b	a5979cc3-0742-4376-8244-c40612d91c0d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE1OTc5Y2MzLTA3NDItNDM3Ni04MjQ0LWM0MDYxMmQ5MWMwZCIsInVzZXJuYW1lIjoiQXp6eV8zIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjI5MDUwMSwiZXhwIjoxNzU4ODgyNTAxfQ.R-wt8LVDJlmKaayPphwBqyH8Fbo6Day9_D_dSruwZU4	2025-08-27 17:28:21.669152
d091ddcc-87fb-4c7b-b1b9-a5aa222c5e9a	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI5MTE0NSwiZXhwIjoxNzU4ODgzMTQ1fQ.WB3cHuxLhwS_L_36Kl2X4rfivFlu_kFH9WYR8AGH_is	2025-08-27 17:39:05.709466
6545c880-0b15-4d66-b686-44d0a6ccaf9f	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjI5MTQzMiwiZXhwIjoxNzU4ODgzNDMyfQ.0zllu-ohJO9oXjrt0J4-xLPw9FEyjaAyOaZVlsxhEWw	2025-08-27 17:43:52.831547
b23d2b80-cae1-4b4b-aa19-3a10ed3e5fec	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjI5MTQ5NCwiZXhwIjoxNzU4ODgzNDk0fQ.mCeR4N0Bsh5q1T26W36UomlyXMwOph0iwbq1Q1lLVSY	2025-08-27 17:44:54.149832
fcfefb96-036c-4fd1-bf4a-7d8f52b8cdc0	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjM0OTg0NiwiZXhwIjoxNzU4OTQxODQ2fQ.cceMx_-DBvIhWSC2-_tDNw-rEEcB52WpRmpR3JB2iNc	2025-08-28 09:57:26.235412
2a8cba3a-caaa-421a-84be-16bbc1921893	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjM1MTI4MywiZXhwIjoxNzU4OTQzMjgzfQ.36_gjV17Ct65UTUN8-gUxc3hQwnVKpokSryIeBlna-I	2025-08-28 10:21:23.813666
d2176814-9e7d-4613-910c-c2cf943b45d6	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjM2Mjk2OCwiZXhwIjoxNzU4OTU0OTY4fQ.-eXq-QyyEE7duscV_0UNRYCSEMd7vXNVJnYigDG81V4	2025-08-28 13:36:08.119537
b4855829-8378-4dd5-addc-d6e30d37e48b	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjM2NDQxNiwiZXhwIjoxNzU4OTU2NDE2fQ.32OQirEqWT-aIFwnguc-o9v1oxszqx5oszXpxiNT_74	2025-08-28 14:00:16.531137
7a530eee-c91e-46c6-91ff-ad3d176d8f96	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjM3NjUwMiwiZXhwIjoxNzU4OTY4NTAyfQ.LwFskkWFDeUaKi-zfFITyjc8Wponsr3tPnIC1poEiGQ	2025-08-28 17:21:42.735625
c6c23bf1-4a5f-4e4c-a280-3679959fec57	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzMjA4MywiZXhwIjoxNzU5MDI0MDgzfQ.xZl-8CJ4u_ZTUVz4E_rnRAtUuf7ipeDWrAue1HJEPT0	2025-08-29 08:48:03.766477
1c7dd2b0-bb26-4cc6-be5d-8ac516e187f5	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjQzMjI5NywiZXhwIjoxNzU5MDI0Mjk3fQ.QORXBoKYWmj3Io7-Hgnmlr9_2h8Y7m7T_Vy1bhjn2Ow	2025-08-29 08:51:37.263195
99c37516-61a7-47a5-b7ee-d04a6d361e10	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjQzNzEwOCwiZXhwIjoxNzU5MDI5MTA4fQ.eesh5ADSwItPyenrTBZcF5Q6niFoCWMrqe09-SGcJvU	2025-08-29 10:11:48.566549
6d20a56d-acf1-42c4-ad0d-841095172086	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjQzNzE1MCwiZXhwIjoxNzU5MDI5MTUwfQ.bpXE0GUksaGR25rxY1J8qlRcHGTbgG_21TdVKlooRn4	2025-08-29 10:12:30.96758
b9a44c8f-5c97-4465-9f27-cc0c1555fa82	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzNzM2OCwiZXhwIjoxNzU5MDI5MzY4fQ.kr_EWMWjikonzjoA5OzUnpUyGyGwHCVmamsSIKz69sk	2025-08-29 10:16:08.834196
ed4027c4-e0d3-493c-a39d-3fcbdf8cc39d	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzODQyMiwiZXhwIjoxNzU5MDMwNDIyfQ.ziRDomJ8rgTbWedmPBgE8peiqoBwF911jqznnPzkNvA	2025-08-29 10:33:42.64227
e88070c6-e4fa-400c-b802-6d4bf3749a1c	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzODU0MiwiZXhwIjoxNzU5MDMwNTQyfQ.ypbSFs0MIEYZBgelTZpIZMSXPor5rY1v8sDBE_trEGU	2025-08-29 10:35:42.317204
da6c30b3-e48a-4d2e-810d-11fa5276faf3	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzODYxNSwiZXhwIjoxNzU5MDMwNjE1fQ.8FJalXIgoP1raBGARviK2z0RBp-WEnyGd9wE4kpI0jE	2025-08-29 10:36:55.403277
23c9ac58-1ec7-46e4-b6e0-8fec77380726	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzOTM3NywiZXhwIjoxNzU5MDMxMzc3fQ.9K4h6bpnLLmqxo88jP0bz2Oo9awxWqtJQSBddRvEhTo	2025-08-29 10:49:37.278971
0277ad2d-1765-478e-8cb5-f932e6b933ef	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzOTg5NCwiZXhwIjoxNzU5MDMxODk0fQ.Kkvbpez43u_iiUYZj9KIClz-ACr2_9Aysg8t5E0uJ-8	2025-08-29 10:58:14.739429
a26690cc-917d-43f9-85b6-fe877c118eff	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzOTkwMywiZXhwIjoxNzU5MDMxOTAzfQ.ZnVkApD-yuFltPXWCnlHOATHKXEz_AuFbmyuBYVlHIM	2025-08-29 10:58:23.488279
85da01f8-1490-41f3-b0c2-3bfdfde3c9a7	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQ1MDk3NCwiZXhwIjoxNzU5MDQyOTc0fQ.OU7lqEbdOCQE6MsEIbrXNGyGvathcrQnRXlz2mx8WlI	2025-08-29 14:02:54.724138
2c6342f5-8841-4030-86d4-bae6b36d596e	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQ1MjYxNCwiZXhwIjoxNzU5MDQ0NjE0fQ.Dv_FKJFMYgWCCeMHlD84Gjd0dIEBYMnBRJg6I6pctu0	2025-08-29 14:30:14.968872
fb6e33f5-8b08-46c2-842b-a39d40ac6c23	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQ1MzkyNywiZXhwIjoxNzU5MDQ1OTI3fQ.PMyJQuiJuS5WYUQbinKVj8kjnzO9Tcpa72hvMKgnK9c	2025-08-29 14:52:07.715579
dfea8dd1-e65c-4808-a141-fe7ab35934ae	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQ1NDkyNCwiZXhwIjoxNzU5MDQ2OTI0fQ.aM2fCQkq5HGE37pma66FA-nc_g8msxd875LgIXwHBD4	2025-08-29 15:08:44.955563
1e0fe89f-7014-48d1-9f29-a6f76b58e82a	7370ea58-d419-4159-bcdf-e1cc9de8f94d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjQ1NTUxNywiZXhwIjoxNzU5MDQ3NTE3fQ.thU6JvXRVggWpomORTgkiEfL8dheAh1untxYb3hTjBg	2025-08-29 15:18:37.014643
41df10a5-4e03-4b8c-97c8-8c0e1a3e0737	7769598e-cb3d-4947-8ddb-024493394624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQ1NTU4NCwiZXhwIjoxNzU5MDQ3NTg0fQ.8Gts9yl15vfXjm1rnWNp6Ad8wnVyB7XJ3sdZsEuE9ZI	2025-08-29 15:19:44.836105
\.


--
-- Data for Name: resistances; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resistances (resistance_id, resistance_type, resistance_damage_reduction) FROM stdin;
1	1	30
3	2	20
4	3	20
5	4	20
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session (user_id, session_id, token, user_agent, login_time, logout_time) FROM stdin;
7370ea58-d419-4159-bcdf-e1cc9de8f94d	18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA0ODczNCwiZXhwIjoxNzU1MDQ5NjM0fQ.rZ2WlW5C0FOVbW93dgCGqLvQ39r39bnJyEZwbqsAwCE	PostmanRuntime/7.45.0	08:32:14.300608+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1MDQ2MSwiZXhwIjoxNzU1MDUxMzYxfQ.1PEWrYv7gAGFbgeojFxIrTd3hZQA73sKjhTyP220jtY	PostmanRuntime/7.45.0	09:01:01.281507+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	20	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1MTQwNywiZXhwIjoxNzU1MDUyMzA3fQ.jQpK9vM9b8N3lzG20cINsISI5zPqPnMwBrDSW48h1vE	PostmanRuntime/7.45.0	09:16:47.45084+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1MjM0MSwiZXhwIjoxNzU1MDUzMjQxfQ.R6Qq61LAj6GzDCY3zrwA_2rF46o20Popus8-TXHRyEg	PostmanRuntime/7.45.0	09:32:21.430785+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	22	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1MzQ1NSwiZXhwIjoxNzU1MDU0MzU1fQ.QTcj0WoLRlY0En0esLf4BQQR31AlWiV6RonPT_82nmw	PostmanRuntime/7.45.0	09:50:55.834057+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1NDQwMiwiZXhwIjoxNzU1MDU1MzAyfQ.9sBCnIDsE_14PnEmt-59B3bwIQFeWe3AtU7FriVYvjs	PostmanRuntime/7.45.0	10:06:42.364144+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	24	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1NTM3MywiZXhwIjoxNzU1MDU2MjczfQ.yAGhG7SAB7kS_Gdx_Q3jLVkuL14Gel_8hrdCjNRp68w	PostmanRuntime/7.45.0	10:22:53.283141+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4MjE3MSwiZXhwIjoxNzU0OTgzMDcxfQ.PlFr8Q1xwp6awF-MThQlEI0DyEYeOW5qwwsR-0jrA9k	PostmanRuntime/7.45.0	14:02:51.612868+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4Mjg2MywiZXhwIjoxNzU0OTgzNzYzfQ.r9lodmoWzyLZhje9OW94aWytzqD9GYJIAtdJKVEYIro	PostmanRuntime/7.45.0	14:14:23.171401+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4Mzc4NCwiZXhwIjoxNzU0OTg0Njg0fQ.taGwmed8N8z-FvfuwjibEl1QcUvF3eHbn5dIIYFPabM	PostmanRuntime/7.45.0	14:29:44.420598+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4Mzk2MSwiZXhwIjoxNzU0OTg0ODYxfQ.js_nhRdB6_as27yvz3fC1ymnKnetoIXXCI7U4_lJucM	PostmanRuntime/7.45.0	14:32:41.813622+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4NTI3MCwiZXhwIjoxNzU0OTg2MTcwfQ.lTqGjWAmaBnvW2zlLYWy91VNuTjBEW9jS0Uys5Stvwg	PostmanRuntime/7.45.0	14:54:30.535194+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	11	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4NjE3NCwiZXhwIjoxNzU0OTg3MDc0fQ.KBq-lQNhECGxCjMyL8Y2AF_-LlrTfC3ec3acRSbky_Q	PostmanRuntime/7.45.0	15:09:34.531134+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	12	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk4NzExOSwiZXhwIjoxNzU0OTg4MDE5fQ.mJITicw8XtjYEGTFbTPSJUgfHZYPoXEQMOhpuwekwHI	PostmanRuntime/7.45.0	15:25:19.970028+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk5MDI1MCwiZXhwIjoxNzU0OTkxMTUwfQ.g9NVB6ugOn-ymgZSPfOJpoWQOTF1qIPFCl5AjLjxwkA	PostmanRuntime/7.45.0	16:17:30.144433+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	14	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk5MTQwNSwiZXhwIjoxNzU0OTkyMzA1fQ.o5Uo8N9oyCe3o17qyi36Zq4LxeZNFAuw69KLJsqwjr8	PostmanRuntime/7.45.0	16:36:45.907587+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk5MjQyMCwiZXhwIjoxNzU0OTkzMzIwfQ.SFUtW4zCS_A0trluGEu6l47rl_huvLzBxeNqDAPGJNw	PostmanRuntime/7.45.0	16:53:40.04669+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk5NDI5NiwiZXhwIjoxNzU0OTk1MTk2fQ.s-ms5JZNMRpQxPJx6GoSfMJFmXYMdP-_OuVIcSQmoCY	PostmanRuntime/7.45.0	17:24:56.49116+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NDk5NTYyOCwiZXhwIjoxNzU0OTk2NTI4fQ.RoqymSloWJV4iPv_wcmE6g-nn_cbJxETWk-xIITDj3s	PostmanRuntime/7.45.0	17:47:08.27523+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	25	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA1OTkyNCwiZXhwIjoxNzU1MDYwODI0fQ.6UqfdCn6s8knD6gIPaqqnNf8q2mP3dkdFCuxGN1MglY	PostmanRuntime/7.45.0	11:38:44.03119+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	26	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA2MDk5MiwiZXhwIjoxNzU1MDYxODkyfQ.aJCiVu3sipGgWKgJXIQqLZbuIg6tNIqszRN-TDHEUZU	PostmanRuntime/7.45.0	11:56:32.426946+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	27	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTA2MTkyMCwiZXhwIjoxNzU1MDYyODIwfQ.rpkag8EXu2_O9vILt61nyXz5WQmnA6TRNwswntMCC3I	PostmanRuntime/7.45.0	12:12:00.75772+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	28	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTE1MTE4MywiZXhwIjoxNzU1MTUyMDgzfQ.f4dPDiWTRKzAi-SHHfEQdGJizwdFsBK_2FL5tVSl8sI	PostmanRuntime/7.45.0	12:59:43.605587+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	29	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTc3OTI4OCwiZXhwIjoxNzU1NzgwMTg4fQ.upbjslQNiO8TKsbtZsXlzCy6qJgnKaz5RuMQSvJX088	PostmanRuntime/7.45.0	19:28:08.453638+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	30	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NTc3OTM3MywiZXhwIjoxNzU1NzgwMjczfQ.CI-vXdwQJpNLJ7A6ZFlt6ATmjSn-FMFs8KCscYVVi00	PostmanRuntime/7.45.0	19:29:33.909105+07	2025-08-21 19:29:48.751469
7370ea58-d419-4159-bcdf-e1cc9de8f94d	31	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjE4NTQxOCwiZXhwIjoxNzU2MTg2MzE4fQ.xjBp3vNVuRePDDgVFvThNT9vUOmHAVvDlOImP7jHC-U	PostmanRuntime/7.45.0	12:16:58.800501+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	32	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjE5MjMzNCwiZXhwIjoxNzU2MTkzMjM0fQ.YIjT0eQr7llYDgojUtS1FZVucvmwnXl77gc79xVzWcc	PostmanRuntime/7.45.0	14:12:14.153013+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	33	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjE5NDgxNSwiZXhwIjoxNzU2MTk1NzE1fQ.tW0YoJ71DrfLXW-KxG4oE-JN1FFLuGFNEk4kBHc7SQo	PostmanRuntime/7.45.0	14:53:35.475306+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	34	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjE5NTc5MywiZXhwIjoxNzU2MTk2NjkzfQ.YtbzQcXcfGkjw75ddGmbWiJ-8KAjOOXE6Gmp9TWmQ_I	PostmanRuntime/7.45.0	15:09:53.53394+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	35	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjE5Njg0MCwiZXhwIjoxNzU2MTk3NzQwfQ.icXoMj6pw7STF7bnAHfh0Eomi42R7WxQmBu0E7qheuY	PostmanRuntime/7.45.0	15:27:20.23392+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	36	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI2NTI2MiwiZXhwIjoxNzU2MjY2MTYyfQ.YIae1oOWe7U3gxlCaCXxyP9vpv-mODqW5iGku22Arg4	PostmanRuntime/7.45.0	10:27:42.359499+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	37	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI2Njg1NCwiZXhwIjoxNzU2MjY3NzU0fQ.Czb21ZQpDMTh14COMMhoof4PpYWhXsv_8klb49l5BnA	PostmanRuntime/7.45.0	10:54:14.854356+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	38	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI2ODYyOCwiZXhwIjoxNzU2MjY5NTI4fQ.AMWeqK0ouPxF_KjbbUocArP-1lLRoH3l1DMgyNLSqW0	PostmanRuntime/7.45.0	11:23:48.964008+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	39	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI2OTU0NywiZXhwIjoxNzU2MjcwNDQ3fQ.xi_LI18LNmlkkxkPVKANLe3DjQMxR7Z-o0Rrc3wejS0	PostmanRuntime/7.45.0	11:39:07.906934+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	40	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI3MDQ2MywiZXhwIjoxNzU2MjcxMzYzfQ.s2jUjtvinQzCARKsLkXV1sGSX3bEbygMFo32QW1SYTY	PostmanRuntime/7.45.0	11:54:23.13852+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	41	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI3MTkzNiwiZXhwIjoxNzU2MjcyODM2fQ.JsnLOG2y6w5FLRSnBmBxizn2f_ve7Xt1oBHH_aqyFPo	PostmanRuntime/7.45.0	12:18:56.444086+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	42	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI3NjQxMCwiZXhwIjoxNzU2Mjc3MzEwfQ.9auT7Iroi_ZVdlY8JHRVA0d42AHSBINmZUtX34rg2jM	PostmanRuntime/7.45.0	13:33:30.883471+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	43	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI3NzQxNCwiZXhwIjoxNzU2Mjc4MzE0fQ.NAxmWUPBrZtFNr9mb9IsFxiJ2NVoRcw2qshwg5Y86gg	PostmanRuntime/7.45.0	13:50:14.256879+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	44	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI3ODQzNywiZXhwIjoxNzU2Mjc5MzM3fQ.YOifaJ20or6jhl9pbRJgyIAVGyKTgiURAxAZx4Ovf9I	PostmanRuntime/7.45.0	14:07:17.994372+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	45	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4MDA5MCwiZXhwIjoxNzU2MjgwOTkwfQ.e5TlQeF5njv9_Nx7GbjU8ewfImBjmP-0Px6KpBrEo_c	PostmanRuntime/7.45.0	14:34:50.917371+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	46	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4Mjg2MSwiZXhwIjoxNzU2MjgzNzYxfQ.TASpPAxSN4Y0h9vko5Ff5SsLfDnR5ue6emOxaugr5Yc	PostmanRuntime/7.45.0	15:21:01.91434+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	47	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4Mzk2MCwiZXhwIjoxNzU2Mjg0ODYwfQ.nug9N2UXVZ9B10uR4uLgfP6ozj2bZpV-SbBN7PXzTcw	PostmanRuntime/7.45.0	15:39:20.010817+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	48	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4NzUzNCwiZXhwIjoxNzU2Mjg4NDM0fQ.RiR5LadYoalJ6_NfOaNE5iZaTAR_NBNNnbX-Vq4badI	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	16:38:54.85792+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	49	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4NzkxNywiZXhwIjoxNzU2Mjg4ODE3fQ.XvQFkGfhDpsZQe07cQUYeNDw3_gzufRPuqf7JiAques	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	16:45:17.629447+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	50	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4NzkzNywiZXhwIjoxNzU2Mjg4ODM3fQ.J_iXRX5p3M4-Rytfs2vnj_UnH49eufUnHUHw3pNz6yM	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	16:45:37.784137+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	51	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4Nzk1NywiZXhwIjoxNzU2Mjg4ODU3fQ.tZN2v_sIx74zFEgNNBmIINILpE1Yp540dVPSGj9g-Bk	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	16:45:57.889907+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	52	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI4ODcyMywiZXhwIjoxNzU2Mjg5NjIzfQ.-MpggbXprOJKuqti-NKLVYMISPF-nw0Xq5ROZsjehq0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	16:58:43.523008+07	\N
7769598e-cb3d-4947-8ddb-024493394624	53	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjI5MDQwNywiZXhwIjoxNzU2MjkxMzA3fQ.aD2bRbCIUhjpx1EhX__QgzsTiOIJS_0mTJBgO5039Vg	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	17:26:47.092578+07	\N
77719a58-094d-48ee-b050-a3dde0ed28fc	54	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3NzE5YTU4LTA5NGQtNDhlZS1iMDUwLWEzZGRlMGVkMjhmYyIsInVzZXJuYW1lIjoiQXp6eV8yIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjI5MDQ3NSwiZXhwIjoxNzU2MjkxMzc1fQ.B0BUXW6p9laPNdRnxKd2IawXBbEJay_QJ7h82St8_NY	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	17:27:55.976128+07	\N
a5979cc3-0742-4376-8244-c40612d91c0d	55	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE1OTc5Y2MzLTA3NDItNDM3Ni04MjQ0LWM0MDYxMmQ5MWMwZCIsInVzZXJuYW1lIjoiQXp6eV8zIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjI5MDUwMSwiZXhwIjoxNzU2MjkxNDAxfQ.i2eOSld0FcvJPGoRnmdshI_ZX2li2hJKRD0EFSPyY1Q	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	17:28:21.666388+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	56	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjI5MTE0NSwiZXhwIjoxNzU2MjkyMDQ1fQ.PStjKRIIZYrPlDnsbDvANFmNJTAkLQ0E08zDfcl7mho	PostmanRuntime/7.45.0	17:39:05.706744+07	\N
7769598e-cb3d-4947-8ddb-024493394624	57	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjI5MTQzMiwiZXhwIjoxNzU2MjkyMzMyfQ.sn5WpDUIY-n_gFfkhFS0U-ta-g0YRm8Cuefw8K476Sc	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	17:43:52.828954+07	\N
7769598e-cb3d-4947-8ddb-024493394624	58	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjI5MTQ5NCwiZXhwIjoxNzU2MjkyMzk0fQ.ADnOdYexVYhMBjE45GYLzBzVRkpQzlOZhYE7xdu3wy4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	17:44:54.147336+07	\N
7769598e-cb3d-4947-8ddb-024493394624	59	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjM0OTg0NiwiZXhwIjoxNzU2MzUwNzQ2fQ.94AuqTodwhqdzui-8yRjzrnQlqBy0PiuTK5VLeCQEH0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	09:57:26.227229+07	\N
7769598e-cb3d-4947-8ddb-024493394624	60	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjM1MTI4MywiZXhwIjoxNzU2MzUyMTgzfQ.i_5-10B1FPK4BBQEZey4jOJS81VkvS6_MIU2vnWS5UI	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	10:21:23.802719+07	\N
7769598e-cb3d-4947-8ddb-024493394624	61	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjM2Mjk2OCwiZXhwIjoxNzU2MzYzODY4fQ.UzKxh13n9vV8g9x65djh1iivL8jYx63S2oBRgN5k8YA	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	13:36:08.109131+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	62	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjM2NDQxNiwiZXhwIjoxNzU2MzY1MzE2fQ.jx3oV8PGDdhchz9r8AY_wYRzF8as_voKWvJXV8pgoVI	PostmanRuntime/7.45.0	14:00:16.527997+07	\N
7769598e-cb3d-4947-8ddb-024493394624	63	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjM3NjUwMiwiZXhwIjoxNzU2Mzc3NDAyfQ.vhfe0VXiQ322k-gzq2XvfuO2-VwIpGGE1O0XXpxHLeI	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	17:21:42.728041+07	\N
7769598e-cb3d-4947-8ddb-024493394624	64	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzMjA4MywiZXhwIjoxNzU2NDMyOTgzfQ.wq-QSWrPLS6LToztvWLsIR7QZYshUl__Xa74qqIiTgM	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	08:48:03.760496+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	65	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjQzMjI5NywiZXhwIjoxNzU2NDMzMTk3fQ.j9raXZz951D9-NjwCCPVWf_kt3YT6jdpVsf36OkSAd8	PostmanRuntime/7.45.0	08:51:37.261053+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	66	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjQzNzEwOCwiZXhwIjoxNzU2NDM4MDA4fQ.wcLx90fHOwQLkPCgfJU3RiphJsM-I_JlZsZJgZQzCno	PostmanRuntime/7.45.0	10:11:48.561983+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	67	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjQzNzE1MCwiZXhwIjoxNzU2NDM4MDUwfQ.K4iN0fQS-XuaVR0isOjDx2LNswiGvsh_ROen00GNbC8	PostmanRuntime/7.45.0	10:12:30.965136+07	\N
7769598e-cb3d-4947-8ddb-024493394624	68	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzNzM2OCwiZXhwIjoxNzU2NDM4MjY4fQ.FLsZm5ww2IqDTvo-etOk6SvwGeEM6k1Op9cEDfT6ug4	PostmanRuntime/7.45.0	10:16:08.831404+07	\N
7769598e-cb3d-4947-8ddb-024493394624	69	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzODQyMiwiZXhwIjoxNzU2NDM5MzIyfQ.fg5-OynbKNs7pyt9RPXbN9ZBb4MTeBhDU6JyYS7GzhE	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	10:33:42.638206+07	\N
7769598e-cb3d-4947-8ddb-024493394624	70	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzODU0MiwiZXhwIjoxNzU2NDM5NDQyfQ.bN986V_l7v6I7xC-zc6MYoUfAn1wQ_3gnMRpFulLRpI	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	10:35:42.315018+07	\N
7769598e-cb3d-4947-8ddb-024493394624	71	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzODYxNSwiZXhwIjoxNzU2NDM5NTE1fQ.06IXKMA2drbDFHu4XHVEYqzaq7p54APLeIHYxwfreWg	PostmanRuntime/7.45.0	10:36:55.401244+07	\N
7769598e-cb3d-4947-8ddb-024493394624	72	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzOTM3NywiZXhwIjoxNzU2NDQwMjc3fQ.1ObUU96ZYBexJHeJFkL8c__R4cuF2_763IbNdzz02IQ	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	10:49:37.27452+07	\N
7769598e-cb3d-4947-8ddb-024493394624	73	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzOTg5NCwiZXhwIjoxNzU2NDQwNzk0fQ.D1gQ4k0V2HQD7fckNGU-HGynA9n_abQdYwuFCx2j5Bg	PostmanRuntime/7.45.0	10:58:14.735179+07	\N
7769598e-cb3d-4947-8ddb-024493394624	74	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQzOTkwMywiZXhwIjoxNzU2NDQwODAzfQ.luQO9pJ8x7Ts-S6WU0yASe7SLD1fs9mWhyXghhWF-3E	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	10:58:23.484799+07	\N
7769598e-cb3d-4947-8ddb-024493394624	75	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQ1MDk3NCwiZXhwIjoxNzU2NDUxODc0fQ.6TgbwCt-6dBs5shB5T5dBZESybaayF9q-lFMyX8v3IU	PostmanRuntime/7.45.0	14:02:54.719569+07	\N
7769598e-cb3d-4947-8ddb-024493394624	76	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQ1MjYxNCwiZXhwIjoxNzU2NDUzNTE0fQ.129OyYgtu8IeLPk8pwcI025XPiN5SMv4KFwQcmuI8eo	PostmanRuntime/7.45.0	14:30:14.965736+07	\N
7769598e-cb3d-4947-8ddb-024493394624	77	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQ1MzkyNywiZXhwIjoxNzU2NDU0ODI3fQ.sWUeNNTt0pCuXFURo0O1q9_mF6qNTP0OV0jpqSD8K8k	PostmanRuntime/7.45.0	14:52:07.706297+07	\N
7769598e-cb3d-4947-8ddb-024493394624	78	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQ1NDkyNCwiZXhwIjoxNzU2NDU1ODI0fQ.V5WpVF7OAOYhurrfeo4LdaFL4Z7HFKpLUGN87xAc8Xw	PostmanRuntime/7.45.0	15:08:44.953056+07	\N
7370ea58-d419-4159-bcdf-e1cc9de8f94d	79	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjczNzBlYTU4LWQ0MTktNDE1OS1iY2RmLWUxY2M5ZGU4Zjk0ZCIsInVzZXJuYW1lIjoiQXp6eSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1NjQ1NTUxNywiZXhwIjoxNzU2NDU2NDE3fQ.SwW96c1c2oS4RiwviT7V68rpDhFfQvQTG3Nr8hIjRrY	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	15:18:37.011485+07	\N
7769598e-cb3d-4947-8ddb-024493394624	80	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc3Njk1OThlLWNiM2QtNDk0Ny04ZGRiLTAyNDQ5MzM5NDYyNCIsInVzZXJuYW1lIjoiQXp6eV8xIiwicm9sZSI6InBsYXllciIsImlhdCI6MTc1NjQ1NTU4NCwiZXhwIjoxNzU2NDU2NDg0fQ.lf90JTfESBd9aDUzwHcVWqSimAYYSM8czYOpPIXF8oQ	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	15:19:44.833564+07	\N
\.


--
-- Data for Name: weakness; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weakness (weakness_id, weakness_type, weakness_damage_mult) FROM stdin;
2	2	40
5	1	40
6	3	40
7	4	40
\.


--
-- Data for Name: weapon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weapon (weapon_id, weapon_element, weapon_type, weapon_base_damage, weapon_name, weapon_image) FROM stdin;
34	1	10	80	Bow of Magi	https://res.cloudinary.com/dmtaew5vg/image/upload/v1756364473/kuy2iv9jbjxejd8ydfli.webp
35	2	7	80	Glory of Guts	https://res.cloudinary.com/dmtaew5vg/image/upload/v1756364506/wnicphxls39n1cngem2s.webp
36	3	9	80	Elevendil bow	https://res.cloudinary.com/dmtaew5vg/image/upload/v1756364535/oly34ueexjbv7wkx5xzb.webp
\.


--
-- Data for Name: weapon_master_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weapon_master_type (weapon_type_id, weapon_type_name) FROM stdin;
7	Blunt
8	Slash
9	Pierce
10	Magic
\.


--
-- Name: element_types_element_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.element_types_element_types_id_seq', 9, true);


--
-- Name: learn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.learn_id_seq', 1, true);


--
-- Name: master_class_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.master_class_class_id_seq', 39, true);


--
-- Name: resistance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resistance_id_seq', 1, false);


--
-- Name: resistance_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resistance_seq', 5, true);


--
-- Name: session_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.session_session_id_seq', 80, true);


--
-- Name: weakness_weakness_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.weakness_weakness_id_seq', 7, true);


--
-- Name: weapon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.weapon_id_seq', 36, true);


--
-- Name: weapon_master_type_weapon_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.weapon_master_type_weapon_type_id_seq', 10, true);


--
-- Name: element_types element_types_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.element_types
    ADD CONSTRAINT element_types_name_unique UNIQUE (element_types_name);


--
-- Name: element_types element_types_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.element_types
    ADD CONSTRAINT element_types_pk PRIMARY KEY (element_types_id);


--
-- Name: enemy enemy_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemy
    ADD CONSTRAINT enemy_pk PRIMARY KEY (enemy_id);


--
-- Name: learn learn_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learn
    ADD CONSTRAINT learn_pkey PRIMARY KEY (id);


--
-- Name: master_class master_class_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.master_class
    ADD CONSTRAINT master_class_pk PRIMARY KEY (class_id);


--
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (user_id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: resistances resistances_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resistances
    ADD CONSTRAINT resistances_pk PRIMARY KEY (resistance_id);


--
-- Name: session session_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pk PRIMARY KEY (session_id);


--
-- Name: learn unique_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learn
    ADD CONSTRAINT unique_name UNIQUE (name);


--
-- Name: weakness weakness_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weakness
    ADD CONSTRAINT weakness_pk PRIMARY KEY (weakness_id);


--
-- Name: weapon_master_type weapon_master_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon_master_type
    ADD CONSTRAINT weapon_master_type_pkey PRIMARY KEY (weapon_type_id);


--
-- Name: weapon_master_type weapon_master_type_unique_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon_master_type
    ADD CONSTRAINT weapon_master_type_unique_name UNIQUE (weapon_type_name);


--
-- Name: weapon weapon_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_pk PRIMARY KEY (weapon_id);


--
-- Name: idx_learn_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_learn_id ON public.learn USING btree (id);


--
-- Name: idx_player_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_player_id ON public.player USING btree (user_id);


--
-- Name: enemy enemy_resistances_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemy
    ADD CONSTRAINT enemy_resistances_fk FOREIGN KEY (enemy_resistance) REFERENCES public.resistances(resistance_id);


--
-- Name: enemy enemy_weakness_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemy
    ADD CONSTRAINT enemy_weakness_fk FOREIGN KEY (enemy_weakness) REFERENCES public.weakness(weakness_id);


--
-- Name: player fk_player_class; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT fk_player_class FOREIGN KEY (player_class) REFERENCES public.master_class(class_id);


--
-- Name: player fk_player_weapon; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT fk_player_weapon FOREIGN KEY (player_weapon) REFERENCES public.weapon(weapon_id);


--
-- Name: refresh_tokens refresh_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.player(user_id);


--
-- Name: resistances resistances_element_types_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resistances
    ADD CONSTRAINT resistances_element_types_fk FOREIGN KEY (resistance_type) REFERENCES public.element_types(element_types_id);


--
-- Name: weakness weakness_weakness_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weakness
    ADD CONSTRAINT weakness_weakness_type_fkey FOREIGN KEY (weakness_type) REFERENCES public.element_types(element_types_id);


--
-- Name: weapon weapon_weapon_element_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_weapon_element_fkey FOREIGN KEY (weapon_element) REFERENCES public.element_types(element_types_id);


--
-- Name: weapon weapon_weapon_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_weapon_type_fkey FOREIGN KEY (weapon_type) REFERENCES public.weapon_master_type(weapon_type_id);