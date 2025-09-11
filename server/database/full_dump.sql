--
-- PostgreSQL database dump
--

\restrict rVN8E9wdbWE1PmEH5EuykthJiJaT04ldx21IgkT95ZDWRRJvYw3uYWf343hNDju

-- Dumped from database version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)

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
-- Name: chat_history; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.chat_history (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    message_text text NOT NULL,
    message_role character varying(20) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chat_history_message_role_check CHECK (((message_role)::text = ANY ((ARRAY['user'::character varying, 'assistant'::character varying, 'tool'::character varying])::text[])))
);


ALTER TABLE public.chat_history OWNER TO myuser;

--
-- Name: garansi; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.garansi (
    garansi_id uuid DEFAULT gen_random_uuid() NOT NULL,
    garansi_description text NOT NULL
);


ALTER TABLE public.garansi OWNER TO myuser;

--
-- Name: product; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.product (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    product character varying(255) NOT NULL,
    quantity integer,
    positive text,
    negative text,
    price integer
);


ALTER TABLE public.product OWNER TO myuser;

--
-- Name: users; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.users (
    user_id character varying(50) NOT NULL,
    id_data uuid,
    product character varying(100),
    status character varying(50),
    estimasi character varying(255)
);


ALTER TABLE public.users OWNER TO myuser;

--
-- Data for Name: chat_history; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.chat_history (id, user_id, message_text, message_role, "timestamp") FROM stdin;
12f2eb1f-bc6c-4f8f-8aab-52ca9d0e6738	ff2973e1-c28b-4690-8b7a-06f11400f72f	my name is raffel	user	2025-09-10 04:50:31.108494+07
50044274-4e7e-474d-a949-4fde424d0eb4	ff2973e1-c28b-4690-8b7a-06f11400f72f	Halo! Berdasarkan konteks terakhir, nama Anda adalah Raffel.	assistant	2025-09-10 21:59:58.899218+07
6913d662-e8ca-4e49-a3b3-5f1e2df0c622	ff2973e1-c28b-4690-8b7a-06f11400f72f	siapa nama saya	user	2025-09-10 21:59:59.023543+07
8ab434fc-5914-42af-89f1-e8e36133f417	ff2973e1-c28b-4690-8b7a-06f11400f72f	Halo! Berdasarkan konteks terakhir, nama Anda adalah Raffel.	assistant	2025-09-10 22:05:52.979845+07
9d996056-063c-4137-b7c2-2ff91e8e3331	ff2973e1-c28b-4690-8b7a-06f11400f72f	siapa nama saya	user	2025-09-10 22:05:53.037165+07
2e50e4cc-e38e-46f9-b0a4-9792771f222e	ff2973e1-c28b-4690-8b7a-06f11400f72f	nama saya prama dari malang dan kerja di lintasarta	user	2025-09-10 22:08:11.600713+07
497e8023-cbcf-4a03-9ad9-d437922e6e85	ff2973e1-c28b-4690-8b7a-06f11400f72f	nama saya prama dari malang dan kerja di lintasarta	user	2025-09-10 22:08:54.12413+07
5570f5c7-2526-459c-a7cf-2b4d904ff761	ff2973e1-c28b-4690-8b7a-06f11400f72f	Halo! Berdasarkan konteks terakhir, nama Anda adalah Raffel dan Anda asal dari Kota Malang. Sementara pekerjaan Anda adalah Lintasarta.	assistant	2025-09-10 22:10:30.747348+07
d5e40413-9b68-4aea-9f9e-c70134732a5b	ff2973e1-c28b-4690-8b7a-06f11400f72f	dari kota mana saya berasal dan apa pekerjaan saya	user	2025-09-10 22:10:30.769007+07
668e478c-6f8a-4b25-b0b1-fcd96deaf1c2	aaaaaaaa-aaaa-aaaa-0000-000000000002	nama saya adri	user	2025-09-11 02:39:10.739389+07
ed1dc817-6896-43a4-9013-c9d27b6f9c12	aaaaaaaa-aaaa-aaaa-0000-000000000001	Halo!\n\nDeath Squad Band adalah grup musik hip hop asal Indonesia, dibentuk pada tahun 2003. Grup ini dikenal karena lagu-lagu mereka yang memiliki lirik yang menggambarkan kehidupan di kota dan masalah sosial di Indonesia.\n\nTerakhir,\nSelamat!	assistant	2025-09-11 03:06:35.831187+07
c1a85c13-45e0-4247-af0a-87bcc39021a1	aaaaaaaa-aaaa-aaaa-0000-000000000001	apa itu death squad band	user	2025-09-11 03:06:35.904917+07
22191768-fddd-40b8-b474-ca16669303f1	aaaaaaaa-aaaa-aaaa-0000-000000000009	Halo Isyana!\n\nAnda bisa meminta bantuan dari saya dalam berbagai hal, seperti menjawab pertanyaan, memberikan informasi tentang topik tertentu, membantu dalam menyelesaikan masalah, atau bahkan membuat konten cerita.\n\nApakah ada sesuatu yang spesifik yang ingin Anda tanyakan atau meminta bantuan?	assistant	2025-09-11 03:09:05.25736+07
e4a164d2-7c10-4256-a0e0-e5c067ae3e48	aaaaaaaa-aaaa-aaaa-0000-000000000009	nama saya adalah isyana, dan saya penasran terhadap apa yang dapat anda lakukan	user	2025-09-11 03:09:05.273263+07
c052d887-34ad-40de-856f-2ebaa0f691fe	aaaaaaaa-aaaa-aaaa-0000-000000000009	Error: Invalid format specifier ' "xxxx"' for object of type 'str'	assistant	2025-09-11 03:13:48.869822+07
3391e3f1-c505-4b55-a72e-709772ba680a	aaaaaaaa-aaaa-aaaa-0000-000000000009	siapakah nama saya tadi	user	2025-09-11 03:13:48.914507+07
19c48dab-a260-41d6-ba1a-4f26cfc9519a	aaaaaaaa-aaaa-aaaa-0000-000000000009	Error: Invalid format specifier ' "get_user", "args": {'user_id': 'aaaaaaaa-aaaa-aaaa-0000-000000000009'}' for object of type 'str'	assistant	2025-09-11 03:15:45.419416+07
f47b39de-ddd1-4df0-a8b3-b1ee53cd0fde	aaaaaaaa-aaaa-aaaa-0000-000000000009	siapakah nama saya tadi	user	2025-09-11 03:15:45.436676+07
64baa0b4-e2b6-4968-b1b2-24f6613ad565	aaaaaaaa-aaaa-aaaa-0000-000000000009	Error: Invalid format specifier ' aaaaaaaa-aaaa-aaaa-0000-000000000009' for object of type 'str'	assistant	2025-09-11 03:18:44.075215+07
611ae5fc-a71c-4bbf-855c-90ed2a256325	aaaaaaaa-aaaa-aaaa-0000-000000000009	siapakah nama saya tadi	user	2025-09-11 03:18:44.110868+07
e238409d-996c-406e-b975-52d17761943d	aaaaaaaa-aaaa-aaaa-0000-000000000009	Selamat pagi Isyana! Saya senang membantu Anda. Kami memiliki berbagai jenis kamera yang bisa memenuhi kebutuhan fotografi Anda, mulai dari kamera DSLR, mirrorless, hingga kamera instan. Apakah Anda memiliki tujuan atau preferensi tertentu dalam memilih kamera?	assistant	2025-09-11 03:20:13.00087+07
170e686b-13f1-48ba-be65-eade9852cc78	aaaaaaaa-aaaa-aaaa-0000-000000000009	nama saya adalah isyana, dan saya penasran terhadap apa yang dapat anda lakukan	user	2025-09-11 03:20:13.029224+07
317ca68f-fb42-4c43-8bae-a0c32c837bf9	aaaaaaaa-aaaa-aaaa-0000-000000000009	Error: cannot access local variable 'final_answer' where it is not associated with a value	assistant	2025-09-11 03:23:04.18675+07
5bdc8464-1c7f-49e1-900d-8f5352e7641b	aaaaaaaa-aaaa-aaaa-0000-000000000009	siapa nama saya tadi	user	2025-09-11 03:23:04.206512+07
989cfe6f-5f57-4cfe-b73d-b66b788929d7	aaaaaaaa-aaaa-aaaa-0000-000000000009	Maaf, saya tidak memiliki informasi tentang identitas Anda. Saya dapat membantu Anda mencari kamera yang tepat untuk kebutuhan Anda, apakah ada jenis kamera tertentu yang Anda cari? \n\nTerima kasih sudah berkomunikasi dengan saya!	assistant	2025-09-11 03:25:14.018295+07
067a9afa-9235-44a3-a9b2-608bb5b47726	aaaaaaaa-aaaa-aaaa-0000-000000000009	siapa nama saya tadi	user	2025-09-11 03:25:14.036798+07
544357c6-56f6-4c6a-9e82-0841e5a828dc	aaaaaaaa-aaaa-aaaa-0000-000000000009	Saya tidak memiliki informasi tentang pertanyaan sebelumnya. Apakah Anda ingin memulai dengan pertanyaan baru? \n\nSelamat pagi! Bagaimana saya dapat membantu Anda hari ini?	assistant	2025-09-11 03:26:26.090434+07
086ff11d-09ea-491f-a7f4-afe24cee5916	aaaaaaaa-aaaa-aaaa-0000-000000000009	apa pertanyaan sebelum ini	user	2025-09-11 03:26:26.160023+07
c6b29e94-59d7-49c7-a393-6345c362905a	aaaaaaaa-aaaa-aaaa-0000-000000000009	Maaf, saya tidak menemukan informasi tentang pertanyaan terakhir Anda.	assistant	2025-09-11 03:28:19.853058+07
d7420b33-e0b2-407e-826b-a172d838ef4f	aaaaaaaa-aaaa-aaaa-0000-000000000009	oke apa pertanyaan terakhir saya	user	2025-09-11 03:28:19.87034+07
00bfef9e-f7e5-44c4-be95-d4cc9d94bb72	aaaaaaaa-aaaa-aaaa-0000-000000000009	Halo Budi!\n\nSaya dapat membantu Anda menemukan kamera yang sesuai dengan kebutuhan Anda. Apakah Anda mencari kamera untuk pengambilan foto, video, atau hanya ingin memiliki alat yang sederhana untuk mengabadikan momen?	assistant	2025-09-11 03:29:07.761276+07
0011c855-6f2f-47fe-87f3-3ac6ba066ff4	aaaaaaaa-aaaa-aaaa-0000-000000000009	nama saya adalah budi, dan saya penasran dengan apa yang dapat anda lakukan	user	2025-09-11 03:29:07.777314+07
c7f26fe4-7ea7-4b94-96bd-b7cf518cb22e	aaaaaaaa-aaaa-aaaa-0000-000000000009	Maaf, saya tidak memiliki informasi tentang identitas Anda. Bagaimana saya bisa membantu Anda hari ini?	assistant	2025-09-11 03:29:40.299437+07
d8476f69-ab1f-4975-b2d1-7f3fc2e0368c	aaaaaaaa-aaaa-aaaa-0000-000000000009	siapa nama saya tadi?	user	2025-09-11 03:29:40.3161+07
3586e272-1939-4ca7-af40-f8b3d6c69c92	aaaaaaaa-aaaa-aaaa-0000-000000000009	Maaf, saya tidak bisa membantu Anda dengan informasi akun.	assistant	2025-09-11 03:30:31.720099+07
6f13ea6b-b2a9-47ab-8fc1-bf4aa64a6474	aaaaaaaa-aaaa-aaaa-0000-000000000009	berapakah user_id saya	user	2025-09-11 03:30:31.736002+07
2502e29d-0492-4b21-a491-dd31a0c342d3	aaaaaaaa-aaaa-aaaa-0000-000000000009	Saya tidak memiliki informasi tentang status pemesanan Anda. Silakan cek email pembayaran atau hubungi kami untuk mendapatkan update status pemesanan Anda. Apakah Anda ingin membantu saya menemukan product yang sesuai dengan kebutuhan Anda?	assistant	2025-09-11 03:33:02.487193+07
e6c848e6-4229-43f5-9572-a74408acf365	aaaaaaaa-aaaa-aaaa-0000-000000000009	bagaimaan status pemesanan saya	user	2025-09-11 03:33:02.544092+07
e4c202ee-460e-44ca-8260-4a7935bf3071	aaaaaaaa-aaaa-aaaa-0000-000000000009	Halo! Kami memiliki beberapa jenis kamera di toko kami, antara lain:\n\n* Kamera DSLR (Digital Single-Lens Reflex)\n* Kamera Mirrorless\n* Kamera Point-and-Shoot\n* Kamera Action\n* Kamera Konvensional\n\nIngin membantu kamu menemukan yang sesuai dengan kebutuhanmu?	assistant	2025-09-11 03:33:39.343469+07
45dde798-ef7c-4877-a751-53c3e8dd9624	aaaaaaaa-aaaa-aaaa-0000-000000000009	apa kamera yang ada di toko ini	user	2025-09-11 03:33:39.402502+07
59da82f5-c3d7-4d07-afc4-a8daeaa90a86	aaaaaaaa-aaaa-aaaa-0000-000000000009	Error: recent_chat() missing 1 required positional argument: 'user_id'	assistant	2025-09-11 03:37:48.248265+07
928fa0a7-662c-483d-b553-739aaf6e2f73	aaaaaaaa-aaaa-aaaa-0000-000000000009	oke nama saya adalah tom dan saya penasaran terhadap apa yang bisa ada disini	user	2025-09-11 03:37:48.280847+07
8545e1a5-e79d-43b5-887d-4b9d16936704	aaaaaaaa-aaaa-aaaa-0000-000000000009	Error: recent_chat() missing 1 required positional argument: 'user_id'	assistant	2025-09-11 03:39:07.701035+07
99f3224d-19f7-4705-9ea8-675eb6833ac7	aaaaaaaa-aaaa-aaaa-0000-000000000009	oke nama saya adalah tom dan saya penasaran terhadap apa yang bisa ada disini	user	2025-09-11 03:39:07.717879+07
816c43f8-19eb-406a-9742-0e4e8888b35b	aaaaaaaa-aaaa-aaaa-0000-000000000009	Halo Tom! Selamat datang di toko kami. Kami memiliki berbagai jenis kamera dari merek-merek ternama seperti Canon, Fuji, Sony, dan GoPro. Apakah Anda mencari kamera untuk fotografi, videografi, atau olahraga ekstrem?	assistant	2025-09-11 03:42:13.368334+07
2ef2f5df-e448-4c5d-a788-374adbedd697	aaaaaaaa-aaaa-aaaa-0000-000000000009	oke nama saya adalah tom dan saya penasaran terhadap apa yang bisa ada disini	user	2025-09-11 03:42:13.412596+07
532d9fa1-8214-4c88-89b3-2353cf6c8ef2	aaaaaaaa-aaaa-aaaa-0000-000000000009	Nama Anda pada chatt lainnya adalah Tom.	assistant	2025-09-11 03:42:44.773977+07
06cd7808-4d60-4eca-9df5-f410d31ae698	aaaaaaaa-aaaa-aaaa-0000-000000000009	siapa nama saya tadi	user	2025-09-11 03:42:44.851908+07
844a5f84-b15e-4d07-80a3-fc0cb469c6a3	aaaaaaaa-aaaa-aaaa-0000-000000000009	Tom, kami memiliki beberapa kamera dari Sony di sini. Berikut ini adalah beberapa contoh:\n\n1. **Sony FX30**: Kamera DSLR yang menawarkan fitur video profesional, termasuk perekaman 4K Super 35 dan dual base ISO untuk performa cahaya rendah yang luar biasa.\n2. **Sony A6400**: Kamera mirrorless yang sangat ringkas dan memiliki resolusi video berkualitas tinggi, ideal untuk foto dan video.\n3. **Hasselblad X1D** (diproduksi oleh Sony): Kamera medium-format yang menghasilkan kualitas gambar luar biasa dengan detail dan rentang dinamis yang luas.\n\nApakah Anda ingin tahu lebih lanjut tentang salah satu dari kamera-kamera tersebut, Tom?	assistant	2025-09-11 03:43:38.195843+07
676199a2-940a-44a8-8014-03d59c70c93a	aaaaaaaa-aaaa-aaaa-0000-000000000009	kamera apa saja yang ada pada merk sony	user	2025-09-11 03:43:38.261947+07
f692e2bb-5d61-4a06-8818-de4b95f4e223	aaaaaaaa-aaaa-aaaa-0000-000000000009	Harga kamera Sony A6400 adalah sekitar Rp 12.000.000.\n\nKekurangan dari kamera Sony A6400 adalah:\n\n1. Sistem menu yang ketinggalan zaman dan sulit dinavigasi.\n2. Tidak dilengkapi stabilisasi gambar di dalam bodi (IBIS), yang menjadi kekurangan untuk pengambilan video genggam.\n\nNamun, perlu diingat bahwa Sony A6400 masih merupakan pilihan yang baik bagi para pembuat konten dan fotografer yang ingin memiliki kamera dengan fitur video profesional.	assistant	2025-09-11 03:44:53.285525+07
4b727c6d-ea8d-401a-85b1-8718a9f8bd8d	aaaaaaaa-aaaa-aaaa-0000-000000000009	berapa harga dari kamera sony a6400 dan apa kekurangannya	user	2025-09-11 03:44:53.304514+07
a674e0b7-18ab-402a-9d12-94cf03713365	aaaaaaaa-aaaa-aaaa-0000-000000000009	Baiklah, saya akan menjawab pertanyaan Anda tentang kelebihan dari kamera Sony A6400.\n\nBerikut ini adalah beberapa kelebihan dari kamera Sony A6400:\n\n1. **Sistem Fokus Otomatis yang Cepat dan Akurat**: Kamera Sony A6400 memiliki sistem fokus otomatis yang sangat cepat dan akurat, ideal untuk foto dan video.\n2. **Resolusi Video Berkualitas Tinggi**: Kamera ini memiliki resolusi video berkualitas tinggi, membuatnya ideal untuk pengambilan video profesional.\n3. **Kemampuan Cahaya Rendah yang Superior**: Kamera Sony A6400 memiliki kemampuan cahaya rendah yang superior dengan fitur dual base ISO.\n4. **Desain Ringkas dan Ergonomis**: Kamera ini sangat ringkas dan memiliki desain ergonomis, membuatnya mudah untuk dipegang dan digunakan selama lama.\n5. **Fitur Video Profesional**: Kamera Sony A6400 menawarkan fitur video profesional seperti perekaman 4K dan stabilisasi gambar di dalam bodi (IBIS).\n6. **Harga yang Kompetitif**: Meskipun memiliki beberapa kelebihan, kamera Sony A6400 masih memiliki harga yang kompetitif dibandingkan dengan kamera lain di klasifikasi yang sama.\n\nSemoga informasi ini membantu, Tom!\n\nTerima kasih sudah berbicara dengan saya!\nAssisten	assistant	2025-09-11 03:57:31.438177+07
8ff32340-a2e8-46a6-9211-aad9a39cce3b	aaaaaaaa-aaaa-aaaa-0000-000000000009	lalu untuk kelebihannya	user	2025-09-11 03:57:34.831831+07
49affe64-218c-4df4-aa9c-e1775ea7d52c	aaaaaaaa-aaaa-aaaa-0000-000000000009	apa kamera nya tadi?	user	2025-09-11 04:08:38.319442+07
4bbf1db8-5e6b-4d22-a0da-43d138d6372a	aaaaaaaa-aaaa-aaaa-0000-000000000009		assistant	2025-09-11 04:31:59.90007+07
50915c4c-d68a-4624-a8ba-d9419b0039b6	aaaaaaaa-aaaa-aaaa-0000-000000000009	apa status pemesanan saya dari user saya	user	2025-09-11 04:35:15.353961+07
fcbfebf8-4e20-4d27-9cd2-048cecdee664	aaaaaaaa-aaaa-aaaa-0000-000000000009	{"name":"get_user","parameters {"user_id": "aaaaaaa-aaaa-aaaa-0000-000000000009"}}	assistant	2025-09-11 04:35:15.394825+07
15a1eb58-ccf6-45ab-a961-fba768f05a57	aaaaaaaa-aaaa-aaaa-0000-000000000009	apa status pemesanan saya dari user saya	user	2025-09-11 04:46:01.547243+07
60f60421-cf97-4832-8f85-8c101b537ad0	aaaaaaaa-aaaa-aaaa-0000-000000000009		assistant	2025-09-11 04:46:01.644541+07
a37fe49f-aa32-4533-9f58-885e2fa037dd	aaaaaaaa-aaaa-aaaa-0000-000000000009	apa status pemesanan saya dari user saya	user	2025-09-11 04:49:57.694637+07
a2363eec-2642-4eb7-9fa3-cf70ae7fe333	aaaaaaaa-aaaa-aaaa-0000-000000000009	halo, maaf sebelumnya saya tidak menjawab pertanyaan Anda. Berdasarkan informasi yang ada, saya tidak menemukan data tentang status pemesanan Anda karena tidak ada korelasi dengan data yang ada. Jika Anda ingin mengetahui status pemesanan Anda, saya sarankan Anda untuk menghubungi pengemasan atau tim penjualan kami. Mereka dapat membantu Anda mengetahui status pemesanan Anda lebih lanjut.	assistant	2025-09-11 04:49:57.797549+07
f286e69c-eb6f-4dc3-8786-9a4face785e0	aaaaaaaa-aaaa-aaaa-0000-000000000009	apa status pemesanan saya dari user saya	user	2025-09-11 05:01:32.703829+07
fff2669e-cb8f-41cc-91b9-ce654d5d0fe3	aaaaaaaa-aaaa-aaaa-0000-000000000009	Halo! Maaf sebelumnya saya tidak menjawab pertanyaan Anda. Berdasarkan informasi yang ada, saya tidak menemukan data tentang status pemesanan Anda karena tidak ada korelasi dengan data yang ada. Jika Anda ingin mengetahui status pemesanan Anda, saya sarankan Anda untuk menghubungi pengemasan atau tim penjualan kami. Mereka dapat membantu Anda mengetahui status pemesanan Anda lebih lanjut.\n\nTerima kasih telah berkomunikasi dengan saya!	assistant	2025-09-11 05:01:37.398037+07
39473516-a50b-4ae8-85a1-376f0a6f1c33	aaaaaaaa-aaaa-aaaa-0000-000000000009	apakah ada garansi pengiriman dan garansi air jika terkena air	user	2025-09-11 05:06:07.042736+07
062ef5e0-0a71-4750-857c-b21a6475f1ac	aaaaaaaa-aaaa-aaaa-0000-000000000009	Error: 'list' object has no attribute 'to_dict'	assistant	2025-09-11 05:06:07.100381+07
cafd80b4-ebe2-414e-9d69-3707498e5dc7	aaaaaaaa-aaaa-aaaa-0000-000000000009	apakah ada garansi pengiriman dan garansi air jika terkena air	user	2025-09-11 05:07:43.678681+07
816db529-eaaf-4bd5-b532-0dd752629478	aaaaaaaa-aaaa-aaaa-0000-000000000009	Error: 'list' object has no attribute 'to_dict'	assistant	2025-09-11 05:07:43.720312+07
c172fef6-280d-4ce5-b01d-153dcf27f140	aaaaaaaa-aaaa-aaaa-0000-000000000009	apakah ada garansi pengiriman dan garansi air jika terkena air	user	2025-09-11 05:09:55.85318+07
2284c6c7-e253-4e12-a77f-26a55273a49d	aaaaaaaa-aaaa-aaaa-0000-000000000009	Berdasarkan informasi yang ada, ada beberapa garansi yang tersedia untuk kamera tersebut. Garansi lensa dan sensor 2 tahun, garansi baterai dan motor gimbal selama 1 tahun, garansi resmi 18 bulan, garansi perjalanan internasional 1 tahun, garansi sistem rekam video selama 18 bulan, garansi body dan shutter selama 2 tahun, garansi sparepart resmi selama 2 tahun, garansi resmi 1 tahun penuh, garansi anti-air dan body selama 1 tahun, serta garansi premium Hasselblad X1D selama 3 tahun.\n\nUntuk informasi lebih lanjut tentang garansi-garansi tersebut, silakan hubungi service center kami atau menghubungi kami melalui telepon untuk mendapatkan informasi lebih lanjut.	assistant	2025-09-11 05:09:55.912814+07
1eacd10c-c942-43e5-af04-bdf8b9fd884d	aaaaaaaa-aaaa-aaaa-0000-000000000009	what is 1+1	user	2025-09-11 05:18:59.111408+07
654f8a4f-f292-414e-8320-f670f9317ad6	aaaaaaaa-aaaa-aaaa-0000-000000000009	Sorry, I didn't understand the question. \n\nBut if you want to calculate 1+1 we have it as 2	assistant	2025-09-11 05:18:59.166626+07
a56fc7f9-df84-4ed6-ac45-3844124cb68a	aaaaaaaa-aaaa-aaaa-0000-000000000009	what is my id	user	2025-09-11 07:09:59.259824+07
1aa80455-32c4-495d-a5be-293fedab24e3	aaaaaaaa-aaaa-aaaa-0000-000000000009	Selamat datang! Berapa lama ingin menggunakan kamera Canon EOS 5D mark II?	assistant	2025-09-11 07:09:59.389878+07
9b87100c-9c80-494c-8f77-e53039250339	aaaaaaaa-aaaa-aaaa-0000-000000000009	apa status tracking saya	user	2025-09-11 08:18:14.969173+07
9794bdf7-dfa1-4c62-b5ce-6f26f1059c9e	aaaaaaaa-aaaa-aaaa-0000-000000000009	Selamat datang! Berapa lama ingin menggunakan kamera Canon EOS 5D mark II?	assistant	2025-09-11 08:18:14.999973+07
f2b20aab-5586-44d6-818e-96c49a35be0c	aaaaaaaa-aaaa-aaaa-0000-000000000009	jika saya ingin melakukan atau mengclaim granasi harus seperti apa	user	2025-09-11 08:32:11.782537+07
f4a2ae77-f2bb-4220-825e-ed29670febd6	aaaaaaaa-aaaa-aaaa-0000-000000000009	Untuk melakukan atau mengklaim garansi, Anda dapat mengikuti langkah-langkah berikut:\n\n1. Bawa produk dan bukti pembelian ke service center resmi.\n2. Tim memeriksa dan verifikasi kerusakan.\n3. Produk diperbaiki/diganti sesuai garansi.\n\nAnda juga dapat mencari informasi lebih lanjut tentang garansi yang tersedia untuk produk Anda dengan menghubungi customer service atau visit website resmi produsen.	assistant	2025-09-11 08:32:11.820464+07
\.


--
-- Data for Name: garansi; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.garansi (garansi_id, garansi_description) FROM stdin;
cbda78cf-d109-4f5d-8356-4a20f35f479d	Garansi resmi 1 tahun penuh, mencakup perbaikan kerusakan pabrik, penggantian sparepart asli, serta layanan teknis di seluruh service center resmi.
0bff9d1c-19fc-43c1-b9ae-f10e67462c1f	Garansi lensa dan sensor 2 tahun, termasuk kalibrasi ulang sensor, perbaikan optik lensa, serta layanan pembersihan rutin di service center resmi.
bd8504bf-e4d0-4741-9b86-bf50a0bbff22	Garansi sistem rekam video selama 18 bulan, termasuk perbaikan modul perekaman, sensor gambar, serta pembaruan firmware resmi tanpa biaya tambahan.
fabf4f12-d2c8-4c2e-8e92-1bba929d28e7	Garansi premium Hasselblad X1D selama 3 tahun, meliputi servis menyeluruh, perbaikan sensor medium format, serta dukungan teknis prioritas langsung dari Hasselblad Global Service.
ca194c04-65ea-4f9b-a1ce-4f16105f70f9	Garansi sparepart resmi selama 2 tahun, mencakup penggantian suku cadang asli, servis perawatan berkala, serta dukungan firmware terbaru.
31acabd2-ab3d-485c-ab5c-39081b7cd532	Garansi baterai dan motor gimbal selama 1 tahun, meliputi penggantian baterai cacat produksi, servis motor gimbal, serta pengecekan stabilisasi berkala.
3d05c13a-e3c9-4adf-8180-c7df30f3c7de	Garansi resmi 18 bulan, mencakup perbaikan sistem elektronik, kalibrasi sensor, serta layanan software update di seluruh jaringan service center resmi.
c12f243e-04ae-4938-909b-b9d369be51af	Garansi body dan shutter selama 2 tahun, meliputi penggantian unit shutter, perbaikan kerusakan body, serta garansi tambahan untuk update software produk.
588d2c7b-4a06-4417-ad7c-7271c2060a72	Garansi perjalanan internasional 1 tahun, mencakup perlindungan kerusakan dan kehilangan produk saat bepergian, serta layanan penggantian darurat di service center global resmi.
d6da00bf-c767-46f3-88a0-652b48526082	 Cara klaim: 1) Bawa produk & bukti pembelian ke service center. 2) Tim memeriksa & verifikasi kerusakan. 3) Produk diperbaiki/diganti sesuai garansi.
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.product (id, product, quantity, positive, negative, price) FROM stdin;
7dc45c4f-5e67-4c10-befd-76238f951879	sony a6400	20	Fitur andalannya adalah sistem fokus otomatis yang sangat cepat dan akurat, ideal untuk foto dan video. Kamera ini juga sangat ringkas dan memiliki resolusi video berkualitas tinggi, menjadikannya pilihan hibrida yang hebat bagi para pembuat konten.	Kamera ini memiliki sistem menu yang ketinggalan zaman dan sulit dinavigasi. Selain itu, kamera ini tidak dilengkapi stabilisasi gambar di dalam bodi (IBIS), yang menjadi kekurangan untuk pengambilan video genggam.	12000000
66963378-248c-4eb7-8a18-8078a00b1e1f	sony fx30	10	Kamera ini unggul dengan fitur video profesionalnya, termasuk perekaman 4K Super 35 dan dual base ISO untuk performa cahaya rendah yang luar biasa. Desain bodinya ringan dan memiliki banyak titik pasang, memudahkan penyiapan untuk pengambilan gambar profesional.	Ukuran yang ringkas bisa menyebabkan panas berlebih selama sesi perekaman panjang, terutama di lingkungan yang lebih hangat. Kemampuan fotonya standar dibandingkan fitur videonya, yang mungkin tidak cocok untuk fotografer.	28000000
e9b01886-d3f8-49c1-9a1c-abdd403ff18a	canon R10	15	Canon R10 menawarkan perpaduan hebat antara kecepatan dan keterjangkauan, dengan kecepatan pemotretan beruntun yang cepat dan fokus otomatis yang luar biasa dengan pelacakan subjek. Dilengkapi jendela bidik resolusi tinggi dan layar artikulasi penuh, ideal untuk vlogging dan sudut kreatif.	Kamera ini tidak memiliki stabilisasi gambar di dalam bodi (IBIS) dan mengandalkan lensa yang distabilisasi. Kapasitas baterainya relatif pendek, sehingga Anda perlu membawa baterai cadangan untuk pemotretan yang lebih lama.	10500000
4feccd29-6a47-4b84-8122-09cfc5c82458	canon EOS 5D mark ii	5	Sebagai kamera DSLR full-frame klasik, ia dikenal karena kualitas gambar legendaris dan bodi profesional yang kokoh. Kamera ini adalah salah satu DSLR pertama yang menawarkan perekaman video HD penuh, yang merevolusi pembuatan film.	Teknologinya sudah ketinggalan zaman, terutama sistem fokus otomatisnya yang lambat dibandingkan kamera mirrorless modern. Bodinya juga berat dan besar, membuatnya kurang nyaman untuk penggunaan sehari-hari.	9000000
c99d35ee-cc9e-41b3-9b7a-bcdc4dd75a62	fuji x-t30	18	Kamera ini terkenal karena desain retro yang menawan dan dial fisik yang intuitif untuk pengalaman memotret yang interaktif. Kamera ini menghasilkan warna yang indah langsung dari kamera berkat simulasi film Fuji yang terkenal.	Ergonominya terasa sempit bagi pengguna dengan tangan yang lebih besar, dan fokus otomatis videonya tidak seandal para pesaing. Baterainya juga lebih kecil, membatasi waktu penggunaan dalam sekali pengisian daya.	12500000
5e59c34f-a3e7-4095-ac3c-7d03271dc843	fuji x100v	7	Kamera ini menonjol dengan desain ringkasnya yang indah dan lensa tetap 23mm f/2, yang mendorong gaya fotografi jalanan yang unik dan disengaja. Kamera ini juga memiliki jendela bidik hibrida, memungkinkan Anda beralih antara tampilan optik dan elektronik.	Lensa yang tidak bisa diganti berarti Anda tidak bisa memperbesar atau mengganti lensa, yang membatasi fleksibilitasnya. Harganya meroket karena popularitasnya yang viral, membuatnya sangat mahal dan sulit ditemukan.	24000000
b9d019ad-90e5-43b9-bb82-144d04dc34dd	dji osmo pocket 3	25	DJI Osmo Pocket 3 memiliki gimbal bawaan yang sangat efektif, menghasilkan rekaman video yang sangat halus dan stabil. Sensor 1 incinya merupakan peningkatan besar, memberikan performa cahaya rendah yang superior dan rentang dinamis yang luas.	Ini adalah alat yang berfokus pada video, dengan fungsionalitas terbatas untuk fotografi. Layar yang kecil dapat menyulitkan pembingkaian bidikan, dan faktor bentuknya yang mungil bisa menjadi tantangan untuk dipegang.	7500000
65aec777-c847-465f-a286-c81bfe44d396	gopro hero 13	30	Kamera GoPro Hero terkenal karena desainnya yang kokoh dan tahan air serta stabilisasi video yang kuat, menjadikannya sempurna untuk olahraga ekstrem. Kamera ini menawarkan bidang pandang yang sangat lebar untuk menangkap perspektif yang imersif.	Sensornya yang kecil kesulitan dalam kondisi cahaya rendah, menghasilkan butiran yang jelas pada pemotretan gelap. Kamera ini juga memiliki masa pakai baterai yang pendek, yang dapat menjadi masalah saat pemotretan jangka panjang.	9000000
676aecd3-628e-4cd2-86b0-c484e36785f6	hasselblad x1d	2	Kamera ini menghasilkan kualitas gambar medium-format yang luar biasa dengan detail dan rentang dinamis yang luar biasa, ideal untuk fotografi lanskap dan potret profesional. Desainnya minimalis dan elegan, menawarkan pengalaman memotret yang unik.	Kamera ini sangat mahal dan tidak cocok untuk aksi cepat karena fokus otomatisnya yang lambat. Ia juga memiliki pilihan lensa yang terbatas dan mahal, menjadikannya alat yang sangat khusus.	80000000
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.users (user_id, id_data, product, status, estimasi) FROM stdin;
aaaaaaaa-aaaa-aaaa-0000-000000000002	0bff9d1c-19fc-43c1-b9ae-f10e67462c1f	fuji x100v	di jalan	Estimasi 2–4 hari hingga sampai tujuan
aaaaaaaa-aaaa-aaaa-0000-000000000003	d6da00bf-c767-46f3-88a0-652b48526082	gopro hero 13	telah sampai	Pesanan sudah diterima, tidak ada estimasi tambahan
aaaaaaaa-aaaa-aaaa-0000-000000000004	bd8504bf-e4d0-4741-9b86-bf50a0bbff22	sony fx30	belum ada transaksi	Belum ada estimasi pengiriman karena belum ada pesanan aktif
aaaaaaaa-aaaa-aaaa-0000-000000000005	fabf4f12-d2c8-4c2e-8e92-1bba929d28e7	hasselblad x1d	transit	Estimasi 1–2 hari menuju lokasi akhir
aaaaaaaa-aaaa-aaaa-0000-000000000006	ca194c04-65ea-4f9b-a1ce-4f16105f70f9	sony a6400	di kemas	Estimasi 1–2 hari sebelum dikirim
aaaaaaaa-aaaa-aaaa-0000-000000000007	31acabd2-ab3d-485c-ab5c-39081b7cd532	dji osmo pocket 3	di jalan	Estimasi 2–4 hari hingga sampai tujuan
aaaaaaaa-aaaa-aaaa-0000-000000000008	3d05c13a-e3c9-4adf-8180-c7df30f3c7de	fuji x-t30	telah sampai	Pesanan sudah diterima, tidak ada estimasi tambahan
aaaaaaaa-aaaa-aaaa-0000-000000000009	c12f243e-04ae-4938-909b-b9d369be51af	canon R10	belum ada transaksi	Belum ada estimasi pengiriman karena belum ada pesanan aktif
aaaaaaaa-aaaa-aaaa-0000-000000000010	588d2c7b-4a06-4417-ad7c-7271c2060a72	fuji x100v	transit	Estimasi 1–2 hari menuju lokasi akhir
aaaaaaaa-aaaa-aaaa-0000-000000000001	cbda78cf-d109-4f5d-8356-4a20f35f479d	canon EOS 5D mark ii	di kemas	Estimasi 1–2 hari sebelum dikirim
\.


--
-- Name: chat_history chat_history_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.chat_history
    ADD CONSTRAINT chat_history_pkey PRIMARY KEY (id);


--
-- Name: users garansi_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT garansi_pkey PRIMARY KEY (user_id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: garansi users_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.garansi
    ADD CONSTRAINT users_pkey PRIMARY KEY (garansi_id);


--
-- Name: garansi users_username_key; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.garansi
    ADD CONSTRAINT users_username_key UNIQUE (garansi_description);


--
-- Name: users garansi_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT garansi_user_id_fkey FOREIGN KEY (id_data) REFERENCES public.garansi(garansi_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO myuser;


--
-- PostgreSQL database dump complete
--

\unrestrict rVN8E9wdbWE1PmEH5EuykthJiJaT04ldx21IgkT95ZDWRRJvYw3uYWf343hNDju

