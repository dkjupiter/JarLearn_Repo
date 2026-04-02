--
-- PostgreSQL database dump
--

\restrict 3uRRFu5i2LlGV9jxU5xz7iOiCNWWTtaVrvK1VUjyaFDFcDAtejljVGi7FAVUCNh

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2026-03-22 16:55:01

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

--
-- TOC entry 266 (class 1255 OID 17079)
-- Name: update_plan_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_plan_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF
    OLD."Plan_Content" IS DISTINCT FROM NEW."Plan_Content"
    OR OLD."Activity_Todo" IS DISTINCT FROM NEW."Activity_Todo"
  THEN
    NEW."Plan_Updated" = NOW();
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_plan_updated_at() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 247 (class 1259 OID 17145)
-- Name: ActivityParticipants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ActivityParticipants" (
    "ActivityParticipant_ID" integer NOT NULL,
    "ActivitySession_ID" integer NOT NULL,
    "Student_ID" integer NOT NULL,
    "Joined_At" timestamp with time zone DEFAULT now() NOT NULL,
    "Left_At" timestamp with time zone
);


ALTER TABLE public."ActivityParticipants" OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 17144)
-- Name: ActivityParticipants_ActivityParticipant_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ActivityParticipants_ActivityParticipant_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ActivityParticipants_ActivityParticipant_ID_seq" OWNER TO postgres;

--
-- TOC entry 5311 (class 0 OID 0)
-- Dependencies: 246
-- Name: ActivityParticipants_ActivityParticipant_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ActivityParticipants_ActivityParticipant_ID_seq" OWNED BY public."ActivityParticipants"."ActivityParticipant_ID";


--
-- TOC entry 241 (class 1259 OID 17065)
-- Name: activityplans_plan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activityplans_plan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activityplans_plan_id_seq OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16654)
-- Name: ActivityPlans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ActivityPlans" (
    "Plan_ID" integer DEFAULT nextval('public.activityplans_plan_id_seq'::regclass) NOT NULL,
    "Class_ID" integer NOT NULL,
    "Week" character varying(100) NOT NULL,
    "Date_WeekPlan" date NOT NULL,
    "Plan_Content" text NOT NULL,
    "Plan_Created" timestamp with time zone DEFAULT now(),
    "Activity_Todo" jsonb NOT NULL,
    "Plan_Updated" timestamp with time zone
);


ALTER TABLE public."ActivityPlans" OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 17095)
-- Name: ActivitySessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ActivitySessions" (
    "ActivitySession_ID" integer NOT NULL,
    "Class_ID" integer NOT NULL,
    "Activity_Type" character varying(20) NOT NULL,
    "Assigned_By" integer NOT NULL,
    "Assigned_At" timestamp with time zone DEFAULT now() NOT NULL,
    "Status" character varying(20) DEFAULT 'active'::character varying NOT NULL,
    "Ended_At" timestamp with time zone
);


ALTER TABLE public."ActivitySessions" OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17094)
-- Name: ActivitySessions_ActivitySession_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ActivitySessions_ActivitySession_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ActivitySessions_ActivitySession_ID_seq" OWNER TO postgres;

--
-- TOC entry 5312 (class 0 OID 0)
-- Dependencies: 242
-- Name: ActivitySessions_ActivitySession_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ActivitySessions_ActivitySession_ID_seq" OWNED BY public."ActivitySessions"."ActivitySession_ID";


--
-- TOC entry 256 (class 1259 OID 17325)
-- Name: AssignedInteractiveBoards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AssignedInteractiveBoards" (
    "AssignedInteractiveBoard_ID" integer NOT NULL,
    "ActivitySession_ID" integer NOT NULL,
    "Allow_Anonymous" boolean DEFAULT false NOT NULL,
    "Created_At" timestamp with time zone DEFAULT now() NOT NULL,
    "Board_Name" text
);


ALTER TABLE public."AssignedInteractiveBoards" OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 17324)
-- Name: AssignedInteractiveBoards_AssignedInteractiveBoard_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AssignedInteractiveBoards_AssignedInteractiveBoard_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."AssignedInteractiveBoards_AssignedInteractiveBoard_ID_seq" OWNER TO postgres;

--
-- TOC entry 5313 (class 0 OID 0)
-- Dependencies: 255
-- Name: AssignedInteractiveBoards_AssignedInteractiveBoard_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AssignedInteractiveBoards_AssignedInteractiveBoard_ID_seq" OWNED BY public."AssignedInteractiveBoards"."AssignedInteractiveBoard_ID";


--
-- TOC entry 250 (class 1259 OID 17193)
-- Name: AssignedPoll; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AssignedPoll" (
    "AssignedPoll_ID" integer CONSTRAINT "AssignedPoll_AssignedPoll_ID_not_null1" NOT NULL,
    "ActivitySession_ID" integer CONSTRAINT "AssignedPoll_ActivitySession_ID_not_null1" NOT NULL,
    "Poll_Question" character varying(255) NOT NULL,
    "Allow_Multiple" boolean DEFAULT false CONSTRAINT "AssignedPoll_Allow_Multiple_not_null1" NOT NULL,
    "Duration" integer,
    "Created_At" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."AssignedPoll" OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17192)
-- Name: AssignedPoll_AssignedPoll_ID_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AssignedPoll_AssignedPoll_ID_seq1"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."AssignedPoll_AssignedPoll_ID_seq1" OWNER TO postgres;

--
-- TOC entry 5314 (class 0 OID 0)
-- Dependencies: 249
-- Name: AssignedPoll_AssignedPoll_ID_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AssignedPoll_AssignedPoll_ID_seq1" OWNED BY public."AssignedPoll"."AssignedPoll_ID";


--
-- TOC entry 245 (class 1259 OID 17110)
-- Name: AssignedQuiz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AssignedQuiz" (
    "AssignedQuiz_ID" integer NOT NULL,
    "ActivitySession_ID" integer NOT NULL,
    "Quiz_ID" integer NOT NULL,
    "Mode" character varying(20) NOT NULL,
    "Student_Per_Team" integer,
    "Timer_Type" character varying(20) NOT NULL,
    "Question_Time" integer,
    "Quiz_Time" integer
);


ALTER TABLE public."AssignedQuiz" OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 17109)
-- Name: AssignedQuiz_AssignedQuiz_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AssignedQuiz_AssignedQuiz_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."AssignedQuiz_AssignedQuiz_ID_seq" OWNER TO postgres;

--
-- TOC entry 5315 (class 0 OID 0)
-- Dependencies: 244
-- Name: AssignedQuiz_AssignedQuiz_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AssignedQuiz_AssignedQuiz_ID_seq" OWNED BY public."AssignedQuiz"."AssignedQuiz_ID";


--
-- TOC entry 225 (class 1259 OID 16537)
-- Name: AvatarAccessories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AvatarAccessories" (
    "Accessory_ID" integer NOT NULL,
    "Accessory_Image" character varying(255) NOT NULL
);


ALTER TABLE public."AvatarAccessories" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16546)
-- Name: AvatarBodies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AvatarBodies" (
    "Body_ID" integer NOT NULL,
    "Body_Image" character varying(255) NOT NULL
);


ALTER TABLE public."AvatarBodies" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16518)
-- Name: AvatarCostumes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AvatarCostumes" (
    "Costume_ID" integer NOT NULL,
    "Costume_Image" character varying(255) NOT NULL
);


ALTER TABLE public."AvatarCostumes" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16492)
-- Name: AvatarMasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AvatarMasks" (
    "Mask_ID" integer NOT NULL,
    "Mask_Image" character varying(255) NOT NULL
);


ALTER TABLE public."AvatarMasks" OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16872)
-- Name: avatars_avatar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.avatars_avatar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.avatars_avatar_id_seq OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16566)
-- Name: Avatars; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Avatars" (
    "Avatar_ID" integer DEFAULT nextval('public.avatars_avatar_id_seq'::regclass) CONSTRAINT "Avatars_Avater_ID_not_null" NOT NULL,
    "Mask_ID" integer NOT NULL,
    "Costume_ID" integer NOT NULL,
    "Accessory_ID" integer NOT NULL,
    "Body_ID" integer NOT NULL
);


ALTER TABLE public."Avatars" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16665)
-- Name: ClassRooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ClassRooms" (
    "Class_ID" integer NOT NULL,
    "Teacher_ID" integer NOT NULL,
    "Class_Name" character varying(100) NOT NULL,
    "Class_Section" character varying(100) NOT NULL,
    "Class_Subject" character varying(100) NOT NULL,
    "Join_Code" character varying(100) NOT NULL,
    is_open boolean DEFAULT false,
    "Is_Hidden" boolean DEFAULT false
);


ALTER TABLE public."ClassRooms" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16843)
-- Name: ClassRooms_Class_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."ClassRooms" ALTER COLUMN "Class_ID" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."ClassRooms_Class_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 258 (class 1259 OID 17339)
-- Name: InteractiveBoardMessages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."InteractiveBoardMessages" (
    "InteractiveBoardMessage_ID" integer NOT NULL,
    "Message" text NOT NULL,
    "Sent_At" timestamp with time zone DEFAULT now() NOT NULL,
    "ActivityParticipant_ID" integer,
    "Sender_Type" text,
    "AssignedInteractiveBoard_ID" integer,
    CONSTRAINT "InteractiveBoardMessages_Sender_Type_check" CHECK (("Sender_Type" = ANY (ARRAY['student'::text, 'teacher'::text])))
);


ALTER TABLE public."InteractiveBoardMessages" OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 17338)
-- Name: InteractiveBoardMessages_InteractiveBoardMessage_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."InteractiveBoardMessages_InteractiveBoardMessage_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."InteractiveBoardMessages_InteractiveBoardMessage_ID_seq" OWNER TO postgres;

--
-- TOC entry 5316 (class 0 OID 0)
-- Dependencies: 257
-- Name: InteractiveBoardMessages_InteractiveBoardMessage_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."InteractiveBoardMessages_InteractiveBoardMessage_ID_seq" OWNED BY public."InteractiveBoardMessages"."InteractiveBoardMessage_ID";


--
-- TOC entry 254 (class 1259 OID 17217)
-- Name: PollAnswers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PollAnswers" (
    "PollAnswer_ID" integer CONSTRAINT "PollAnswers_PollAnswer_ID_not_null1" NOT NULL,
    "PollOption_ID" integer NOT NULL,
    "Answered_At" timestamp with time zone DEFAULT now(),
    "ActivityParticipant_ID" integer
);


ALTER TABLE public."PollAnswers" OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 17216)
-- Name: PollAnswers_PollAnswer_ID_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PollAnswers_PollAnswer_ID_seq1"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PollAnswers_PollAnswer_ID_seq1" OWNER TO postgres;

--
-- TOC entry 5317 (class 0 OID 0)
-- Dependencies: 253
-- Name: PollAnswers_PollAnswer_ID_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PollAnswers_PollAnswer_ID_seq1" OWNED BY public."PollAnswers"."PollAnswer_ID";


--
-- TOC entry 252 (class 1259 OID 17207)
-- Name: PollOptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PollOptions" (
    "PollOption_ID" integer CONSTRAINT "PollOptions_PollOption_ID_not_null1" NOT NULL,
    "AssignedPoll_ID" integer NOT NULL,
    "Option_Text" character varying(255) CONSTRAINT "PollOptions_Option_Text_not_null1" NOT NULL
);


ALTER TABLE public."PollOptions" OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17206)
-- Name: PollOptions_PollOption_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PollOptions_PollOption_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PollOptions_PollOption_ID_seq" OWNER TO postgres;

--
-- TOC entry 5318 (class 0 OID 0)
-- Dependencies: 251
-- Name: PollOptions_PollOption_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PollOptions_PollOption_ID_seq" OWNED BY public."PollOptions"."PollOption_ID";


--
-- TOC entry 222 (class 1259 OID 16443)
-- Name: QuestionOptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuestionOptions" (
    "Option_ID" integer NOT NULL,
    "Question_ID" integer NOT NULL,
    "Option_Text" character varying(150) CONSTRAINT "QuestionOptions_Question_Text_not_null" NOT NULL
);


ALTER TABLE public."QuestionOptions" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16871)
-- Name: QuestionOptions_Option_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."QuestionOptions" ALTER COLUMN "Option_ID" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."QuestionOptions_Option_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16398)
-- Name: QuestionSets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuestionSets" (
    "Set_ID" integer NOT NULL,
    "Teacher_ID" integer NOT NULL,
    "Title" text NOT NULL,
    "Question_Last_Edit" timestamp with time zone DEFAULT now() NOT NULL,
    "Parent_Set_ID" integer,
    "Is_Latest" boolean DEFAULT true,
    "Is_Archived" boolean DEFAULT false
);


ALTER TABLE public."QuestionSets" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16869)
-- Name: QuestionSets_Set_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."QuestionSets" ALTER COLUMN "Set_ID" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."QuestionSets_Set_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 240 (class 1259 OID 17026)
-- Name: Question_Correct_Options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Question_Correct_Options" (
    "Question_ID" integer NOT NULL,
    "Option_ID" integer NOT NULL
);


ALTER TABLE public."Question_Correct_Options" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16428)
-- Name: Questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Questions" (
    "Question_ID" integer NOT NULL,
    "Set_ID" integer NOT NULL,
    "Question_Type" character varying(100) NOT NULL,
    "Question_Text" character varying(500) NOT NULL,
    "Question_Image" character varying(150)
);


ALTER TABLE public."Questions" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16870)
-- Name: Questions_Question_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Questions" ALTER COLUMN "Question_ID" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Questions_Question_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 259 (class 1259 OID 17368)
-- Name: quizanswers_quizanswer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quizanswers_quizanswer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quizanswers_quizanswer_id_seq OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 17157)
-- Name: QuizAnswers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuizAnswers" (
    "QuizAnswer_ID" integer DEFAULT nextval('public.quizanswers_quizanswer_id_seq'::regclass) NOT NULL,
    "Question_ID" integer NOT NULL,
    "Choice_ID" integer,
    "Is_Correct" boolean,
    "Answered_At" timestamp with time zone DEFAULT now(),
    "Answer_Order" integer,
    "Time_Spent" integer,
    "AssignedQuiz_ID" integer,
    "ActivityParticipant_ID" integer
);


ALTER TABLE public."QuizAnswers" OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 17378)
-- Name: QuizProgress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuizProgress" (
    "Current_Question" integer,
    "Total_Questions" integer,
    "Updated_At" timestamp without time zone DEFAULT now(),
    "AssignedQuiz_ID" integer NOT NULL,
    "ActivityParticipant_ID" integer NOT NULL
);


ALTER TABLE public."QuizProgress" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16576)
-- Name: QuizResults; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuizResults" (
    "Result_ID" integer NOT NULL,
    "Total_Score" integer DEFAULT 0 NOT NULL,
    "Total_Question" integer DEFAULT 0 NOT NULL,
    "Total_Correct" integer DEFAULT 0 NOT NULL,
    "Total_Incorrct" integer DEFAULT 0 NOT NULL,
    "Time_ Submission" time with time zone,
    "Total_Time_Taken" integer DEFAULT 0,
    "AssignedQuiz_ID" integer,
    "ActivityParticipant_ID" integer
);


ALTER TABLE public."QuizResults" OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 17372)
-- Name: QuizResults_Result_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."QuizResults" ALTER COLUMN "Result_ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."QuizResults_Result_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 239 (class 1259 OID 16965)
-- Name: students_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.students_student_id_seq OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16629)
-- Name: Students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Students" (
    "Student_ID" integer DEFAULT nextval('public.students_student_id_seq'::regclass) NOT NULL,
    "Student_Name" character varying(100) NOT NULL,
    "Student_Number" integer NOT NULL,
    "Avatar_ID" integer,
    "Class_ID" integer NOT NULL
);


ALTER TABLE public."Students" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16812)
-- Name: Teachers_Teacher_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Teachers_Teacher_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Teachers_Teacher_ID_seq" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16388)
-- Name: Teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Teachers" (
    "Teacher_ID" integer DEFAULT nextval('public."Teachers_Teacher_ID_seq"'::regclass) NOT NULL,
    "Teacher_Name" character varying(100) NOT NULL,
    "Teacher_Email" character varying(100) NOT NULL,
    "Teacher_Password" character varying(100) NOT NULL,
    "Reset_Token" text,
    "Reset_Token_Expire" bigint
);


ALTER TABLE public."Teachers" OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 25563)
-- Name: TeamAssignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TeamAssignments" (
    "Team_ID" integer NOT NULL,
    "Team_Name" character varying(50) NOT NULL,
    "Created_At" timestamp without time zone DEFAULT now(),
    "AssignedQuiz_ID" integer
);


ALTER TABLE public."TeamAssignments" OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 25562)
-- Name: TeamAssignments_Team_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."TeamAssignments_Team_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."TeamAssignments_Team_ID_seq" OWNER TO postgres;

--
-- TOC entry 5319 (class 0 OID 0)
-- Dependencies: 262
-- Name: TeamAssignments_Team_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TeamAssignments_Team_ID_seq" OWNED BY public."TeamAssignments"."Team_ID";


--
-- TOC entry 265 (class 1259 OID 25579)
-- Name: TeamMembers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TeamMembers" (
    "TeamMember_ID" integer NOT NULL,
    "Team_ID" integer NOT NULL,
    "ActivityParticipant_ID" integer
);


ALTER TABLE public."TeamMembers" OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 25578)
-- Name: TeamMembers_TeamMember_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."TeamMembers_TeamMember_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."TeamMembers_TeamMember_ID_seq" OWNER TO postgres;

--
-- TOC entry 5320 (class 0 OID 0)
-- Dependencies: 264
-- Name: TeamMembers_TeamMember_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TeamMembers_TeamMember_ID_seq" OWNED BY public."TeamMembers"."TeamMember_ID";


--
-- TOC entry 233 (class 1259 OID 16841)
-- Name: classrooms_class_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.classrooms_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.classrooms_class_id_seq OWNER TO postgres;

--
-- TOC entry 5321 (class 0 OID 0)
-- Dependencies: 233
-- Name: classrooms_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.classrooms_class_id_seq OWNED BY public."ClassRooms"."Class_ID";


--
-- TOC entry 4996 (class 2604 OID 17148)
-- Name: ActivityParticipants ActivityParticipant_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityParticipants" ALTER COLUMN "ActivityParticipant_ID" SET DEFAULT nextval('public."ActivityParticipants_ActivityParticipant_ID_seq"'::regclass);


--
-- TOC entry 4992 (class 2604 OID 17098)
-- Name: ActivitySessions ActivitySession_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivitySessions" ALTER COLUMN "ActivitySession_ID" SET DEFAULT nextval('public."ActivitySessions_ActivitySession_ID_seq"'::regclass);


--
-- TOC entry 5006 (class 2604 OID 17328)
-- Name: AssignedInteractiveBoards AssignedInteractiveBoard_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssignedInteractiveBoards" ALTER COLUMN "AssignedInteractiveBoard_ID" SET DEFAULT nextval('public."AssignedInteractiveBoards_AssignedInteractiveBoard_ID_seq"'::regclass);


--
-- TOC entry 5000 (class 2604 OID 17196)
-- Name: AssignedPoll AssignedPoll_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssignedPoll" ALTER COLUMN "AssignedPoll_ID" SET DEFAULT nextval('public."AssignedPoll_AssignedPoll_ID_seq1"'::regclass);


--
-- TOC entry 4995 (class 2604 OID 17113)
-- Name: AssignedQuiz AssignedQuiz_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssignedQuiz" ALTER COLUMN "AssignedQuiz_ID" SET DEFAULT nextval('public."AssignedQuiz_AssignedQuiz_ID_seq"'::regclass);


--
-- TOC entry 5009 (class 2604 OID 17342)
-- Name: InteractiveBoardMessages InteractiveBoardMessage_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InteractiveBoardMessages" ALTER COLUMN "InteractiveBoardMessage_ID" SET DEFAULT nextval('public."InteractiveBoardMessages_InteractiveBoardMessage_ID_seq"'::regclass);


--
-- TOC entry 5004 (class 2604 OID 17220)
-- Name: PollAnswers PollAnswer_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PollAnswers" ALTER COLUMN "PollAnswer_ID" SET DEFAULT nextval('public."PollAnswers_PollAnswer_ID_seq1"'::regclass);


--
-- TOC entry 5003 (class 2604 OID 17210)
-- Name: PollOptions PollOption_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PollOptions" ALTER COLUMN "PollOption_ID" SET DEFAULT nextval('public."PollOptions_PollOption_ID_seq"'::regclass);


--
-- TOC entry 5012 (class 2604 OID 25566)
-- Name: TeamAssignments Team_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamAssignments" ALTER COLUMN "Team_ID" SET DEFAULT nextval('public."TeamAssignments_Team_ID_seq"'::regclass);


--
-- TOC entry 5014 (class 2604 OID 25582)
-- Name: TeamMembers TeamMember_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamMembers" ALTER COLUMN "TeamMember_ID" SET DEFAULT nextval('public."TeamMembers_TeamMember_ID_seq"'::regclass);


--
-- TOC entry 5287 (class 0 OID 17145)
-- Dependencies: 247
-- Data for Name: ActivityParticipants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ActivityParticipants" ("ActivityParticipant_ID", "ActivitySession_ID", "Student_ID", "Joined_At", "Left_At") FROM stdin;
1	505	82	2026-02-15 14:31:20.120375+07	\N
5	506	82	2026-02-15 14:33:35.421831+07	\N
8	512	83	2026-02-15 15:23:21.068372+07	\N
13	514	83	2026-02-15 15:29:42.578445+07	\N
19	515	83	2026-02-15 15:33:28.524935+07	\N
23	511	170	2026-02-15 15:34:23.028014+07	\N
24	511	7	2026-02-15 15:34:43.644681+07	\N
30	517	7	2026-02-15 15:37:29.303323+07	\N
31	517	170	2026-02-15 15:37:38.144859+07	\N
32	516	83	2026-02-15 15:38:02.611451+07	\N
35	519	86	2026-02-15 15:39:57.514641+07	\N
38	520	86	2026-02-15 15:43:09.412654+07	\N
40	521	170	2026-02-15 15:49:35.866871+07	\N
41	521	172	2026-02-15 15:49:36.310608+07	\N
45	522	86	2026-02-15 15:51:57.409647+07	\N
48	523	86	2026-02-15 15:54:42.978787+07	\N
51	524	86	2026-02-15 15:56:43.22063+07	\N
54	525	86	2026-02-15 16:00:07.300943+07	\N
62	526	172	2026-02-15 16:05:16.765947+07	\N
63	526	170	2026-02-15 16:05:16.877087+07	\N
71	527	86	2026-02-15 16:08:13.838504+07	\N
73	528	86	2026-02-15 16:08:29.689478+07	\N
75	529	86	2026-02-15 16:10:07.794945+07	\N
80	531	86	2026-02-15 16:13:51.78743+07	\N
83	532	86	2026-02-15 16:14:12.863352+07	\N
86	533	86	2026-02-15 16:17:17.656238+07	\N
88	534	86	2026-02-15 16:18:18.536259+07	\N
91	535	86	2026-02-15 16:30:47.370235+07	\N
93	536	86	2026-02-15 16:33:16.489543+07	\N
95	537	86	2026-02-15 16:36:14.544461+07	\N
97	538	86	2026-02-15 16:37:56.446776+07	\N
99	539	86	2026-02-15 16:39:49.595005+07	\N
101	540	86	2026-02-15 16:42:50.975838+07	\N
103	541	86	2026-02-15 16:43:32.21301+07	\N
105	542	86	2026-02-15 16:44:04.140225+07	\N
108	543	172	2026-02-15 16:45:43.916596+07	\N
111	544	86	2026-02-15 16:47:37.365243+07	\N
114	545	86	2026-02-15 16:59:37.276812+07	\N
116	546	86	2026-02-15 17:00:04.704122+07	\N
119	547	86	2026-02-15 17:00:25.059975+07	\N
122	548	86	2026-02-15 17:00:41.36111+07	\N
124	549	86	2026-02-15 17:00:55.292487+07	\N
126	550	173	2026-02-15 17:01:53.087889+07	\N
130	551	174	2026-02-15 17:08:08.988727+07	\N
138	554	175	2026-02-15 17:22:27.387636+07	\N
142	555	175	2026-02-15 17:24:47.829073+07	\N
145	556	170	2026-02-15 17:46:51.270967+07	\N
151	558	87	2026-02-18 13:25:50.198034+07	\N
154	559	87	2026-02-18 13:33:25.344714+07	\N
156	561	87	2026-02-18 13:35:40.165706+07	\N
159	562	87	2026-02-18 13:36:08.609577+07	\N
162	563	87	2026-02-18 13:40:56.481585+07	\N
164	564	87	2026-02-18 13:41:25.61879+07	\N
167	565	87	2026-02-18 13:43:19.279455+07	\N
169	566	87	2026-02-18 13:43:34.263186+07	\N
171	567	87	2026-02-18 13:49:56.559681+07	\N
173	568	87	2026-02-18 13:50:15.593939+07	\N
175	569	87	2026-02-18 13:50:47.463855+07	\N
177	570	176	2026-02-18 13:53:20.613979+07	\N
180	571	87	2026-02-18 13:57:56.246059+07	\N
184	572	176	2026-02-18 14:02:04.233342+07	\N
188	574	88	2026-02-18 14:09:01.906284+07	\N
191	575	88	2026-02-18 14:10:16.810102+07	\N
192	575	80	2026-02-18 14:10:16.915073+07	\N
195	576	177	2026-02-18 14:10:45.49811+07	\N
199	577	88	2026-02-18 14:11:13.002559+07	\N
200	577	80	2026-02-18 14:11:13.086888+07	\N
204	578	88	2026-02-18 14:15:45.548989+07	\N
205	578	80	2026-02-18 14:15:45.623529+07	\N
209	579	88	2026-02-18 14:17:30.882032+07	\N
212	580	179	2026-02-18 14:18:18.861642+07	\N
214	581	88	2026-02-18 14:18:27.364933+07	\N
217	582	88	2026-02-18 14:20:44.521874+07	\N
219	584	179	2026-02-18 14:21:11.189583+07	\N
222	585	87	2026-02-18 14:21:23.517267+07	\N
225	586	89	2026-02-18 14:22:13.368491+07	\N
227	587	89	2026-02-18 14:22:41.881406+07	\N
229	588	179	2026-02-18 14:26:27.008911+07	\N
231	589	179	2026-02-18 14:26:52.262964+07	\N
233	590	179	2026-02-18 14:27:28.281744+07	\N
235	591	89	2026-02-18 14:27:54.3906+07	\N
239	592	89	2026-02-18 14:29:32.058744+07	\N
242	594	89	2026-02-18 14:34:09.925365+07	\N
245	595	89	2026-02-18 14:35:56.368172+07	\N
247	596	89	2026-02-18 14:36:13.954038+07	\N
249	597	89	2026-02-18 14:37:01.312424+07	\N
251	598	89	2026-02-18 14:38:34.487632+07	\N
254	599	89	2026-02-18 14:39:21.131459+07	\N
258	600	89	2026-02-18 14:40:12.793742+07	\N
260	601	89	2026-02-18 14:40:43.922052+07	\N
263	602	89	2026-02-18 14:44:10.95277+07	\N
266	603	89	2026-02-18 14:48:08.904472+07	\N
268	604	89	2026-02-18 14:48:24.064241+07	\N
270	605	89	2026-02-18 14:48:49.616316+07	\N
273	606	89	2026-02-18 14:49:15.206674+07	\N
276	607	89	2026-02-18 14:51:20.983254+07	\N
278	608	89	2026-02-18 14:53:52.221995+07	\N
280	609	89	2026-02-18 14:54:00.92972+07	\N
283	610	179	2026-02-18 14:56:11.872934+07	\N
285	611	89	2026-02-18 14:57:34.362474+07	\N
288	612	89	2026-02-18 15:02:04.957793+07	\N
291	613	179	2026-02-18 15:05:32.204728+07	\N
293	614	89	2026-02-18 15:07:18.881755+07	\N
295	615	89	2026-02-18 15:07:40.009662+07	\N
297	616	89	2026-02-18 15:09:36.153351+07	\N
299	617	179	2026-02-18 15:11:49.881533+07	\N
302	619	179	2026-02-18 15:12:40.079933+07	\N
305	620	179	2026-02-18 15:14:44.688113+07	\N
309	622	179	2026-02-18 15:16:08.187535+07	\N
312	623	179	2026-02-18 15:18:22.542746+07	\N
315	624	179	2026-02-18 15:21:15.414423+07	\N
318	625	89	2026-02-18 15:33:29.548768+07	\N
321	626	89	2026-02-18 15:34:06.211932+07	\N
323	627	89	2026-02-18 15:35:50.447204+07	\N
325	628	89	2026-02-18 15:36:05.686372+07	\N
327	629	89	2026-02-18 15:38:16.40776+07	\N
329	630	89	2026-02-18 15:44:35.751375+07	\N
333	631	89	2026-02-18 16:26:37.311841+07	\N
335	632	89	2026-02-18 16:37:41.513682+07	\N
337	633	89	2026-02-18 16:38:35.49829+07	\N
340	634	89	2026-02-18 16:47:13.954573+07	\N
341	634	80	2026-02-18 16:47:14.000016+07	\N
344	635	90	2026-02-19 13:34:01.947903+07	\N
347	636	90	2026-02-19 13:35:14.649878+07	\N
350	637	90	2026-02-19 13:35:51.399837+07	\N
355	638	90	2026-02-19 13:49:56.005931+07	\N
358	639	90	2026-02-19 13:51:11.638059+07	\N
363	640	90	2026-02-19 13:57:24.051031+07	\N
367	643	90	2026-02-19 14:02:53.992342+07	\N
371	645	90	2026-02-19 14:07:06.96991+07	\N
374	646	90	2026-02-19 14:07:37.075151+07	\N
378	647	90	2026-02-19 14:10:05.334644+07	\N
382	648	90	2026-02-19 14:13:48.033589+07	\N
385	649	90	2026-02-19 14:14:04.681197+07	\N
390	651	90	2026-02-19 14:16:50.056186+07	\N
395	652	90	2026-02-19 14:17:47.433798+07	\N
400	653	90	2026-02-19 14:18:17.028581+07	\N
405	654	90	2026-02-19 14:22:31.660449+07	\N
409	658	186	2026-02-19 14:52:17.185451+07	\N
410	658	187	2026-02-19 14:52:17.23866+07	\N
411	658	188	2026-02-19 14:52:17.338693+07	\N
416	659	187	2026-02-19 14:56:14.476429+07	\N
417	659	188	2026-02-19 14:56:14.558633+07	\N
418	659	186	2026-02-19 14:56:14.725552+07	\N
422	660	91	2026-02-19 14:59:51.162691+07	\N
425	661	91	2026-02-19 15:07:23.97557+07	\N
433	662	91	2026-02-19 15:07:51.788547+07	\N
437	663	91	2026-02-19 15:08:15.711833+07	\N
441	664	91	2026-02-19 15:08:41.291211+07	\N
446	665	91	2026-02-19 15:09:08.148478+07	\N
451	666	187	2026-02-19 15:11:38.644131+07	\N
453	667	91	2026-02-19 15:14:20.290472+07	\N
461	668	91	2026-02-19 15:20:41.380333+07	\N
465	669	91	2026-02-19 15:21:06.800281+07	\N
467	670	92	2026-02-19 15:21:34.035534+07	\N
469	671	92	2026-02-19 15:25:25.266369+07	\N
475	672	92	2026-02-19 15:25:58.58515+07	\N
479	673	92	2026-02-19 15:26:26.597943+07	\N
485	674	92	2026-02-19 15:27:01.772286+07	\N
490	675	92	2026-02-19 15:30:53.257996+07	\N
498	676	92	2026-02-19 15:36:13.936477+07	\N
503	677	92	2026-02-19 15:36:46.334555+07	\N
506	678	92	2026-02-19 15:37:05.67997+07	\N
513	679	92	2026-02-19 15:37:43.97727+07	\N
519	680	186	2026-02-19 15:41:32.017552+07	\N
520	680	189	2026-02-19 15:41:32.07015+07	\N
521	680	8	2026-02-19 15:41:32.254895+07	\N
522	680	170	2026-02-19 15:41:32.268745+07	\N
528	681	94	2026-02-19 15:44:34.688797+07	\N
532	682	94	2026-02-19 15:45:09.910795+07	\N
535	683	95	2026-02-19 15:45:44.816677+07	\N
539	684	8	2026-02-19 15:46:51.167+07	\N
540	684	189	2026-02-19 15:46:51.285962+07	\N
542	684	190	2026-02-19 15:46:51.44713+07	\N
543	684	170	2026-02-19 15:46:51.462922+07	\N
551	685	95	2026-02-19 15:50:00.213845+07	\N
557	686	95	2026-02-19 15:50:44.136712+07	\N
568	687	190	2026-02-19 15:52:18.687086+07	\N
569	687	170	2026-02-19 15:52:18.707334+07	\N
570	687	189	2026-02-19 15:52:18.786447+07	\N
571	687	8	2026-02-19 15:52:18.914174+07	\N
579	688	95	2026-02-19 15:56:48.803907+07	\N
584	689	95	2026-02-19 15:57:19.634385+07	\N
587	690	26	2026-02-19 15:57:32.666845+07	\N
588	690	191	2026-02-19 15:57:32.706696+07	\N
589	690	42	2026-02-19 15:57:32.79239+07	\N
592	690	192	2026-02-19 15:57:33.049714+07	\N
597	691	95	2026-02-19 15:57:52.43873+07	\N
601	692	95	2026-02-19 15:58:25.254401+07	\N
606	693	95	2026-02-19 15:58:57.057603+07	\N
612	694	26	2026-02-19 16:02:53.070624+07	\N
613	694	42	2026-02-19 16:02:53.095911+07	\N
614	694	192	2026-02-19 16:02:53.13971+07	\N
615	694	191	2026-02-19 16:02:53.332842+07	\N
619	695	96	2026-02-19 16:03:20.859858+07	\N
623	696	96	2026-02-19 16:03:42.966117+07	\N
628	697	97	2026-02-19 16:04:09.619574+07	\N
631	698	97	2026-02-19 16:10:06.327119+07	\N
633	699	97	2026-02-19 16:10:43.60026+07	\N
638	700	97	2026-02-19 16:17:34.91301+07	\N
642	701	97	2026-02-19 16:18:16.255612+07	\N
646	702	97	2026-02-19 16:31:09.990347+07	\N
648	703	97	2026-02-19 16:32:28.416113+07	\N
650	704	98	2026-02-19 16:40:08.878521+07	\N
653	705	98	2026-02-19 16:40:45.854945+07	\N
656	706	98	2026-02-19 16:41:05.199823+07	\N
664	707	99	2026-02-19 16:46:23.611144+07	\N
666	708	106	2026-02-19 16:50:27.166569+07	\N
670	709	106	2026-02-19 16:50:43.717995+07	\N
673	710	106	2026-02-19 16:55:41.92683+07	\N
677	711	106	2026-02-19 16:58:33.815643+07	\N
684	713	106	2026-02-19 17:08:22.395967+07	\N
687	714	106	2026-02-19 17:08:42.559447+07	\N
709	715	106	2026-02-19 17:20:28.533032+07	\N
711	716	109	2026-02-19 17:20:49.859005+07	\N
714	717	109	2026-02-19 17:21:52.063776+07	\N
717	718	112	2026-02-19 17:23:39.373835+07	\N
720	719	112	2026-02-19 17:25:01.550332+07	\N
730	720	112	2026-02-19 17:25:28.55607+07	\N
738	721	112	2026-02-19 17:28:43.805927+07	\N
740	722	112	2026-02-19 17:30:19.040932+07	\N
750	723	112	2026-02-19 17:30:57.162441+07	\N
756	724	112	2026-02-19 17:31:17.611014+07	\N
760	725	112	2026-02-19 17:31:34.347985+07	\N
764	726	112	2026-02-19 17:32:23.409439+07	\N
782	727	112	2026-02-19 17:34:13.665929+07	\N
785	728	113	2026-02-22 13:34:25.113833+07	\N
791	729	113	2026-02-22 13:35:13.632325+07	\N
793	730	113	2026-02-22 13:35:54.746346+07	\N
796	731	113	2026-02-22 13:36:28.961177+07	\N
798	732	113	2026-02-22 13:38:11.778694+07	\N
807	733	113	2026-02-22 13:45:21.856119+07	\N
809	734	113	2026-02-22 13:45:35.780825+07	\N
811	735	113	2026-02-22 13:45:54.609478+07	\N
813	736	113	2026-02-22 13:46:22.026142+07	\N
816	737	113	2026-02-22 13:54:53.177873+07	\N
818	738	113	2026-02-22 13:55:35.574478+07	\N
820	739	113	2026-02-22 13:55:48.994611+07	\N
822	740	113	2026-02-22 13:56:31.378819+07	\N
824	741	113	2026-02-22 13:57:05.541294+07	\N
827	743	113	2026-02-22 14:01:32.224457+07	\N
829	744	113	2026-02-22 14:01:59.929758+07	\N
832	745	195	2026-02-22 14:02:46.435686+07	\N
833	745	172	2026-02-22 14:02:46.612397+07	\N
834	745	197	2026-02-22 14:02:46.628309+07	\N
835	745	196	2026-02-22 14:02:46.692619+07	\N
837	746	113	2026-02-22 14:04:25.368146+07	\N
841	747	113	2026-02-22 14:05:44.671471+07	\N
843	748	113	2026-02-22 14:06:06.269987+07	\N
845	749	196	2026-02-22 14:06:46.097409+07	\N
846	749	195	2026-02-22 14:06:46.251186+07	\N
847	749	172	2026-02-22 14:06:46.254215+07	\N
848	749	197	2026-02-22 14:06:46.278416+07	\N
850	751	113	2026-02-22 14:08:40.553068+07	\N
853	752	113	2026-02-22 14:10:26.23725+07	\N
855	753	172	2026-02-22 14:11:41.313174+07	\N
856	753	197	2026-02-22 14:11:41.450345+07	\N
857	753	196	2026-02-22 14:11:41.451106+07	\N
858	753	195	2026-02-22 14:11:41.470337+07	\N
860	754	113	2026-02-22 14:14:27.020278+07	\N
862	755	113	2026-02-22 14:14:47.611369+07	\N
864	756	113	2026-02-22 14:15:01.751371+07	\N
867	757	196	2026-02-22 14:16:11.40121+07	\N
868	757	195	2026-02-22 14:16:11.590969+07	\N
869	757	172	2026-02-22 14:16:11.669221+07	\N
870	757	197	2026-02-22 14:16:11.707576+07	\N
873	758	113	2026-02-22 14:17:38.243559+07	\N
876	760	113	2026-02-22 14:18:16.419963+07	\N
878	761	113	2026-02-22 14:18:29.243434+07	\N
882	762	113	2026-02-22 14:19:11.485456+07	\N
885	763	113	2026-02-22 14:19:30.726238+07	\N
888	764	113	2026-02-22 14:20:26.806446+07	\N
891	765	113	2026-02-22 14:20:48.072941+07	\N
895	766	113	2026-02-22 14:21:17.225623+07	\N
898	767	113	2026-02-22 14:21:35.393286+07	\N
901	768	113	2026-02-22 14:21:49.33529+07	\N
905	770	195	2026-02-22 14:25:07.622561+07	\N
906	770	197	2026-02-22 14:25:07.820494+07	\N
907	770	196	2026-02-22 14:25:07.821171+07	\N
908	770	172	2026-02-22 14:25:07.829995+07	\N
914	771	113	2026-02-22 14:27:33.00547+07	\N
917	772	113	2026-02-22 14:28:04.321974+07	\N
921	773	113	2026-02-22 14:28:21.078953+07	\N
927	775	113	2026-02-22 14:28:56.954148+07	\N
929	776	195	2026-02-22 14:29:07.657788+07	\N
930	776	172	2026-02-22 14:29:07.824515+07	\N
931	776	197	2026-02-22 14:29:07.855898+07	\N
932	776	196	2026-02-22 14:29:07.893222+07	\N
933	777	113	2026-02-22 14:29:09.560494+07	\N
935	778	113	2026-02-22 14:29:25.34187+07	\N
944	781	172	2026-02-22 14:38:03.083327+07	\N
945	781	197	2026-02-22 14:38:03.089606+07	\N
946	781	196	2026-02-22 14:38:03.104103+07	\N
947	781	195	2026-02-22 14:38:03.114914+07	\N
950	782	113	2026-02-22 14:39:26.857136+07	\N
953	783	113	2026-02-22 14:39:47.674058+07	\N
956	785	113	2026-02-22 14:45:10.320716+07	\N
960	786	113	2026-02-22 14:45:35.386178+07	\N
963	787	113	2026-02-22 14:45:56.081518+07	\N
968	788	195	2026-02-22 14:46:30.169361+07	\N
969	788	196	2026-02-22 14:46:30.332039+07	\N
970	788	197	2026-02-22 14:46:30.372676+07	\N
971	788	172	2026-02-22 14:46:30.375155+07	\N
972	789	113	2026-02-22 14:46:36.646714+07	\N
974	790	113	2026-02-22 14:46:50.935121+07	\N
977	791	113	2026-02-22 14:47:11.363805+07	\N
980	792	113	2026-02-22 14:50:51.997475+07	\N
983	793	113	2026-02-22 14:51:06.604903+07	\N
987	794	195	2026-02-22 14:54:42.329297+07	\N
988	794	197	2026-02-22 14:54:42.529225+07	\N
989	794	172	2026-02-22 14:54:42.532853+07	\N
990	794	196	2026-02-22 14:54:42.534799+07	\N
991	795	113	2026-02-22 14:54:46.93535+07	\N
993	796	113	2026-02-22 14:55:00.15951+07	\N
996	798	113	2026-02-22 14:56:59.708655+07	\N
999	799	113	2026-02-22 14:57:21.071593+07	\N
1001	800	113	2026-02-22 14:57:39.028802+07	\N
1004	801	113	2026-02-22 14:58:02.53973+07	\N
1007	803	113	2026-02-22 14:58:19.129967+07	\N
1010	804	113	2026-02-22 15:00:10.996078+07	\N
1012	805	113	2026-02-22 15:00:27.179376+07	\N
1014	806	113	2026-02-22 15:00:44.250385+07	\N
1017	807	195	2026-02-22 15:06:33.95031+07	\N
1018	808	195	2026-02-22 15:10:22.9219+07	\N
1019	808	172	2026-02-22 15:10:23.092067+07	\N
1020	808	196	2026-02-22 15:10:23.170465+07	\N
1021	808	197	2026-02-22 15:10:23.184263+07	\N
1023	809	113	2026-02-22 15:10:37.738679+07	\N
1025	810	113	2026-02-22 15:10:53.261514+07	\N
1027	811	195	2026-02-22 15:11:55.815794+07	\N
1028	811	196	2026-02-22 15:11:55.978511+07	\N
1029	811	197	2026-02-22 15:11:56.01128+07	\N
1030	811	172	2026-02-22 15:11:56.061464+07	\N
1032	812	113	2026-02-22 15:13:03.423223+07	\N
1034	813	172	2026-02-22 15:13:39.414698+07	\N
1035	813	196	2026-02-22 15:13:39.623743+07	\N
1036	813	195	2026-02-22 15:13:39.685893+07	\N
1037	813	197	2026-02-22 15:13:39.72438+07	\N
1038	814	113	2026-02-22 15:13:43.650174+07	\N
1041	815	113	2026-02-22 15:14:07.519301+07	\N
1044	816	113	2026-02-22 15:14:23.063448+07	\N
1046	817	113	2026-02-22 15:14:32.824048+07	\N
1048	818	113	2026-02-22 15:14:44.746303+07	\N
1050	819	113	2026-02-22 15:15:03.796918+07	\N
1052	820	195	2026-02-22 15:17:22.232292+07	\N
1053	820	172	2026-02-22 15:17:22.304627+07	\N
1055	820	196	2026-02-22 15:17:22.60906+07	\N
1057	820	197	2026-02-22 15:17:22.663499+07	\N
1063	821	113	2026-02-22 15:18:10.730739+07	\N
1065	822	113	2026-02-22 15:18:35.963265+07	\N
1070	823	116	2026-02-22 15:25:36.018417+07	\N
1073	824	116	2026-02-22 15:25:53.197053+07	\N
1077	825	116	2026-02-22 15:26:21.778393+07	\N
1081	826	116	2026-02-22 15:26:50.868651+07	\N
1083	827	116	2026-02-22 15:30:20.884921+07	\N
1087	828	116	2026-02-22 15:30:48.339711+07	\N
1089	829	116	2026-02-22 15:30:57.104646+07	\N
1091	830	116	2026-02-22 15:31:18.133733+07	\N
1094	831	116	2026-02-22 15:31:48.093273+07	\N
1097	832	116	2026-02-22 15:32:28.345354+07	\N
1099	833	116	2026-02-22 15:32:46.28328+07	\N
1101	834	116	2026-02-22 15:33:07.684517+07	\N
1103	835	116	2026-02-22 15:33:28.011766+07	\N
1105	836	116	2026-02-22 15:33:51.373122+07	\N
1107	837	116	2026-02-22 15:33:59.115149+07	\N
1109	838	116	2026-02-22 15:34:09.686483+07	\N
1111	839	116	2026-02-22 15:34:27.892519+07	\N
1114	840	116	2026-02-22 15:34:45.794303+07	\N
1117	841	116	2026-02-22 15:35:06.887117+07	\N
1119	842	116	2026-02-22 15:39:41.359491+07	\N
1122	843	116	2026-02-22 15:40:12.356422+07	\N
1124	844	116	2026-02-22 15:40:31.551711+07	\N
1126	845	116	2026-02-22 15:41:01.67228+07	\N
1129	846	116	2026-02-22 15:41:20.834086+07	\N
1131	847	116	2026-02-22 15:41:35.059445+07	\N
1134	848	116	2026-02-22 15:42:09.055148+07	\N
1136	849	116	2026-02-22 15:42:31.109095+07	\N
1140	850	117	2026-02-22 15:46:54.328138+07	\N
1142	851	117	2026-02-22 15:47:18.961814+07	\N
1144	852	117	2026-02-22 15:47:38.45886+07	\N
1150	853	117	2026-02-22 15:51:24.662604+07	\N
1154	854	117	2026-02-22 15:52:15.147327+07	\N
1161	855	119	2026-02-22 15:56:48.39941+07	\N
1163	856	195	2026-02-22 15:56:51.641935+07	\N
1164	856	197	2026-02-22 15:56:51.70919+07	\N
1165	856	172	2026-02-22 15:56:51.812784+07	\N
1171	857	121	2026-02-22 15:59:04.893572+07	\N
1173	858	121	2026-02-22 15:59:23.186799+07	\N
1177	859	121	2026-02-22 15:59:48.45059+07	\N
1180	860	121	2026-02-22 16:00:07.163014+07	\N
1183	861	121	2026-02-22 16:00:22.716317+07	\N
1187	862	197	2026-02-22 16:04:21.086227+07	\N
1188	862	172	2026-02-22 16:04:21.364061+07	\N
1189	862	195	2026-02-22 16:04:21.366971+07	\N
1196	863	195	2026-02-22 16:06:09.840912+07	\N
1197	863	197	2026-02-22 16:06:10.133029+07	\N
1198	863	172	2026-02-22 16:06:10.17946+07	\N
1205	864	197	2026-02-22 16:07:46.099963+07	\N
1206	864	195	2026-02-22 16:07:46.274532+07	\N
1207	864	172	2026-02-22 16:07:46.369331+07	\N
1211	865	195	2026-02-22 16:09:12.344882+07	\N
1212	865	197	2026-02-22 16:09:12.414449+07	\N
1213	865	172	2026-02-22 16:09:12.668845+07	\N
1217	866	195	2026-02-22 16:12:54.698001+07	\N
1218	866	197	2026-02-22 16:12:54.900175+07	\N
1219	866	172	2026-02-22 16:12:54.944767+07	\N
1223	867	172	2026-02-22 16:20:59.88358+07	\N
1225	867	195	2026-02-22 16:21:00.078309+07	\N
1226	867	197	2026-02-22 16:21:00.159746+07	\N
1231	868	196	2026-02-22 16:24:23.812165+07	\N
1232	868	195	2026-02-22 16:24:24.008238+07	\N
1234	868	172	2026-02-22 16:24:24.068693+07	\N
1237	870	195	2026-02-22 16:28:03.261126+07	\N
1238	870	172	2026-02-22 16:28:03.473642+07	\N
1241	871	121	2026-02-22 16:32:02.303596+07	\N
1242	871	111	2026-02-22 16:32:02.405602+07	\N
1249	872	121	2026-02-22 16:33:45.499686+07	\N
1250	872	111	2026-02-22 16:33:45.623078+07	\N
1254	873	121	2026-02-22 16:34:14.738662+07	\N
1256	873	114	2026-02-22 16:34:15.008512+07	\N
1260	874	121	2026-02-22 16:35:11.973171+07	\N
1261	874	114	2026-02-22 16:35:12.074519+07	\N
1264	875	121	2026-02-22 16:35:42.977804+07	\N
1265	875	114	2026-02-22 16:35:43.081981+07	\N
1268	876	121	2026-02-22 16:36:34.911977+07	\N
1270	876	114	2026-02-22 16:36:35.215584+07	\N
1272	877	121	2026-02-22 16:37:11.465584+07	\N
1273	877	114	2026-02-22 16:37:11.586023+07	\N
1276	878	121	2026-02-22 16:42:20.41291+07	\N
1281	879	121	2026-02-22 16:46:11.880825+07	\N
1285	880	121	2026-02-22 16:46:40.718434+07	\N
1288	881	121	2026-02-22 16:53:18.673089+07	\N
1289	881	114	2026-02-22 16:53:18.76349+07	\N
1292	882	122	2026-02-23 13:39:59.773152+07	\N
1296	883	122	2026-02-23 13:40:27.417566+07	\N
1299	884	122	2026-02-23 13:40:48.363779+07	\N
1302	885	122	2026-02-23 13:41:13.490733+07	\N
1305	886	122	2026-02-23 13:41:33.37514+07	\N
1308	887	122	2026-02-23 13:41:56.901918+07	\N
1312	888	122	2026-02-23 13:42:15.471151+07	\N
1314	889	122	2026-02-23 13:42:36.272624+07	\N
1316	890	122	2026-02-23 13:42:57.611945+07	\N
1319	891	122	2026-02-23 13:45:48.837071+07	\N
1322	892	122	2026-02-23 13:46:11.141635+07	\N
1324	893	122	2026-02-23 13:46:30.980747+07	\N
1326	894	122	2026-02-23 13:46:50.403286+07	\N
1329	895	122	2026-02-23 13:47:10.364589+07	\N
1332	896	122	2026-02-23 13:47:27.426965+07	\N
1335	897	122	2026-02-23 13:47:43.113755+07	\N
1338	898	122	2026-02-23 13:50:53.026913+07	\N
1340	899	123	2026-02-23 13:51:16.151118+07	\N
1342	900	123	2026-02-23 13:52:10.7717+07	\N
1344	901	123	2026-02-23 13:52:32.178053+07	\N
1346	902	123	2026-02-23 13:52:48.038814+07	\N
1348	903	123	2026-02-23 13:53:05.600365+07	\N
1350	904	123	2026-02-23 13:53:39.69981+07	\N
1352	905	123	2026-02-23 13:54:04.430001+07	\N
1355	906	123	2026-02-23 13:54:20.161302+07	\N
1357	907	123	2026-02-23 13:57:49.101525+07	\N
1359	908	124	2026-02-23 14:00:16.86353+07	\N
1363	909	124	2026-02-23 14:01:10.116587+07	\N
1366	910	124	2026-02-23 14:03:39.718771+07	\N
1368	911	124	2026-02-23 14:04:00.511314+07	\N
1370	912	124	2026-02-23 14:04:22.353969+07	\N
1372	913	124	2026-02-23 14:09:19.109529+07	\N
1374	914	124	2026-02-23 14:09:40.322272+07	\N
1376	915	124	2026-02-23 14:09:56.019656+07	\N
1378	916	124	2026-02-23 14:10:09.884416+07	\N
1383	917	124	2026-02-23 14:10:44.574359+07	\N
1385	918	124	2026-02-23 14:14:25.964832+07	\N
1387	919	124	2026-02-23 14:14:47.622011+07	\N
1390	920	125	2026-02-23 14:17:41.344856+07	\N
1392	921	125	2026-02-23 14:17:57.32535+07	\N
1396	922	125	2026-02-23 14:18:33.147468+07	\N
1398	923	125	2026-02-23 14:18:53.223646+07	\N
1401	924	125	2026-02-23 14:19:11.880556+07	\N
1405	925	125	2026-02-23 14:19:50.003849+07	\N
1407	926	125	2026-02-23 14:20:07.033722+07	\N
1409	927	125	2026-02-23 14:20:42.718243+07	\N
1411	928	125	2026-02-23 14:21:03.928504+07	\N
1413	929	125	2026-02-23 14:21:19.707433+07	\N
1416	930	125	2026-02-23 14:21:34.699812+07	\N
1418	931	125	2026-02-23 14:21:53.18567+07	\N
1420	932	125	2026-02-23 14:22:12.078755+07	\N
1422	933	125	2026-02-23 14:22:37.070389+07	\N
1424	934	125	2026-02-23 14:22:52.747614+07	\N
1426	935	125	2026-02-23 14:23:11.285895+07	\N
1428	936	125	2026-02-23 14:25:35.358796+07	\N
1430	937	125	2026-02-23 14:26:05.622745+07	\N
1435	938	125	2026-02-23 14:26:26.407415+07	\N
1437	939	125	2026-02-23 14:26:46.625738+07	\N
1439	940	125	2026-02-23 14:27:03.212459+07	\N
1441	941	125	2026-02-23 14:27:16.221902+07	\N
1443	942	125	2026-02-23 14:27:33.803121+07	\N
1445	943	125	2026-02-23 14:27:47.304596+07	\N
1447	944	125	2026-02-23 14:27:59.243425+07	\N
1449	945	125	2026-02-23 14:28:13.866861+07	\N
1451	946	125	2026-02-23 14:28:33.647497+07	\N
1453	947	125	2026-02-23 15:13:30.623713+07	\N
1455	949	125	2026-02-23 15:14:30.605125+07	\N
1458	950	125	2026-02-23 15:17:50.562174+07	\N
1461	951	125	2026-02-23 15:22:47.713784+07	\N
1464	952	125	2026-02-23 15:26:26.145973+07	\N
1467	953	125	2026-02-23 15:33:00.724989+07	\N
1469	954	125	2026-02-23 15:33:58.044931+07	\N
1470	954	115	2026-02-23 15:33:58.172919+07	\N
1473	955	125	2026-02-23 15:34:40.593626+07	\N
1474	955	115	2026-02-23 15:34:40.668585+07	\N
1477	956	125	2026-02-23 15:41:48.891421+07	\N
1478	956	115	2026-02-23 15:41:48.940084+07	\N
1482	957	125	2026-02-23 15:52:20.849478+07	\N
1483	957	115	2026-02-23 15:52:20.944622+07	\N
1489	958	125	2026-02-23 16:02:33.334183+07	\N
1490	958	115	2026-02-23 16:02:33.436337+07	\N
1493	959	125	2026-02-23 16:03:16.401373+07	\N
1494	959	115	2026-02-23 16:03:16.457719+07	\N
1497	960	125	2026-02-23 16:06:29.274217+07	\N
1498	960	115	2026-02-23 16:06:29.365415+07	\N
1501	961	125	2026-02-23 16:09:35.115662+07	\N
1502	961	115	2026-02-23 16:09:35.401096+07	\N
1505	962	125	2026-02-23 16:11:18.902851+07	\N
1506	962	115	2026-02-23 16:11:18.956707+07	\N
1509	963	125	2026-02-23 16:13:18.207498+07	\N
1510	963	115	2026-02-23 16:13:18.367184+07	\N
1513	964	125	2026-02-23 16:13:59.95746+07	\N
1515	964	115	2026-02-23 16:14:00.233597+07	\N
1517	965	125	2026-02-23 16:16:31.567957+07	\N
1518	965	115	2026-02-23 16:16:31.704134+07	\N
1521	966	125	2026-02-23 16:18:11.535464+07	\N
1522	966	115	2026-02-23 16:18:11.596871+07	\N
1525	967	125	2026-02-23 16:20:23.465493+07	\N
1526	967	115	2026-02-23 16:20:23.681062+07	\N
1530	969	131	2026-02-23 16:28:35.265046+07	\N
1532	970	131	2026-02-23 16:28:45.780775+07	\N
1535	971	131	2026-02-23 16:30:31.233457+07	\N
1536	971	118	2026-02-23 16:30:31.316857+07	\N
1541	972	131	2026-02-23 16:59:44.439677+07	\N
1542	972	118	2026-02-23 16:59:44.469743+07	\N
1547	973	65	2026-02-23 17:06:47.249281+07	\N
1548	973	118	2026-02-23 17:06:47.287103+07	\N
1551	974	120	2026-02-23 17:11:15.591525+07	\N
1555	975	66	2026-02-23 17:20:24.929553+07	\N
1556	975	126	2026-02-23 17:20:25.092079+07	\N
1559	976	66	2026-02-23 17:20:52.150608+07	\N
1560	976	126	2026-02-23 17:20:52.209142+07	\N
1563	977	66	2026-02-23 17:21:26.81835+07	\N
1564	977	126	2026-02-23 17:21:26.866382+07	\N
1567	978	66	2026-02-23 17:21:51.843766+07	\N
1569	978	126	2026-02-23 17:21:52.134913+07	\N
1571	979	66	2026-02-23 17:29:56.627157+07	\N
1573	980	66	2026-02-23 17:30:04.677625+07	\N
1575	981	125	2026-02-23 17:30:25.933264+07	\N
1577	982	66	2026-02-23 17:34:50.470635+07	\N
1579	983	66	2026-02-23 17:41:11.15472+07	\N
1581	984	66	2026-02-23 17:41:25.997354+07	\N
1583	985	66	2026-02-23 17:41:32.910927+07	\N
1585	986	66	2026-02-23 17:51:42.315562+07	\N
1587	987	66	2026-02-23 17:56:36.826772+07	\N
1592	988	67	2026-02-25 14:52:41.984151+07	\N
1595	989	67	2026-02-25 15:17:31.913621+07	\N
1596	989	127	2026-02-25 15:17:32.154494+07	\N
1599	990	67	2026-02-25 15:18:35.301217+07	\N
1603	991	67	2026-02-25 15:26:11.080129+07	\N
1615	992	199	2026-02-25 16:09:13.782232+07	\N
1616	992	198	2026-02-25 16:09:14.087932+07	\N
1617	992	200	2026-02-25 16:09:14.156079+07	\N
1620	992	201	2026-02-25 16:09:14.281327+07	\N
1623	993	200	2026-02-25 16:09:57.558879+07	\N
1624	993	201	2026-02-25 16:09:58.035451+07	\N
1626	993	198	2026-02-25 16:09:58.06626+07	\N
1628	993	199	2026-02-25 16:09:58.143722+07	\N
1631	994	69	2026-03-02 14:27:29.152794+07	\N
1633	995	69	2026-03-02 14:28:13.784721+07	\N
1635	998	69	2026-03-02 14:40:47.5273+07	\N
1637	1000	69	2026-03-02 15:18:48.145176+07	\N
1639	1006	69	2026-03-02 15:26:10.364201+07	\N
1641	1008	69	2026-03-02 15:31:28.486658+07	\N
1644	1011	69	2026-03-02 15:37:18.375767+07	2026-03-02 15:37:31.82986+07
1647	1012	69	2026-03-02 15:37:47.296057+07	\N
1651	1014	69	2026-03-02 15:38:32.576619+07	\N
1653	1015	69	2026-03-02 15:38:57.219195+07	\N
1655	1016	69	2026-03-02 15:39:28.844525+07	\N
1663	1017	69	2026-03-02 15:42:56.060101+07	\N
1666	1020	69	2026-03-02 15:46:51.800393+07	\N
1669	1028	69	2026-03-02 16:18:22.546808+07	\N
1670	1028	128	2026-03-02 16:18:22.634724+07	\N
1673	1029	69	2026-03-02 16:19:53.241631+07	\N
1674	1029	128	2026-03-02 16:19:53.426095+07	2026-03-02 16:22:03.354259+07
1677	1032	69	2026-03-02 16:30:40.010889+07	\N
1678	1032	128	2026-03-02 16:30:40.329297+07	\N
1679	1034	69	2026-03-02 16:34:13.880306+07	\N
1682	1035	245	2026-03-02 16:35:51.673174+07	\N
1684	1035	231	2026-03-02 16:35:51.997989+07	\N
1688	1036	246	2026-03-02 16:37:57.315494+07	\N
1692	1038	69	2026-03-02 16:38:40.997321+07	\N
1680	1034	128	2026-03-02 16:34:14.035999+07	2026-03-02 16:38:59.075876+07
1697	1039	126	2026-03-02 16:39:15.171212+07	\N
1695	1039	69	2026-03-02 16:39:15.131628+07	2026-03-02 16:39:28.319276+07
1699	1040	69	2026-03-02 16:40:27.510532+07	\N
1701	1040	126	2026-03-02 16:40:27.744832+07	2026-03-02 16:41:29.648365+07
1689	1036	231	2026-03-02 16:37:57.517891+07	2026-03-02 16:42:04.330688+07
1707	1042	69	2026-03-02 16:47:54.838541+07	\N
1709	1043	69	2026-03-02 16:48:15.769429+07	\N
1710	1043	126	2026-03-02 16:48:15.774964+07	2026-03-02 16:50:27.874223+07
1703	1041	246	2026-03-02 16:47:36.525824+07	2026-03-02 16:57:01.295009+07
1714	1049	69	2026-03-02 17:09:42.072669+07	2026-03-02 17:09:53.099096+07
1704	1041	231	2026-03-02 16:47:36.706804+07	2026-03-02 17:08:36.175811+07
1715	1049	127	2026-03-02 17:09:42.239614+07	2026-03-02 17:09:56.298634+07
1649	1013	69	2026-03-02 15:38:03.464856+07	2026-03-02 17:11:22.487722+07
1719	1052	69	2026-03-02 17:34:08.901551+07	\N
1722	1050	231	2026-03-02 17:50:11.843993+07	2026-03-02 17:57:11.606124+07
1723	1053	69	2026-03-04 13:09:40.055148+07	\N
1725	1057	69	2026-03-04 13:16:09.399571+07	\N
1727	1059	69	2026-03-04 13:24:19.27666+07	\N
1728	1060	69	2026-03-04 13:24:35.13526+07	\N
1730	1062	69	2026-03-04 13:38:44.392294+07	\N
1732	1063	69	2026-03-04 13:39:14.227434+07	\N
1734	1064	247	2026-03-04 13:50:12.549455+07	2026-03-04 14:01:03.196498+07
1733	1064	248	2026-03-04 13:50:12.490228+07	2026-03-04 14:01:18.083822+07
1737	1065	250	2026-03-04 14:04:40.737079+07	\N
1738	1065	249	2026-03-04 14:04:40.818815+07	\N
1741	1067	249	2026-03-04 14:07:32.750417+07	\N
1744	1069	249	2026-03-04 14:08:24.467513+07	\N
1749	1071	249	2026-03-04 14:09:29.691998+07	\N
1747	1071	250	2026-03-04 14:09:29.576983+07	2026-03-04 14:09:36.314842+07
1753	1072	249	2026-03-04 14:09:58.263204+07	\N
1756	1073	69	2026-03-04 14:11:14.799118+07	\N
1758	1074	69	2026-03-04 14:12:09.388181+07	\N
1752	1072	248	2026-03-04 14:09:58.159966+07	2026-03-04 14:15:21.478944+07
1762	1075	249	2026-03-04 14:16:56.580903+07	\N
1761	1075	248	2026-03-04 14:16:56.542142+07	2026-03-04 14:21:22.06613+07
1765	1076	248	2026-03-04 14:27:48.062393+07	\N
1766	1076	249	2026-03-04 14:27:48.098637+07	\N
1769	1077	69	2026-03-04 14:31:41.777952+07	2026-03-04 14:32:16.39136+07
1771	1078	248	2026-03-04 14:33:06.313316+07	\N
1773	1078	249	2026-03-04 14:33:08.895282+07	\N
1774	1078	251	2026-03-04 14:33:08.904191+07	\N
1777	1079	69	2026-03-04 14:34:07.291821+07	\N
1778	1079	127	2026-03-04 14:34:07.425475+07	\N
1781	1080	69	2026-03-04 14:39:28.64555+07	\N
1782	1080	127	2026-03-04 14:39:28.727115+07	\N
1787	1081	69	2026-03-04 14:40:14.754138+07	\N
1788	1081	127	2026-03-04 14:40:14.906715+07	2026-03-04 14:40:24.558168+07
1790	1082	127	2026-03-04 14:40:30.707542+07	2026-03-04 14:40:44.747821+07
1789	1082	69	2026-03-04 14:40:30.540291+07	2026-03-04 14:40:45.291181+07
1791	1083	69	2026-03-04 14:40:58.672462+07	\N
1792	1083	127	2026-03-04 14:40:58.709528+07	2026-03-04 14:41:00.77645+07
1794	1084	248	2026-03-04 14:41:14.510018+07	\N
1795	1084	251	2026-03-04 14:41:14.590587+07	\N
1798	1084	249	2026-03-04 14:41:14.796143+07	\N
1801	1085	127	2026-03-04 14:41:43.993653+07	\N
1800	1085	69	2026-03-04 14:41:43.833162+07	2026-03-04 14:41:47.331969+07
1802	1086	69	2026-03-04 14:42:14.652858+07	\N
1803	1086	127	2026-03-04 14:42:14.726637+07	\N
1812	1087	251	2026-03-04 14:44:59.564737+07	\N
1818	1088	127	2026-03-04 14:45:05.548423+07	2026-03-04 14:45:31.052171+07
1817	1088	69	2026-03-04 14:45:05.373356+07	2026-03-04 14:46:03.336516+07
2081	1125	69	2026-03-04 17:16:53.584451+07	\N
1813	1087	249	2026-03-04 14:44:59.581382+07	2026-03-04 14:53:19.284574+07
1827	1089	69	2026-03-04 14:53:38.297751+07	\N
1828	1089	127	2026-03-04 14:53:38.452554+07	2026-03-04 14:53:41.594878+07
1830	1090	69	2026-03-04 14:54:13.576916+07	\N
1831	1090	127	2026-03-04 14:54:13.80839+07	\N
1811	1087	248	2026-03-04 14:44:59.489566+07	2026-03-04 14:54:28.593978+07
1833	1091	248	2026-03-04 14:55:23.111743+07	\N
1834	1091	249	2026-03-04 14:55:23.218014+07	\N
1837	1091	252	2026-03-04 14:55:23.70692+07	\N
1842	1093	127	2026-03-04 14:59:30.665362+07	\N
1841	1093	69	2026-03-04 14:59:30.483912+07	2026-03-04 14:59:38.132069+07
1844	1094	69	2026-03-04 14:59:54.789396+07	\N
1847	1095	69	2026-03-04 15:03:36.456832+07	\N
1845	1094	127	2026-03-04 14:59:55.050609+07	2026-03-04 15:06:11.918962+07
1858	1097	69	2026-03-04 15:06:20.235873+07	\N
1859	1097	127	2026-03-04 15:06:20.246723+07	\N
1860	1098	69	2026-03-04 15:06:32.431001+07	\N
1861	1098	127	2026-03-04 15:06:32.542012+07	\N
1849	1096	248	2026-03-04 15:03:45.529075+07	2026-03-04 15:10:31.72708+07
1867	1099	69	2026-03-04 15:18:14.321296+07	\N
1868	1099	127	2026-03-04 15:18:14.471029+07	\N
1873	1100	69	2026-03-04 15:18:40.936846+07	\N
1874	1100	127	2026-03-04 15:18:41.031625+07	2026-03-04 15:20:37.673436+07
1882	1101	69	2026-03-04 15:21:28.28487+07	\N
1883	1101	127	2026-03-04 15:21:28.362502+07	\N
1884	1102	69	2026-03-04 15:21:44.593453+07	\N
1885	1102	127	2026-03-04 15:21:44.805598+07	2026-03-04 15:33:58.110613+07
1848	1096	252	2026-03-04 15:03:45.4997+07	2026-03-04 15:34:24.188315+07
1851	1096	249	2026-03-04 15:03:45.672553+07	2026-03-04 15:38:45.600657+07
1900	1103	69	2026-03-04 15:44:59.263191+07	\N
1901	1103	127	2026-03-04 15:44:59.384885+07	2026-03-04 15:47:20.185786+07
1913	1104	69	2026-03-04 15:47:44.079582+07	\N
1914	1104	127	2026-03-04 15:47:44.304143+07	\N
1915	1105	69	2026-03-04 15:47:56.619667+07	\N
1916	1105	127	2026-03-04 15:47:56.628559+07	\N
1925	1106	69	2026-03-04 15:49:51.245707+07	\N
1927	1106	127	2026-03-04 15:49:51.429791+07	\N
1933	1108	69	2026-03-04 15:59:25.128719+07	\N
1934	1108	127	2026-03-04 15:59:25.132769+07	\N
1944	1109	127	2026-03-04 16:10:02.246157+07	\N
1943	1109	69	2026-03-04 16:10:02.183695+07	2026-03-04 16:21:17.612406+07
1956	1110	69	2026-03-04 16:21:57.237783+07	\N
1957	1110	127	2026-03-04 16:21:57.332799+07	\N
1966	1111	69	2026-03-04 16:25:11.574232+07	\N
1967	1111	127	2026-03-04 16:25:11.722125+07	\N
1976	1112	69	2026-03-04 16:31:29.857265+07	\N
1977	1112	127	2026-03-04 16:31:30.280128+07	2026-03-04 16:31:32.4537+07
1980	1113	69	2026-03-04 16:31:47.631589+07	2026-03-04 16:31:53.415062+07
1979	1113	127	2026-03-04 16:31:47.625402+07	2026-03-04 16:31:53.65433+07
1983	1114	69	2026-03-04 16:32:05.168547+07	\N
1984	1114	127	2026-03-04 16:32:05.319559+07	\N
1993	1115	69	2026-03-04 16:45:08.44842+07	\N
1994	1115	127	2026-03-04 16:45:08.483906+07	2026-03-04 16:45:16.510889+07
1996	1116	127	2026-03-04 16:45:57.613604+07	\N
1997	1116	69	2026-03-04 16:45:57.643619+07	\N
2008	1117	69	2026-03-04 16:54:42.263372+07	\N
2009	1117	127	2026-03-04 16:54:42.272552+07	\N
2018	1118	69	2026-03-04 16:56:56.093142+07	\N
2019	1118	127	2026-03-04 16:56:56.309505+07	\N
2030	1119	69	2026-03-04 16:59:01.212294+07	\N
2031	1119	127	2026-03-04 16:59:01.266317+07	\N
2042	1120	69	2026-03-04 17:02:36.471527+07	\N
2043	1120	127	2026-03-04 17:02:36.784147+07	\N
2052	1121	69	2026-03-04 17:03:41.486684+07	\N
2053	1121	127	2026-03-04 17:03:41.612551+07	\N
2062	1122	69	2026-03-04 17:04:40.24497+07	\N
2066	1123	248	2026-03-04 17:13:36.100073+07	\N
2068	1123	252	2026-03-04 17:13:36.193253+07	\N
2069	1123	253	2026-03-04 17:13:36.203075+07	\N
2063	1122	127	2026-03-04 17:04:40.285631+07	2026-03-04 17:15:25.008521+07
2074	1124	248	2026-03-04 17:15:35.476016+07	\N
2075	1124	252	2026-03-04 17:15:35.580853+07	\N
2076	1124	253	2026-03-04 17:15:35.595236+07	\N
2083	1125	130	2026-03-04 17:16:53.822635+07	2026-03-04 17:17:41.820383+07
2082	1125	127	2026-03-04 17:16:53.702788+07	2026-03-04 17:18:56.701428+07
2097	1126	253	2026-03-04 17:17:29.947036+07	2026-03-04 17:21:42.522686+07
2171	1137	126	2026-03-04 17:42:22.482308+07	\N
2103	1127	69	2026-03-04 17:26:57.02053+07	\N
2102	1127	127	2026-03-04 17:26:56.884038+07	2026-03-04 17:33:04.326162+07
2094	1126	252	2026-03-04 17:17:29.781046+07	2026-03-04 17:33:33.750325+07
2112	1128	127	2026-03-04 17:33:56.810507+07	\N
2131	1130	70	2026-03-04 17:35:44.163878+07	2026-03-04 17:36:07.035789+07
2111	1128	69	2026-03-04 17:33:56.726234+07	2026-03-04 17:34:52.999245+07
2168	1135	126	2026-03-04 17:40:53.448753+07	\N
2132	1130	127	2026-03-04 17:35:44.335394+07	2026-03-04 17:36:20.010224+07
2161	1135	70	2026-03-04 17:39:18.244733+07	\N
2123	1129	127	2026-03-04 17:35:04.501222+07	2026-03-04 17:35:31.333625+07
2141	1131	70	2026-03-04 17:36:54.314803+07	\N
2142	1131	127	2026-03-04 17:36:54.492161+07	\N
2151	1132	127	2026-03-04 17:38:05.107154+07	\N
2152	1132	70	2026-03-04 17:38:05.159269+07	\N
2153	1133	70	2026-03-04 17:38:29.882378+07	\N
2154	1133	127	2026-03-04 17:38:30.018158+07	\N
2156	1134	127	2026-03-04 17:38:44.766683+07	2026-03-04 17:39:04.95183+07
2155	1134	70	2026-03-04 17:38:44.654049+07	2026-03-04 17:39:05.437207+07
2122	1129	70	2026-03-04 17:35:04.417615+07	2026-03-04 17:40:28.378547+07
2162	1135	127	2026-03-04 17:39:18.875155+07	2026-03-04 17:39:22.243674+07
2093	1126	248	2026-03-04 17:17:29.759972+07	2026-03-04 17:41:19.460059+07
2169	1136	70	2026-03-04 17:41:49.306604+07	\N
2170	1136	126	2026-03-04 17:41:49.506679+07	\N
2172	1137	70	2026-03-04 17:42:22.541307+07	\N
2175	1138	70	2026-03-04 17:43:08.469534+07	\N
2176	1138	126	2026-03-04 17:43:08.603992+07	2026-03-04 17:43:26.204185+07
2182	1139	70	2026-03-04 17:43:53.979779+07	\N
2183	1139	126	2026-03-04 17:43:54.004696+07	\N
2192	1140	70	2026-03-04 17:44:40.433973+07	\N
2193	1140	126	2026-03-04 17:44:40.622304+07	\N
2199	1141	70	2026-03-04 17:51:55.680762+07	2026-03-04 17:52:14.071471+07
2200	1141	126	2026-03-04 17:51:55.73283+07	2026-03-04 17:52:13.562024+07
2207	1142	70	2026-03-04 17:52:23.58522+07	\N
2208	1142	126	2026-03-04 17:52:23.795723+07	\N
2209	1143	70	2026-03-04 17:52:47.177945+07	\N
2210	1143	126	2026-03-04 17:52:47.251315+07	\N
2214	1146	126	2026-03-04 18:01:34.75284+07	\N
2221	1147	70	2026-03-04 18:05:26.341114+07	\N
2222	1147	126	2026-03-04 18:05:26.462147+07	\N
2233	1148	70	2026-03-04 18:08:46.554638+07	2026-03-04 18:08:57.60461+07
2234	1148	126	2026-03-04 18:08:46.56699+07	2026-03-04 18:08:58.243779+07
2237	1149	70	2026-03-04 18:09:11.259254+07	\N
2238	1149	126	2026-03-04 18:09:11.37634+07	\N
2241	1150	70	2026-03-04 18:12:27.79654+07	\N
2242	1150	126	2026-03-04 18:12:27.79987+07	\N
2689	1207	70	2026-03-05 16:14:07.941008+07	\N
2248	1151	126	2026-03-04 18:21:58.351792+07	2026-03-04 18:22:03.790367+07
2249	1151	70	2026-03-04 18:21:58.363716+07	2026-03-04 18:22:04.362993+07
2252	1152	126	2026-03-04 18:22:10.350665+07	2026-03-04 18:22:18.716671+07
2213	1146	70	2026-03-04 18:01:34.606433+07	2026-03-04 18:22:22.323178+07
2253	1152	70	2026-03-04 18:22:10.430186+07	2026-03-04 18:22:31.075271+07
2259	1153	70	2026-03-04 18:22:54.720982+07	\N
2260	1153	126	2026-03-04 18:22:54.964276+07	\N
2266	1154	126	2026-03-04 18:23:43.388815+07	\N
2267	1154	70	2026-03-04 18:23:43.39595+07	\N
2268	1155	70	2026-03-05 13:10:39.608463+07	\N
2269	1155	126	2026-03-05 13:10:39.822728+07	\N
2276	1156	70	2026-03-05 13:33:38.482243+07	\N
2277	1156	126	2026-03-05 13:33:38.653747+07	\N
2283	1157	126	2026-03-05 13:35:37.175249+07	2026-03-05 13:35:52.441883+07
2282	1157	70	2026-03-05 13:35:37.050631+07	2026-03-05 13:36:17.105665+07
2288	1158	70	2026-03-05 13:36:35.105651+07	\N
2289	1158	126	2026-03-05 13:36:35.124536+07	\N
2298	1159	70	2026-03-05 13:40:14.750388+07	\N
2299	1159	126	2026-03-05 13:40:14.913737+07	\N
2306	1160	70	2026-03-05 13:43:25.642983+07	\N
2307	1160	126	2026-03-05 13:43:25.764474+07	\N
2308	1161	70	2026-03-05 13:43:42.278692+07	\N
2309	1161	126	2026-03-05 13:43:42.403372+07	\N
2319	1162	126	2026-03-05 13:48:04.782445+07	\N
2324	1163	70	2026-03-05 13:50:31.512885+07	\N
2325	1163	126	2026-03-05 13:50:31.64527+07	\N
2330	1164	70	2026-03-05 13:52:25.058112+07	\N
2331	1164	126	2026-03-05 13:52:25.303546+07	\N
2318	1162	70	2026-03-05 13:48:04.643897+07	2026-03-05 13:55:39.294225+07
2337	1165	126	2026-03-05 13:56:18.299221+07	\N
2338	1165	70	2026-03-05 13:56:18.391495+07	\N
2343	1166	126	2026-03-05 14:00:44.208472+07	\N
2344	1166	70	2026-03-05 14:00:44.325309+07	\N
2351	1167	126	2026-03-05 14:01:53.228727+07	\N
2352	1167	70	2026-03-05 14:01:53.252041+07	\N
2359	1168	126	2026-03-05 14:06:18.124292+07	\N
2360	1168	70	2026-03-05 14:06:18.36515+07	\N
2367	1169	126	2026-03-05 14:07:00.333472+07	\N
2368	1169	70	2026-03-05 14:07:00.339076+07	\N
2378	1170	70	2026-03-05 14:09:30.551756+07	\N
2379	1170	126	2026-03-05 14:09:30.690737+07	\N
2386	1171	70	2026-03-05 14:10:50.642578+07	\N
2387	1171	126	2026-03-05 14:10:50.663735+07	\N
2392	1172	70	2026-03-05 14:11:31.822116+07	\N
2393	1172	126	2026-03-05 14:11:31.852649+07	\N
2400	1173	70	2026-03-05 14:22:16.669227+07	\N
2401	1173	126	2026-03-05 14:22:16.772965+07	\N
2410	1174	70	2026-03-05 14:32:19.341968+07	\N
2411	1174	126	2026-03-05 14:32:19.356546+07	2026-03-05 14:44:24.115802+07
2425	1175	70	2026-03-05 15:00:52.868302+07	\N
2426	1175	126	2026-03-05 15:00:53.0458+07	\N
2431	1176	70	2026-03-05 15:01:35.590977+07	\N
2433	1176	126	2026-03-05 15:01:35.627502+07	\N
2437	1177	70	2026-03-05 15:02:13.716859+07	\N
2438	1177	126	2026-03-05 15:02:13.72644+07	\N
2445	1178	70	2026-03-05 15:02:57.605303+07	\N
2446	1178	126	2026-03-05 15:02:57.731851+07	\N
2453	1179	70	2026-03-05 15:03:52.168956+07	\N
2454	1179	126	2026-03-05 15:03:52.286946+07	2026-03-05 15:16:05.295843+07
2463	1180	70	2026-03-05 15:20:57.406622+07	\N
2464	1180	126	2026-03-05 15:20:57.553369+07	\N
2469	1181	70	2026-03-05 15:21:46.240627+07	\N
2470	1181	126	2026-03-05 15:21:46.366622+07	\N
2481	1182	70	2026-03-05 15:25:14.294679+07	\N
2482	1182	126	2026-03-05 15:25:14.518967+07	\N
2489	1183	70	2026-03-05 15:25:51.223713+07	\N
2490	1183	126	2026-03-05 15:25:51.23756+07	\N
2497	1184	70	2026-03-05 15:26:12.912796+07	\N
2498	1184	126	2026-03-05 15:26:13.016608+07	\N
2505	1185	70	2026-03-05 15:27:05.857679+07	\N
2506	1186	70	2026-03-05 15:27:05.904407+07	\N
2507	1186	126	2026-03-05 15:27:05.953665+07	\N
2508	1185	126	2026-03-05 15:27:06.18608+07	\N
2519	1187	70	2026-03-05 15:41:58.343715+07	\N
2520	1187	126	2026-03-05 15:41:58.500966+07	\N
2525	1188	70	2026-03-05 15:42:22.532078+07	\N
2526	1188	126	2026-03-05 15:42:22.672551+07	\N
2539	1189	70	2026-03-05 15:46:34.735078+07	\N
2540	1189	126	2026-03-05 15:46:34.793544+07	\N
2547	1190	70	2026-03-05 15:47:14.372987+07	\N
2548	1190	126	2026-03-05 15:47:14.398356+07	\N
2555	1191	70	2026-03-05 15:47:55.088811+07	\N
2556	1191	126	2026-03-05 15:47:55.318597+07	\N
2567	1192	70	2026-03-05 15:55:01.68611+07	\N
2568	1192	126	2026-03-05 15:55:01.790464+07	\N
2575	1193	70	2026-03-05 15:56:56.728768+07	\N
2576	1193	126	2026-03-05 15:56:56.795007+07	\N
2587	1194	70	2026-03-05 16:01:42.662127+07	\N
2588	1194	126	2026-03-05 16:01:42.824838+07	\N
2595	1195	70	2026-03-05 16:02:21.678761+07	\N
2597	1195	126	2026-03-05 16:02:21.721066+07	\N
2602	1196	126	2026-03-05 16:02:40.256262+07	\N
2609	1197	70	2026-03-05 16:03:06.343111+07	\N
2611	1197	126	2026-03-05 16:03:06.372994+07	\N
2616	1198	126	2026-03-05 16:03:27.230493+07	\N
2615	1198	70	2026-03-05 16:03:27.193692+07	2026-03-05 16:10:15.688367+07
2601	1196	70	2026-03-05 16:02:40.148047+07	2026-03-05 16:10:25.80484+07
2631	1199	70	2026-03-05 16:10:56.858879+07	\N
2632	1199	126	2026-03-05 16:10:56.918512+07	\N
2639	1200	70	2026-03-05 16:11:19.258118+07	\N
2640	1200	126	2026-03-05 16:11:19.270364+07	\N
2645	1201	70	2026-03-05 16:11:50.352486+07	\N
2646	1201	126	2026-03-05 16:11:50.529579+07	\N
2653	1202	70	2026-03-05 16:12:10.194683+07	\N
2655	1202	126	2026-03-05 16:12:10.254388+07	\N
2659	1203	70	2026-03-05 16:12:34.909991+07	\N
2661	1203	126	2026-03-05 16:12:35.12167+07	\N
2665	1204	70	2026-03-05 16:12:53.788737+07	\N
2666	1204	126	2026-03-05 16:12:53.975969+07	\N
2673	1205	70	2026-03-05 16:13:18.598525+07	\N
2674	1205	126	2026-03-05 16:13:18.612642+07	\N
2681	1206	70	2026-03-05 16:13:46.13871+07	\N
2682	1206	126	2026-03-05 16:13:46.285555+07	\N
2690	1207	126	2026-03-05 16:14:07.974284+07	\N
2697	1208	70	2026-03-05 16:14:21.954692+07	\N
2698	1208	126	2026-03-05 16:14:21.966449+07	\N
2703	1209	70	2026-03-05 16:14:38.369735+07	\N
2704	1209	126	2026-03-05 16:14:38.37977+07	2026-03-05 16:24:35.23116+07
2709	1210	170	2026-03-05 16:50:17.562604+07	\N
2710	1210	9	2026-03-05 16:50:17.674831+07	\N
2714	1211	170	2026-03-05 16:51:40.34206+07	\N
2716	1211	9	2026-03-05 16:51:40.36385+07	\N
2720	1212	170	2026-03-05 16:52:15.204775+07	\N
2721	1212	9	2026-03-05 16:52:15.320981+07	2026-03-05 17:00:15.930808+07
2729	1215	190	2026-03-05 17:01:53.438292+07	2026-03-05 17:07:33.587965+07
2730	1215	172	2026-03-05 17:01:53.44223+07	2026-03-05 17:07:45.740874+07
2726	1215	9	2026-03-05 17:01:53.301454+07	2026-03-05 17:09:30.279982+07
2725	1215	170	2026-03-05 17:01:53.263729+07	2026-03-05 17:11:01.27538+07
2735	1216	70	2026-03-08 13:15:50.430069+07	\N
2736	1216	126	2026-03-08 13:15:50.65898+07	\N
2743	1217	70	2026-03-08 13:18:30.031459+07	\N
2744	1217	126	2026-03-08 13:18:30.292135+07	\N
2751	1218	70	2026-03-08 13:19:24.509411+07	\N
2752	1218	126	2026-03-08 13:19:24.592504+07	\N
2759	1219	70	2026-03-08 13:21:22.972014+07	\N
2760	1219	126	2026-03-08 13:21:23.202831+07	\N
2767	1220	70	2026-03-08 13:24:06.801292+07	\N
2768	1220	126	2026-03-08 13:24:06.817266+07	\N
2775	1221	70	2026-03-08 13:42:11.485865+07	\N
2776	1221	126	2026-03-08 13:42:11.691972+07	\N
2785	1222	70	2026-03-08 13:44:13.980885+07	\N
2786	1222	126	2026-03-08 13:44:14.05137+07	\N
2792	1223	70	2026-03-08 13:45:02.241849+07	\N
2793	1223	126	2026-03-08 13:45:02.431592+07	\N
2800	1224	70	2026-03-08 13:46:46.187641+07	\N
2801	1224	126	2026-03-08 13:46:46.313733+07	\N
2806	1225	70	2026-03-08 13:48:26.639103+07	\N
2807	1225	126	2026-03-08 13:48:26.652006+07	\N
2813	1226	70	2026-03-08 13:50:47.252889+07	\N
2815	1226	126	2026-03-08 13:50:47.518511+07	\N
2819	1227	70	2026-03-08 13:51:24.290446+07	\N
2821	1227	126	2026-03-08 13:51:24.339424+07	\N
2825	1228	70	2026-03-08 13:51:54.857504+07	\N
2827	1228	126	2026-03-08 13:51:54.960329+07	\N
2831	1229	70	2026-03-08 13:55:44.011576+07	\N
2832	1229	126	2026-03-08 13:55:44.017541+07	\N
2837	1230	70	2026-03-08 13:56:05.354343+07	\N
2839	1230	126	2026-03-08 13:56:05.400993+07	\N
2845	1231	70	2026-03-08 14:03:50.867298+07	\N
2846	1231	126	2026-03-08 14:03:51.016038+07	\N
2851	1232	70	2026-03-08 14:04:07.774091+07	\N
2853	1232	126	2026-03-08 14:04:07.964345+07	\N
2857	1233	70	2026-03-08 14:04:22.715743+07	\N
2858	1233	126	2026-03-08 14:04:22.733707+07	\N
2863	1234	70	2026-03-08 14:04:41.89903+07	\N
2865	1234	126	2026-03-08 14:04:41.958745+07	\N
2869	1235	70	2026-03-08 14:05:12.737666+07	\N
2870	1235	126	2026-03-08 14:05:13.023101+07	\N
2877	1236	70	2026-03-08 14:05:53.393023+07	\N
2878	1236	126	2026-03-08 14:05:53.647531+07	\N
2885	1237	70	2026-03-08 14:06:46.856703+07	\N
2886	1237	126	2026-03-08 14:06:47.339033+07	\N
2893	1238	70	2026-03-08 14:07:13.181573+07	\N
2894	1238	126	2026-03-08 14:07:13.315876+07	\N
2901	1239	70	2026-03-08 14:07:47.591762+07	\N
2902	1239	126	2026-03-08 14:07:47.84871+07	\N
2909	1240	70	2026-03-08 14:25:31.060225+07	\N
2910	1240	126	2026-03-08 14:25:31.107266+07	\N
2915	1241	70	2026-03-08 14:25:46.339873+07	\N
2917	1241	126	2026-03-08 14:25:46.431012+07	\N
2921	1242	70	2026-03-08 14:26:02.641951+07	\N
2923	1242	126	2026-03-08 14:26:02.929779+07	\N
2929	1243	70	2026-03-08 14:26:48.97505+07	\N
2930	1243	126	2026-03-08 14:26:49.025225+07	\N
2935	1244	70	2026-03-08 14:27:42.909344+07	\N
2937	1244	126	2026-03-08 14:27:42.974813+07	\N
2941	1245	70	2026-03-08 14:28:18.639955+07	\N
2943	1245	126	2026-03-08 14:28:18.720759+07	\N
3244	1289	70	2026-03-08 15:25:28.826938+07	\N
3245	1289	126	2026-03-08 15:25:28.943322+07	\N
3246	1289	130	2026-03-08 15:25:28.947592+07	\N
2949	1246	126	2026-03-08 14:28:59.879917+07	2026-03-08 14:40:35.519597+07
2947	1246	70	2026-03-08 14:28:59.790504+07	2026-03-08 14:40:37.945504+07
2959	1247	70	2026-03-08 14:44:21.078358+07	\N
2960	1247	126	2026-03-08 14:44:21.241785+07	\N
2965	1248	70	2026-03-08 14:45:06.586521+07	\N
2967	1248	126	2026-03-08 14:45:07.207199+07	\N
2971	1249	70	2026-03-08 14:45:33.099789+07	\N
2973	1249	126	2026-03-08 14:45:33.405485+07	\N
2977	1250	70	2026-03-08 14:45:58.718176+07	\N
2978	1250	126	2026-03-08 14:45:58.727044+07	\N
2983	1251	70	2026-03-08 14:46:32.490395+07	\N
2984	1251	126	2026-03-08 14:46:32.664751+07	\N
2989	1253	70	2026-03-08 14:47:09.562921+07	\N
2990	1253	126	2026-03-08 14:47:09.602538+07	\N
2995	1254	70	2026-03-08 14:47:27.085349+07	\N
2996	1254	126	2026-03-08 14:47:27.094339+07	\N
3001	1255	70	2026-03-08 14:47:42.707427+07	\N
3003	1255	126	2026-03-08 14:47:43.510486+07	\N
3007	1256	70	2026-03-08 14:47:54.567237+07	\N
3009	1256	126	2026-03-08 14:47:54.616109+07	\N
3013	1257	70	2026-03-08 14:48:24.425918+07	\N
3014	1257	126	2026-03-08 14:48:24.52252+07	\N
3019	1258	70	2026-03-08 14:49:12.970412+07	\N
3021	1258	126	2026-03-08 14:49:13.571135+07	\N
3025	1260	70	2026-03-08 14:52:49.614011+07	\N
3026	1260	126	2026-03-08 14:52:49.781746+07	\N
3027	1261	70	2026-03-08 14:53:52.930487+07	\N
3028	1261	126	2026-03-08 14:53:53.541869+07	2026-03-08 14:54:14.32575+07
3036	1262	70	2026-03-08 14:55:03.992545+07	\N
3037	1262	126	2026-03-08 14:55:04.115444+07	\N
3044	1263	70	2026-03-08 14:55:44.530599+07	\N
3045	1263	126	2026-03-08 14:55:44.796259+07	\N
3052	1264	70	2026-03-08 14:56:20.888452+07	\N
3054	1264	126	2026-03-08 14:56:21.035363+07	\N
3058	1266	70	2026-03-08 14:57:08.324608+07	\N
3059	1266	126	2026-03-08 14:57:08.329333+07	\N
3066	1267	70	2026-03-08 14:57:34.009645+07	\N
3067	1267	126	2026-03-08 14:57:34.116476+07	\N
3074	1268	70	2026-03-08 14:58:15.921328+07	\N
3075	1268	126	2026-03-08 14:58:16.096155+07	\N
3082	1269	70	2026-03-08 14:58:46.705258+07	\N
3083	1269	126	2026-03-08 14:58:46.829206+07	\N
3091	1271	70	2026-03-08 15:00:10.57904+07	\N
3092	1271	130	2026-03-08 15:00:10.703589+07	\N
3093	1271	126	2026-03-08 15:00:10.820988+07	\N
3103	1272	70	2026-03-08 15:00:55.735428+07	\N
3104	1272	126	2026-03-08 15:00:55.90464+07	\N
3105	1272	130	2026-03-08 15:00:55.973511+07	\N
3115	1273	70	2026-03-08 15:01:31.45675+07	\N
3116	1273	130	2026-03-08 15:01:31.584132+07	\N
3118	1273	126	2026-03-08 15:01:31.608822+07	\N
3124	1275	70	2026-03-08 15:02:04.612313+07	\N
3125	1275	130	2026-03-08 15:02:04.670561+07	\N
3126	1275	126	2026-03-08 15:02:04.865506+07	\N
3136	1276	70	2026-03-08 15:02:39.495416+07	\N
3137	1276	130	2026-03-08 15:02:39.580496+07	\N
3138	1276	126	2026-03-08 15:02:39.616651+07	\N
3145	1277	70	2026-03-08 15:03:22.51903+07	\N
3146	1277	130	2026-03-08 15:03:22.646221+07	\N
3147	1277	126	2026-03-08 15:03:23.444117+07	\N
3154	1278	70	2026-03-08 15:04:42.953321+07	\N
3155	1278	130	2026-03-08 15:04:43.249011+07	\N
3156	1278	126	2026-03-08 15:04:43.286515+07	\N
3166	1279	70	2026-03-08 15:05:17.496233+07	\N
3168	1279	126	2026-03-08 15:05:17.639614+07	\N
3170	1279	130	2026-03-08 15:05:17.861906+07	\N
3175	1280	70	2026-03-08 15:05:50.093385+07	\N
3176	1280	126	2026-03-08 15:05:50.159924+07	\N
3179	1280	130	2026-03-08 15:05:50.460436+07	\N
3184	1281	70	2026-03-08 15:06:23.713455+07	\N
3185	1281	130	2026-03-08 15:06:23.872759+07	\N
3186	1281	126	2026-03-08 15:06:24.004337+07	\N
3196	1282	70	2026-03-08 15:07:08.079811+07	\N
3198	1282	130	2026-03-08 15:07:08.482417+07	\N
3197	1282	126	2026-03-08 15:07:08.201799+07	2026-03-08 15:16:20.416223+07
3211	1285	70	2026-03-08 15:20:03.729332+07	\N
3213	1285	130	2026-03-08 15:20:03.799207+07	\N
3215	1285	126	2026-03-08 15:20:03.897638+07	\N
3220	1287	70	2026-03-08 15:24:17.926501+07	\N
3221	1287	130	2026-03-08 15:24:18.092327+07	\N
3222	1287	126	2026-03-08 15:24:18.098212+07	\N
3232	1288	70	2026-03-08 15:24:55.599776+07	\N
3233	1288	126	2026-03-08 15:24:55.74698+07	\N
3234	1288	130	2026-03-08 15:24:55.750024+07	\N
3256	1290	70	2026-03-08 15:26:13.542538+07	\N
3257	1290	126	2026-03-08 15:26:13.681977+07	\N
3258	1290	130	2026-03-08 15:26:13.68747+07	\N
3268	1292	70	2026-03-08 15:27:03.563728+07	\N
3269	1292	130	2026-03-08 15:27:03.65179+07	\N
3270	1292	126	2026-03-08 15:27:05.192363+07	\N
3280	1293	70	2026-03-08 15:27:40.209654+07	\N
3282	1293	130	2026-03-08 15:27:40.307515+07	\N
3284	1293	126	2026-03-08 15:27:40.622604+07	2026-03-08 15:28:15.091085+07
3289	1293	128	2026-03-08 15:28:34.594437+07	\N
3290	1296	70	2026-03-08 15:28:52.326558+07	\N
3291	1296	130	2026-03-08 15:28:52.474632+07	\N
3292	1296	128	2026-03-08 15:28:52.554951+07	\N
3302	1297	70	2026-03-08 15:29:32.879413+07	\N
3303	1297	130	2026-03-08 15:29:33.026628+07	\N
3304	1297	128	2026-03-08 15:29:33.052742+07	\N
3314	1298	70	2026-03-08 15:30:01.619317+07	\N
3315	1298	130	2026-03-08 15:30:01.74213+07	\N
3316	1298	128	2026-03-08 15:30:01.762206+07	\N
3326	1299	70	2026-03-08 15:30:34.954056+07	\N
3328	1299	130	2026-03-08 15:30:35.002824+07	\N
4088	1397	265	2026-03-08 18:25:19.342097+07	\N
4092	1398	266	2026-03-08 18:26:30.172638+07	\N
4097	1399	37	2026-03-08 18:27:30.892248+07	2026-03-08 18:28:34.25346+07
4107	1400	130	2026-03-08 18:31:07.539792+07	\N
4114	1401	267	2026-03-08 18:33:06.185218+07	\N
4115	1401	37	2026-03-08 18:33:06.266467+07	\N
4129	1403	267	2026-03-08 18:39:45.982068+07	\N
4135	1404	70	2026-03-08 18:39:47.083793+07	\N
4136	1404	130	2026-03-08 18:39:47.192858+07	\N
4144	1405	267	2026-03-08 18:40:45.032584+07	\N
4153	1406	37	2026-03-08 18:41:10.305548+07	\N
4145	1405	37	2026-03-08 18:40:45.114838+07	2026-03-08 18:42:03.950877+07
4160	1407	269	2026-03-08 18:42:47.584677+07	\N
4799	1542	72	2026-03-09 20:00:37.089172+07	\N
4179	1409	270	2026-03-08 18:43:36.177446+07	2026-03-08 18:44:58.442655+07
4194	1411	271	2026-03-08 18:45:40.568548+07	\N
4168	1408	128	2026-03-08 18:43:28.649123+07	2026-03-08 18:46:03.647197+07
4195	1411	37	2026-03-08 18:45:40.651165+07	2026-03-08 18:47:47.284904+07
4201	1413	70	2026-03-08 18:48:17.450285+07	\N
4206	1415	70	2026-03-08 18:49:23.978468+07	\N
4207	1415	130	2026-03-08 18:49:24.062684+07	\N
4220	1417	70	2026-03-08 18:53:56.045725+07	\N
4228	1418	70	2026-03-08 18:58:43.781997+07	\N
4229	1418	130	2026-03-08 18:58:43.849403+07	\N
4236	1419	130	2026-03-08 18:59:06.616535+07	\N
4246	1421	70	2026-03-08 18:59:41.457555+07	\N
4253	1422	130	2026-03-08 19:00:21.186861+07	\N
4264	1423	130	2026-03-08 19:01:05.674739+07	\N
4272	1424	130	2026-03-08 19:01:38.700201+07	\N
4293	1427	70	2026-03-08 19:02:50.618318+07	\N
4301	1428	70	2026-03-08 19:03:17.502796+07	\N
4302	1428	130	2026-03-08 19:03:17.593172+07	\N
4310	1429	130	2026-03-08 19:03:41.122957+07	\N
4318	1430	130	2026-03-08 19:04:12.50052+07	\N
4326	1431	130	2026-03-08 19:04:42.195292+07	\N
4335	1432	130	2026-03-08 19:14:38.040918+07	\N
4345	1434	70	2026-03-08 19:18:35.089647+07	\N
4351	1435	70	2026-03-08 19:20:20.807418+07	\N
4357	1436	70	2026-03-08 19:20:37.877325+07	\N
4358	1436	130	2026-03-08 19:20:37.888157+07	\N
4364	1437	130	2026-03-08 19:23:24.013108+07	\N
4370	1438	130	2026-03-08 19:23:44.114684+07	\N
4378	1439	130	2026-03-08 19:28:31.122483+07	\N
4386	1440	130	2026-03-08 19:31:00.386225+07	\N
4406	1442	70	2026-03-08 19:32:17.487799+07	\N
4408	1442	128	2026-03-08 19:32:17.64545+07	\N
4420	1443	130	2026-03-08 19:34:11.572934+07	\N
4431	1444	128	2026-03-08 19:34:59.694503+07	\N
4437	1445	128	2026-03-08 19:36:13.743357+07	\N
4446	1446	130	2026-03-08 19:37:32.260631+07	\N
4457	1447	70	2026-03-08 19:38:55.499751+07	\N
4469	1448	70	2026-03-08 19:40:09.029746+07	\N
4471	1448	128	2026-03-08 19:40:09.201326+07	\N
4481	1449	70	2026-03-08 19:40:38.82513+07	\N
4493	1451	70	2026-03-08 19:52:25.403184+07	\N
4494	1451	130	2026-03-08 19:52:25.463369+07	\N
4503	1452	130	2026-03-08 19:55:14.95589+07	\N
4514	1454	71	2026-03-08 19:56:13.433236+07	\N
4520	1455	71	2026-03-08 20:00:19.271629+07	\N
4531	1465	7	2026-03-09 14:38:24.990445+07	\N
4530	1465	170	2026-03-09 14:38:24.931736+07	2026-03-09 14:39:18.143254+07
4535	1467	7	2026-03-09 14:39:59.290274+07	\N
4534	1467	170	2026-03-09 14:39:59.216344+07	2026-03-09 14:41:10.337877+07
4540	1469	170	2026-03-09 14:43:17.669285+07	\N
4544	1470	170	2026-03-09 14:43:36.887148+07	\N
4550	1474	170	2026-03-09 14:56:25.339335+07	\N
4551	1474	7	2026-03-09 14:56:25.447326+07	\N
4556	1475	7	2026-03-09 14:56:38.01974+07	2026-03-09 14:58:17.400114+07
4566	1479	272	2026-03-09 15:07:25.817015+07	2026-03-09 15:08:44.601062+07
4577	1482	170	2026-03-09 15:23:05.397817+07	\N
4579	1482	272	2026-03-09 15:23:05.478186+07	\N
4586	1484	272	2026-03-09 15:28:44.629852+07	2026-03-09 15:33:39.302118+07
4585	1484	170	2026-03-09 15:28:44.600694+07	2026-03-09 15:35:32.773297+07
4595	1487	71	2026-03-09 15:59:25.814935+07	\N
4601	1489	170	2026-03-09 16:05:52.738539+07	2026-03-09 16:10:57.510947+07
4608	1491	71	2026-03-09 16:15:55.139344+07	\N
4616	1493	71	2026-03-09 16:19:19.230972+07	\N
4622	1495	71	2026-03-09 16:20:28.07749+07	\N
4632	1497	71	2026-03-09 16:25:06.280501+07	\N
4640	1498	71	2026-03-09 16:25:58.795421+07	\N
4646	1499	71	2026-03-09 16:26:30.589828+07	\N
4647	1499	128	2026-03-09 16:26:30.772352+07	\N
4662	1502	71	2026-03-09 16:31:39.863029+07	\N
4670	1505	71	2026-03-09 16:51:32.112194+07	\N
4678	1507	7	2026-03-09 17:07:37.739597+07	2026-03-09 17:09:25.924792+07
4677	1507	170	2026-03-09 17:07:37.460506+07	2026-03-09 17:15:10.791578+07
4690	1509	71	2026-03-09 17:36:16.132114+07	\N
4696	1511	72	2026-03-09 17:39:49.363029+07	\N
4702	1513	72	2026-03-09 17:40:38.124771+07	\N
4706	1514	72	2026-03-09 17:41:03.560076+07	\N
4710	1515	72	2026-03-09 17:41:28.815021+07	\N
4714	1516	72	2026-03-09 18:17:41.165309+07	\N
4717	1517	72	2026-03-09 18:19:18.737322+07	\N
4720	1518	72	2026-03-09 18:30:13.704793+07	\N
4723	1519	72	2026-03-09 18:40:41.003235+07	\N
4726	1521	72	2026-03-09 19:04:23.877909+07	\N
4729	1522	72	2026-03-09 19:05:10.898658+07	\N
4732	1523	72	2026-03-09 19:07:53.978849+07	\N
4735	1524	72	2026-03-09 19:17:44.05248+07	\N
4738	1525	72	2026-03-09 19:19:13.352515+07	\N
4741	1526	72	2026-03-09 19:24:39.296987+07	\N
4744	1527	72	2026-03-09 19:26:07.16919+07	\N
4747	1528	72	2026-03-09 19:32:25.266153+07	\N
4754	1529	72	2026-03-09 19:38:58.20259+07	\N
4758	1530	72	2026-03-09 19:41:05.743265+07	\N
4762	1531	72	2026-03-09 19:42:24.169361+07	\N
4765	1532	72	2026-03-09 19:46:37.321956+07	\N
4768	1533	72	2026-03-09 19:48:20.255873+07	\N
4771	1534	72	2026-03-09 19:48:44.588032+07	\N
4774	1535	72	2026-03-09 19:51:15.679115+07	\N
4777	1536	72	2026-03-09 19:51:36.806472+07	\N
4780	1537	72	2026-03-09 19:51:59.512467+07	\N
4783	1538	72	2026-03-09 19:52:21.142217+07	\N
4786	1539	72	2026-03-09 19:53:45.311251+07	\N
4789	1540	72	2026-03-09 19:54:07.932733+07	\N
4792	1541	72	2026-03-09 19:58:48.232521+07	\N
4654	1500	128	2026-03-09 16:27:00.764313+07	2026-03-09 20:00:08.383048+07
4800	1542	130	2026-03-09 20:00:37.185109+07	2026-03-09 20:01:41.964297+07
4801	1542	128	2026-03-09 20:00:37.271042+07	2026-03-09 20:03:20.474661+07
4811	1159	72	2026-03-11 12:44:54.415111+07	\N
4812	1549	72	2026-03-11 12:45:58.958256+07	\N
4815	1550	72	2026-03-11 12:54:21.193755+07	\N
4865	1554	127	2026-03-11 13:42:37.851753+07	\N
4820	1551	72	2026-03-11 13:04:49.022456+07	\N
4821	1551	130	2026-03-11 13:04:49.136885+07	\N
4816	1550	127	2026-03-11 12:54:22.44908+07	2026-03-11 13:04:54.596821+07
4832	1552	72	2026-03-11 13:05:37.308405+07	\N
4833	1552	130	2026-03-11 13:05:37.3703+07	\N
4840	1552	127	2026-03-11 13:28:11.998962+07	2026-03-11 13:28:53.499609+07
4853	1553	72	2026-03-11 13:29:52.047468+07	\N
4854	1553	130	2026-03-11 13:29:52.401298+07	\N
4864	1554	72	2026-03-11 13:42:37.581419+07	2026-03-11 13:47:58.46324+07
4875	1555	127	2026-03-11 13:48:08.045084+07	2026-03-11 13:48:14.932186+07
4878	1555	130	2026-03-11 13:48:40.782477+07	\N
4879	1556	130	2026-03-11 13:48:48.392126+07	\N
4882	1554	128	2026-03-11 13:49:02.289543+07	\N
4884	1557	130	2026-03-11 13:49:47.066839+07	\N
4888	1558	130	2026-03-11 13:50:15.646302+07	\N
4892	1559	130	2026-03-11 13:50:23.535978+07	2026-03-11 13:50:39.775763+07
4897	1560	130	2026-03-11 13:50:43.454311+07	\N
4912	1562	130	2026-03-11 13:54:22.358032+07	\N
4927	1561	72	2026-03-11 14:00:01.514325+07	\N
4903	1561	130	2026-03-11 13:53:01.225579+07	2026-03-11 14:03:48.472821+07
4941	1561	128	2026-03-11 14:04:06.288448+07	2026-03-11 14:04:18.952471+07
4964	1563	72	2026-03-11 14:08:02.769461+07	\N
4949	1563	128	2026-03-11 14:04:32.302494+07	2026-03-11 14:07:44.19249+07
4975	1563	130	2026-03-11 14:15:30.60796+07	\N
4976	1564	130	2026-03-11 14:15:35.852512+07	\N
3329	1299	128	2026-03-08 15:30:35.007853+07	\N
3335	1300	70	2026-03-08 15:31:04.626437+07	\N
3336	1300	130	2026-03-08 15:31:04.760574+07	\N
3337	1300	128	2026-03-08 15:31:05.012058+07	\N
3347	1301	70	2026-03-08 15:31:33.878938+07	\N
3349	1301	130	2026-03-08 15:31:34.001865+07	\N
3348	1301	128	2026-03-08 15:31:33.903793+07	2026-03-08 15:40:35.367698+07
3362	1307	70	2026-03-08 15:45:43.33195+07	\N
3363	1307	130	2026-03-08 15:45:43.446937+07	\N
3364	1307	128	2026-03-08 15:45:43.481863+07	\N
3370	1309	130	2026-03-08 15:51:51.471714+07	\N
3369	1309	128	2026-03-08 15:51:51.42759+07	2026-03-08 15:56:49.360442+07
3385	1310	130	2026-03-08 15:57:41.172914+07	\N
3386	1310	128	2026-03-08 15:57:41.266635+07	\N
3387	1311	130	2026-03-08 15:58:19.476398+07	\N
3388	1311	128	2026-03-08 15:58:20.294084+07	\N
3774	1363	70	2026-03-08 17:29:19.744991+07	\N
3393	1312	70	2026-03-08 16:05:03.222653+07	\N
3394	1312	130	2026-03-08 16:05:03.284021+07	\N
3775	1363	128	2026-03-08 17:29:19.770908+07	\N
3395	1312	128	2026-03-08 16:05:03.370629+07	2026-03-08 16:08:14.014706+07
3406	1313	70	2026-03-08 16:08:43.529843+07	\N
3408	1313	130	2026-03-08 16:08:43.62243+07	\N
3776	1363	130	2026-03-08 17:29:19.845025+07	\N
3787	1364	70	2026-03-08 17:29:45.835579+07	\N
3407	1313	128	2026-03-08 16:08:43.547206+07	2026-03-08 16:17:42.785835+07
3426	1317	70	2026-03-08 16:18:19.059119+07	\N
3427	1317	130	2026-03-08 16:18:19.131543+07	\N
3428	1317	128	2026-03-08 16:18:19.223114+07	\N
3368	1309	70	2026-03-08 15:51:51.282661+07	2026-03-08 16:25:33.195034+07
3438	1320	70	2026-03-08 16:26:01.903687+07	\N
3440	1320	130	2026-03-08 16:26:02.04295+07	\N
3439	1320	128	2026-03-08 16:26:02.038547+07	2026-03-08 16:26:22.953124+07
3447	1321	70	2026-03-08 16:27:06.047415+07	\N
3448	1321	128	2026-03-08 16:27:06.188545+07	\N
3449	1321	130	2026-03-08 16:27:06.206576+07	\N
3459	1322	70	2026-03-08 16:27:46.442779+07	\N
3461	1322	128	2026-03-08 16:27:46.552469+07	\N
3463	1322	130	2026-03-08 16:27:46.657937+07	\N
3468	1323	70	2026-03-08 16:28:12.08257+07	\N
3470	1323	128	2026-03-08 16:28:12.15262+07	\N
3471	1323	130	2026-03-08 16:28:12.152595+07	\N
3477	1324	70	2026-03-08 16:28:40.865559+07	\N
3478	1324	130	2026-03-08 16:28:40.924575+07	\N
3479	1324	128	2026-03-08 16:28:41.466801+07	\N
3486	1325	70	2026-03-08 16:29:21.300407+07	\N
3487	1325	130	2026-03-08 16:29:21.438133+07	\N
3488	1325	128	2026-03-08 16:29:21.459653+07	\N
3498	1326	70	2026-03-08 16:30:48.722712+07	\N
3499	1326	130	2026-03-08 16:30:48.83524+07	\N
3501	1326	128	2026-03-08 16:30:48.996735+07	\N
3507	1328	70	2026-03-08 16:33:05.805759+07	\N
3508	1328	128	2026-03-08 16:33:05.849121+07	\N
3509	1328	130	2026-03-08 16:33:05.914721+07	\N
3521	1329	130	2026-03-08 16:33:27.578492+07	\N
3523	1329	128	2026-03-08 16:33:27.874488+07	\N
3519	1329	70	2026-03-08 16:33:27.490515+07	2026-03-08 16:37:35.90247+07
3529	1332	70	2026-03-08 16:37:53.458006+07	\N
3530	1332	130	2026-03-08 16:37:53.495611+07	\N
3531	1332	128	2026-03-08 16:37:54.409982+07	\N
3542	1333	128	2026-03-08 16:38:21.155494+07	\N
3545	1333	130	2026-03-08 16:38:21.255357+07	\N
3550	1334	70	2026-03-08 16:38:41.670527+07	\N
3552	1334	130	2026-03-08 16:38:41.728147+07	\N
3554	1334	128	2026-03-08 16:38:41.954381+07	\N
3559	1335	70	2026-03-08 16:39:36.865646+07	\N
3560	1335	128	2026-03-08 16:39:36.93623+07	\N
3561	1335	130	2026-03-08 16:39:37.106453+07	\N
3573	1337	128	2026-03-08 16:47:35.193607+07	2026-03-08 16:55:49.352452+07
3572	1337	130	2026-03-08 16:47:34.267593+07	2026-03-08 16:55:52.288028+07
3541	1333	70	2026-03-08 16:38:21.145326+07	2026-03-08 16:56:04.493077+07
3571	1337	70	2026-03-08 16:47:34.136465+07	2026-03-08 16:56:10.445366+07
3593	1342	70	2026-03-08 16:56:29.011047+07	\N
3594	1342	128	2026-03-08 16:56:29.017513+07	\N
3595	1342	130	2026-03-08 16:56:29.106748+07	\N
3605	1343	70	2026-03-08 16:56:52.990661+07	\N
3606	1343	128	2026-03-08 16:56:52.994705+07	\N
3607	1343	130	2026-03-08 16:56:53.003332+07	\N
3614	1344	70	2026-03-08 16:57:23.768624+07	\N
3618	1344	130	2026-03-08 16:57:24.062683+07	\N
3577	1340	256	2026-03-08 16:53:24.885657+07	2026-03-08 16:57:35.619007+07
3615	1344	128	2026-03-08 16:57:23.872562+07	2026-03-08 16:57:48.568494+07
3624	1345	70	2026-03-08 16:58:04.112723+07	\N
3625	1345	130	2026-03-08 16:58:04.213738+07	\N
3626	1345	128	2026-03-08 16:58:05.036174+07	\N
3636	1346	70	2026-03-08 16:58:22.583413+07	\N
3637	1346	128	2026-03-08 16:58:22.58799+07	\N
3638	1346	130	2026-03-08 16:58:22.637598+07	\N
3645	1347	70	2026-03-08 16:58:42.347748+07	\N
3647	1347	130	2026-03-08 16:58:42.417518+07	\N
3648	1347	128	2026-03-08 16:58:42.417674+07	\N
3651	1349	170	2026-03-08 17:00:51.68524+07	\N
3659	1351	70	2026-03-08 17:08:59.127258+07	\N
3660	1351	128	2026-03-08 17:08:59.293762+07	\N
3661	1351	130	2026-03-08 17:08:59.33012+07	\N
3671	1352	70	2026-03-08 17:09:22.689672+07	\N
3673	1352	130	2026-03-08 17:09:22.739407+07	\N
3674	1352	128	2026-03-08 17:09:22.752267+07	\N
3680	1353	70	2026-03-08 17:09:47.67074+07	\N
3681	1353	130	2026-03-08 17:09:47.82801+07	\N
3682	1353	128	2026-03-08 17:09:47.832772+07	\N
3692	1354	70	2026-03-08 17:10:09.611128+07	\N
3693	1354	128	2026-03-08 17:10:09.621906+07	\N
3694	1354	130	2026-03-08 17:10:09.644375+07	\N
3701	1355	70	2026-03-08 17:10:31.99957+07	\N
3702	1355	130	2026-03-08 17:10:32.013391+07	\N
3703	1355	128	2026-03-08 17:10:32.073682+07	\N
3713	1356	70	2026-03-08 17:10:56.246257+07	\N
3714	1356	130	2026-03-08 17:10:56.43869+07	\N
3656	1350	257	2026-03-08 17:08:19.520239+07	2026-03-08 17:14:05.093264+07
3788	1364	130	2026-03-08 17:29:45.88324+07	\N
3715	1356	128	2026-03-08 17:10:56.849133+07	2026-03-08 17:20:46.19097+07
3728	1357	257	2026-03-08 17:17:07.792949+07	2026-03-08 17:24:40.669942+07
3741	1360	70	2026-03-08 17:28:11.550209+07	\N
3742	1360	128	2026-03-08 17:28:11.647989+07	\N
3743	1360	130	2026-03-08 17:28:11.784036+07	\N
3753	1361	70	2026-03-08 17:28:35.125026+07	\N
3755	1361	130	2026-03-08 17:28:35.18932+07	\N
3756	1361	128	2026-03-08 17:28:35.191437+07	\N
3762	1362	70	2026-03-08 17:28:57.190412+07	\N
3763	1362	128	2026-03-08 17:28:57.193907+07	\N
3764	1362	130	2026-03-08 17:28:57.212331+07	\N
3789	1364	128	2026-03-08 17:29:45.884241+07	\N
3795	1365	70	2026-03-08 17:30:04.106738+07	\N
3796	1365	128	2026-03-08 17:30:04.12103+07	\N
3797	1365	130	2026-03-08 17:30:04.187139+07	\N
3807	1366	70	2026-03-08 17:30:28.598825+07	\N
3808	1366	130	2026-03-08 17:30:28.680608+07	\N
3809	1366	128	2026-03-08 17:30:28.756404+07	\N
3819	1367	70	2026-03-08 17:30:52.235582+07	\N
3821	1367	128	2026-03-08 17:30:52.275219+07	\N
3823	1367	130	2026-03-08 17:30:52.37392+07	\N
3828	1368	70	2026-03-08 17:31:18.569775+07	\N
3829	1368	128	2026-03-08 17:31:18.715893+07	\N
3830	1368	130	2026-03-08 17:31:18.730511+07	\N
3840	1369	70	2026-03-08 17:31:42.284134+07	\N
3841	1369	130	2026-03-08 17:31:42.397294+07	\N
3843	1369	128	2026-03-08 17:31:42.457489+07	\N
3851	1371	70	2026-03-08 17:32:05.945078+07	\N
3852	1371	128	2026-03-08 17:32:05.990096+07	\N
3854	1371	130	2026-03-08 17:32:06.066895+07	\N
3860	1372	130	2026-03-08 17:35:39.148466+07	\N
3861	1372	70	2026-03-08 17:35:39.225127+07	\N
3862	1372	128	2026-03-08 17:35:39.279586+07	\N
3868	1373	70	2026-03-08 17:36:06.923355+07	\N
3870	1373	130	2026-03-08 17:36:06.997517+07	\N
3872	1373	128	2026-03-08 17:36:07.413813+07	\N
3877	1374	70	2026-03-08 17:36:29.527763+07	\N
3878	1374	128	2026-03-08 17:36:29.542261+07	\N
3880	1374	130	2026-03-08 17:36:29.634251+07	\N
3846	1370	170	2026-03-08 17:31:47.869477+07	2026-03-08 17:36:42.1659+07
3886	1375	70	2026-03-08 17:36:43.57023+07	\N
3888	1375	130	2026-03-08 17:36:43.657505+07	\N
3889	1375	128	2026-03-08 17:36:43.65751+07	\N
3895	1376	70	2026-03-08 17:37:08.478107+07	\N
3896	1376	128	2026-03-08 17:37:08.560113+07	\N
3897	1376	130	2026-03-08 17:37:08.604448+07	\N
3906	1377	70	2026-03-08 17:37:45.272971+07	\N
3907	1377	128	2026-03-08 17:37:45.283147+07	\N
3908	1377	130	2026-03-08 17:37:45.312596+07	\N
3918	1378	70	2026-03-08 17:38:18.117563+07	\N
3919	1378	128	2026-03-08 17:38:18.253751+07	\N
3920	1378	130	2026-03-08 17:38:18.409549+07	\N
3930	1379	70	2026-03-08 17:38:35.087205+07	\N
3931	1379	128	2026-03-08 17:38:35.090441+07	\N
3932	1379	130	2026-03-08 17:38:35.109542+07	\N
3939	1380	70	2026-03-08 17:38:48.042069+07	\N
3940	1380	130	2026-03-08 17:38:48.08565+07	\N
3941	1380	128	2026-03-08 17:38:48.22687+07	\N
3951	1381	70	2026-03-08 17:39:30.634605+07	\N
3952	1381	130	2026-03-08 17:39:30.733726+07	\N
3953	1381	128	2026-03-08 17:39:31.550004+07	\N
3963	1382	70	2026-03-08 17:40:42.913753+07	\N
3964	1382	128	2026-03-08 17:40:42.988605+07	\N
3965	1382	130	2026-03-08 17:40:43.36445+07	\N
3972	1383	70	2026-03-08 17:41:21.404124+07	\N
3973	1383	128	2026-03-08 17:41:21.581363+07	\N
3974	1383	130	2026-03-08 17:41:21.608228+07	\N
3984	1384	70	2026-03-08 17:42:52.083419+07	\N
3987	1384	130	2026-03-08 17:42:52.113186+07	\N
3985	1384	128	2026-03-08 17:42:52.094251+07	2026-03-08 17:51:44.227694+07
3996	1385	70	2026-03-08 18:00:01.295286+07	\N
3997	1385	130	2026-03-08 18:00:01.488661+07	\N
3998	1385	128	2026-03-08 18:00:01.568259+07	\N
4009	1386	70	2026-03-08 18:03:05.869629+07	\N
4010	1386	128	2026-03-08 18:03:06.008901+07	\N
4011	1386	130	2026-03-08 18:03:06.033067+07	\N
4021	1387	70	2026-03-08 18:03:35.785861+07	\N
4022	1387	128	2026-03-08 18:03:35.938271+07	\N
4023	1387	130	2026-03-08 18:03:35.945357+07	\N
4033	1388	70	2026-03-08 18:04:36.212087+07	\N
4034	1388	130	2026-03-08 18:04:36.370178+07	\N
4035	1388	128	2026-03-08 18:04:36.372514+07	\N
4045	1389	70	2026-03-08 18:08:33.154398+07	\N
4046	1389	130	2026-03-08 18:08:33.349868+07	\N
4047	1389	128	2026-03-08 18:08:34.104111+07	\N
4057	1390	70	2026-03-08 18:09:22.591874+07	\N
4059	1390	128	2026-03-08 18:09:22.868321+07	2026-03-08 18:09:33.172115+07
4058	1390	130	2026-03-08 18:09:22.849272+07	2026-03-08 18:09:49.86355+07
4066	1391	263	2026-03-08 18:10:49.351452+07	\N
4068	1392	263	2026-03-08 18:12:07.205293+07	\N
4071	1393	263	2026-03-08 18:14:01.806423+07	\N
4073	1394	263	2026-03-08 18:14:57.922428+07	2026-03-08 18:18:58.825305+07
4078	1395	70	2026-03-08 18:19:28.325594+07	\N
4079	1395	130	2026-03-08 18:19:28.475484+07	\N
4091	1398	265	2026-03-08 18:26:30.038254+07	\N
4080	1395	128	2026-03-08 18:19:28.776022+07	2026-03-08 18:30:52.230189+07
4106	1400	128	2026-03-08 18:31:07.539805+07	2026-03-08 18:32:04.555363+07
4095	1399	267	2026-03-08 18:27:30.864945+07	2026-03-08 18:32:07.965109+07
4120	1402	267	2026-03-08 18:33:48.450126+07	\N
4121	1402	37	2026-03-08 18:33:48.537866+07	2026-03-08 18:38:03.188823+07
4105	1400	70	2026-03-08 18:31:07.257515+07	2026-03-08 18:38:48.533726+07
4132	1403	37	2026-03-08 18:39:46.394812+07	\N
4137	1404	128	2026-03-08 18:39:47.270103+07	\N
4532	1466	71	2026-03-09 14:38:28.464828+07	\N
4150	1406	267	2026-03-08 18:41:10.220302+07	2026-03-08 18:41:59.411377+07
4157	1407	268	2026-03-08 18:42:47.371811+07	\N
4158	1407	37	2026-03-08 18:42:47.413078+07	\N
4166	1408	70	2026-03-08 18:43:28.377009+07	\N
4175	1409	269	2026-03-08 18:43:36.023485+07	\N
4167	1408	130	2026-03-08 18:43:28.477122+07	2026-03-08 18:44:15.485308+07
4176	1409	37	2026-03-08 18:43:36.130017+07	2026-03-08 18:45:06.922132+07
4186	1410	270	2026-03-08 18:45:16.157078+07	\N
4187	1410	37	2026-03-08 18:45:16.174262+07	\N
4188	1410	271	2026-03-08 18:45:16.178549+07	\N
4198	1412	70	2026-03-08 18:47:54.424618+07	\N
4204	1414	70	2026-03-08 18:48:54.074586+07	\N
4193	1411	270	2026-03-08 18:45:40.55298+07	2026-03-08 18:49:03.970562+07
4214	1416	70	2026-03-08 18:53:29.685076+07	\N
4215	1416	130	2026-03-08 18:53:29.777774+07	\N
4222	1417	130	2026-03-08 18:53:56.107356+07	\N
4234	1419	70	2026-03-08 18:59:06.563718+07	\N
4240	1420	70	2026-03-08 18:59:25.077154+07	\N
4242	1420	130	2026-03-08 18:59:25.14837+07	\N
4248	1421	130	2026-03-08 18:59:41.519711+07	\N
4252	1422	70	2026-03-08 19:00:20.987118+07	\N
4263	1423	70	2026-03-08 19:01:05.646813+07	\N
4271	1424	70	2026-03-08 19:01:38.56133+07	\N
4285	1426	70	2026-03-08 19:01:58.832864+07	\N
4286	1426	130	2026-03-08 19:01:58.923482+07	\N
4294	1427	130	2026-03-08 19:02:50.821032+07	\N
4282	1425	270	2026-03-08 19:01:57.711715+07	2026-03-08 19:03:07.536402+07
4279	1425	271	2026-03-08 19:01:57.604471+07	2026-03-08 19:03:09.605059+07
4280	1425	37	2026-03-08 19:01:57.692613+07	2026-03-08 19:03:13.482578+07
4309	1429	70	2026-03-08 19:03:41.058979+07	\N
4317	1430	70	2026-03-08 19:04:12.491066+07	\N
4325	1431	70	2026-03-08 19:04:41.881802+07	\N
4333	1432	70	2026-03-08 19:14:37.987412+07	\N
4339	1433	70	2026-03-08 19:17:15.671314+07	\N
4340	1433	130	2026-03-08 19:17:15.720518+07	\N
4346	1434	130	2026-03-08 19:18:35.267893+07	\N
4352	1435	130	2026-03-08 19:20:20.816609+07	\N
4363	1437	70	2026-03-08 19:23:24.011173+07	\N
4369	1438	70	2026-03-08 19:23:44.09923+07	\N
4377	1439	70	2026-03-08 19:28:30.988025+07	\N
4385	1440	70	2026-03-08 19:31:00.137709+07	\N
4394	1441	70	2026-03-08 19:31:33.603571+07	\N
4395	1441	130	2026-03-08 19:31:33.710407+07	\N
4396	1441	128	2026-03-08 19:31:33.801023+07	\N
4407	1442	130	2026-03-08 19:32:17.636547+07	\N
4418	1443	70	2026-03-08 19:34:11.343031+07	\N
4419	1443	128	2026-03-08 19:34:11.414862+07	\N
4427	1444	70	2026-03-08 19:34:59.474282+07	\N
4428	1444	130	2026-03-08 19:34:59.547417+07	\N
4436	1445	70	2026-03-08 19:36:13.736262+07	\N
4438	1445	130	2026-03-08 19:36:13.796993+07	\N
4445	1446	70	2026-03-08 19:37:32.034297+07	\N
4447	1446	128	2026-03-08 19:37:32.271082+07	\N
4458	1447	130	2026-03-08 19:38:55.551614+07	\N
4459	1447	128	2026-03-08 19:38:55.652139+07	\N
4470	1448	130	2026-03-08 19:40:09.176906+07	\N
4483	1449	130	2026-03-08 19:40:38.842826+07	\N
4482	1449	128	2026-03-08 19:40:38.842749+07	2026-03-08 19:47:05.209566+07
4502	1452	71	2026-03-08 19:55:14.943983+07	\N
4508	1453	71	2026-03-08 19:55:51.11579+07	\N
4509	1453	130	2026-03-08 19:55:51.199093+07	\N
4516	1454	130	2026-03-08 19:56:13.528737+07	2026-03-08 20:01:17.948394+07
4524	1461	71	2026-03-09 14:12:28.803158+07	\N
4537	1468	7	2026-03-09 14:41:25.707289+07	\N
4536	1468	170	2026-03-09 14:41:25.622289+07	2026-03-09 14:42:39.655766+07
4542	1469	7	2026-03-09 14:43:17.739626+07	\N
4546	1470	7	2026-03-09 14:43:37.248785+07	2026-03-09 14:49:45.024745+07
4554	1475	170	2026-03-09 14:56:37.90678+07	2026-03-09 14:58:12.743492+07
4558	1476	272	2026-03-09 15:01:19.331575+07	2026-03-09 15:05:58.820161+07
4571	1480	272	2026-03-09 15:11:26.788111+07	2026-03-09 15:19:38.334933+07
4573	1481	170	2026-03-09 15:21:13.604142+07	\N
4574	1481	272	2026-03-09 15:21:13.662956+07	\N
4581	1483	272	2026-03-09 15:27:13.182357+07	\N
4582	1483	170	2026-03-09 15:27:13.282658+07	\N
4591	1486	71	2026-03-09 15:58:42.614315+07	\N
4599	1488	71	2026-03-09 16:05:13.954925+07	\N
4604	1490	71	2026-03-09 16:09:25.270481+07	\N
4613	1492	71	2026-03-09 16:18:20.019754+07	\N
4619	1494	71	2026-03-09 16:19:46.391181+07	\N
4627	1496	71	2026-03-09 16:23:39.088027+07	\N
4633	1497	128	2026-03-09 16:25:06.508109+07	\N
4642	1498	128	2026-03-09 16:25:59.11737+07	\N
4652	1500	71	2026-03-09 16:27:00.537673+07	\N
4658	1501	71	2026-03-09 16:30:01.572139+07	\N
4666	1503	71	2026-03-09 16:48:27.374594+07	2026-03-09 16:49:36.914551+07
4673	1506	71	2026-03-09 16:52:03.741382+07	\N
4687	1508	71	2026-03-09 17:35:50.652231+07	\N
4693	1510	71	2026-03-09 17:38:18.304723+07	\N
4699	1512	72	2026-03-09 17:40:12.418795+07	\N
7382	1605	274	2026-03-12 10:52:31.972031+07	\N
4979	1564	72	2026-03-11 14:15:42.638195+07	2026-03-11 14:21:05.494165+07
6620	1569	72	2026-03-11 14:41:13.837684+07	2026-03-11 15:48:44.064747+07
7384	1605	277	2026-03-12 10:52:32.032822+07	2026-03-12 10:55:45.808349+07
7387	1606	72	2026-03-12 10:59:07.835508+07	\N
7392	1611	276	2026-03-12 11:04:14.526054+07	\N
7393	1611	275	2026-03-12 11:04:14.589246+07	\N
7390	1609	72	2026-03-12 11:02:19.93403+07	2026-03-12 11:06:16.064498+07
7397	1612	72	2026-03-12 11:19:32.306478+07	\N
4989	1565	130	2026-03-11 14:21:10.887094+07	2026-03-11 14:34:00.139127+07
6338	1566	130	2026-03-11 14:34:10.885807+07	\N
7398	1613	276	2026-03-12 11:19:45.216552+07	\N
7400	1613	275	2026-03-12 11:19:45.307492+07	\N
7404	1614	72	2026-03-12 11:20:47.927466+07	\N
6340	1566	72	2026-03-11 14:34:21.532155+07	2026-03-11 14:35:54.585544+07
6594	1567	130	2026-03-11 14:35:59.775696+07	\N
6599	1567	72	2026-03-11 14:36:09.018723+07	2026-03-11 14:40:43.096782+07
6610	1568	130	2026-03-11 14:40:46.597135+07	\N
6608	1568	72	2026-03-11 14:40:46.454594+07	2026-03-11 14:40:56.70772+07
7399	1613	274	2026-03-12 11:19:45.25419+07	2026-03-12 11:21:47.358197+07
7408	1615	72	2026-03-12 11:57:49.534759+07	\N
7411	1616	72	2026-03-12 12:00:25.205276+07	\N
7415	1617	72	2026-03-12 12:03:48.886675+07	\N
7420	1618	72	2026-03-12 12:07:53.387536+07	\N
7423	1619	72	2026-03-12 12:13:42.014584+07	2026-03-12 12:13:46.13+07
7426	1620	72	2026-03-12 12:14:41.098542+07	2026-03-12 12:14:58.074+07
6924	1570	130	2026-03-11 15:48:48.086817+07	2026-03-11 16:05:43.061233+07
6926	1570	72	2026-03-11 15:49:00.32403+07	2026-03-11 16:05:50.274958+07
7177	1571	130	2026-03-11 16:05:54.731973+07	2026-03-11 16:05:54.88967+07
7181	1571	72	2026-03-11 16:06:13.802251+07	2026-03-11 16:06:29.331397+07
4993	1565	72	2026-03-11 14:21:19.133265+07	2026-03-11 14:21:29.298827+07
7187	1572	72	2026-03-11 16:06:55.293972+07	2026-03-11 16:06:55.793551+07
7191	1571	128	2026-03-11 16:07:03.589277+07	\N
7192	1572	128	2026-03-11 16:07:03.642204+07	\N
7429	1621	280	2026-03-12 12:15:31.024476+07	\N
7201	1573	128	2026-03-11 16:09:52.959993+07	2026-03-11 16:18:53.28843+07
7197	1573	72	2026-03-11 16:09:42.083003+07	2026-03-11 16:21:40.424654+07
7430	1621	278	2026-03-12 12:15:31.115839+07	\N
7431	1621	279	2026-03-12 12:15:31.185623+07	\N
7208	1574	72	2026-03-11 16:23:57.124061+07	2026-03-11 16:24:10.03604+07
7214	1574	128	2026-03-11 16:24:33.73317+07	\N
7435	1622	280	2026-03-12 12:16:28.809235+07	\N
7216	1575	128	2026-03-11 16:24:47.190525+07	2026-03-11 16:26:02.333849+07
7232	1575	72	2026-03-11 16:26:17.423453+07	\N
7234	1576	72	2026-03-11 16:26:17.443116+07	2026-03-11 16:26:38.227006+07
7436	1622	279	2026-03-12 12:16:28.863539+07	\N
7228	1576	128	2026-03-11 16:26:14.89924+07	2026-03-11 16:29:17.053639+07
7240	1577	72	2026-03-11 16:29:48.428304+07	\N
7243	1577	128	2026-03-11 16:29:59.288955+07	2026-03-11 16:30:38.298315+07
7248	1578	72	2026-03-11 16:32:54.26101+07	\N
7437	1622	278	2026-03-12 12:16:28.901727+07	\N
7442	1623	279	2026-03-12 12:17:11.595098+07	2026-03-12 12:19:35.554303+07
7252	1578	128	2026-03-11 16:33:00.763098+07	2026-03-11 16:43:46.381058+07
7277	1579	128	2026-03-11 16:43:55.553824+07	2026-03-11 16:44:26.631334+07
7279	1579	72	2026-03-11 16:45:10.099215+07	\N
7280	1580	72	2026-03-11 16:45:17.75515+07	\N
7286	1581	72	2026-03-11 16:45:40.886366+07	\N
7284	1581	128	2026-03-11 16:45:40.785702+07	2026-03-11 16:45:57.662089+07
7290	1582	72	2026-03-11 16:46:03.433706+07	\N
7295	1583	72	2026-03-11 16:46:42.146954+07	\N
7294	1583	128	2026-03-11 16:46:41.860571+07	2026-03-11 16:46:55.452813+07
7443	1623	278	2026-03-12 12:17:11.855739+07	2026-03-12 12:19:54.598927+07
7296	1584	72	2026-03-11 16:47:06.827698+07	2026-03-11 16:49:30.52807+07
7301	1585	128	2026-03-11 16:54:50.460452+07	2026-03-11 16:55:14.226491+07
7307	1585	72	2026-03-11 16:55:20.95609+07	\N
7308	1586	72	2026-03-11 16:55:30.505778+07	\N
7313	1588	72	2026-03-11 17:02:30.067881+07	\N
7316	1589	72	2026-03-11 17:02:50.512664+07	\N
7319	1590	72	2026-03-11 17:03:19.145542+07	\N
7323	1591	72	2026-03-11 17:08:24.638006+07	\N
7326	1592	72	2026-03-11 17:09:03.115231+07	\N
7330	1596	72	2026-03-12 10:07:32.428558+07	\N
7333	1597	72	2026-03-12 10:13:41.839995+07	\N
7336	1598	72	2026-03-12 10:14:35.394557+07	\N
7338	1598	128	2026-03-12 10:14:35.57069+07	2026-03-12 10:15:02.558067+07
7344	1599	72	2026-03-12 10:15:51.966388+07	\N
7347	1600	72	2026-03-12 10:16:09.03663+07	\N
7441	1623	280	2026-03-12 12:17:11.537196+07	2026-03-12 12:21:34.344063+07
7353	1601	276	2026-03-12 10:18:57.848874+07	\N
7354	1601	275	2026-03-12 10:18:57.925788+07	\N
7355	1601	274	2026-03-12 10:18:57.936776+07	\N
7359	1602	276	2026-03-12 10:21:51.843689+07	\N
7361	1602	274	2026-03-12 10:21:51.899776+07	2026-03-12 10:24:25.84236+07
7360	1602	275	2026-03-12 10:21:51.893655+07	2026-03-12 10:24:33.963818+07
7349	1600	128	2026-03-12 10:16:09.178469+07	2026-03-12 10:40:26.443802+07
7367	1603	274	2026-03-12 10:46:14.377082+07	\N
6616	1569	130	2026-03-11 14:41:05.150466+07	2026-03-11 15:30:41.409154+07
7368	1603	277	2026-03-12 10:46:14.487371+07	\N
7447	1624	72	2026-03-12 12:24:24.92483+07	\N
7371	1603	276	2026-03-12 10:46:14.638322+07	2026-03-12 10:47:34.269677+07
7375	1604	277	2026-03-12 10:51:09.141585+07	2026-03-12 10:52:05.11182+07
7374	1604	274	2026-03-12 10:51:09.124079+07	2026-03-12 10:52:06.258237+07
7373	1604	275	2026-03-12 10:51:09.062298+07	2026-03-12 10:52:14.597814+07
7380	1605	275	2026-03-12 10:52:31.917227+07	\N
7458	1625	72	2026-03-12 12:26:25.671309+07	\N
7461	1626	72	2026-03-12 12:33:18.632608+07	\N
7465	1627	72	2026-03-12 12:37:11.981282+07	2026-03-12 12:37:23.549+07
7468	1628	72	2026-03-12 12:55:23.565318+07	2026-03-12 12:55:41.204+07
7472	1629	72	2026-03-12 12:55:49.796791+07	\N
7477	1630	72	2026-03-12 12:56:20.706574+07	2026-03-12 12:58:23.738+07
7480	1631	72	2026-03-12 12:58:51.108287+07	2026-03-12 13:08:29.496+07
7483	1632	72	2026-03-12 13:08:39.904209+07	2026-03-12 13:09:11.355+07
7488	1633	72	2026-03-12 14:48:54.893047+07	2026-03-12 14:49:03.407+07
7491	1634	72	2026-03-12 14:49:15.894506+07	2026-03-12 14:55:02.36+07
7497	1636	72	2026-03-12 14:56:27.749629+07	2026-03-12 14:56:51.444+07
7501	1637	72	2026-03-12 14:57:05.924845+07	2026-03-12 14:57:11.788+07
7502	1637	128	2026-03-12 14:57:05.973614+07	2026-03-12 14:57:11.788+07
7507	1638	72	2026-03-12 14:57:23.641475+07	2026-03-12 14:57:51.674+07
7508	1638	128	2026-03-12 14:57:23.838446+07	2026-03-12 14:57:51.674+07
7513	1639	72	2026-03-12 14:58:10.476428+07	2026-03-12 14:58:56.71+07
7515	1639	128	2026-03-12 14:58:10.646215+07	2026-03-12 14:58:56.71+07
7518	1640	72	2026-03-12 15:04:58.057597+07	2026-03-12 15:05:10.009+07
7520	1641	72	2026-03-12 15:11:46.808948+07	2026-03-12 15:12:01.017+07
7523	1642	72	2026-03-12 15:12:59.153944+07	2026-03-12 15:13:22.943+07
7527	1643	72	2026-03-12 15:13:39.398066+07	2026-03-12 15:13:59.614+07
7529	1644	72	2026-03-12 15:14:18.450857+07	2026-03-12 15:14:38.446+07
7533	1645	72	2026-03-12 15:14:50.806516+07	2026-03-12 15:15:09.135+07
7536	1646	72	2026-03-12 15:15:24.863828+07	2026-03-12 15:15:42.771+07
7540	1647	72	2026-03-12 15:15:55.82485+07	2026-03-12 15:16:06.706+07
7544	1648	72	2026-03-12 15:16:12.977162+07	2026-03-12 15:16:19.501+07
7547	1649	72	2026-03-12 15:16:32.003551+07	2026-03-12 15:16:49.473+07
7551	1650	72	2026-03-12 15:17:02.589165+07	2026-03-12 15:17:15.659+07
7554	1651	72	2026-03-12 15:17:21.775458+07	2026-03-12 15:17:30.304+07
7557	1653	72	2026-03-14 16:59:10.670202+07	2026-03-14 16:59:25.896+07
7561	1655	72	2026-03-14 17:16:54.73239+07	2026-03-14 17:16:56.836+07
7564	1656	72	2026-03-14 17:17:04.873493+07	2026-03-14 17:17:06.303+07
7567	1657	72	2026-03-14 17:18:27.011649+07	2026-03-14 17:18:39.015+07
7570	1658	72	2026-03-14 17:18:48.413288+07	2026-03-14 17:21:52.243+07
7573	1659	72	2026-03-14 17:22:00.009481+07	2026-03-14 17:22:14.821+07
7576	1660	72	2026-03-14 17:22:22.751646+07	2026-03-14 17:22:31.783+07
7579	1661	72	2026-03-14 17:27:30.800176+07	2026-03-14 17:27:32.384+07
7582	1662	72	2026-03-14 17:27:48.374174+07	2026-03-14 17:27:54.455+07
7585	1663	72	2026-03-14 17:28:04.363942+07	2026-03-14 17:28:14.85+07
7588	1664	72	2026-03-14 17:28:22.794109+07	2026-03-14 17:28:35.19+07
7591	1665	72	2026-03-14 17:29:13.65687+07	2026-03-14 17:29:34.799+07
7592	1665	128	2026-03-14 17:29:13.785137+07	2026-03-14 17:29:34.799+07
7598	1666	72	2026-03-14 17:31:25.975139+07	2026-03-14 17:31:37.537+07
7599	1666	128	2026-03-14 17:31:26.011153+07	2026-03-14 17:31:37.537+07
7605	1667	72	2026-03-14 17:31:46.272266+07	2026-03-14 17:31:49.132+07
7604	1667	128	2026-03-14 17:31:46.272248+07	2026-03-14 17:31:49.132+07
7611	1668	72	2026-03-14 17:41:02.30848+07	\N
7617	1669	72	2026-03-14 17:43:47.29316+07	2026-03-14 17:45:03.898+07
7619	1669	128	2026-03-14 17:43:47.509511+07	2026-03-14 17:45:03.898+07
7623	1671	72	2026-03-14 18:00:41.707952+07	2026-03-14 18:02:02.789+07
7630	1672	72	2026-03-14 18:02:27.182643+07	2026-03-14 18:02:39.219+07
7629	1672	128	2026-03-14 18:02:27.17667+07	2026-03-14 18:02:39.219+07
7636	1680	72	2026-03-15 13:01:37.911768+07	2026-03-15 13:01:50.304+07
7639	1681	72	2026-03-15 13:04:03.212073+07	2026-03-15 13:04:22.13+07
7643	1682	72	2026-03-15 13:14:00.756652+07	2026-03-15 13:16:46.82+07
7646	1683	72	2026-03-15 13:16:54.122067+07	2026-03-15 13:17:13.985+07
7650	1684	72	2026-03-15 13:18:05.031002+07	2026-03-15 13:19:34.809+07
7649	1684	128	2026-03-15 13:18:05.030884+07	2026-03-15 13:19:34.809+07
7657	1685	72	2026-03-15 13:19:46.066463+07	2026-03-15 13:20:54.177+07
7656	1685	128	2026-03-15 13:19:45.729751+07	2026-03-15 13:20:54.177+07
7663	1686	72	2026-03-15 13:21:44.945121+07	2026-03-15 13:22:30.377+07
7662	1686	128	2026-03-15 13:21:44.765461+07	2026-03-15 13:22:30.377+07
7671	1687	72	2026-03-15 13:22:53.456649+07	2026-03-15 13:23:15.33+07
7670	1687	128	2026-03-15 13:22:53.290078+07	2026-03-15 13:23:15.33+07
7677	1688	72	2026-03-15 13:23:33.407014+07	2026-03-15 13:24:08.239+07
7676	1688	128	2026-03-15 13:23:33.188743+07	2026-03-15 13:24:08.239+07
7685	1689	72	2026-03-15 13:24:23.170469+07	2026-03-15 13:26:16.923+07
7684	1689	128	2026-03-15 13:24:22.925836+07	2026-03-15 13:26:16.923+07
7693	1690	72	2026-03-15 13:29:35.885416+07	2026-03-15 13:31:43.285+07
7692	1690	128	2026-03-15 13:29:35.571912+07	2026-03-15 13:31:43.285+07
7700	1691	72	2026-03-15 13:31:49.158067+07	2026-03-15 13:34:46.738+07
7699	1691	128	2026-03-15 13:31:49.10324+07	2026-03-15 13:34:46.738+07
7705	1692	128	2026-03-15 13:34:51.613012+07	\N
7706	1692	72	2026-03-15 13:34:51.617743+07	\N
7713	1693	72	2026-03-15 13:35:30.93219+07	2026-03-15 13:35:47.415+07
7711	1693	128	2026-03-15 13:35:30.852466+07	2026-03-15 13:35:47.415+07
7719	1694	72	2026-03-15 13:35:52.409766+07	2026-03-15 13:35:57.604+07
7717	1694	128	2026-03-15 13:35:52.098916+07	2026-03-15 13:35:57.604+07
7725	1695	72	2026-03-15 13:36:06.562683+07	2026-03-15 13:37:47.59+07
7723	1695	128	2026-03-15 13:36:06.48811+07	2026-03-15 13:37:47.59+07
7729	1696	128	2026-03-15 13:37:51.982797+07	\N
7731	1696	72	2026-03-15 13:37:52.076262+07	\N
7741	1697	72	2026-03-15 13:40:32.927221+07	2026-03-15 13:43:00.988+07
7743	1697	128	2026-03-15 13:40:32.997403+07	2026-03-15 13:43:00.988+07
7747	1698	72	2026-03-15 13:43:07.010872+07	2026-03-15 13:43:15.313+07
7749	1698	128	2026-03-15 13:43:07.184975+07	2026-03-15 13:43:15.313+07
7753	1699	72	2026-03-15 13:43:33.840384+07	\N
7754	1699	128	2026-03-15 13:43:34.116995+07	\N
7761	1700	72	2026-03-15 13:45:27.138072+07	2026-03-15 13:45:34.893+07
7762	1700	128	2026-03-15 13:45:27.191759+07	2026-03-15 13:45:34.893+07
7766	1701	72	2026-03-15 13:45:40.512841+07	2026-03-15 13:45:45.757+07
7768	1701	128	2026-03-15 13:45:40.674446+07	2026-03-15 13:45:45.757+07
7774	1703	72	2026-03-15 14:05:20.569774+07	2026-03-15 14:05:25.466+07
7777	1704	72	2026-03-15 14:05:35.115165+07	2026-03-15 14:05:39.452+07
7780	1705	72	2026-03-15 14:05:49.608704+07	2026-03-15 14:05:52.981+07
7783	1706	72	2026-03-15 14:06:14.75901+07	2026-03-15 14:06:32.759+07
7786	1707	72	2026-03-15 14:06:56.360347+07	2026-03-15 14:07:00.39+07
7789	1708	72	2026-03-15 14:10:54.000442+07	2026-03-15 14:10:57.4+07
7792	1709	72	2026-03-15 14:18:47.370658+07	2026-03-15 14:18:52.498+07
7795	1710	72	2026-03-15 14:21:54.26328+07	2026-03-15 14:22:00.611+07
7798	1711	72	2026-03-15 14:22:19.946928+07	2026-03-15 14:22:26.235+07
7800	1711	128	2026-03-15 14:22:20.151311+07	2026-03-15 14:22:26.235+07
7804	1712	72	2026-03-15 14:23:39.520937+07	2026-03-15 14:23:47.654+07
7806	1712	128	2026-03-15 14:23:39.729664+07	2026-03-15 14:23:47.654+07
7810	1713	72	2026-03-15 14:23:51.619315+07	2026-03-15 14:23:54.5+07
7812	1713	128	2026-03-15 14:23:51.71277+07	2026-03-15 14:23:54.5+07
7816	1714	72	2026-03-15 14:24:03.675618+07	2026-03-15 14:27:47.108+07
7818	1714	128	2026-03-15 14:24:03.739779+07	2026-03-15 14:27:47.108+07
7822	1715	72	2026-03-15 14:27:51.348278+07	2026-03-15 14:31:39.024+07
7824	1715	128	2026-03-15 14:27:51.544486+07	2026-03-15 14:31:39.024+07
7828	1716	72	2026-03-15 14:31:43.440642+07	2026-03-15 14:31:52.853+07
7829	1716	128	2026-03-15 14:31:43.446352+07	2026-03-15 14:31:52.853+07
7834	1717	72	2026-03-15 14:31:57.706504+07	2026-03-15 14:33:43.288+07
7836	1717	128	2026-03-15 14:31:57.823968+07	2026-03-15 14:33:43.288+07
7840	1718	72	2026-03-15 14:34:51.519639+07	2026-03-15 14:34:58.089+07
7843	1719	72	2026-03-15 14:35:12.990671+07	2026-03-15 14:38:20.856+07
7845	1719	128	2026-03-15 14:35:13.16912+07	2026-03-15 14:38:20.856+07
7849	1720	72	2026-03-15 14:38:30.751798+07	2026-03-15 14:49:06.39+07
7851	1720	128	2026-03-15 14:38:30.767499+07	2026-03-15 14:49:06.39+07
7863	1721	72	2026-03-15 14:49:10.709794+07	2026-03-15 14:49:16.888+07
7865	1721	128	2026-03-15 14:49:11.177887+07	2026-03-15 14:49:16.888+07
7871	1722	72	2026-03-15 14:49:23.982807+07	2026-03-15 14:50:41.483+07
7872	1722	128	2026-03-15 14:49:23.999932+07	2026-03-15 14:50:41.483+07
7879	1723	72	2026-03-15 14:50:45.122749+07	2026-03-15 14:50:50.991+07
7881	1723	128	2026-03-15 14:50:45.182961+07	2026-03-15 14:50:50.991+07
7887	1724	72	2026-03-15 14:51:01.943782+07	2026-03-15 14:51:09.51+07
7888	1724	128	2026-03-15 14:51:02.086283+07	2026-03-15 14:51:09.51+07
7889	1726	128	2026-03-15 14:51:02.111657+07	2026-03-15 14:51:12.823+07
7899	1727	72	2026-03-15 14:52:11.734617+07	2026-03-15 14:52:18.093+07
7900	1727	128	2026-03-15 14:52:11.823211+07	2026-03-15 14:52:18.093+07
7907	1728	72	2026-03-15 14:52:39.423329+07	2026-03-15 14:52:51.991+07
7909	1728	128	2026-03-15 14:52:39.471104+07	2026-03-15 14:52:51.991+07
7913	1729	72	2026-03-15 14:52:57.277891+07	2026-03-15 14:53:05.301+07
7914	1729	128	2026-03-15 14:52:57.284432+07	2026-03-15 14:53:05.301+07
7919	1730	72	2026-03-15 14:53:09.276075+07	2026-03-15 14:53:19.198+07
7920	1730	128	2026-03-15 14:53:09.282041+07	2026-03-15 14:53:19.198+07
7925	1731	72	2026-03-15 14:53:58.403804+07	2026-03-15 14:54:00.321+07
7927	1731	128	2026-03-15 14:53:58.855252+07	2026-03-15 14:54:00.321+07
7931	1732	72	2026-03-15 14:56:01.578252+07	2026-03-15 14:56:05.16+07
7933	1732	128	2026-03-15 14:56:01.735527+07	2026-03-15 14:56:05.16+07
7937	1733	72	2026-03-15 15:00:23.124308+07	2026-03-15 15:00:25.148+07
7939	1733	128	2026-03-15 15:00:23.221829+07	2026-03-15 15:00:25.148+07
7943	1734	72	2026-03-15 15:13:01.268738+07	2026-03-15 15:13:05.138+07
7946	1735	72	2026-03-15 15:13:17.053525+07	2026-03-15 15:13:20.607+07
7949	1736	72	2026-03-15 15:25:54.94277+07	2026-03-15 15:26:18.143+07
7952	1737	72	2026-03-15 15:32:52.267299+07	2026-03-15 15:36:09.046+07
7957	1738	72	2026-03-15 15:37:57.855238+07	2026-03-15 15:38:08.148+07
7958	1738	128	2026-03-15 15:37:58.041071+07	2026-03-15 15:38:08.148+07
7965	1739	72	2026-03-15 15:38:22.349498+07	2026-03-15 15:38:28.714+07
7966	1739	128	2026-03-15 15:38:22.527799+07	2026-03-15 15:38:28.714+07
7973	1740	72	2026-03-15 15:46:43.558879+07	2026-03-15 15:46:49.499+07
7974	1740	128	2026-03-15 15:46:43.696895+07	2026-03-15 15:46:49.499+07
7979	1741	72	2026-03-15 15:58:50.6737+07	2026-03-15 16:01:44.971+07
7984	1725	72	2026-03-15 16:17:05.756615+07	2026-03-15 16:20:14.523+07
7890	1725	128	2026-03-15 14:51:02.115537+07	2026-03-15 16:20:14.523+07
7999	1742	72	2026-03-15 16:21:27.412524+07	2026-03-15 16:22:18.066+07
8006	1743	72	2026-03-15 16:22:48.612802+07	2026-03-15 16:23:06.391+07
8010	1744	72	2026-03-15 16:23:11.787769+07	2026-03-15 16:23:16.624+07
8012	1744	128	2026-03-15 16:23:11.877158+07	2026-03-15 16:23:16.624+07
8016	1745	72	2026-03-15 16:45:37.949318+07	2026-03-15 16:45:50.273+07
8019	1746	72	2026-03-15 16:46:05.405325+07	2026-03-15 16:46:15.351+07
8022	1747	72	2026-03-15 16:46:26.206888+07	2026-03-15 16:46:37.812+07
8025	1748	72	2026-03-15 16:46:44.105922+07	2026-03-15 16:46:51.641+07
8028	1749	72	2026-03-15 16:47:10.428704+07	2026-03-15 16:47:26.471+07
8032	1750	72	2026-03-15 16:47:39.026915+07	2026-03-15 16:47:50.5+07
8036	1751	72	2026-03-15 16:49:14.961897+07	2026-03-15 16:51:51.128+07
8037	1751	128	2026-03-15 16:49:15.104696+07	2026-03-15 16:51:51.128+07
8044	1752	72	2026-03-15 16:52:32.192394+07	2026-03-15 16:52:41.445+07
8045	1752	128	2026-03-15 16:52:32.234315+07	2026-03-15 16:52:41.445+07
8050	1753	72	2026-03-15 16:52:50.565049+07	2026-03-15 16:53:01.814+07
8052	1753	128	2026-03-15 16:52:50.611155+07	2026-03-15 16:53:01.814+07
8056	1754	72	2026-03-15 16:53:56.85912+07	2026-03-15 16:54:08.828+07
8057	1754	128	2026-03-15 16:53:57.007127+07	2026-03-15 16:54:08.828+07
8064	1755	282	2026-03-16 16:44:52.568678+07	2026-03-16 16:45:04.059+07
8066	1756	282	2026-03-16 16:55:32.080062+07	\N
8068	1757	282	2026-03-16 17:19:35.185657+07	2026-03-16 17:19:57.168+07
8072	1756	283	2026-03-16 17:24:48.47167+07	\N
8073	1758	284	2026-03-16 17:33:57.618054+07	2026-03-16 17:34:21.003+07
8075	1759	284	2026-03-16 17:39:06.760159+07	\N
8077	1759	285	2026-03-16 17:39:06.966966+07	\N
8094	1760	287	2026-03-16 17:41:27.81595+07	\N
8095	1760	286	2026-03-16 17:41:27.829623+07	\N
8098	1761	287	2026-03-16 17:43:22.911569+07	\N
8099	1761	286	2026-03-16 17:43:22.93744+07	\N
8102	1762	287	2026-03-16 17:54:58.040457+07	\N
8103	1762	286	2026-03-16 17:54:58.16748+07	\N
8106	1763	287	2026-03-16 17:56:02.121599+07	\N
8108	1763	286	2026-03-16 17:56:02.149209+07	\N
8117	1764	286	2026-03-16 17:59:16.489589+07	2026-03-16 17:59:24.039+07
8116	1764	287	2026-03-16 17:59:16.375132+07	2026-03-16 17:59:24.039+07
8121	1765	286	2026-03-16 17:59:39.327263+07	2026-03-16 17:59:44.788+07
8120	1765	287	2026-03-16 17:59:39.298108+07	2026-03-16 17:59:44.788+07
8124	1766	286	2026-03-16 17:59:57.138976+07	2026-03-16 18:00:04.953+07
8126	1766	287	2026-03-16 17:59:57.201824+07	2026-03-16 18:00:04.953+07
8128	1768	287	2026-03-16 18:30:26.675099+07	\N
8129	1768	286	2026-03-16 18:30:26.705639+07	\N
8140	1769	287	2026-03-16 19:23:10.933994+07	\N
8144	1770	287	2026-03-16 19:30:22.640867+07	\N
8146	1771	287	2026-03-16 19:31:12.630083+07	\N
8148	1772	287	2026-03-16 19:32:17.233893+07	\N
8150	1773	287	2026-03-16 19:46:50.825844+07	2026-03-16 19:47:15.047+07
8152	1774	287	2026-03-16 19:48:25.112022+07	\N
8153	1774	286	2026-03-16 19:48:25.144965+07	\N
8159	1775	286	2026-03-16 19:49:22.073908+07	2026-03-16 19:50:03.551+07
8157	1775	287	2026-03-16 19:49:21.964394+07	2026-03-16 19:50:03.551+07
8161	1776	286	2026-03-16 19:50:41.887276+07	2026-03-16 19:51:12.238+07
8162	1776	287	2026-03-16 19:50:41.943719+07	2026-03-16 19:51:12.238+07
8165	1777	286	2026-03-16 19:51:24.846681+07	2026-03-16 19:51:32.391+07
8166	1777	287	2026-03-16 19:51:24.854735+07	2026-03-16 19:51:32.391+07
8170	1778	286	2026-03-16 19:52:08.986941+07	2026-03-16 19:52:14.343+07
8169	1778	287	2026-03-16 19:52:08.985537+07	2026-03-16 19:52:14.343+07
8175	1779	286	2026-03-16 19:52:20.483892+07	2026-03-16 19:53:39.372+07
8173	1779	287	2026-03-16 19:52:20.44846+07	2026-03-16 19:53:39.372+07
8177	1780	288	2026-03-16 19:58:43.510719+07	2026-03-16 19:58:52.588+07
8180	1781	288	2026-03-16 19:59:09.404781+07	2026-03-16 19:59:16.832+07
8183	1782	288	2026-03-16 19:59:23.134258+07	2026-03-16 19:59:31.145+07
8186	1783	288	2026-03-16 19:59:36.021543+07	2026-03-16 19:59:43.917+07
8189	1784	288	2026-03-16 19:59:56.865608+07	\N
8190	1785	288	2026-03-16 20:19:03.001771+07	2026-03-16 20:26:31.411+07
8196	1786	288	2026-03-16 20:26:57.986534+07	2026-03-16 20:27:07.499+07
8199	1787	288	2026-03-16 20:27:19.647298+07	\N
8202	1788	287	2026-03-16 21:46:07.342697+07	\N
8203	1788	286	2026-03-16 21:46:07.527817+07	\N
8207	1789	287	2026-03-16 22:41:53.694385+07	\N
8209	1789	286	2026-03-16 22:41:53.787102+07	\N
8212	1790	286	2026-03-16 22:58:09.461668+07	\N
8213	1790	287	2026-03-16 22:58:09.541943+07	\N
8216	1791	287	2026-03-16 23:06:14.960848+07	\N
8217	1791	289	2026-03-16 23:06:15.12605+07	\N
8219	1791	286	2026-03-18 12:59:34.847673+07	\N
8220	1792	287	2026-03-18 13:00:01.805363+07	\N
8221	1792	286	2026-03-18 13:00:01.854779+07	\N
8230	1793	286	2026-03-18 13:07:40.238483+07	2026-03-18 13:08:23.994+07
8229	1793	287	2026-03-18 13:07:40.077412+07	2026-03-18 13:08:23.994+07
8239	1794	286	2026-03-18 13:11:04.227376+07	2026-03-18 13:11:29.225+07
8237	1794	287	2026-03-18 13:11:04.135664+07	2026-03-18 13:11:29.225+07
8246	1795	286	2026-03-18 13:18:00.167173+07	2026-03-18 13:18:31.235+07
8245	1795	287	2026-03-18 13:18:00.08705+07	2026-03-18 13:18:31.235+07
8256	1796	286	2026-03-18 13:30:00.324154+07	2026-03-18 13:32:51.029+07
8255	1796	287	2026-03-18 13:30:00.25915+07	2026-03-18 13:32:51.029+07
8265	1797	286	2026-03-18 13:37:06.39707+07	2026-03-18 13:37:41.052+07
8264	1797	287	2026-03-18 13:37:06.264272+07	2026-03-18 13:37:41.052+07
8273	1798	286	2026-03-18 13:44:42.295741+07	2026-03-18 13:45:40.212+07
8274	1798	287	2026-03-18 13:44:42.696199+07	2026-03-18 13:45:40.212+07
8282	1799	286	2026-03-18 13:47:42.183136+07	2026-03-18 13:48:08.909+07
8281	1799	287	2026-03-18 13:47:42.09206+07	2026-03-18 13:48:08.909+07
8288	1800	288	2026-03-18 13:51:07.067987+07	2026-03-18 13:51:11.252+07
8291	1801	288	2026-03-18 13:55:09.416712+07	2026-03-18 13:55:17.967+07
8295	1802	286	2026-03-18 13:56:02.123437+07	2026-03-18 13:56:07.3+07
8298	1803	288	2026-03-18 13:56:13.111219+07	2026-03-18 13:57:03.821+07
8302	1804	286	2026-03-18 14:10:34.625581+07	2026-03-18 14:15:12.168+07
8301	1804	287	2026-03-18 14:10:34.462482+07	2026-03-18 14:15:12.168+07
8312	1805	286	2026-03-18 14:15:58.638752+07	2026-03-18 14:22:41.97+07
8311	1805	287	2026-03-18 14:15:58.51184+07	2026-03-18 14:22:41.97+07
8322	1806	286	2026-03-18 14:23:55.826497+07	2026-03-18 14:24:26.353+07
8321	1806	287	2026-03-18 14:23:55.686075+07	2026-03-18 14:24:26.353+07
8331	1807	287	2026-03-18 14:32:12.426884+07	\N
8332	1807	286	2026-03-18 14:32:12.490002+07	\N
8337	1808	286	2026-03-18 14:36:20.994986+07	\N
8338	1808	287	2026-03-18 14:36:21.091387+07	\N
8341	1809	288	2026-03-18 14:57:15.656401+07	2026-03-18 14:58:55.312+07
8345	1809	290	2026-03-18 14:57:15.904373+07	2026-03-18 14:58:55.312+07
8342	1809	291	2026-03-18 14:57:15.733423+07	2026-03-18 14:58:55.312+07
8352	1810	287	2026-03-18 15:00:41.56747+07	\N
8353	1810	286	2026-03-18 15:00:41.671381+07	\N
8356	1811	288	2026-03-18 16:15:12.911251+07	2026-03-18 16:16:27.263+07
8357	1811	290	2026-03-18 16:15:13.120367+07	2026-03-18 16:16:27.263+07
8358	1811	291	2026-03-18 16:15:13.214054+07	2026-03-18 16:16:27.263+07
8365	1813	292	2026-03-18 17:24:44.648131+07	2026-03-18 17:34:08.668+07
8366	1813	293	2026-03-18 17:24:44.811784+07	2026-03-18 17:34:08.668+07
8371	1814	292	2026-03-18 17:51:54.888631+07	2026-03-18 17:52:03.286+07
8374	1815	292	2026-03-18 17:54:32.370079+07	2026-03-18 17:55:38.075+07
8375	1815	293	2026-03-18 17:54:32.523962+07	2026-03-18 17:55:38.075+07
8380	1816	292	2026-03-18 17:55:46.152623+07	2026-03-18 17:56:04.465+07
8381	1816	293	2026-03-18 17:55:46.166416+07	2026-03-18 17:56:04.465+07
8386	1817	292	2026-03-18 17:56:10.390941+07	2026-03-18 17:56:37.515+07
8388	1817	293	2026-03-18 17:56:10.416941+07	2026-03-18 17:56:37.515+07
8409	1818	292	2026-03-18 18:47:30.444075+07	2026-03-18 18:47:36.027+07
8410	1818	293	2026-03-18 18:47:30.53097+07	2026-03-18 18:47:36.027+07
8417	1819	292	2026-03-18 18:49:05.737502+07	2026-03-18 18:49:13.475+07
8449	1818	294	2026-03-18 19:01:20.704258+07	\N
8450	1820	292	2026-03-18 19:01:40.48313+07	\N
8451	1820	294	2026-03-18 19:01:40.559017+07	\N
8452	1820	293	2026-03-18 19:01:40.764628+07	\N
8465	1821	292	2026-03-18 19:09:31.433604+07	2026-03-18 19:09:56.461+07
8464	1821	293	2026-03-18 19:09:31.238329+07	2026-03-18 19:09:56.461+07
8466	1821	294	2026-03-18 19:09:31.489532+07	2026-03-18 19:09:56.461+07
8477	1822	292	2026-03-18 19:27:22.343896+07	2026-03-18 19:28:11.174+07
8476	1822	294	2026-03-18 19:27:22.169964+07	2026-03-18 19:28:11.174+07
8482	1823	292	2026-03-18 19:28:40.935573+07	2026-03-18 19:36:06.891+07
8483	1823	294	2026-03-18 19:28:41.117566+07	2026-03-18 19:36:06.891+07
8488	1824	292	2026-03-18 19:39:05.394587+07	2026-03-18 19:40:00.933+07
8491	1825	292	2026-03-18 19:41:01.724151+07	2026-03-18 19:41:47.235+07
8492	1825	293	2026-03-18 19:41:01.812802+07	2026-03-18 19:41:47.235+07
8496	1826	292	2026-03-18 19:43:19.1164+07	2026-03-18 19:43:28.96+07
8497	1826	293	2026-03-18 19:43:19.189243+07	2026-03-18 19:43:28.96+07
8502	1827	292	2026-03-18 19:43:34.413533+07	2026-03-18 19:43:53.569+07
8503	1827	293	2026-03-18 19:43:34.424209+07	2026-03-18 19:43:53.569+07
8508	1828	292	2026-03-18 19:44:00.522857+07	2026-03-18 19:44:44.038+07
8510	1828	293	2026-03-18 19:44:00.563058+07	2026-03-18 19:44:44.038+07
8514	1829	292	2026-03-18 19:45:18.628485+07	2026-03-18 19:46:17.243+07
8516	1829	293	2026-03-18 19:45:18.718732+07	2026-03-18 19:46:17.243+07
8520	1830	292	2026-03-18 19:46:25.72691+07	2026-03-18 19:46:55.6+07
8522	1830	293	2026-03-18 19:46:25.738942+07	2026-03-18 19:46:55.6+07
8526	1831	292	2026-03-18 19:47:12.01395+07	2026-03-18 19:48:06.451+07
8527	1831	293	2026-03-18 19:47:12.174589+07	2026-03-18 19:48:06.451+07
8534	1832	292	2026-03-18 19:48:42.86272+07	2026-03-18 19:49:06.69+07
8535	1832	293	2026-03-18 19:48:42.991069+07	2026-03-18 19:49:06.69+07
8542	1833	292	2026-03-18 19:49:37.35644+07	2026-03-18 19:50:11.833+07
8544	1833	293	2026-03-18 19:49:37.369139+07	2026-03-18 19:50:11.833+07
8548	1834	292	2026-03-18 19:50:27.08079+07	2026-03-18 19:52:17.069+07
8549	1834	293	2026-03-18 19:50:27.094381+07	2026-03-18 19:52:17.069+07
8558	1835	292	2026-03-18 19:52:28.276109+07	2026-03-18 19:53:12.963+07
8559	1835	293	2026-03-18 19:52:28.289008+07	2026-03-18 19:53:12.963+07
8567	1836	286	2026-03-18 19:53:25.411573+07	2026-03-18 19:53:52.077+07
8568	1836	287	2026-03-18 19:53:25.570203+07	2026-03-18 19:53:52.077+07
8580	1837	286	2026-03-18 19:58:46.953238+07	2026-03-18 20:01:37.942+07
8579	1837	287	2026-03-18 19:58:46.836916+07	2026-03-18 20:01:37.942+07
8591	1838	286	2026-03-18 20:02:44.156621+07	2026-03-18 20:03:21.02+07
8590	1838	287	2026-03-18 20:02:43.83847+07	2026-03-18 20:03:21.02+07
8598	1839	292	2026-03-19 12:32:42.537167+07	2026-03-19 12:33:39.186+07
8601	1840	292	2026-03-19 12:34:23.978389+07	2026-03-19 12:34:43.594+07
8604	1841	292	2026-03-19 12:36:52.09905+07	2026-03-19 12:37:05.461+07
8607	1842	292	2026-03-19 12:37:12.402131+07	2026-03-19 12:37:36.053+07
8610	1843	292	2026-03-19 12:56:57.517736+07	2026-03-19 12:57:29.417+07
8613	1844	292	2026-03-19 12:59:03.401064+07	2026-03-19 12:59:13.193+07
8616	1845	292	2026-03-19 13:00:43.72578+07	2026-03-19 13:00:52.243+07
8619	1846	292	2026-03-19 13:08:02.886862+07	2026-03-19 13:08:15.585+07
8622	1847	292	2026-03-19 13:16:44.593032+07	2026-03-19 13:17:04.768+07
8625	1848	292	2026-03-19 13:17:45.546544+07	2026-03-19 13:18:14.725+07
8629	1849	292	2026-03-19 13:23:38.960422+07	2026-03-19 13:23:51.188+07
8632	1850	292	2026-03-19 13:24:00.371372+07	2026-03-19 13:24:15.783+07
8636	1851	292	2026-03-19 13:24:24.360413+07	2026-03-19 13:24:38.33+07
8639	1852	292	2026-03-19 13:24:59.600635+07	2026-03-19 13:25:23.248+07
8643	1853	292	2026-03-19 13:27:17.540576+07	2026-03-19 13:28:12.074+07
8647	1854	292	2026-03-19 13:30:27.700186+07	2026-03-19 13:30:59.178+07
8650	1855	292	2026-03-19 13:31:39.285125+07	2026-03-19 13:31:59.454+07
8654	1856	292	2026-03-19 13:44:25.618126+07	2026-03-19 13:44:33.582+07
8657	1857	292	2026-03-19 13:44:48.410397+07	2026-03-19 13:44:56.305+07
8661	1858	292	2026-03-19 13:54:51.537918+07	2026-03-19 13:55:24.023+07
8662	1858	293	2026-03-19 13:54:51.675692+07	2026-03-19 13:55:24.023+07
8667	1859	292	2026-03-19 13:58:23.071926+07	\N
8669	1860	292	2026-03-19 14:00:37.410143+07	2026-03-19 14:00:54.65+07
8670	1860	293	2026-03-19 14:00:37.532337+07	2026-03-19 14:00:54.65+07
8678	1861	292	2026-03-19 14:12:46.377698+07	2026-03-19 14:18:52.958+07
8679	1861	293	2026-03-19 14:12:46.455734+07	2026-03-19 14:18:52.958+07
8683	1862	292	2026-03-19 14:27:27.22269+07	2026-03-19 14:28:15.458+07
8691	1863	296	2026-03-20 10:48:21.085331+07	2026-03-20 10:49:43.462+07
8687	1863	297	2026-03-20 10:48:20.872205+07	2026-03-20 10:49:43.462+07
8688	1863	298	2026-03-20 10:48:20.963035+07	2026-03-20 10:49:43.462+07
8696	1864	296	2026-03-20 10:55:13.543669+07	2026-03-20 10:56:14.31+07
8697	1864	297	2026-03-20 10:55:13.567881+07	2026-03-20 10:56:14.31+07
8699	1864	298	2026-03-20 10:55:13.97239+07	2026-03-20 10:56:14.31+07
8698	1864	299	2026-03-20 10:55:13.629929+07	2026-03-20 10:56:14.31+07
8712	1865	296	2026-03-20 10:56:50.20402+07	2026-03-20 10:58:05.67+07
8714	1865	297	2026-03-20 10:56:50.461566+07	2026-03-20 10:58:05.67+07
8713	1865	298	2026-03-20 10:56:50.295585+07	2026-03-20 10:58:05.67+07
8715	1865	299	2026-03-20 10:56:50.490731+07	2026-03-20 10:58:05.67+07
8728	1866	296	2026-03-20 10:58:43.93756+07	2026-03-20 10:59:03.287+07
8732	1866	297	2026-03-20 10:58:44.23416+07	2026-03-20 10:59:03.287+07
8730	1866	298	2026-03-20 10:58:44.05991+07	2026-03-20 10:59:03.287+07
8729	1866	299	2026-03-20 10:58:43.980972+07	2026-03-20 10:59:03.287+07
8740	1867	296	2026-03-20 10:59:10.213084+07	2026-03-20 10:59:19.374+07
8742	1867	297	2026-03-20 10:59:10.225915+07	2026-03-20 10:59:19.374+07
8746	1867	298	2026-03-20 10:59:10.278273+07	2026-03-20 10:59:19.374+07
8744	1867	299	2026-03-20 10:59:10.256126+07	2026-03-20 10:59:19.374+07
8752	1868	296	2026-03-20 10:59:24.484879+07	2026-03-20 11:00:48.487+07
8753	1868	297	2026-03-20 10:59:24.494385+07	2026-03-20 11:00:48.487+07
8756	1868	298	2026-03-20 10:59:24.623515+07	2026-03-20 11:00:48.487+07
8755	1868	299	2026-03-20 10:59:24.609975+07	2026-03-20 11:00:48.487+07
\.


--
-- TOC entry 5270 (class 0 OID 16654)
-- Dependencies: 230
-- Data for Name: ActivityPlans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ActivityPlans" ("Plan_ID", "Class_ID", "Week", "Date_WeekPlan", "Plan_Content", "Plan_Created", "Activity_Todo", "Plan_Updated") FROM stdin;
26	55	า่นย	2026-03-16	ื่ยน่	2026-03-16 21:27:48.790058+07	[{"type": "quiz", "title": "18", "quizId": 71}]	\N
29	59	1	2026-03-09	gjdrdrrd	2026-03-20 10:20:25.232884+07	[{"type": "quiz", "title": "คณิต3", "quizId": 126}, {"type": "poll", "title": "iggiigig"}, {"type": "chat", "title": "chat"}]	\N
10	4	1	2026-02-01	Syllabus 	2026-02-25 13:52:36.585351+07	[]	\N
11	4	2	2026-03-04	unit 1-2	2026-02-25 16:15:48.893299+07	[{"type": "chat", "title": "chat"}]	\N
14	5	Week1	2026-03-02	บทที่ 1\nการบวกพื้นฐาน	2026-03-09 12:51:40.599647+07	[{"type": "quiz", "title": "คณิตศาสตร์เบื้องต้น", "quizId": 40}]	\N
21	15	;lm'm	2026-03-12	;'ln';	2026-03-12 16:23:24.775004+07	[{"type": "quiz"}]	\N
23	60	1	2026-03-02	บทที่ 1 \n- คณิตศาสตร์เบื้องต้น	2026-03-16 15:09:29.631751+07	[{"type": "quiz", "title": "คณิต2", "quizId": 117}, {"type": "chat", "title": "chat"}]	2026-03-16 17:59:10.20609+07
\.


--
-- TOC entry 5283 (class 0 OID 17095)
-- Dependencies: 243
-- Data for Name: ActivitySessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ActivitySessions" ("ActivitySession_ID", "Class_ID", "Activity_Type", "Assigned_By", "Assigned_At", "Status", "Ended_At") FROM stdin;
1	4	quiz	1	2026-01-25 15:22:12.858228+07	active	\N
2	4	poll	1	2026-01-25 15:23:04.376126+07	active	\N
3	4	quiz	1	2026-01-25 15:38:05.011514+07	active	\N
4	4	quiz	1	2026-01-25 15:41:17.920813+07	active	\N
5	4	quiz	1	2026-01-25 16:10:08.140594+07	active	\N
6	4	quiz	1	2026-01-25 16:56:51.496139+07	active	\N
7	4	quiz	1	2026-01-25 17:00:32.628808+07	active	\N
8	4	quiz	1	2026-01-25 17:08:49.577531+07	active	\N
9	4	quiz	1	2026-01-25 17:11:55.099399+07	active	\N
10	4	quiz	1	2026-01-25 17:23:55.025823+07	active	\N
11	4	quiz	1	2026-01-25 17:27:29.202418+07	active	\N
12	4	quiz	1	2026-01-25 17:28:24.097251+07	active	\N
13	4	quiz	1	2026-01-25 17:34:48.474133+07	active	\N
14	4	quiz	1	2026-01-25 17:37:58.677221+07	active	\N
15	4	quiz	1	2026-01-25 17:39:11.444522+07	active	\N
16	4	quiz	1	2026-01-25 17:43:23.468582+07	active	\N
17	4	quiz	1	2026-01-25 17:43:36.967178+07	active	\N
18	4	quiz	1	2026-01-25 17:43:54.657406+07	active	\N
19	4	quiz	1	2026-01-26 14:48:13.942128+07	active	\N
20	4	quiz	1	2026-01-26 14:48:18.906155+07	active	\N
21	4	quiz	1	2026-01-26 14:48:29.124136+07	active	\N
22	4	quiz	1	2026-01-26 14:58:55.504717+07	active	\N
23	4	quiz	1	2026-01-26 15:15:32.926804+07	active	\N
24	4	quiz	1	2026-01-26 15:16:18.157448+07	active	\N
25	4	quiz	1	2026-01-26 15:26:52.944969+07	active	\N
26	4	quiz	1	2026-01-26 15:28:13.650211+07	active	\N
27	4	quiz	1	2026-01-26 15:51:44.666845+07	active	\N
28	4	quiz	1	2026-01-26 15:52:28.871971+07	active	\N
29	4	quiz	1	2026-01-26 16:13:01.187916+07	active	\N
30	4	quiz	1	2026-01-26 16:13:14.277362+07	active	\N
31	4	quiz	1	2026-01-26 16:18:34.751499+07	active	\N
32	4	quiz	1	2026-01-26 16:19:18.109595+07	active	\N
33	4	quiz	1	2026-01-26 16:24:17.807571+07	active	\N
34	4	quiz	1	2026-01-26 16:24:27.578753+07	active	\N
35	4	quiz	1	2026-01-26 16:24:50.409252+07	active	\N
36	4	quiz	1	2026-01-26 16:35:04.729674+07	active	\N
37	4	quiz	1	2026-01-26 16:38:27.125941+07	active	\N
38	4	quiz	1	2026-01-26 16:39:48.182674+07	active	\N
39	4	quiz	1	2026-02-01 13:47:27.569255+07	active	\N
40	4	quiz	1	2026-02-01 13:47:46.023331+07	active	\N
41	4	quiz	1	2026-02-01 13:49:27.346409+07	active	\N
42	4	quiz	1	2026-02-01 13:49:34.044449+07	active	\N
43	4	quiz	1	2026-02-01 13:54:50.670428+07	active	\N
1564	5	quiz	1	2026-03-11 14:15:35.69856+07	finished	2026-03-11 14:16:27.854559+07
1579	5	quiz	1	2026-03-11 16:43:55.281749+07	finished	2026-03-11 17:10:08.456119+07
1594	4	quiz	1	2026-03-12 09:23:12.19963+07	active	\N
50	4	quiz	1	2026-02-01 14:14:44.793422+07	active	\N
51	4	quiz	1	2026-02-01 14:16:26.592147+07	active	\N
52	4	quiz	1	2026-02-01 14:17:34.654567+07	active	\N
53	4	quiz	1	2026-02-01 14:17:45.345362+07	active	\N
54	4	quiz	1	2026-02-01 14:19:14.374432+07	active	\N
55	4	quiz	1	2026-02-01 14:20:49.945127+07	active	\N
56	4	quiz	1	2026-02-01 14:23:18.089888+07	active	\N
57	4	quiz	1	2026-02-01 14:23:43.292711+07	active	\N
58	4	quiz	1	2026-02-01 14:23:59.771922+07	active	\N
59	4	quiz	1	2026-02-01 14:24:24.809824+07	active	\N
60	4	quiz	1	2026-02-01 14:28:45.162357+07	active	\N
61	4	quiz	1	2026-02-01 14:32:05.67928+07	active	\N
1595	4	quiz	1	2026-03-12 09:23:42.738768+07	finished	2026-03-12 09:23:47.944904+07
1610	13	quiz	1	2026-03-12 11:03:26.779483+07	active	\N
1624	5	quiz	1	2026-03-12 12:24:24.445875+07	finished	2026-03-12 12:25:42.656949+07
66	4	quiz	1	2026-02-01 14:54:38.658811+07	active	\N
67	4	quiz	1	2026-02-01 14:58:23.28954+07	active	\N
68	4	quiz	1	2026-02-01 14:58:41.951598+07	active	\N
69	4	quiz	1	2026-02-01 14:59:36.524891+07	active	\N
70	4	quiz	1	2026-02-01 15:00:54.721602+07	active	\N
71	4	quiz	1	2026-02-01 15:02:33.283353+07	active	\N
72	4	quiz	1	2026-02-01 15:03:24.977104+07	active	\N
1637	5	quiz	1	2026-03-12 14:57:05.784589+07	finished	2026-03-12 14:57:11.788449+07
76	4	quiz	1	2026-02-01 15:06:33.997506+07	active	\N
77	4	quiz	1	2026-02-01 15:07:44.839535+07	active	\N
78	4	quiz	1	2026-02-01 15:09:02.854236+07	active	\N
79	4	quiz	1	2026-02-01 15:10:45.833491+07	active	\N
80	4	quiz	1	2026-02-01 15:12:06.456256+07	active	\N
81	4	quiz	1	2026-02-01 15:12:16.712445+07	active	\N
82	4	quiz	1	2026-02-01 15:13:40.240726+07	active	\N
1649	5	quiz	1	2026-03-12 15:16:31.895627+07	finished	2026-03-12 15:16:49.473129+07
1661	5	quiz	1	2026-03-14 17:27:30.587156+07	finished	2026-03-14 17:27:32.384205+07
86	4	quiz	1	2026-02-01 15:18:29.961752+07	active	\N
87	4	quiz	1	2026-02-01 15:18:47.478148+07	active	\N
1673	5	quiz	1	2026-03-14 18:05:32.627219+07	finished	2026-03-14 18:07:53.149292+07
90	4	quiz	1	2026-02-01 15:24:53.950734+07	active	\N
91	4	quiz	1	2026-02-01 15:25:37.410882+07	active	\N
93	4	quiz	1	2026-02-01 15:30:10.478218+07	active	\N
94	4	quiz	1	2026-02-01 15:30:49.193808+07	active	\N
1677	5	quiz	1	2026-03-15 12:39:48.283663+07	finished	2026-03-15 12:39:57.624016+07
1689	5	quiz	1	2026-03-15 13:24:22.787355+07	finished	2026-03-15 13:26:16.923487+07
1699	5	poll	1	2026-03-15 13:43:33.56138+07	finished	2026-03-15 14:03:40.656166+07
99	4	quiz	1	2026-02-01 15:37:27.965026+07	active	\N
1714	5	poll	1	2026-03-15 14:24:03.570469+07	finished	2026-03-15 14:27:47.108093+07
1724	5	poll	1	2026-03-15 14:50:58.255794+07	finished	2026-03-15 14:51:09.510615+07
102	4	quiz	1	2026-02-01 15:39:46.400259+07	active	\N
1737	5	poll	1	2026-03-15 15:32:52.086211+07	finished	2026-03-15 15:36:09.046851+07
105	4	quiz	1	2026-02-01 15:42:52.150242+07	active	\N
106	4	quiz	1	2026-02-01 15:45:20.213575+07	active	\N
107	4	quiz	1	2026-02-01 15:46:02.264486+07	active	\N
1747	5	quiz	1	2026-03-15 16:46:26.133794+07	finished	2026-03-15 16:46:37.812383+07
1748	5	quiz	1	2026-03-15 16:46:44.027379+07	finished	2026-03-15 16:46:51.641845+07
1755	55	quiz	1	2026-03-16 16:44:52.411673+07	finished	2026-03-16 16:45:04.059626+07
1766	55	poll	1	2026-03-16 17:59:56.992102+07	finished	2026-03-16 18:00:04.953865+07
1777	55	quiz	1	2026-03-16 19:51:24.714256+07	finished	2026-03-16 19:51:32.391714+07
1791	55	quiz	1	2026-03-16 23:06:14.854959+07	finished	2026-03-18 13:10:05.33353+07
1801	60	poll	24	2026-03-18 13:55:09.213788+07	finished	2026-03-18 13:55:17.967606+07
1812	17	quiz	24	2026-03-18 17:21:50.647593+07	finished	2026-03-18 17:22:03.306625+07
1823	17	chat	24	2026-03-18 19:28:40.808711+07	finished	2026-03-18 19:36:06.89155+07
1834	17	quiz	24	2026-03-18 19:50:26.968576+07	finished	2026-03-18 19:52:17.069315+07
1845	17	quiz	24	2026-03-19 13:00:43.603996+07	finished	2026-03-19 13:00:52.243524+07
1856	17	quiz	24	2026-03-19 13:44:25.27851+07	finished	2026-03-19 13:44:33.582998+07
1857	17	quiz	24	2026-03-19 13:44:48.303199+07	finished	2026-03-19 13:44:56.305875+07
1863	14	quiz	1	2026-03-20 10:48:20.705776+07	finished	2026-03-20 10:49:43.462408+07
1565	5	quiz	1	2026-03-11 14:21:10.41616+07	finished	2026-03-11 14:33:33.922808+07
1580	5	quiz	1	2026-03-11 16:45:17.399787+07	finished	2026-03-11 16:45:34.272564+07
1596	5	quiz	1	2026-03-12 10:07:32.189628+07	finished	2026-03-12 10:07:48.804562+07
1611	13	quiz	1	2026-03-12 11:04:14.46584+07	active	\N
1625	5	quiz	1	2026-03-12 12:26:25.558637+07	finished	2026-03-12 12:26:45.303754+07
1638	5	quiz	1	2026-03-12 14:57:23.540603+07	finished	2026-03-12 14:57:51.674181+07
1650	5	poll	1	2026-03-12 15:17:02.419875+07	finished	2026-03-12 15:17:15.659216+07
1662	5	quiz	1	2026-03-14 17:27:48.092656+07	finished	2026-03-14 17:27:54.455528+07
137	4	quiz	1	2026-02-01 17:13:59.778395+07	active	\N
138	4	quiz	1	2026-02-01 17:17:13.593478+07	active	\N
139	4	quiz	1	2026-02-01 17:19:37.852783+07	active	\N
140	4	quiz	1	2026-02-01 17:20:42.947681+07	active	\N
1674	5	quiz	1	2026-03-14 18:08:07.415092+07	finished	2026-03-14 18:10:57.846218+07
1678	5	quiz	1	2026-03-15 12:42:35.299934+07	finished	2026-03-15 12:42:39.057585+07
1690	5	poll	1	2026-03-15 13:29:35.365111+07	finished	2026-03-15 13:31:43.285475+07
147	4	quiz	1	2026-02-01 17:45:36.871746+07	active	\N
1702	5	poll	1	2026-03-15 14:05:04.878546+07	finished	2026-03-15 14:05:08.209665+07
1715	5	poll	1	2026-03-15 14:27:51.244177+07	finished	2026-03-15 14:31:39.024326+07
152	4	quiz	1	2026-02-01 17:53:11.401756+07	active	\N
1727	5	poll	1	2026-03-15 14:52:11.609962+07	finished	2026-03-15 14:52:18.093134+07
156	4	quiz	1	2026-02-01 18:06:50.109663+07	active	\N
1738	5	quiz	1	2026-03-15 15:37:57.658211+07	finished	2026-03-15 15:38:08.148959+07
1749	5	quiz	1	2026-03-15 16:47:10.329912+07	finished	2026-03-15 16:47:26.471355+07
1756	55	quiz	1	2026-03-16 16:55:31.836598+07	finished	2026-03-16 17:33:16.90574+07
1767	55	quiz	1	2026-03-16 18:30:03.532349+07	finished	2026-03-16 19:13:03.787309+07
1778	55	poll	1	2026-03-16 19:52:08.895788+07	finished	2026-03-16 19:52:14.343392+07
166	4	quiz	1	2026-02-01 18:23:47.371989+07	active	\N
167	4	quiz	1	2026-02-01 18:29:13.871322+07	active	\N
169	4	quiz	1	2026-02-01 18:37:35.860557+07	active	\N
1792	55	quiz	1	2026-03-18 13:00:01.700463+07	finished	2026-03-18 13:10:05.33353+07
1802	55	poll	1	2026-03-18 13:56:02.067987+07	finished	2026-03-18 13:56:07.300931+07
1813	17	quiz	24	2026-03-18 17:24:44.497805+07	finished	2026-03-18 17:34:08.668285+07
1824	17	quiz	24	2026-03-18 19:39:05.274526+07	finished	2026-03-18 19:40:00.933351+07
177	4	quiz	1	2026-02-01 19:13:43.464149+07	active	\N
178	4	quiz	1	2026-02-01 19:19:50.16823+07	active	\N
1835	17	quiz	24	2026-03-18 19:52:28.173004+07	finished	2026-03-18 19:53:12.963053+07
1846	17	quiz	24	2026-03-19 13:08:02.696895+07	finished	2026-03-19 13:08:15.585613+07
1858	17	poll	24	2026-03-19 13:54:51.320188+07	finished	2026-03-19 13:55:24.023051+07
1864	14	quiz	1	2026-03-20 10:55:13.490416+07	finished	2026-03-20 10:56:14.310045+07
221	4	quiz	1	2026-02-02 16:53:23.690066+07	finished	2026-02-04 15:02:11.773758+07
211	4	quiz	1	2026-02-02 16:11:23.583117+07	finished	2026-02-04 15:29:08.045862+07
121	5	quiz	1	2026-02-01 16:28:21.938448+07	finished	2026-03-11 14:14:32.381553+07
1566	5	quiz	1	2026-03-11 14:34:10.243031+07	finished	2026-03-11 14:35:46.198555+07
1581	5	quiz	1	2026-03-11 16:45:40.691963+07	finished	2026-03-11 16:45:51.694758+07
1597	5	quiz	1	2026-03-12 10:13:41.713269+07	finished	2026-03-12 10:14:27.613675+07
1626	5	quiz	1	2026-03-12 12:33:18.484589+07	finished	2026-03-12 12:33:28.178713+07
1612	5	quiz	1	2026-03-12 11:10:16.018795+07	finished	2026-03-12 12:47:57.869932+07
1639	5	quiz	1	2026-03-12 14:58:10.394557+07	finished	2026-03-12 15:03:55.660479+07
1651	5	chat	1	2026-03-12 15:17:21.700867+07	finished	2026-03-12 15:17:30.30469+07
1663	5	quiz	1	2026-03-14 17:28:04.165214+07	finished	2026-03-14 17:28:14.85041+07
1675	5	quiz	1	2026-03-14 18:11:05.247733+07	finished	2026-03-14 18:11:16.531419+07
1679	5	poll	1	2026-03-15 12:58:01.639322+07	finished	2026-03-15 12:58:17.419737+07
1691	5	poll	1	2026-03-15 13:31:48.697176+07	finished	2026-03-15 13:34:46.738341+07
1703	5	poll	1	2026-03-15 14:05:20.454758+07	finished	2026-03-15 14:05:25.46608+07
1705	5	poll	1	2026-03-15 14:05:49.501533+07	finished	2026-03-15 14:05:52.981914+07
1716	5	poll	1	2026-03-15 14:31:43.283322+07	finished	2026-03-15 14:31:52.853035+07
1728	5	poll	1	2026-03-15 14:52:39.303759+07	finished	2026-03-15 14:52:51.991866+07
199	4	quiz	1	2026-02-02 15:06:01.714984+07	finished	2026-02-04 15:02:16.886873+07
196	4	quiz	1	2026-02-02 14:07:15.32188+07	finished	2026-02-04 15:02:22.145509+07
1739	5	quiz	1	2026-03-15 15:38:22.21486+07	finished	2026-03-15 15:38:28.714346+07
1750	5	quiz	1	2026-03-15 16:47:38.94353+07	finished	2026-03-15 16:47:50.500289+07
1757	55	chat	1	2026-03-16 17:19:34.905907+07	finished	2026-03-16 17:19:57.168019+07
1768	55	quiz	1	2026-03-16 18:30:26.604338+07	finished	2026-03-16 19:13:03.787309+07
1779	55	chat	1	2026-03-16 19:52:20.400343+07	finished	2026-03-16 20:06:05.705359+07
1793	55	quiz	1	2026-03-18 13:07:40.039269+07	finished	2026-03-18 13:08:23.994596+07
1803	60	chat	24	2026-03-18 13:56:13.012184+07	finished	2026-03-18 13:57:03.821286+07
1814	17	quiz	24	2026-03-18 17:51:54.502756+07	finished	2026-03-18 17:52:03.286594+07
1825	17	quiz	24	2026-03-18 19:41:01.601523+07	finished	2026-03-18 19:41:47.235314+07
292	4	quiz	1	2026-02-09 13:51:43.095323+07	active	\N
293	4	quiz	1	2026-02-09 13:56:07.237738+07	active	\N
294	4	quiz	1	2026-02-09 14:13:28.631601+07	active	\N
1836	55	quiz	1	2026-03-18 19:53:25.250041+07	finished	2026-03-18 19:58:20.048358+07
297	4	quiz	1	2026-02-09 14:32:58.653227+07	active	\N
1847	17	quiz	24	2026-03-19 13:16:44.430241+07	finished	2026-03-19 13:17:04.768563+07
1859	17	quiz	24	2026-03-19 13:58:22.898817+07	finished	2026-03-19 13:58:51.732932+07
1865	14	quiz	1	2026-03-20 10:56:50.15468+07	finished	2026-03-20 10:58:05.670218+07
310	4	quiz	1	2026-02-09 16:04:11.59391+07	active	\N
315	4	quiz	1	2026-02-09 16:26:07.025677+07	active	\N
320	4	quiz	1	2026-02-09 17:23:49.905311+07	active	\N
334	4	quiz	1	2026-02-09 18:06:16.887629+07	active	\N
1567	5	quiz	1	2026-03-11 14:35:59.685231+07	finished	2026-03-11 14:40:33.737849+07
1582	5	quiz	1	2026-03-11 16:46:03.330545+07	finished	2026-03-11 16:46:27.702533+07
1598	5	quiz	1	2026-03-12 10:14:35.311611+07	finished	2026-03-12 10:14:39.890526+07
1613	13	quiz	1	2026-03-12 11:19:45.153114+07	finished	2026-03-12 11:20:22.726235+07
1627	5	quiz	1	2026-03-12 12:37:11.860523+07	finished	2026-03-12 12:37:23.549648+07
1640	5	quiz	1	2026-03-12 15:04:57.921323+07	finished	2026-03-12 15:05:10.009945+07
1652	5	quiz	1	2026-03-12 16:21:38.249009+07	finished	2026-03-12 16:21:47.093738+07
1664	5	quiz	1	2026-03-14 17:28:22.508396+07	finished	2026-03-14 17:28:35.190536+07
1676	5	quiz	1	2026-03-14 18:16:11.24536+07	finished	2026-03-14 18:16:14.574057+07
1680	5	poll	1	2026-03-15 13:01:37.570359+07	finished	2026-03-15 13:01:50.304333+07
1692	5	poll	1	2026-03-15 13:34:51.464972+07	finished	2026-03-15 14:03:40.656166+07
381	4	quiz	1	2026-02-10 10:54:29.458785+07	active	\N
382	4	quiz	1	2026-02-10 10:56:42.92711+07	active	\N
383	4	quiz	1	2026-02-10 10:57:06.068982+07	active	\N
384	4	quiz	1	2026-02-10 11:11:18.25557+07	active	\N
385	4	quiz	1	2026-02-10 11:17:33.587314+07	active	\N
1704	5	poll	1	2026-03-15 14:05:34.992171+07	finished	2026-03-15 14:05:39.452289+07
389	4	quiz	1	2026-02-10 11:22:04.471202+07	active	\N
1717	5	poll	1	2026-03-15 14:31:57.597586+07	finished	2026-03-15 14:33:43.288588+07
391	4	quiz	1	2026-02-10 11:26:42.418523+07	active	\N
392	4	quiz	1	2026-02-10 11:28:16.583757+07	active	\N
393	4	quiz	1	2026-02-10 11:34:14.606325+07	active	\N
1729	5	poll	1	2026-03-15 14:52:57.166118+07	finished	2026-03-15 14:53:05.301124+07
1740	5	chat	1	2026-03-15 15:46:43.477213+07	finished	2026-03-15 15:46:49.499068+07
398	4	quiz	1	2026-02-10 11:47:41.428909+07	active	\N
1751	5	quiz	1	2026-03-15 16:49:14.862472+07	finished	2026-03-15 16:51:51.128952+07
1758	55	chat	1	2026-03-16 17:33:57.577267+07	finished	2026-03-16 17:34:21.00306+07
1769	55	quiz	1	2026-03-16 19:23:10.77699+07	finished	2026-03-16 19:53:46.930828+07
1780	60	quiz	24	2026-03-16 19:58:43.357859+07	finished	2026-03-16 19:58:52.588631+07
407	4	quiz	1	2026-02-11 14:04:57.132648+07	active	\N
408	4	quiz	1	2026-02-11 14:06:07.942396+07	active	\N
409	4	quiz	1	2026-02-11 14:06:28.047902+07	active	\N
1789	55	quiz	1	2026-03-16 22:41:53.575917+07	finished	2026-03-18 13:10:05.33353+07
411	4	quiz	1	2026-02-11 14:07:16.008928+07	active	\N
413	4	quiz	1	2026-02-11 14:12:09.834843+07	active	\N
414	4	quiz	1	2026-02-11 14:12:45.203131+07	active	\N
415	4	quiz	1	2026-02-11 14:13:03.671525+07	active	\N
416	4	quiz	1	2026-02-11 14:13:19.477133+07	active	\N
417	4	quiz	1	2026-02-11 14:13:33.809566+07	active	\N
1804	55	quiz	1	2026-03-18 14:10:34.352389+07	finished	2026-03-18 14:15:12.168166+07
420	4	quiz	1	2026-02-11 14:17:23.534929+07	active	\N
421	4	quiz	1	2026-02-11 14:18:06.435352+07	active	\N
422	4	quiz	1	2026-02-11 14:18:38.627674+07	active	\N
423	4	quiz	1	2026-02-11 14:19:04.576597+07	active	\N
1815	17	quiz	24	2026-03-18 17:54:32.257958+07	finished	2026-03-18 17:55:38.075494+07
1826	17	quiz	24	2026-03-18 19:43:18.99747+07	finished	2026-03-18 19:43:28.960279+07
1837	55	quiz	1	2026-03-18 19:58:46.785602+07	finished	2026-03-18 20:01:37.942988+07
1848	17	quiz	24	2026-03-19 13:17:45.430058+07	finished	2026-03-19 13:18:14.7251+07
1860	17	quiz	24	2026-03-19 14:00:37.316333+07	finished	2026-03-19 14:00:54.650993+07
1866	14	poll	1	2026-03-20 10:58:43.864597+07	finished	2026-03-20 10:59:03.287641+07
469	5	quiz	1	2026-02-12 13:26:31.020372+07	finished	2026-02-12 13:27:32.149013+07
470	5	quiz	1	2026-02-12 13:29:49.490277+07	finished	2026-02-12 13:30:03.044723+07
471	5	quiz	1	2026-02-12 13:31:05.085589+07	finished	2026-02-12 13:31:09.129179+07
472	5	quiz	1	2026-02-12 13:32:00.531316+07	finished	2026-02-12 13:32:06.94891+07
473	5	quiz	1	2026-02-12 13:33:00.701631+07	finished	2026-02-12 13:33:12.773784+07
474	4	quiz	1	2026-02-12 13:33:51.962624+07	active	\N
358	5	quiz	1	2026-02-10 09:10:53.245433+07	finished	2026-03-11 14:14:32.381553+07
475	4	quiz	1	2026-02-12 13:34:01.610494+07	finished	2026-02-12 13:34:08.07311+07
477	4	quiz	1	2026-02-12 13:34:52.948819+07	finished	2026-02-12 13:35:17.294059+07
478	4	quiz	1	2026-02-12 13:38:39.193063+07	finished	2026-02-12 13:38:52.229404+07
1568	5	quiz	1	2026-03-11 14:40:46.364441+07	finished	2026-03-11 14:40:50.578554+07
1583	5	quiz	1	2026-03-11 16:46:41.760475+07	finished	2026-03-11 17:10:08.456119+07
483	4	quiz	1	2026-02-12 15:12:39.774433+07	finished	2026-02-12 15:13:02.075398+07
1599	5	quiz	1	2026-03-12 10:15:51.83505+07	finished	2026-03-12 10:16:03.137402+07
1614	5	quiz	1	2026-03-12 11:20:47.836817+07	finished	2026-03-12 11:21:01.793738+07
1628	5	quiz	1	2026-03-12 12:55:23.45328+07	finished	2026-03-12 12:55:41.204027+07
489	4	quiz	1	2026-02-15 13:38:28.503504+07	active	\N
490	4	quiz	1	2026-02-15 13:53:00.6435+07	active	\N
491	4	quiz	1	2026-02-15 14:00:42.533167+07	active	\N
492	4	quiz	1	2026-02-15 14:01:50.740527+07	active	\N
493	4	quiz	1	2026-02-15 14:02:11.437586+07	active	\N
494	4	quiz	1	2026-02-15 14:02:47.214645+07	active	\N
495	4	quiz	1	2026-02-15 14:03:06.26387+07	active	\N
497	4	quiz	1	2026-02-15 14:17:05.058027+07	active	\N
498	4	quiz	1	2026-02-15 14:18:56.803033+07	active	\N
499	4	quiz	1	2026-02-15 14:23:51.770492+07	active	\N
500	4	quiz	1	2026-02-15 14:24:33.098814+07	active	\N
501	4	quiz	1	2026-02-15 14:25:08.962272+07	active	\N
502	4	quiz	1	2026-02-15 14:25:20.936954+07	finished	2026-02-15 14:25:30.280223+07
503	4	quiz	1	2026-02-15 14:25:36.841695+07	active	\N
504	4	quiz	1	2026-02-15 14:29:08.176271+07	active	\N
1629	5	quiz	1	2026-03-12 12:55:49.723345+07	finished	2026-03-12 13:26:49.88467+07
507	4	quiz	1	2026-02-15 14:36:50.639925+07	active	\N
508	4	quiz	1	2026-02-15 14:57:16.540411+07	active	\N
509	4	quiz	1	2026-02-15 15:10:35.118446+07	active	\N
510	4	quiz	1	2026-02-15 15:11:48.951008+07	active	\N
511	4	quiz	1	2026-02-15 15:22:51.288203+07	active	\N
1641	5	quiz	1	2026-03-12 15:11:46.638291+07	finished	2026-03-12 15:12:01.017337+07
513	4	quiz	1	2026-02-15 15:25:59.081227+07	active	\N
1653	5	quiz	1	2026-03-14 16:59:10.13196+07	finished	2026-03-14 16:59:25.896474+07
517	4	quiz	1	2026-02-15 15:34:53.130286+07	active	\N
1665	5	quiz	1	2026-03-14 17:29:13.56684+07	finished	2026-03-14 17:29:34.799233+07
1681	5	poll	1	2026-03-15 13:04:03.080055+07	finished	2026-03-15 13:04:22.130146+07
521	4	quiz	1	2026-02-15 15:49:35.753014+07	active	\N
1693	5	poll	1	2026-03-15 13:35:30.730844+07	finished	2026-03-15 13:35:47.415495+07
1706	5	poll	1	2026-03-15 14:06:14.658633+07	finished	2026-03-15 14:06:32.759868+07
1718	5	poll	1	2026-03-15 14:34:51.397257+07	finished	2026-03-15 14:34:58.089938+07
526	4	quiz	1	2026-02-15 16:05:16.70252+07	finished	2026-02-15 16:09:07.794211+07
1730	5	poll	1	2026-03-15 14:53:09.162611+07	finished	2026-03-15 14:53:19.198515+07
530	4	quiz	1	2026-02-15 16:13:34.946099+07	finished	2026-02-15 16:14:44.820422+07
1741	5	chat	1	2026-03-15 15:58:50.519339+07	finished	2026-03-15 16:01:44.971203+07
1752	5	quiz	1	2026-03-15 16:52:32.099294+07	finished	2026-03-15 16:52:41.445723+07
1759	55	poll	1	2026-03-16 17:39:06.632366+07	finished	2026-03-16 17:40:23.045392+07
1770	55	quiz	1	2026-03-16 19:30:22.515068+07	finished	2026-03-16 19:53:46.930828+07
1781	60	quiz	24	2026-03-16 19:59:09.277326+07	finished	2026-03-16 19:59:16.832351+07
543	4	quiz	1	2026-02-15 16:45:43.808157+07	finished	2026-02-15 16:47:02.064927+07
1782	60	quiz	24	2026-03-16 19:59:23.047646+07	finished	2026-03-16 19:59:31.145351+07
1783	60	quiz	24	2026-03-16 19:59:35.916102+07	finished	2026-03-16 19:59:43.91738+07
1794	55	quiz	1	2026-03-18 13:11:04.092315+07	finished	2026-03-18 13:11:29.225229+07
550	4	quiz	1	2026-02-15 17:01:53.021268+07	finished	2026-02-15 17:02:16.988051+07
551	1	quiz	1	2026-02-15 17:08:08.915233+07	finished	2026-02-15 17:08:53.59635+07
552	1	quiz	1	2026-02-15 17:12:24.113119+07	finished	2026-02-15 17:12:54.611306+07
553	1	quiz	1	2026-02-15 17:13:07.122189+07	finished	2026-02-15 17:15:50.179275+07
554	4	quiz	1	2026-02-15 17:22:27.301959+07	finished	2026-02-15 17:24:05.086547+07
555	4	quiz	1	2026-02-15 17:24:47.746539+07	active	\N
556	4	quiz	1	2026-02-15 17:46:51.206845+07	finished	2026-02-15 17:49:25.660099+07
557	4	quiz	1	2026-02-15 17:49:40.274705+07	active	\N
1805	55	quiz	1	2026-03-18 14:15:58.464441+07	finished	2026-03-18 14:22:41.97048+07
1816	17	quiz	24	2026-03-18 17:55:46.039872+07	finished	2026-03-18 17:56:04.465397+07
1827	17	quiz	24	2026-03-18 19:43:34.316887+07	finished	2026-03-18 19:43:53.56991+07
1838	55	quiz	1	2026-03-18 20:02:43.756883+07	finished	2026-03-18 20:03:21.020442+07
1849	17	quiz	24	2026-03-19 13:23:38.819233+07	finished	2026-03-19 13:23:51.188098+07
1861	17	poll	24	2026-03-19 14:12:46.231649+07	finished	2026-03-19 14:18:52.958459+07
1867	14	poll	1	2026-03-20 10:59:10.177896+07	finished	2026-03-20 10:59:19.374857+07
570	4	quiz	1	2026-02-18 13:53:20.573869+07	finished	2026-02-18 14:01:49.28424+07
572	4	quiz	1	2026-02-18 14:02:04.188277+07	active	\N
576	4	quiz	1	2026-02-18 14:10:45.456224+07	active	\N
580	4	quiz	1	2026-02-18 14:18:18.821411+07	active	\N
584	4	quiz	1	2026-02-18 14:21:11.141754+07	active	\N
588	4	quiz	1	2026-02-18 14:26:26.945842+07	active	\N
589	4	quiz	1	2026-02-18 14:26:52.208493+07	active	\N
590	4	quiz	1	2026-02-18 14:27:28.239305+07	finished	2026-02-18 14:28:00.793605+07
1569	5	quiz	1	2026-03-11 14:41:04.917003+07	finished	2026-03-11 15:48:25.125341+07
1584	5	quiz	1	2026-03-11 16:47:06.329086+07	finished	2026-03-11 17:10:08.456119+07
1600	5	quiz	1	2026-03-12 10:16:08.939383+07	finished	2026-03-12 10:16:12.07435+07
1615	5	quiz	1	2026-03-12 11:57:49.401643+07	finished	2026-03-12 11:58:02.185926+07
1630	5	quiz	1	2026-03-12 12:56:20.600325+07	finished	2026-03-12 12:58:23.738431+07
1642	5	quiz	1	2026-03-12 15:12:59.073596+07	finished	2026-03-12 15:13:22.943052+07
1654	5	quiz	1	2026-03-14 17:16:38.313075+07	finished	2026-03-14 17:16:42.784681+07
1666	5	quiz	1	2026-03-14 17:31:25.646521+07	finished	2026-03-14 17:31:37.537432+07
1682	5	poll	1	2026-03-15 13:14:00.614619+07	finished	2026-03-15 13:16:46.820115+07
610	4	quiz	1	2026-02-18 14:56:11.817425+07	finished	2026-02-18 14:56:54.38194+07
1694	5	poll	1	2026-03-15 13:35:51.984457+07	finished	2026-03-15 13:35:57.604421+07
613	4	quiz	1	2026-02-18 15:05:32.106373+07	finished	2026-02-18 15:06:18.196517+07
1707	5	poll	1	2026-03-15 14:06:56.222111+07	finished	2026-03-15 14:07:00.390721+07
1719	5	poll	1	2026-03-15 14:35:12.85246+07	finished	2026-03-15 14:38:20.856921+07
618	4	quiz	1	2026-02-18 15:12:23.337608+07	active	\N
619	4	quiz	1	2026-02-18 15:12:39.984516+07	active	\N
617	4	quiz	1	2026-02-18 15:11:49.657166+07	finished	2026-02-18 15:14:32.43653+07
620	4	quiz	1	2026-02-18 15:14:44.607417+07	finished	2026-02-18 15:14:53.996033+07
621	4	quiz	1	2026-02-18 15:15:39.176+07	active	\N
622	4	quiz	1	2026-02-18 15:16:08.120167+07	finished	2026-02-18 15:17:47.961578+07
623	4	quiz	1	2026-02-18 15:18:22.476431+07	finished	2026-02-18 15:19:28.087997+07
1731	5	poll	1	2026-03-15 14:53:58.216008+07	finished	2026-03-15 14:54:00.321074+07
624	4	quiz	1	2026-02-18 15:21:15.304496+07	finished	2026-02-18 15:22:41.557539+07
1725	5	poll	1	2026-03-15 14:51:01.909984+07	finished	2026-03-15 16:20:14.523083+07
1753	5	quiz	1	2026-03-15 16:52:50.483617+07	finished	2026-03-15 16:53:01.81412+07
1760	55	poll	1	2026-03-16 17:41:27.682117+07	finished	2026-03-16 19:13:03.787309+07
1771	55	quiz	1	2026-03-16 19:31:12.570377+07	finished	2026-03-16 19:53:46.930828+07
1784	60	quiz	24	2026-03-16 19:59:56.746666+07	finished	2026-03-16 20:17:18.843387+07
1795	55	quiz	1	2026-03-18 13:18:00.045858+07	finished	2026-03-18 13:18:31.235133+07
1806	55	quiz	1	2026-03-18 14:23:55.640277+07	finished	2026-03-18 14:24:26.35335+07
1817	17	quiz	24	2026-03-18 17:56:10.281909+07	finished	2026-03-18 17:56:37.515968+07
641	4	quiz	1	2026-02-19 14:01:55.677973+07	active	\N
1828	17	quiz	24	2026-03-18 19:44:00.423075+07	finished	2026-03-18 19:44:44.038495+07
644	4	quiz	1	2026-02-19 14:04:40.452842+07	active	\N
1839	17	quiz	24	2026-03-19 12:32:42.327106+07	finished	2026-03-19 12:33:39.186919+07
1850	17	quiz	24	2026-03-19 13:24:00.295389+07	finished	2026-03-19 13:24:15.783206+07
1862	17	chat	24	2026-03-19 14:27:26.968854+07	finished	2026-03-19 14:28:15.458314+07
1868	14	chat	1	2026-03-20 10:59:24.449771+07	finished	2026-03-20 11:00:48.487309+07
655	4	quiz	1	2026-02-19 14:30:22.783567+07	active	\N
656	4	quiz	1	2026-02-19 14:33:38.856821+07	active	\N
657	4	quiz	1	2026-02-19 14:47:07.523385+07	active	\N
658	4	quiz	1	2026-02-19 14:52:17.096815+07	finished	2026-02-19 14:55:10.649618+07
659	4	quiz	1	2026-02-19 14:56:14.37734+07	finished	2026-02-19 14:57:15.287946+07
666	4	quiz	1	2026-02-19 15:11:38.402172+07	finished	2026-02-19 15:11:55.398462+07
680	4	quiz	1	2026-02-19 15:41:31.911684+07	active	\N
684	4	quiz	1	2026-02-19 15:46:51.124476+07	active	\N
687	4	quiz	1	2026-02-19 15:52:18.644828+07	active	\N
690	4	quiz	1	2026-02-19 15:57:32.612505+07	active	\N
694	4	quiz	1	2026-02-19 16:02:53.021371+07	active	\N
1570	5	quiz	1	2026-03-11 15:48:47.88602+07	finished	2026-03-11 16:05:39.698741+07
1585	5	quiz	1	2026-03-11 16:54:50.013779+07	finished	2026-03-11 16:55:03.569135+07
1601	13	quiz	1	2026-03-12 10:18:57.792519+07	finished	2026-03-12 10:20:48.730708+07
1616	5	quiz	1	2026-03-12 12:00:24.81774+07	finished	2026-03-12 12:00:39.903851+07
1631	5	quiz	1	2026-03-12 12:58:50.985564+07	finished	2026-03-12 13:08:29.496175+07
1643	5	quiz	1	2026-03-12 15:13:39.297235+07	finished	2026-03-12 15:13:59.614233+07
1655	5	quiz	1	2026-03-14 17:16:54.634632+07	finished	2026-03-14 17:16:56.836004+07
1667	5	quiz	1	2026-03-14 17:31:46.143739+07	finished	2026-03-14 17:31:49.132977+07
1683	5	poll	1	2026-03-15 13:16:53.871666+07	finished	2026-03-15 13:17:13.98538+07
1695	5	poll	1	2026-03-15 13:36:06.381139+07	finished	2026-03-15 13:37:47.59061+07
1708	5	poll	1	2026-03-15 14:10:53.867398+07	finished	2026-03-15 14:10:57.400722+07
1720	5	poll	1	2026-03-15 14:38:30.503897+07	finished	2026-03-15 14:49:06.390611+07
1732	5	chat	1	2026-03-15 14:56:01.492337+07	finished	2026-03-15 14:56:05.16093+07
1742	5	quiz	1	2026-03-15 16:21:27.295072+07	finished	2026-03-15 16:22:18.066736+07
1754	5	quiz	1	2026-03-15 16:53:56.74697+07	finished	2026-03-15 16:54:08.828304+07
1761	55	poll	1	2026-03-16 17:43:22.840791+07	finished	2026-03-16 19:13:03.787309+07
1772	55	quiz	1	2026-03-16 19:32:17.104698+07	finished	2026-03-16 19:53:46.930828+07
1785	60	poll	24	2026-03-16 20:19:02.689681+07	finished	2026-03-16 20:26:31.411267+07
742	4	quiz	1	2026-02-22 13:58:18.31075+07	active	\N
1796	55	quiz	1	2026-03-18 13:30:00.197321+07	finished	2026-03-18 13:32:51.029886+07
745	4	quiz	1	2026-02-22 14:02:46.333244+07	finished	2026-02-22 14:04:35.939516+07
1807	55	quiz	1	2026-03-18 14:32:12.338614+07	finished	2026-03-18 14:36:27.775173+07
749	4	quiz	1	2026-02-22 14:06:45.995455+07	active	\N
1818	17	quiz	24	2026-03-18 18:47:30.294924+07	finished	2026-03-18 18:47:36.027749+07
1829	17	quiz	24	2026-03-18 19:45:18.496909+07	finished	2026-03-18 19:46:17.243189+07
753	4	quiz	1	2026-02-22 14:11:41.003422+07	active	\N
1840	17	quiz	24	2026-03-19 12:34:23.842611+07	finished	2026-03-19 12:34:43.594405+07
757	4	quiz	1	2026-02-22 14:16:11.29275+07	active	\N
1851	17	quiz	24	2026-03-19 13:24:24.261218+07	finished	2026-03-19 13:24:38.33018+07
769	4	quiz	1	2026-02-22 14:24:24.976691+07	active	\N
770	4	quiz	1	2026-02-22 14:25:07.539645+07	active	\N
776	4	quiz	1	2026-02-22 14:29:07.60721+07	active	\N
779	4	quiz	1	2026-02-22 14:30:56.393758+07	active	\N
780	4	quiz	1	2026-02-22 14:31:23.708774+07	active	\N
781	4	quiz	1	2026-02-22 14:38:02.770094+07	active	\N
784	4	quiz	1	2026-02-22 14:44:34.721217+07	active	\N
788	4	quiz	1	2026-02-22 14:46:30.114364+07	active	\N
794	4	quiz	1	2026-02-22 14:54:42.279078+07	active	\N
807	4	quiz	1	2026-02-22 15:06:33.849671+07	active	\N
808	4	quiz	1	2026-02-22 15:10:22.857378+07	active	\N
811	4	quiz	1	2026-02-22 15:11:55.78111+07	active	\N
813	4	quiz	1	2026-02-22 15:13:39.378819+07	active	\N
820	4	quiz	1	2026-02-22 15:17:22.130339+07	active	\N
1571	5	quiz	1	2026-03-11 16:05:54.63286+07	finished	2026-03-11 16:06:21.383213+07
1586	5	quiz	1	2026-03-11 16:55:30.429073+07	finished	2026-03-11 16:55:47.782038+07
1602	13	quiz	1	2026-03-12 10:21:51.807248+07	finished	2026-03-12 10:22:35.407825+07
1617	5	quiz	1	2026-03-12 12:03:48.707976+07	finished	2026-03-12 12:04:01.413877+07
1632	5	quiz	1	2026-03-12 13:08:39.803048+07	finished	2026-03-12 13:09:11.355367+07
1644	5	quiz	1	2026-03-12 15:14:18.352618+07	finished	2026-03-12 15:14:38.446028+07
1656	5	quiz	1	2026-03-14 17:17:04.775865+07	finished	2026-03-14 17:17:06.303527+07
1668	5	quiz	1	2026-03-14 17:33:30.636+07	finished	2026-03-14 17:38:23.053696+07
1684	5	poll	1	2026-03-15 13:18:04.657432+07	finished	2026-03-15 13:19:34.809505+07
1696	5	poll	1	2026-03-15 13:37:51.85577+07	finished	2026-03-15 14:03:40.656166+07
1709	5	poll	1	2026-03-15 14:18:47.215338+07	finished	2026-03-15 14:18:52.49839+07
1721	5	poll	1	2026-03-15 14:49:10.45658+07	finished	2026-03-15 14:49:16.888313+07
1733	5	chat	1	2026-03-15 15:00:22.969665+07	finished	2026-03-15 15:00:25.148851+07
1743	5	quiz	1	2026-03-15 16:22:48.498866+07	finished	2026-03-15 16:23:06.391791+07
1762	55	poll	1	2026-03-16 17:54:57.903899+07	finished	2026-03-16 19:13:03.787309+07
856	4	quiz	1	2026-02-22 15:56:51.605782+07	active	\N
1773	55	quiz	1	2026-03-16 19:46:50.688347+07	finished	2026-03-16 19:47:15.047709+07
1786	60	poll	24	2026-03-16 20:26:57.79737+07	finished	2026-03-16 20:27:07.499158+07
1797	55	quiz	1	2026-03-18 13:37:06.217029+07	finished	2026-03-18 13:37:41.05255+07
862	4	quiz	1	2026-02-22 16:04:21.024837+07	finished	2026-02-22 16:05:25.794892+07
863	4	quiz	1	2026-02-22 16:06:09.793312+07	finished	2026-02-22 16:07:17.086376+07
864	4	quiz	1	2026-02-22 16:07:46.04312+07	active	\N
865	4	quiz	1	2026-02-22 16:09:12.151663+07	active	\N
866	4	quiz	1	2026-02-22 16:12:54.639174+07	active	\N
867	4	quiz	1	2026-02-22 16:20:59.821043+07	active	\N
868	4	quiz	1	2026-02-22 16:24:23.743983+07	active	\N
869	4	quiz	1	2026-02-22 16:27:21.761661+07	active	\N
870	4	quiz	1	2026-02-22 16:28:03.19653+07	active	\N
1808	55	quiz	1	2026-03-18 14:36:20.858826+07	finished	2026-03-18 14:36:27.775173+07
1819	17	quiz	24	2026-03-18 18:49:05.610444+07	finished	2026-03-18 18:49:13.475694+07
1830	17	quiz	24	2026-03-18 19:46:25.633086+07	finished	2026-03-18 19:46:55.60023+07
1841	17	quiz	24	2026-03-19 12:36:51.9915+07	finished	2026-03-19 12:37:05.461659+07
1852	17	quiz	24	2026-03-19 13:24:59.496241+07	finished	2026-03-19 13:25:23.248652+07
1572	5	quiz	1	2026-03-11 16:06:55.142317+07	finished	2026-03-11 16:09:18.615238+07
1587	5	quiz	1	2026-03-11 17:02:12.661615+07	finished	2026-03-11 17:02:18.596237+07
1603	13	quiz	1	2026-03-12 10:46:14.265626+07	finished	2026-03-12 10:46:32.075755+07
1618	5	quiz	1	2026-03-12 12:07:53.208416+07	finished	2026-03-12 12:09:14.871432+07
1633	5	quiz	1	2026-03-12 14:48:54.729583+07	finished	2026-03-12 14:49:03.407219+07
1645	5	quiz	1	2026-03-12 15:14:50.715672+07	finished	2026-03-12 15:15:09.135168+07
1657	5	quiz	1	2026-03-14 17:18:26.814103+07	finished	2026-03-14 17:18:39.015904+07
1669	5	quiz	1	2026-03-14 17:43:47.116348+07	finished	2026-03-14 17:45:03.898258+07
1685	5	poll	1	2026-03-15 13:19:45.536761+07	finished	2026-03-15 13:20:54.177914+07
1697	5	poll	1	2026-03-15 13:40:32.58708+07	finished	2026-03-15 13:43:00.988776+07
1710	5	poll	1	2026-03-15 14:21:53.664462+07	finished	2026-03-15 14:22:00.611033+07
1722	5	poll	1	2026-03-15 14:49:23.888248+07	finished	2026-03-15 14:50:41.483055+07
1734	5	poll	1	2026-03-15 15:13:01.022417+07	finished	2026-03-15 15:13:05.138623+07
1744	5	quiz	1	2026-03-15 16:23:11.67101+07	finished	2026-03-15 16:23:16.624228+07
1763	55	poll	1	2026-03-16 17:56:02.022495+07	finished	2026-03-16 19:13:03.787309+07
1774	55	quiz	1	2026-03-16 19:48:25.058797+07	finished	2026-03-16 19:53:46.930828+07
1787	60	chat	24	2026-03-16 20:27:19.506202+07	finished	2026-03-18 12:30:53.631861+07
1798	55	quiz	1	2026-03-18 13:44:42.16495+07	finished	2026-03-18 13:45:40.212063+07
1809	60	quiz	24	2026-03-18 14:57:15.503504+07	finished	2026-03-18 14:58:55.312392+07
1820	17	quiz	24	2026-03-18 19:01:40.301484+07	finished	2026-03-18 19:07:20.257525+07
1831	17	quiz	24	2026-03-18 19:47:11.880225+07	finished	2026-03-18 19:48:06.451648+07
1842	17	quiz	24	2026-03-19 12:37:12.316766+07	finished	2026-03-19 12:37:36.053043+07
1853	17	quiz	24	2026-03-19 13:27:17.439522+07	finished	2026-03-19 13:28:12.074055+07
992	12	quiz	1	2026-02-25 16:09:13.618+07	active	\N
993	12	quiz	1	2026-02-25 16:09:57.508587+07	finished	2026-02-25 16:14:05.064062+07
996	4	quiz	1	2026-03-02 14:30:46.376703+07	active	\N
997	4	quiz	1	2026-03-02 14:31:23.376817+07	finished	2026-03-02 14:34:28.12614+07
999	4	quiz	1	2026-03-02 15:11:36.253969+07	finished	2026-03-02 15:19:22.782453+07
1001	4	quiz	1	2026-03-02 15:20:05.272077+07	finished	2026-03-02 15:20:14.261555+07
1002	4	quiz	1	2026-03-02 15:20:24.762298+07	finished	2026-03-02 15:20:59.562068+07
1003	4	quiz	1	2026-03-02 15:21:23.37824+07	finished	2026-03-02 15:22:35.082969+07
1004	4	quiz	1	2026-03-02 15:23:11.627087+07	finished	2026-03-02 15:23:25.908558+07
1005	4	quiz	1	2026-03-02 15:24:12.099484+07	finished	2026-03-02 15:24:53.666482+07
1007	4	quiz	1	2026-03-02 15:26:53.635042+07	active	\N
1008	5	quiz	1	2026-03-02 15:31:28.380853+07	finished	2026-03-02 15:31:50.235845+07
1009	5	quiz	1	2026-03-02 15:35:15.50896+07	finished	2026-03-02 15:35:22.303305+07
1011	5	quiz	1	2026-03-02 15:37:18.25133+07	finished	2026-03-02 15:37:37.20308+07
1012	5	quiz	1	2026-03-02 15:37:47.180761+07	finished	2026-03-02 15:37:53.193321+07
1013	5	quiz	1	2026-03-02 15:38:03.386751+07	finished	2026-03-02 15:38:23.587168+07
1014	5	quiz	1	2026-03-02 15:38:32.487453+07	finished	2026-03-02 15:38:49.138035+07
1015	5	quiz	1	2026-03-02 15:38:57.133275+07	finished	2026-03-02 15:39:15.473597+07
1016	5	quiz	1	2026-03-02 15:39:28.760316+07	finished	2026-03-02 15:39:41.721023+07
1010	4	quiz	1	2026-03-02 15:36:10.78399+07	finished	2026-03-02 15:43:33.194853+07
1018	4	quiz	1	2026-03-02 15:43:58.662753+07	finished	2026-03-02 15:46:43.309253+07
1020	5	quiz	1	2026-03-02 15:46:51.662769+07	finished	2026-03-02 15:47:01.39217+07
1021	4	quiz	1	2026-03-02 15:46:57.220386+07	finished	2026-03-02 15:52:42.255174+07
1022	4	quiz	1	2026-03-02 15:52:52.684617+07	active	\N
1023	4	quiz	1	2026-03-02 15:55:23.148803+07	finished	2026-03-02 15:55:46.419237+07
1019	4	quiz	1	2026-03-02 15:46:00.466964+07	finished	2026-03-02 16:11:17.201819+07
1024	4	quiz	1	2026-03-02 15:55:58.034767+07	finished	2026-03-02 16:11:25.098555+07
1025	4	quiz	1	2026-03-02 16:11:32.843603+07	finished	2026-03-02 16:12:04.994027+07
1026	4	quiz	1	2026-03-02 16:15:01.833596+07	finished	2026-03-02 16:15:32.220995+07
1027	4	quiz	1	2026-03-02 16:15:40.447341+07	active	\N
1030	4	quiz	1	2026-03-02 16:28:26.29452+07	active	\N
1031	4	quiz	1	2026-03-02 16:30:08.462149+07	active	\N
1033	4	quiz	1	2026-03-02 16:31:11.672161+07	finished	2026-03-02 16:34:34.802844+07
1035	4	quiz	1	2026-03-02 16:35:51.600431+07	active	\N
1036	4	quiz	1	2026-03-02 16:37:57.276102+07	active	\N
1041	4	quiz	1	2026-03-02 16:47:36.328085+07	finished	2026-03-02 16:50:15.761368+07
1044	4	quiz	1	2026-03-02 16:50:24.837756+07	finished	2026-03-02 16:50:30.952961+07
1045	4	quiz	1	2026-03-02 16:50:50.52695+07	finished	2026-03-02 16:51:21.95247+07
1046	4	quiz	1	2026-03-02 16:51:29.631861+07	finished	2026-03-02 16:51:56.063279+07
1047	4	quiz	1	2026-03-02 16:52:01.069005+07	finished	2026-03-02 16:52:08.87976+07
1048	4	quiz	1	2026-03-02 16:52:21.689243+07	finished	2026-03-02 16:56:34.714107+07
1050	4	quiz	1	2026-03-02 17:29:18.419576+07	active	\N
1051	4	quiz	1	2026-03-02 17:29:44.773885+07	active	\N
1054	4	quiz	1	2026-03-04 13:10:41.723687+07	finished	2026-03-04 13:10:51.467342+07
1055	4	quiz	1	2026-03-04 13:11:19.007855+07	finished	2026-03-04 13:11:23.339147+07
1058	3	quiz	1	2026-03-04 13:18:34.013036+07	active	\N
1573	5	quiz	1	2026-03-11 16:09:41.958838+07	finished	2026-03-11 16:19:05.085338+07
1060	5	quiz	1	2026-03-04 13:24:34.978009+07	finished	2026-03-04 13:24:50.182764+07
1056	4	quiz	1	2026-03-04 13:12:00.545224+07	finished	2026-03-04 13:31:38.596842+07
1062	5	quiz	1	2026-03-04 13:38:43.996916+07	finished	2026-03-04 13:39:02.529395+07
1061	4	quiz	1	2026-03-04 13:31:45.724197+07	finished	2026-03-04 13:46:04.401139+07
1064	4	quiz	1	2026-03-04 13:50:12.434786+07	active	\N
1065	4	quiz	1	2026-03-04 14:04:40.699798+07	finished	2026-03-04 14:06:55.763879+07
1066	4	quiz	1	2026-03-04 14:07:04.260511+07	finished	2026-03-04 14:07:18.029036+07
1067	4	quiz	1	2026-03-04 14:07:32.676814+07	finished	2026-03-04 14:07:41.073557+07
1068	4	quiz	1	2026-03-04 14:07:48.781836+07	finished	2026-03-04 14:08:11.315886+07
1069	4	quiz	1	2026-03-04 14:08:24.367911+07	finished	2026-03-04 14:08:44.362749+07
1070	4	quiz	1	2026-03-04 14:08:58.765888+07	active	\N
1071	4	quiz	1	2026-03-04 14:09:29.549029+07	active	\N
1588	5	quiz	1	2026-03-11 17:02:29.98261+07	finished	2026-03-11 17:02:41.202707+07
1072	4	quiz	1	2026-03-04 14:09:58.131659+07	finished	2026-03-04 14:16:17.67334+07
1075	4	quiz	1	2026-03-04 14:16:56.49174+07	finished	2026-03-04 14:26:51.302416+07
1076	4	quiz	1	2026-03-04 14:27:47.741081+07	active	\N
1604	13	quiz	1	2026-03-12 10:51:09.013105+07	finished	2026-03-12 10:51:45.420687+07
1080	5	quiz	1	2026-03-04 14:39:28.460552+07	finished	2026-03-04 14:39:50.953058+07
1619	5	poll	1	2026-03-12 12:13:41.827345+07	finished	2026-03-12 12:13:46.130792+07
1078	4	quiz	1	2026-03-04 14:33:06.152568+07	finished	2026-03-04 14:40:28.9022+07
1634	5	quiz	1	2026-03-12 14:49:15.780377+07	finished	2026-03-12 14:55:02.360742+07
1646	5	quiz	1	2026-03-12 15:15:24.759496+07	finished	2026-03-12 15:15:42.771669+07
1084	4	quiz	1	2026-03-04 14:41:14.465552+07	finished	2026-03-04 14:44:04.908359+07
1087	4	quiz	1	2026-03-04 14:44:59.423734+07	finished	2026-03-04 14:47:54.125742+07
1658	5	quiz	1	2026-03-14 17:18:48.14077+07	finished	2026-03-14 17:21:52.2434+07
1091	4	quiz	1	2026-03-04 14:55:23.047925+07	active	\N
1670	5	quiz	1	2026-03-14 18:00:21.730677+07	finished	2026-03-14 18:33:50.068974+07
1686	5	quiz	1	2026-03-15 13:21:44.597783+07	finished	2026-03-15 13:22:30.37715+07
1698	5	poll	1	2026-03-15 13:43:06.70418+07	finished	2026-03-15 13:43:15.313102+07
1711	5	poll	1	2026-03-15 14:22:19.840122+07	finished	2026-03-15 14:22:26.235026+07
1096	4	quiz	1	2026-03-04 15:03:45.331479+07	finished	2026-03-04 15:19:55.207411+07
1723	5	poll	1	2026-03-15 14:50:45.005422+07	finished	2026-03-15 14:50:50.991495+07
1735	5	poll	1	2026-03-15 15:13:16.947023+07	finished	2026-03-15 15:13:20.607882+07
1745	5	quiz	1	2026-03-15 16:45:37.854513+07	finished	2026-03-15 16:45:50.273315+07
1764	55	poll	1	2026-03-16 17:59:16.276415+07	finished	2026-03-16 17:59:24.039287+07
1775	55	quiz	1	2026-03-16 19:49:21.824345+07	finished	2026-03-16 19:50:03.551542+07
1788	55	quiz	1	2026-03-16 21:46:07.100943+07	finished	2026-03-18 13:10:05.33353+07
1799	55	quiz	1	2026-03-18 13:47:42.050238+07	finished	2026-03-18 13:48:08.909329+07
1821	17	quiz	24	2026-03-18 19:09:31.048013+07	finished	2026-03-18 19:09:56.461549+07
1832	17	quiz	24	2026-03-18 19:48:42.740183+07	finished	2026-03-18 19:49:06.690706+07
1119	5	quiz	1	2026-03-04 16:59:01.12502+07	finished	2026-03-04 16:59:35.804268+07
1810	55	quiz	1	2026-03-18 15:00:41.469485+07	finished	2026-03-18 20:02:00.640843+07
1843	17	quiz	24	2026-03-19 12:56:57.396602+07	finished	2026-03-19 12:57:29.417045+07
1123	4	quiz	1	2026-03-04 17:13:36.050933+07	finished	2026-03-04 17:15:01.079193+07
1124	4	quiz	1	2026-03-04 17:15:35.443294+07	finished	2026-03-04 17:16:15.502878+07
1854	17	quiz	24	2026-03-19 13:30:27.4298+07	finished	2026-03-19 13:30:59.17849+07
1126	4	quiz	1	2026-03-04 17:17:29.729476+07	finished	2026-03-04 17:39:48.026463+07
1144	4	quiz	1	2026-03-04 17:55:29.679953+07	finished	2026-03-04 17:55:38.705844+07
1145	11	quiz	1	2026-03-04 17:56:33.661033+07	finished	2026-03-04 17:56:42.114266+07
1166	5	quiz	1	2026-03-05 14:00:44.123655+07	finished	2026-03-05 14:01:36.208202+07
1167	5	quiz	1	2026-03-05 14:01:53.172789+07	finished	2026-03-05 14:06:05.555509+07
1168	5	quiz	1	2026-03-05 14:06:18.033259+07	finished	2026-03-05 14:06:49.648087+07
1169	5	quiz	1	2026-03-05 14:07:00.237411+07	finished	2026-03-05 14:07:48.916662+07
1170	5	quiz	1	2026-03-05 14:09:30.460033+07	finished	2026-03-05 14:09:56.890731+07
1171	5	quiz	1	2026-03-05 14:10:50.535981+07	finished	2026-03-05 14:11:20.116972+07
1172	5	quiz	1	2026-03-05 14:11:31.673818+07	finished	2026-03-05 14:22:06.489456+07
1574	5	quiz	1	2026-03-11 16:23:56.860155+07	finished	2026-03-11 16:24:17.410496+07
1175	5	quiz	1	2026-03-05 15:00:52.765705+07	finished	2026-03-05 15:01:25.896075+07
1176	5	quiz	1	2026-03-05 15:01:35.516476+07	finished	2026-03-05 15:02:01.03487+07
1177	5	quiz	1	2026-03-05 15:02:13.644057+07	finished	2026-03-05 15:02:42.908399+07
1178	5	quiz	1	2026-03-05 15:02:57.525869+07	finished	2026-03-05 15:03:33.796439+07
1179	5	quiz	1	2026-03-05 15:03:52.082921+07	finished	2026-03-05 15:08:40.301171+07
1180	5	quiz	1	2026-03-05 15:20:57.201833+07	finished	2026-03-05 15:21:16.953349+07
1182	5	quiz	1	2026-03-05 15:25:14.168167+07	finished	2026-03-05 15:25:40.490223+07
1183	5	quiz	1	2026-03-05 15:25:51.126749+07	finished	2026-03-05 15:26:02.249228+07
1184	5	quiz	1	2026-03-05 15:26:12.82673+07	finished	2026-03-05 15:26:42.85633+07
1589	5	quiz	1	2026-03-11 17:02:50.424523+07	finished	2026-03-11 17:03:11.181137+07
1187	5	quiz	1	2026-03-05 15:41:58.243999+07	finished	2026-03-05 15:42:08.8717+07
1188	5	quiz	1	2026-03-05 15:42:22.429565+07	finished	2026-03-05 15:46:15.959642+07
1189	5	quiz	1	2026-03-05 15:46:34.627209+07	finished	2026-03-05 15:47:03.947871+07
1190	5	quiz	1	2026-03-05 15:47:14.278186+07	finished	2026-03-05 15:47:42.159393+07
1191	5	quiz	1	2026-03-05 15:47:54.991996+07	finished	2026-03-05 15:48:09.669812+07
1192	5	quiz	1	2026-03-05 15:55:01.576431+07	finished	2026-03-05 15:55:15.658668+07
1193	5	quiz	1	2026-03-05 15:56:56.617691+07	finished	2026-03-05 15:57:16.259117+07
1194	5	quiz	1	2026-03-05 16:01:42.578848+07	finished	2026-03-05 16:02:05.25436+07
1195	5	quiz	1	2026-03-05 16:02:21.609764+07	finished	2026-03-05 16:02:27.412584+07
1196	5	quiz	1	2026-03-05 16:02:40.058027+07	finished	2026-03-05 16:02:53.818991+07
1197	5	quiz	1	2026-03-05 16:03:06.233673+07	finished	2026-03-05 16:03:16.962291+07
1605	13	quiz	1	2026-03-12 10:52:31.877303+07	finished	2026-03-12 10:53:01.056235+07
1199	5	quiz	1	2026-03-05 16:10:56.743789+07	finished	2026-03-05 16:11:08.671846+07
1200	5	quiz	1	2026-03-05 16:11:19.172009+07	finished	2026-03-05 16:11:31.754732+07
1201	5	quiz	1	2026-03-05 16:11:50.196035+07	finished	2026-03-05 16:12:02.057573+07
1202	5	quiz	1	2026-03-05 16:12:10.094704+07	finished	2026-03-05 16:12:22.720753+07
1203	5	quiz	1	2026-03-05 16:12:34.826524+07	finished	2026-03-05 16:12:40.167814+07
1204	5	quiz	1	2026-03-05 16:12:53.703841+07	finished	2026-03-05 16:13:06.532604+07
1205	5	quiz	1	2026-03-05 16:13:18.515882+07	finished	2026-03-05 16:13:33.725798+07
1206	5	quiz	1	2026-03-05 16:13:46.06648+07	finished	2026-03-05 16:13:56.316843+07
1207	5	quiz	1	2026-03-05 16:14:07.863061+07	finished	2026-03-05 16:14:17.065596+07
1208	5	quiz	1	2026-03-05 16:14:21.865347+07	finished	2026-03-05 16:14:29.903509+07
1209	5	quiz	1	2026-03-05 16:14:38.296306+07	finished	2026-03-05 16:14:44.631276+07
1210	4	quiz	1	2026-03-05 16:50:17.524879+07	finished	2026-03-05 16:51:15.794227+07
1211	4	quiz	1	2026-03-05 16:51:40.326857+07	finished	2026-03-05 16:51:55.022577+07
1212	4	quiz	1	2026-03-05 16:52:15.191789+07	finished	2026-03-05 16:53:01.406969+07
1213	4	quiz	1	2026-03-05 16:55:25.353316+07	finished	2026-03-05 16:55:31.261784+07
1214	4	quiz	1	2026-03-05 16:57:18.28408+07	active	\N
1215	4	quiz	1	2026-03-05 17:01:53.216602+07	finished	2026-03-05 17:03:07.898532+07
1216	5	quiz	1	2026-03-08 13:15:50.262452+07	finished	2026-03-08 13:16:21.281933+07
1217	5	quiz	1	2026-03-08 13:18:29.855066+07	finished	2026-03-08 13:18:58.726909+07
1218	5	quiz	1	2026-03-08 13:19:24.414803+07	finished	2026-03-08 13:19:55.043172+07
1219	5	quiz	1	2026-03-08 13:21:22.862355+07	finished	2026-03-08 13:22:04.700587+07
1220	5	quiz	1	2026-03-08 13:24:06.708129+07	finished	2026-03-08 13:24:39.286526+07
1221	5	quiz	1	2026-03-08 13:42:11.373116+07	finished	2026-03-08 13:42:31.336479+07
1222	5	quiz	1	2026-03-08 13:44:13.877997+07	finished	2026-03-08 13:44:30.949896+07
1223	5	quiz	1	2026-03-08 13:45:02.135996+07	finished	2026-03-08 13:45:28.770082+07
1224	5	quiz	1	2026-03-08 13:46:46.055838+07	finished	2026-03-08 13:47:05.949007+07
1225	5	quiz	1	2026-03-08 13:48:26.522088+07	finished	2026-03-08 13:48:35.719769+07
1226	5	quiz	1	2026-03-08 13:50:47.168485+07	finished	2026-03-08 13:51:03.114227+07
1227	5	quiz	1	2026-03-08 13:51:24.118837+07	finished	2026-03-08 13:51:42.695145+07
1228	5	quiz	1	2026-03-08 13:51:54.748227+07	finished	2026-03-08 13:52:13.938705+07
1229	5	quiz	1	2026-03-08 13:55:43.900472+07	finished	2026-03-08 13:55:55.575137+07
1230	5	quiz	1	2026-03-08 13:56:05.274441+07	finished	2026-03-08 13:56:14.314592+07
1231	5	quiz	1	2026-03-08 14:03:50.782721+07	finished	2026-03-08 14:04:00.019537+07
1232	5	quiz	1	2026-03-08 14:04:07.68745+07	finished	2026-03-08 14:04:13.116952+07
1233	5	quiz	1	2026-03-08 14:04:22.635451+07	finished	2026-03-08 14:04:33.406738+07
1234	5	quiz	1	2026-03-08 14:04:41.811171+07	finished	2026-03-08 14:04:55.524742+07
1235	5	quiz	1	2026-03-08 14:05:12.6067+07	finished	2026-03-08 14:05:34.136198+07
1236	5	quiz	1	2026-03-08 14:05:53.219014+07	finished	2026-03-08 14:06:36.106425+07
1237	5	quiz	1	2026-03-08 14:06:46.759853+07	finished	2026-03-08 14:07:00.066443+07
1238	5	quiz	1	2026-03-08 14:07:13.105968+07	finished	2026-03-08 14:07:33.628556+07
1239	5	quiz	1	2026-03-08 14:07:47.463521+07	finished	2026-03-08 14:25:10.123488+07
1240	5	quiz	1	2026-03-08 14:25:30.956267+07	finished	2026-03-08 14:25:40.589092+07
1241	5	quiz	1	2026-03-08 14:25:46.256984+07	finished	2026-03-08 14:25:54.940431+07
1242	5	quiz	1	2026-03-08 14:26:02.569424+07	finished	2026-03-08 14:26:06.562013+07
1243	5	quiz	1	2026-03-08 14:26:48.848462+07	finished	2026-03-08 14:27:22.894845+07
1244	5	quiz	1	2026-03-08 14:27:42.791165+07	finished	2026-03-08 14:28:08.59133+07
1245	5	quiz	1	2026-03-08 14:28:18.544095+07	finished	2026-03-08 14:28:41.623879+07
1246	5	quiz	1	2026-03-08 14:28:59.683134+07	finished	2026-03-08 14:40:20.683955+07
1247	5	quiz	1	2026-03-08 14:44:20.941712+07	finished	2026-03-08 14:44:56.951458+07
1248	5	quiz	1	2026-03-08 14:45:06.519681+07	finished	2026-03-08 14:45:20.214067+07
1249	5	quiz	1	2026-03-08 14:45:33.017692+07	finished	2026-03-08 14:45:47.890995+07
1250	5	quiz	1	2026-03-08 14:45:58.643995+07	finished	2026-03-08 14:46:07.394272+07
1251	5	quiz	1	2026-03-08 14:46:32.385918+07	finished	2026-03-08 14:46:52.312977+07
1252	4	poll	1	2026-03-08 14:46:55.706188+07	active	\N
1253	5	quiz	1	2026-03-08 14:47:09.468088+07	finished	2026-03-08 14:47:18.796439+07
1254	5	quiz	1	2026-03-08 14:47:27.025179+07	finished	2026-03-08 14:47:36.909914+07
1255	5	quiz	1	2026-03-08 14:47:42.642581+07	finished	2026-03-08 14:47:48.406867+07
1256	5	quiz	1	2026-03-08 14:47:54.509959+07	finished	2026-03-08 14:48:07.343947+07
1257	5	quiz	1	2026-03-08 14:48:24.334782+07	finished	2026-03-08 14:48:41.88934+07
1258	5	quiz	1	2026-03-08 14:49:12.879678+07	finished	2026-03-08 14:49:52.269852+07
1259	4	poll	1	2026-03-08 14:49:52.385386+07	active	\N
1620	5	chat	1	2026-03-12 12:14:40.908823+07	finished	2026-03-12 12:14:58.074462+07
1262	5	quiz	1	2026-03-08 14:55:03.918555+07	finished	2026-03-08 14:55:31.214625+07
1263	5	quiz	1	2026-03-08 14:55:44.446839+07	finished	2026-03-08 14:56:10.233017+07
1265	4	poll	1	2026-03-08 14:56:33.562631+07	active	\N
1264	5	quiz	1	2026-03-08 14:56:20.816331+07	finished	2026-03-08 14:56:46.226558+07
1266	5	quiz	1	2026-03-08 14:57:08.24655+07	finished	2026-03-08 14:57:21.842264+07
1267	5	quiz	1	2026-03-08 14:57:33.939653+07	finished	2026-03-08 14:57:59.505699+07
1268	5	quiz	1	2026-03-08 14:58:15.829604+07	finished	2026-03-08 14:58:28.254294+07
1270	4	poll	1	2026-03-08 14:59:02.297701+07	active	\N
1269	5	quiz	1	2026-03-08 14:58:46.61356+07	finished	2026-03-08 14:59:12.028275+07
1271	5	quiz	1	2026-03-08 15:00:10.501214+07	finished	2026-03-08 15:00:33.240101+07
1272	5	quiz	1	2026-03-08 15:00:55.652432+07	finished	2026-03-08 15:01:18.599042+07
1274	4	poll	1	2026-03-08 15:01:44.646975+07	active	\N
1273	5	quiz	1	2026-03-08 15:01:31.394795+07	finished	2026-03-08 15:01:45.9955+07
1275	5	quiz	1	2026-03-08 15:02:04.529417+07	finished	2026-03-08 15:02:21.068574+07
1276	5	quiz	1	2026-03-08 15:02:39.394387+07	finished	2026-03-08 15:03:05.144883+07
1278	5	quiz	1	2026-03-08 15:04:42.844926+07	finished	2026-03-08 15:05:09.077187+07
1279	5	quiz	1	2026-03-08 15:05:17.33866+07	finished	2026-03-08 15:05:33.539762+07
1280	5	quiz	1	2026-03-08 15:05:49.994918+07	finished	2026-03-08 15:06:04.131182+07
1281	5	quiz	1	2026-03-08 15:06:23.623653+07	finished	2026-03-08 15:06:53.0835+07
1282	5	quiz	1	2026-03-08 15:07:07.886919+07	finished	2026-03-08 15:07:36.313562+07
1283	4	poll	1	2026-03-08 15:09:25.976751+07	active	\N
1284	4	poll	1	2026-03-08 15:12:17.225004+07	active	\N
1286	4	poll	1	2026-03-08 15:22:13.301403+07	active	\N
1285	5	quiz	1	2026-03-08 15:20:03.63411+07	finished	2026-03-08 15:24:02.769192+07
1287	5	quiz	1	2026-03-08 15:24:17.808592+07	finished	2026-03-08 15:24:36.374726+07
1288	5	quiz	1	2026-03-08 15:24:55.508183+07	finished	2026-03-08 15:25:05.697311+07
1289	5	quiz	1	2026-03-08 15:25:28.748572+07	finished	2026-03-08 15:25:50.293648+07
1291	4	poll	1	2026-03-08 15:26:40.247119+07	active	\N
1290	5	quiz	1	2026-03-08 15:26:13.462591+07	finished	2026-03-08 15:26:46.161273+07
1292	5	quiz	1	2026-03-08 15:27:03.470642+07	finished	2026-03-08 15:27:25.777336+07
1293	5	quiz	1	2026-03-08 15:27:40.138638+07	finished	2026-03-08 15:27:49.213073+07
1294	4	poll	1	2026-03-08 15:27:57.899796+07	active	\N
1295	4	poll	1	2026-03-08 15:28:20.177498+07	active	\N
1296	5	quiz	1	2026-03-08 15:28:52.244251+07	finished	2026-03-08 15:29:11.716566+07
1297	5	quiz	1	2026-03-08 15:29:32.800758+07	finished	2026-03-08 15:29:46.695775+07
1298	5	quiz	1	2026-03-08 15:30:01.503368+07	finished	2026-03-08 15:30:24.318419+07
1299	5	quiz	1	2026-03-08 15:30:34.889176+07	finished	2026-03-08 15:30:44.34646+07
1300	5	quiz	1	2026-03-08 15:31:04.542667+07	finished	2026-03-08 15:31:23.301764+07
1301	5	quiz	1	2026-03-08 15:31:33.808297+07	finished	2026-03-08 15:31:47.066717+07
1302	4	poll	1	2026-03-08 15:33:08.841338+07	active	\N
1303	4	poll	1	2026-03-08 15:33:26.16542+07	active	\N
1304	4	poll	1	2026-03-08 15:35:45.996947+07	active	\N
1305	4	poll	1	2026-03-08 15:37:28.390883+07	active	\N
1306	4	poll	1	2026-03-08 15:38:47.039752+07	active	\N
1575	5	quiz	1	2026-03-11 16:24:47.068829+07	finished	2026-03-11 16:25:50.74664+07
1308	4	poll	1	2026-03-08 15:49:08.66173+07	active	\N
1590	5	quiz	1	2026-03-11 17:03:19.067133+07	finished	2026-03-11 17:03:37.076143+07
1606	5	quiz	1	2026-03-12 10:59:07.639715+07	finished	2026-03-12 10:59:32.449019+07
1314	4	poll	1	2026-03-08 16:14:00.105925+07	active	\N
1315	4	poll	1	2026-03-08 16:15:25.992039+07	active	\N
1316	4	poll	1	2026-03-08 16:17:57.472674+07	active	\N
1621	14	quiz	1	2026-03-12 12:15:30.942305+07	finished	2026-03-12 12:16:04.856937+07
1318	4	poll	1	2026-03-08 16:18:30.775098+07	active	\N
1319	4	poll	1	2026-03-08 16:21:45.998991+07	active	\N
1635	5	quiz	1	2026-03-12 14:55:14.650931+07	finished	2026-03-12 14:55:24.935055+07
1321	5	quiz	1	2026-03-08 16:27:05.954492+07	finished	2026-03-08 16:27:27.699296+07
1322	5	quiz	1	2026-03-08 16:27:46.362678+07	finished	2026-03-08 16:28:01.650928+07
1323	5	quiz	1	2026-03-08 16:28:12.016448+07	finished	2026-03-08 16:28:21.419629+07
1647	5	quiz	1	2026-03-12 15:15:55.750713+07	finished	2026-03-12 15:16:06.706108+07
1325	5	quiz	1	2026-03-08 16:29:21.207539+07	finished	2026-03-08 16:29:40.614126+07
1326	5	quiz	1	2026-03-08 16:30:48.625779+07	finished	2026-03-08 16:31:00.585411+07
1327	4	poll	1	2026-03-08 16:33:03.095661+07	active	\N
1328	5	quiz	1	2026-03-08 16:33:05.716372+07	finished	2026-03-08 16:33:17.417567+07
1329	5	quiz	1	2026-03-08 16:33:27.323359+07	finished	2026-03-08 16:33:38.718916+07
1330	4	poll	1	2026-03-08 16:34:19.101321+07	active	\N
1331	4	poll	1	2026-03-08 16:35:36.690272+07	active	\N
1332	5	quiz	1	2026-03-08 16:37:53.367972+07	finished	2026-03-08 16:38:11.334165+07
1333	5	quiz	1	2026-03-08 16:38:21.076054+07	finished	2026-03-08 16:38:30.767952+07
1334	5	quiz	1	2026-03-08 16:38:41.58664+07	finished	2026-03-08 16:38:55.420556+07
1659	5	quiz	1	2026-03-14 17:21:59.917778+07	finished	2026-03-14 17:22:14.821915+07
1671	5	quiz	1	2026-03-14 18:00:41.541979+07	finished	2026-03-14 18:02:02.789191+07
1687	5	quiz	1	2026-03-15 13:22:53.195694+07	finished	2026-03-15 13:23:15.330389+07
1338	4	poll	1	2026-03-08 16:51:08.558102+07	active	\N
1339	4	poll	1	2026-03-08 16:52:15.803078+07	active	\N
1340	4	quiz	1	2026-03-08 16:53:24.789567+07	finished	2026-03-08 16:53:59.20025+07
1341	4	poll	1	2026-03-08 16:54:34.175799+07	active	\N
1342	5	quiz	1	2026-03-08 16:56:28.925888+07	finished	2026-03-08 16:56:43.486919+07
1343	5	quiz	1	2026-03-08 16:56:52.905791+07	finished	2026-03-08 16:57:05.324412+07
1344	5	quiz	1	2026-03-08 16:57:23.681072+07	finished	2026-03-08 16:57:30.921843+07
1345	5	quiz	1	2026-03-08 16:58:04.045734+07	finished	2026-03-08 16:58:13.761777+07
1346	5	quiz	1	2026-03-08 16:58:22.510014+07	finished	2026-03-08 16:58:36.524948+07
1347	5	quiz	1	2026-03-08 16:58:42.255813+07	finished	2026-03-08 16:58:47.35433+07
1348	4	poll	1	2026-03-08 17:00:10.102054+07	active	\N
1349	4	poll	1	2026-03-08 17:00:51.657817+07	active	\N
1350	4	poll	1	2026-03-08 17:08:19.483319+07	active	\N
1351	5	quiz	1	2026-03-08 17:08:59.023831+07	finished	2026-03-08 17:09:13.167541+07
1352	5	quiz	1	2026-03-08 17:09:22.609249+07	finished	2026-03-08 17:09:34.40149+07
1353	5	quiz	1	2026-03-08 17:09:47.567697+07	finished	2026-03-08 17:10:00.969675+07
1354	5	quiz	1	2026-03-08 17:10:09.543588+07	finished	2026-03-08 17:10:20.116015+07
1355	5	quiz	1	2026-03-08 17:10:31.923873+07	finished	2026-03-08 17:10:44.531459+07
1356	5	quiz	1	2026-03-08 17:10:56.162953+07	finished	2026-03-08 17:11:09.19133+07
1357	4	poll	1	2026-03-08 17:17:07.763421+07	active	\N
1358	4	poll	1	2026-03-08 17:25:40.718709+07	active	\N
1360	5	quiz	1	2026-03-08 17:28:11.454881+07	finished	2026-03-08 17:28:23.447517+07
1361	5	quiz	1	2026-03-08 17:28:35.040562+07	finished	2026-03-08 17:28:42.494612+07
1362	5	quiz	1	2026-03-08 17:28:57.098229+07	finished	2026-03-08 17:29:08.028822+07
1261	5	quiz	1	2026-03-08 14:53:52.816403+07	finished	2026-03-11 14:14:32.381553+07
1700	5	poll	1	2026-03-15 13:45:26.901411+07	finished	2026-03-15 13:45:34.893278+07
1712	5	poll	1	2026-03-15 14:23:39.393904+07	finished	2026-03-15 14:23:47.654345+07
1363	5	quiz	1	2026-03-08 17:29:19.672182+07	finished	2026-03-08 17:29:31.121641+07
1364	5	quiz	1	2026-03-08 17:29:45.763577+07	finished	2026-03-08 17:29:54.756589+07
1365	5	quiz	1	2026-03-08 17:30:04.01677+07	finished	2026-03-08 17:30:15.808345+07
1366	5	quiz	1	2026-03-08 17:30:28.514316+07	finished	2026-03-08 17:30:42.364923+07
1367	5	quiz	1	2026-03-08 17:30:52.13766+07	finished	2026-03-08 17:31:02.524811+07
1368	5	quiz	1	2026-03-08 17:31:18.475246+07	finished	2026-03-08 17:31:28.344876+07
1370	4	poll	1	2026-03-08 17:31:47.841761+07	active	\N
1369	5	quiz	1	2026-03-08 17:31:42.204343+07	finished	2026-03-08 17:31:52.064885+07
1371	5	quiz	1	2026-03-08 17:32:05.862089+07	finished	2026-03-08 17:32:27.505969+07
1372	5	quiz	1	2026-03-08 17:35:39.011242+07	finished	2026-03-08 17:35:52.685561+07
1373	5	quiz	1	2026-03-08 17:36:06.813794+07	finished	2026-03-08 17:36:17.162147+07
1374	5	quiz	1	2026-03-08 17:36:29.46109+07	finished	2026-03-08 17:36:37.520202+07
1375	5	quiz	1	2026-03-08 17:36:43.509204+07	finished	2026-03-08 17:36:51.499603+07
1376	5	quiz	1	2026-03-08 17:37:08.388301+07	finished	2026-03-08 17:37:31.89245+07
1377	5	quiz	1	2026-03-08 17:37:45.200432+07	finished	2026-03-08 17:37:59.471925+07
1378	5	quiz	1	2026-03-08 17:38:18.015811+07	finished	2026-03-08 17:38:28.465731+07
1379	5	quiz	1	2026-03-08 17:38:35.003553+07	finished	2026-03-08 17:38:38.504091+07
1380	5	quiz	1	2026-03-08 17:38:47.97119+07	finished	2026-03-08 17:39:00.644812+07
1381	5	quiz	1	2026-03-08 17:39:30.513596+07	finished	2026-03-08 17:39:54.618539+07
1382	5	quiz	1	2026-03-08 17:40:42.748439+07	finished	2026-03-08 17:41:06.904999+07
1383	5	quiz	1	2026-03-08 17:41:21.306363+07	finished	2026-03-08 17:41:56.395305+07
1384	5	quiz	1	2026-03-08 17:42:51.950082+07	finished	2026-03-08 17:53:53.900615+07
1385	5	quiz	1	2026-03-08 18:00:01.149074+07	finished	2026-03-08 18:00:14.835889+07
1386	5	quiz	1	2026-03-08 18:03:05.745944+07	finished	2026-03-08 18:03:19.821378+07
1387	5	quiz	1	2026-03-08 18:03:35.723092+07	finished	2026-03-08 18:03:57.647864+07
1388	5	quiz	1	2026-03-08 18:04:36.125344+07	finished	2026-03-08 18:04:53.9678+07
1389	5	quiz	1	2026-03-08 18:08:33.039507+07	finished	2026-03-08 18:08:44.119541+07
1390	5	quiz	1	2026-03-08 18:09:22.47332+07	finished	2026-03-08 18:10:50.012456+07
1412	5	quiz	1	2026-03-08 18:47:54.263451+07	finished	2026-03-08 18:48:07.143628+07
1391	4	poll	1	2026-03-08 18:10:49.315731+07	finished	2026-03-08 18:11:46.880474+07
1392	4	poll	1	2026-03-08 18:12:07.138877+07	finished	2026-03-08 18:12:17.667075+07
1393	4	poll	1	2026-03-08 18:14:01.744458+07	finished	2026-03-08 18:14:05.420746+07
1394	4	poll	1	2026-03-08 18:14:57.880946+07	finished	2026-03-08 18:15:02.817938+07
1395	5	quiz	1	2026-03-08 18:19:28.219786+07	finished	2026-03-08 18:19:40.581079+07
1396	4	poll	1	2026-03-08 18:24:20.172896+07	active	\N
1397	4	poll	1	2026-03-08 18:25:19.286277+07	finished	2026-03-08 18:25:28.733748+07
1398	4	poll	1	2026-03-08 18:26:30.00416+07	finished	2026-03-08 18:26:51.022286+07
1399	4	poll	1	2026-03-08 18:27:30.83238+07	finished	2026-03-08 18:27:46.909094+07
1400	5	quiz	1	2026-03-08 18:31:07.136862+07	finished	2026-03-08 18:31:28.005804+07
1401	4	poll	1	2026-03-08 18:33:06.129279+07	finished	2026-03-08 18:33:35.854004+07
1402	4	poll	1	2026-03-08 18:33:48.392772+07	finished	2026-03-08 18:33:54.42663+07
1404	5	quiz	1	2026-03-08 18:39:46.96608+07	finished	2026-03-08 18:39:58.803183+07
1403	4	poll	1	2026-03-08 18:39:45.90722+07	finished	2026-03-08 18:40:01.732227+07
1405	4	poll	1	2026-03-08 18:40:45.001095+07	finished	2026-03-08 18:41:03.061113+07
1406	4	poll	1	2026-03-08 18:41:10.191403+07	finished	2026-03-08 18:41:55.171654+07
1407	4	poll	1	2026-03-08 18:42:47.336219+07	finished	2026-03-08 18:42:57.568426+07
1408	5	quiz	1	2026-03-08 18:43:28.283219+07	finished	2026-03-08 18:43:40.594672+07
1409	4	poll	1	2026-03-08 18:43:35.994722+07	finished	2026-03-08 18:43:49.039253+07
1410	4	poll	1	2026-03-08 18:45:16.102294+07	finished	2026-03-08 18:45:32.549572+07
1413	5	quiz	1	2026-03-08 18:48:17.378029+07	finished	2026-03-08 18:48:36.446621+07
1415	5	quiz	1	2026-03-08 18:49:23.8703+07	finished	2026-03-08 18:49:44.994959+07
1416	5	quiz	1	2026-03-08 18:53:29.530739+07	finished	2026-03-08 18:53:44.871429+07
1417	5	quiz	1	2026-03-08 18:53:55.951595+07	finished	2026-03-08 18:58:28.931321+07
1418	5	quiz	1	2026-03-08 18:58:43.678292+07	finished	2026-03-08 18:58:56.232843+07
1419	5	quiz	1	2026-03-08 18:59:06.476744+07	finished	2026-03-08 18:59:17.532803+07
1420	5	quiz	1	2026-03-08 18:59:25.011524+07	finished	2026-03-08 18:59:35.287999+07
1421	5	quiz	1	2026-03-08 18:59:41.365819+07	finished	2026-03-08 18:59:50.953152+07
1422	5	quiz	1	2026-03-08 19:00:20.832841+07	finished	2026-03-08 19:00:42.724345+07
1427	5	quiz	1	2026-03-08 19:02:50.496456+07	finished	2026-03-08 19:03:06.639412+07
1428	5	quiz	1	2026-03-08 19:03:17.432383+07	finished	2026-03-08 19:03:29.95933+07
1423	5	quiz	1	2026-03-08 19:01:05.569717+07	finished	2026-03-08 19:01:18.501063+07
1429	5	quiz	1	2026-03-08 19:03:40.984272+07	finished	2026-03-08 19:03:52.324667+07
1430	5	quiz	1	2026-03-08 19:04:12.372351+07	finished	2026-03-08 19:04:25.254872+07
1431	5	quiz	1	2026-03-08 19:04:41.72843+07	finished	2026-03-08 19:14:29.315972+07
1411	4	poll	1	2026-03-08 18:45:40.515103+07	finished	2026-03-08 19:01:42.554255+07
1424	5	quiz	1	2026-03-08 19:01:38.464727+07	finished	2026-03-08 19:01:46.265621+07
1426	5	quiz	1	2026-03-08 19:01:58.764393+07	finished	2026-03-08 19:02:10.6673+07
1425	4	poll	1	2026-03-08 19:01:57.515343+07	finished	2026-03-08 19:02:21.201167+07
1432	5	quiz	1	2026-03-08 19:14:37.892438+07	finished	2026-03-08 19:14:58.212487+07
1433	5	quiz	1	2026-03-08 19:17:15.571047+07	finished	2026-03-08 19:18:20.298366+07
1434	5	quiz	1	2026-03-08 19:18:35.008543+07	finished	2026-03-08 19:18:55.030276+07
1435	5	quiz	1	2026-03-08 19:20:20.697209+07	finished	2026-03-08 19:20:29.540333+07
1436	5	quiz	1	2026-03-08 19:20:37.812197+07	finished	2026-03-08 19:22:56.279874+07
1437	5	quiz	1	2026-03-08 19:23:23.926126+07	finished	2026-03-08 19:23:33.353359+07
1438	5	quiz	1	2026-03-08 19:23:44.019693+07	finished	2026-03-08 19:24:28.86211+07
1439	5	quiz	1	2026-03-08 19:28:30.875196+07	finished	2026-03-08 19:28:45.397917+07
1440	5	quiz	1	2026-03-08 19:31:00.022781+07	finished	2026-03-08 19:31:11.42533+07
1441	5	quiz	1	2026-03-08 19:31:33.488579+07	finished	2026-03-08 19:31:43.69252+07
1442	5	quiz	1	2026-03-08 19:32:17.402874+07	finished	2026-03-08 19:33:16.170907+07
1443	5	quiz	1	2026-03-08 19:34:11.247062+07	finished	2026-03-08 19:34:31.45232+07
1444	5	quiz	1	2026-03-08 19:34:59.391292+07	finished	2026-03-08 19:36:05.830417+07
1445	5	quiz	1	2026-03-08 19:36:13.648374+07	finished	2026-03-08 19:37:01.958811+07
1446	5	quiz	1	2026-03-08 19:37:31.936601+07	finished	2026-03-08 19:38:15.430827+07
1447	5	quiz	1	2026-03-08 19:38:55.408108+07	finished	2026-03-08 19:39:33.832707+07
1448	5	quiz	1	2026-03-08 19:40:08.922849+07	finished	2026-03-08 19:40:25.891107+07
1449	5	quiz	1	2026-03-08 19:40:38.753535+07	finished	2026-03-08 19:40:50.303+07
1450	4	poll	1	2026-03-08 19:41:43.619956+07	finished	2026-03-08 19:41:46.381868+07
1451	5	quiz	1	2026-03-08 19:52:25.234723+07	finished	2026-03-08 19:52:34.720892+07
1452	5	quiz	1	2026-03-08 19:55:14.843914+07	finished	2026-03-08 19:55:25.205287+07
1453	5	quiz	1	2026-03-08 19:55:51.025202+07	finished	2026-03-08 19:56:03.581567+07
1454	5	quiz	1	2026-03-08 19:56:13.353889+07	finished	2026-03-08 19:56:23.867854+07
1414	5	quiz	1	2026-03-08 18:48:53.954869+07	finished	2026-03-11 14:14:32.381553+07
1608	13	quiz	1	2026-03-12 11:02:17.896751+07	active	\N
1455	5	quiz	1	2026-03-08 20:00:19.185588+07	finished	2026-03-08 20:00:34.402034+07
1456	4	chat	1	2026-03-09 13:40:44.286862+07	active	\N
1457	4	chat	1	2026-03-09 13:43:06.27867+07	active	\N
1458	4	chat	1	2026-03-09 13:48:15.63657+07	active	\N
1459	4	chat	1	2026-03-09 13:49:16.774734+07	finished	\N
1461	5	quiz	1	2026-03-09 14:12:28.640241+07	finished	2026-03-09 14:12:44.993176+07
1507	4	chat	1	2026-03-09 17:07:37.407656+07	finished	2026-03-09 17:08:01.485186+07
1460	4	chat	1	2026-03-09 14:04:39.577992+07	finished	\N
1462	4	chat	1	2026-03-09 14:19:13.740517+07	finished	\N
1463	4	chat	1	2026-03-09 14:22:47.123744+07	finished	\N
1464	4	chat	1	2026-03-09 14:26:53.285549+07	finished	\N
1465	4	poll	1	2026-03-09 14:38:24.891651+07	finished	2026-03-09 14:39:24.492079+07
1467	4	poll	1	2026-03-09 14:39:59.190959+07	finished	2026-03-09 14:41:16.622265+07
1468	4	poll	1	2026-03-09 14:41:25.595872+07	finished	2026-03-09 14:43:03.661909+07
1469	4	poll	1	2026-03-09 14:43:17.630558+07	finished	2026-03-09 14:43:26.581285+07
1470	4	poll	1	2026-03-09 14:43:36.849551+07	finished	2026-03-09 14:44:06.770299+07
1471	4	chat	1	2026-03-09 14:44:24.93264+07	active	\N
1472	4	chat	1	2026-03-09 14:53:21.965022+07	active	\N
1473	4	chat	1	2026-03-09 14:53:37.944619+07	active	\N
1474	4	poll	1	2026-03-09 14:56:25.294153+07	finished	2026-03-09 14:56:31.101148+07
1466	5	quiz	1	2026-03-09 14:38:28.344719+07	finished	2026-03-09 14:57:19.633161+07
1475	4	chat	1	2026-03-09 14:56:37.893755+07	finished	\N
1476	4	chat	1	2026-03-09 15:01:19.183388+07	finished	\N
1477	4	chat	1	2026-03-09 15:06:34.975912+07	finished	\N
1478	4	chat	1	2026-03-09 15:06:56.450592+07	finished	\N
1479	4	chat	1	2026-03-09 15:07:25.773162+07	finished	\N
1480	4	chat	1	2026-03-09 15:11:26.661015+07	finished	\N
1481	4	chat	1	2026-03-09 15:21:13.561044+07	finished	\N
1482	4	chat	1	2026-03-09 15:23:05.372857+07	finished	\N
1483	4	chat	1	2026-03-09 15:27:13.033349+07	finished	\N
1484	4	chat	1	2026-03-09 15:28:44.546433+07	finished	\N
1486	5	quiz	1	2026-03-09 15:58:42.511013+07	finished	2026-03-09 15:59:10.947725+07
1487	5	quiz	1	2026-03-09 15:59:25.705917+07	finished	2026-03-09 16:00:12.537616+07
1489	4	quiz	1	2026-03-09 16:05:52.589927+07	finished	2026-03-09 16:06:32.832961+07
1488	5	quiz	1	2026-03-09 16:05:13.752037+07	finished	2026-03-09 16:09:06.190005+07
1490	5	quiz	1	2026-03-09 16:09:25.140153+07	finished	2026-03-09 16:09:37.963391+07
1491	5	quiz	1	2026-03-09 16:15:54.947289+07	finished	2026-03-09 16:17:17.996536+07
1492	5	quiz	1	2026-03-09 16:18:19.875986+07	finished	2026-03-09 16:18:30.74407+07
1493	5	quiz	1	2026-03-09 16:19:19.085903+07	finished	2026-03-09 16:19:32.872128+07
1494	5	quiz	1	2026-03-09 16:19:46.284086+07	finished	2026-03-09 16:19:59.930829+07
1495	5	quiz	1	2026-03-09 16:20:27.86474+07	finished	2026-03-09 16:20:44.845137+07
1496	5	quiz	1	2026-03-09 16:23:38.967326+07	finished	2026-03-09 16:23:53.914511+07
1497	5	quiz	1	2026-03-09 16:25:06.162898+07	finished	2026-03-09 16:25:26.438685+07
1498	5	quiz	1	2026-03-09 16:25:58.666896+07	finished	2026-03-09 16:26:12.521407+07
1499	5	quiz	1	2026-03-09 16:26:30.447431+07	finished	2026-03-09 16:26:43.547706+07
1500	5	quiz	1	2026-03-09 16:27:00.460561+07	finished	2026-03-09 16:27:31.489078+07
1501	5	quiz	1	2026-03-09 16:30:01.449821+07	finished	2026-03-09 16:30:15.428515+07
1502	5	quiz	1	2026-03-09 16:31:39.759442+07	finished	2026-03-09 16:39:20.931931+07
1503	5	quiz	1	2026-03-09 16:48:27.235205+07	finished	2026-03-09 16:48:40.66466+07
1504	5	quiz	1	2026-03-09 16:51:08.240061+07	finished	2026-03-09 16:51:18.78976+07
1505	5	quiz	1	2026-03-09 16:51:31.983112+07	finished	2026-03-09 16:51:45.610376+07
1506	5	quiz	1	2026-03-09 16:52:03.673574+07	finished	2026-03-09 16:52:18.324658+07
1508	5	poll	1	2026-03-09 17:35:50.482966+07	finished	2026-03-09 17:35:56.367266+07
1576	5	quiz	1	2026-03-11 16:26:14.609428+07	finished	2026-03-11 16:26:41.909804+07
1510	5	chat	1	2026-03-09 17:38:18.240372+07	finished	2026-03-09 17:38:51.097926+07
1511	5	quiz	1	2026-03-09 17:39:49.263183+07	finished	2026-03-09 17:40:01.944314+07
1512	5	quiz	1	2026-03-09 17:40:12.344424+07	finished	2026-03-09 17:40:24.47502+07
1513	5	quiz	1	2026-03-09 17:40:38.020502+07	finished	2026-03-09 17:40:50.800256+07
1514	5	quiz	1	2026-03-09 17:41:03.483886+07	finished	2026-03-09 17:41:17.885486+07
1515	5	quiz	1	2026-03-09 17:41:28.739274+07	finished	2026-03-09 17:41:40.330178+07
1516	5	quiz	1	2026-03-09 18:17:41.005952+07	finished	2026-03-09 18:18:00.247736+07
1517	5	quiz	1	2026-03-09 18:19:18.654674+07	finished	2026-03-09 18:19:33.322335+07
1518	5	quiz	1	2026-03-09 18:30:13.569116+07	finished	2026-03-09 18:30:21.775061+07
1519	5	quiz	1	2026-03-09 18:40:40.818282+07	finished	2026-03-09 18:41:03.047576+07
1520	5	quiz	1	2026-03-09 19:03:47.319507+07	finished	2026-03-09 19:03:49.960695+07
1521	5	quiz	1	2026-03-09 19:04:23.786764+07	finished	2026-03-09 19:05:06.052514+07
1522	5	quiz	1	2026-03-09 19:05:10.824914+07	finished	2026-03-09 19:07:44.026863+07
1523	5	quiz	1	2026-03-09 19:07:53.88975+07	finished	2026-03-09 19:17:36.054195+07
1524	5	quiz	1	2026-03-09 19:17:43.955193+07	finished	2026-03-09 19:19:03.684213+07
1525	5	quiz	1	2026-03-09 19:19:13.219586+07	finished	2026-03-09 19:23:27.841601+07
1526	5	quiz	1	2026-03-09 19:24:39.212601+07	finished	2026-03-09 19:25:57.492844+07
1527	5	quiz	1	2026-03-09 19:26:07.089941+07	finished	2026-03-09 19:32:16.99163+07
1528	5	quiz	1	2026-03-09 19:32:25.09085+07	finished	2026-03-09 19:38:43.32996+07
1529	5	quiz	1	2026-03-09 19:38:58.081777+07	finished	2026-03-09 19:40:51.445589+07
1530	5	quiz	1	2026-03-09 19:41:05.653305+07	finished	2026-03-09 19:41:26.888307+07
1531	5	quiz	1	2026-03-09 19:42:24.084689+07	finished	2026-03-09 19:45:44.31926+07
1532	5	quiz	1	2026-03-09 19:46:37.225972+07	finished	2026-03-09 19:48:09.737318+07
1533	5	quiz	1	2026-03-09 19:48:20.181691+07	finished	2026-03-09 19:48:38.414611+07
1534	5	quiz	1	2026-03-09 19:48:44.522729+07	finished	2026-03-09 19:51:08.851275+07
1535	5	quiz	1	2026-03-09 19:51:15.562162+07	finished	2026-03-09 19:51:31.149237+07
1536	5	quiz	1	2026-03-09 19:51:36.732167+07	finished	2026-03-09 19:51:51.326383+07
1537	5	quiz	1	2026-03-09 19:51:59.433607+07	finished	2026-03-09 19:52:10.866895+07
1538	5	quiz	1	2026-03-09 19:52:21.033658+07	finished	2026-03-09 19:52:27.54329+07
1539	5	quiz	1	2026-03-09 19:53:45.229101+07	finished	2026-03-09 19:53:59.63188+07
1540	5	quiz	1	2026-03-09 19:54:07.86684+07	finished	2026-03-09 19:54:19.864254+07
1541	5	quiz	1	2026-03-09 19:58:47.997417+07	finished	2026-03-09 19:59:07.29839+07
1542	5	quiz	1	2026-03-09 20:00:37.004225+07	finished	2026-03-09 20:01:12.815457+07
1543	4	quiz	1	2026-03-11 12:35:49.913066+07	active	\N
1544	4	quiz	1	2026-03-11 12:36:15.557396+07	finished	2026-03-11 12:36:24.325009+07
1545	4	quiz	1	2026-03-11 12:36:35.093226+07	active	\N
1546	4	quiz	1	2026-03-11 12:40:14.814802+07	active	\N
1547	4	quiz	1	2026-03-11 12:44:19.632146+07	finished	2026-03-11 12:44:27.442967+07
1548	4	quiz	1	2026-03-11 12:44:41.120287+07	active	\N
1549	5	quiz	1	2026-03-11 12:45:58.762594+07	finished	2026-03-11 12:46:23.497061+07
1591	5	quiz	1	2026-03-11 17:08:24.405898+07	finished	2026-03-11 17:08:47.426335+07
1485	5	quiz	1	2026-03-09 15:58:16.806153+07	finished	2026-03-11 14:14:32.381553+07
1551	5	quiz	1	2026-03-11 13:04:48.841358+07	finished	2026-03-11 13:05:08.789074+07
1552	5	quiz	1	2026-03-11 13:05:37.179195+07	finished	2026-03-11 13:28:48.266879+07
1553	5	quiz	1	2026-03-11 13:29:51.838438+07	finished	2026-03-11 13:30:36.780989+07
1556	5	quiz	1	2026-03-11 13:48:47.989325+07	finished	2026-03-11 13:49:19.601607+07
1557	5	quiz	1	2026-03-11 13:49:46.845749+07	finished	2026-03-11 13:50:03.606642+07
1558	5	quiz	1	2026-03-11 13:50:15.517813+07	finished	2026-03-11 13:50:19.004792+07
1562	5	quiz	1	2026-03-11 13:54:22.131399+07	finished	2026-03-11 13:55:19.872677+07
44	5	quiz	1	2026-02-01 14:05:44.560485+07	finished	2026-03-11 14:14:32.381553+07
45	5	quiz	1	2026-02-01 14:07:48.460758+07	finished	2026-03-11 14:14:32.381553+07
46	5	quiz	1	2026-02-01 14:13:20.509144+07	finished	2026-03-11 14:14:32.381553+07
47	5	quiz	1	2026-02-01 14:13:52.599146+07	finished	2026-03-11 14:14:32.381553+07
48	5	quiz	1	2026-02-01 14:13:59.863075+07	finished	2026-03-11 14:14:32.381553+07
49	5	quiz	1	2026-02-01 14:14:43.957671+07	finished	2026-03-11 14:14:32.381553+07
62	5	quiz	1	2026-02-01 14:48:30.721883+07	finished	2026-03-11 14:14:32.381553+07
63	5	quiz	1	2026-02-01 14:52:29.400579+07	finished	2026-03-11 14:14:32.381553+07
64	5	quiz	1	2026-02-01 14:53:17.229092+07	finished	2026-03-11 14:14:32.381553+07
65	5	quiz	1	2026-02-01 14:54:04.63946+07	finished	2026-03-11 14:14:32.381553+07
73	5	quiz	1	2026-02-01 15:04:33.552559+07	finished	2026-03-11 14:14:32.381553+07
74	5	quiz	1	2026-02-01 15:05:13.704401+07	finished	2026-03-11 14:14:32.381553+07
75	5	quiz	1	2026-02-01 15:05:29.86816+07	finished	2026-03-11 14:14:32.381553+07
83	5	quiz	1	2026-02-01 15:15:57.054622+07	finished	2026-03-11 14:14:32.381553+07
84	5	quiz	1	2026-02-01 15:16:16.769234+07	finished	2026-03-11 14:14:32.381553+07
85	5	quiz	1	2026-02-01 15:16:32.106099+07	finished	2026-03-11 14:14:32.381553+07
88	5	quiz	1	2026-02-01 15:18:57.401882+07	finished	2026-03-11 14:14:32.381553+07
89	5	quiz	1	2026-02-01 15:22:24.952011+07	finished	2026-03-11 14:14:32.381553+07
92	5	quiz	1	2026-02-01 15:29:21.647257+07	finished	2026-03-11 14:14:32.381553+07
95	5	quiz	1	2026-02-01 15:34:45.208359+07	finished	2026-03-11 14:14:32.381553+07
96	5	quiz	1	2026-02-01 15:35:06.556449+07	finished	2026-03-11 14:14:32.381553+07
97	5	quiz	1	2026-02-01 15:36:31.99694+07	finished	2026-03-11 14:14:32.381553+07
98	5	quiz	1	2026-02-01 15:36:39.175212+07	finished	2026-03-11 14:14:32.381553+07
100	5	quiz	1	2026-02-01 15:39:12.355+07	finished	2026-03-11 14:14:32.381553+07
101	5	quiz	1	2026-02-01 15:39:23.884748+07	finished	2026-03-11 14:14:32.381553+07
103	5	quiz	1	2026-02-01 15:40:19.545518+07	finished	2026-03-11 14:14:32.381553+07
104	5	quiz	1	2026-02-01 15:40:34.532271+07	finished	2026-03-11 14:14:32.381553+07
108	5	quiz	1	2026-02-01 15:53:53.900339+07	finished	2026-03-11 14:14:32.381553+07
109	5	quiz	1	2026-02-01 16:02:55.427598+07	finished	2026-03-11 14:14:32.381553+07
110	5	quiz	1	2026-02-01 16:07:41.30508+07	finished	2026-03-11 14:14:32.381553+07
111	5	quiz	1	2026-02-01 16:07:52.179833+07	finished	2026-03-11 14:14:32.381553+07
112	5	quiz	1	2026-02-01 16:09:55.717074+07	finished	2026-03-11 14:14:32.381553+07
113	5	quiz	1	2026-02-01 16:10:15.87908+07	finished	2026-03-11 14:14:32.381553+07
114	5	quiz	1	2026-02-01 16:11:58.875868+07	finished	2026-03-11 14:14:32.381553+07
115	5	quiz	1	2026-02-01 16:16:00.400538+07	finished	2026-03-11 14:14:32.381553+07
116	5	quiz	1	2026-02-01 16:20:07.088302+07	finished	2026-03-11 14:14:32.381553+07
117	5	quiz	1	2026-02-01 16:26:29.937624+07	finished	2026-03-11 14:14:32.381553+07
118	5	quiz	1	2026-02-01 16:27:24.215938+07	finished	2026-03-11 14:14:32.381553+07
119	5	quiz	1	2026-02-01 16:27:57.952752+07	finished	2026-03-11 14:14:32.381553+07
120	5	quiz	1	2026-02-01 16:28:12.47422+07	finished	2026-03-11 14:14:32.381553+07
122	5	quiz	1	2026-02-01 16:28:38.520781+07	finished	2026-03-11 14:14:32.381553+07
123	5	quiz	1	2026-02-01 16:29:04.256089+07	finished	2026-03-11 14:14:32.381553+07
124	5	quiz	1	2026-02-01 16:32:49.336142+07	finished	2026-03-11 14:14:32.381553+07
125	5	quiz	1	2026-02-01 16:37:03.331805+07	finished	2026-03-11 14:14:32.381553+07
126	5	quiz	1	2026-02-01 16:39:43.386956+07	finished	2026-03-11 14:14:32.381553+07
127	5	quiz	1	2026-02-01 16:46:56.121761+07	finished	2026-03-11 14:14:32.381553+07
128	5	quiz	1	2026-02-01 16:51:07.241501+07	finished	2026-03-11 14:14:32.381553+07
129	5	quiz	1	2026-02-01 17:06:08.488206+07	finished	2026-03-11 14:14:32.381553+07
130	5	quiz	1	2026-02-01 17:07:08.441575+07	finished	2026-03-11 14:14:32.381553+07
131	5	quiz	1	2026-02-01 17:07:32.23875+07	finished	2026-03-11 14:14:32.381553+07
132	5	quiz	1	2026-02-01 17:07:41.706426+07	finished	2026-03-11 14:14:32.381553+07
133	5	quiz	1	2026-02-01 17:10:02.160429+07	finished	2026-03-11 14:14:32.381553+07
134	5	quiz	1	2026-02-01 17:10:30.116698+07	finished	2026-03-11 14:14:32.381553+07
135	5	quiz	1	2026-02-01 17:10:49.544825+07	finished	2026-03-11 14:14:32.381553+07
136	5	quiz	1	2026-02-01 17:10:59.198461+07	finished	2026-03-11 14:14:32.381553+07
141	5	quiz	1	2026-02-01 17:39:28.736137+07	finished	2026-03-11 14:14:32.381553+07
142	5	quiz	1	2026-02-01 17:39:57.179905+07	finished	2026-03-11 14:14:32.381553+07
143	5	quiz	1	2026-02-01 17:41:16.081711+07	finished	2026-03-11 14:14:32.381553+07
144	5	quiz	1	2026-02-01 17:41:54.070056+07	finished	2026-03-11 14:14:32.381553+07
145	5	quiz	1	2026-02-01 17:42:26.478787+07	finished	2026-03-11 14:14:32.381553+07
146	5	quiz	1	2026-02-01 17:44:49.751085+07	finished	2026-03-11 14:14:32.381553+07
148	5	quiz	1	2026-02-01 17:46:12.688223+07	finished	2026-03-11 14:14:32.381553+07
149	5	quiz	1	2026-02-01 17:47:37.066358+07	finished	2026-03-11 14:14:32.381553+07
150	5	quiz	1	2026-02-01 17:51:53.627602+07	finished	2026-03-11 14:14:32.381553+07
151	5	quiz	1	2026-02-01 17:52:17.443933+07	finished	2026-03-11 14:14:32.381553+07
153	5	quiz	1	2026-02-01 18:00:37.271069+07	finished	2026-03-11 14:14:32.381553+07
154	5	quiz	1	2026-02-01 18:03:15.27856+07	finished	2026-03-11 14:14:32.381553+07
155	5	quiz	1	2026-02-01 18:05:49.705337+07	finished	2026-03-11 14:14:32.381553+07
157	5	quiz	1	2026-02-01 18:12:18.057673+07	finished	2026-03-11 14:14:32.381553+07
158	5	quiz	1	2026-02-01 18:12:43.510645+07	finished	2026-03-11 14:14:32.381553+07
159	5	quiz	1	2026-02-01 18:13:11.8306+07	finished	2026-03-11 14:14:32.381553+07
160	5	quiz	1	2026-02-01 18:13:33.898651+07	finished	2026-03-11 14:14:32.381553+07
161	5	quiz	1	2026-02-01 18:14:44.243983+07	finished	2026-03-11 14:14:32.381553+07
162	5	quiz	1	2026-02-01 18:15:35.342172+07	finished	2026-03-11 14:14:32.381553+07
163	5	quiz	1	2026-02-01 18:16:35.351315+07	finished	2026-03-11 14:14:32.381553+07
164	5	quiz	1	2026-02-01 18:18:33.933936+07	finished	2026-03-11 14:14:32.381553+07
165	5	quiz	1	2026-02-01 18:21:44.773049+07	finished	2026-03-11 14:14:32.381553+07
168	5	quiz	1	2026-02-01 18:35:16.993023+07	finished	2026-03-11 14:14:32.381553+07
170	5	quiz	1	2026-02-01 18:42:06.888772+07	finished	2026-03-11 14:14:32.381553+07
171	5	quiz	1	2026-02-01 19:01:42.537893+07	finished	2026-03-11 14:14:32.381553+07
1554	5	quiz	1	2026-03-11 13:42:37.46385+07	finished	2026-03-11 14:14:32.381553+07
1555	5	quiz	1	2026-03-11 13:48:07.711275+07	finished	2026-03-11 14:14:32.381553+07
1559	5	quiz	1	2026-03-11 13:50:23.186745+07	finished	2026-03-11 14:14:32.381553+07
1560	5	quiz	1	2026-03-11 13:50:43.27644+07	finished	2026-03-11 14:14:32.381553+07
1561	5	quiz	1	2026-03-11 13:53:00.982436+07	finished	2026-03-11 14:14:32.381553+07
1577	5	quiz	1	2026-03-11 16:29:47.807353+07	finished	2026-03-11 16:30:19.913934+07
1592	5	quiz	1	2026-03-11 17:09:03.039858+07	finished	2026-03-11 17:09:27.525859+07
1607	13	quiz	1	2026-03-12 11:02:17.90029+07	active	\N
1622	14	quiz	1	2026-03-12 12:16:28.767998+07	finished	2026-03-12 12:16:44.775673+07
172	5	quiz	1	2026-02-01 19:03:00.829882+07	finished	2026-03-11 14:14:32.381553+07
173	5	quiz	1	2026-02-01 19:03:36.221427+07	finished	2026-03-11 14:14:32.381553+07
174	5	quiz	1	2026-02-01 19:05:00.995919+07	finished	2026-03-11 14:14:32.381553+07
175	5	quiz	1	2026-02-01 19:08:08.688118+07	finished	2026-03-11 14:14:32.381553+07
176	5	quiz	1	2026-02-01 19:08:38.054567+07	finished	2026-03-11 14:14:32.381553+07
179	5	quiz	1	2026-02-01 19:23:24.385358+07	finished	2026-03-11 14:14:32.381553+07
180	5	quiz	1	2026-02-01 19:24:07.246915+07	finished	2026-03-11 14:14:32.381553+07
181	5	quiz	1	2026-02-01 19:25:10.857033+07	finished	2026-03-11 14:14:32.381553+07
182	5	quiz	1	2026-02-01 19:25:35.244375+07	finished	2026-03-11 14:14:32.381553+07
183	5	quiz	1	2026-02-01 19:26:20.778396+07	finished	2026-03-11 14:14:32.381553+07
184	5	quiz	1	2026-02-01 19:27:24.830564+07	finished	2026-03-11 14:14:32.381553+07
185	5	quiz	1	2026-02-01 19:29:13.569294+07	finished	2026-03-11 14:14:32.381553+07
186	5	quiz	1	2026-02-01 19:30:38.839518+07	finished	2026-03-11 14:14:32.381553+07
187	5	quiz	1	2026-02-01 19:32:05.604106+07	finished	2026-03-11 14:14:32.381553+07
188	5	quiz	1	2026-02-01 19:32:13.540505+07	finished	2026-03-11 14:14:32.381553+07
189	5	quiz	1	2026-02-01 19:33:56.842056+07	finished	2026-03-11 14:14:32.381553+07
190	5	quiz	1	2026-02-01 19:37:03.734593+07	finished	2026-03-11 14:14:32.381553+07
191	5	quiz	1	2026-02-01 19:38:36.817295+07	finished	2026-03-11 14:14:32.381553+07
192	5	quiz	1	2026-02-01 19:40:04.510797+07	finished	2026-03-11 14:14:32.381553+07
193	5	quiz	1	2026-02-01 19:45:24.248542+07	finished	2026-03-11 14:14:32.381553+07
194	5	quiz	1	2026-02-02 14:00:12.726116+07	finished	2026-03-11 14:14:32.381553+07
195	5	quiz	1	2026-02-02 14:00:26.548077+07	finished	2026-03-11 14:14:32.381553+07
197	5	quiz	1	2026-02-02 14:08:35.387805+07	finished	2026-03-11 14:14:32.381553+07
198	5	quiz	1	2026-02-02 14:56:08.226864+07	finished	2026-03-11 14:14:32.381553+07
200	5	quiz	1	2026-02-02 15:12:26.802585+07	finished	2026-03-11 14:14:32.381553+07
201	5	quiz	1	2026-02-02 15:19:28.076203+07	finished	2026-03-11 14:14:32.381553+07
202	5	quiz	1	2026-02-02 15:21:02.663642+07	finished	2026-03-11 14:14:32.381553+07
203	5	quiz	1	2026-02-02 15:23:25.766582+07	finished	2026-03-11 14:14:32.381553+07
204	5	quiz	1	2026-02-02 15:28:36.956532+07	finished	2026-03-11 14:14:32.381553+07
205	5	quiz	1	2026-02-02 15:32:12.003951+07	finished	2026-03-11 14:14:32.381553+07
206	5	quiz	1	2026-02-02 15:34:10.213352+07	finished	2026-03-11 14:14:32.381553+07
207	5	quiz	1	2026-02-02 15:45:21.930485+07	finished	2026-03-11 14:14:32.381553+07
208	5	quiz	1	2026-02-02 15:46:39.406979+07	finished	2026-03-11 14:14:32.381553+07
209	5	quiz	1	2026-02-02 15:51:18.358212+07	finished	2026-03-11 14:14:32.381553+07
210	5	quiz	1	2026-02-02 16:06:08.873625+07	finished	2026-03-11 14:14:32.381553+07
212	5	quiz	1	2026-02-02 16:22:00.664135+07	finished	2026-03-11 14:14:32.381553+07
213	5	quiz	1	2026-02-02 16:23:08.846165+07	finished	2026-03-11 14:14:32.381553+07
214	5	quiz	1	2026-02-02 16:26:16.550035+07	finished	2026-03-11 14:14:32.381553+07
215	5	quiz	1	2026-02-02 16:33:35.916517+07	finished	2026-03-11 14:14:32.381553+07
216	5	quiz	1	2026-02-02 16:33:56.884532+07	finished	2026-03-11 14:14:32.381553+07
217	5	quiz	1	2026-02-02 16:39:02.144011+07	finished	2026-03-11 14:14:32.381553+07
218	5	quiz	1	2026-02-02 16:39:21.27842+07	finished	2026-03-11 14:14:32.381553+07
219	5	quiz	1	2026-02-02 16:43:29.566558+07	finished	2026-03-11 14:14:32.381553+07
220	5	quiz	1	2026-02-02 16:43:49.268052+07	finished	2026-03-11 14:14:32.381553+07
222	5	quiz	1	2026-02-02 17:15:18.841138+07	finished	2026-03-11 14:14:32.381553+07
223	5	quiz	1	2026-02-02 17:19:47.525702+07	finished	2026-03-11 14:14:32.381553+07
224	5	quiz	1	2026-02-02 17:20:21.846976+07	finished	2026-03-11 14:14:32.381553+07
225	5	quiz	1	2026-02-02 17:22:50.774483+07	finished	2026-03-11 14:14:32.381553+07
226	5	quiz	1	2026-02-02 17:26:35.058193+07	finished	2026-03-11 14:14:32.381553+07
227	5	quiz	1	2026-02-02 17:27:07.215035+07	finished	2026-03-11 14:14:32.381553+07
228	5	quiz	1	2026-02-02 17:27:29.096803+07	finished	2026-03-11 14:14:32.381553+07
229	5	quiz	1	2026-02-02 17:28:18.578821+07	finished	2026-03-11 14:14:32.381553+07
230	5	quiz	1	2026-02-02 17:40:57.521523+07	finished	2026-03-11 14:14:32.381553+07
231	5	quiz	1	2026-02-02 17:41:13.799941+07	finished	2026-03-11 14:14:32.381553+07
232	5	quiz	1	2026-02-02 17:41:39.138391+07	finished	2026-03-11 14:14:32.381553+07
233	5	quiz	1	2026-02-02 17:42:14.010625+07	finished	2026-03-11 14:14:32.381553+07
234	5	quiz	1	2026-02-02 17:51:32.585217+07	finished	2026-03-11 14:14:32.381553+07
235	5	quiz	1	2026-02-02 17:52:07.578515+07	finished	2026-03-11 14:14:32.381553+07
236	5	quiz	1	2026-02-02 17:54:15.487294+07	finished	2026-03-11 14:14:32.381553+07
237	5	quiz	1	2026-02-02 17:56:47.841999+07	finished	2026-03-11 14:14:32.381553+07
238	5	quiz	1	2026-02-02 18:01:57.860596+07	finished	2026-03-11 14:14:32.381553+07
239	5	quiz	1	2026-02-02 18:03:20.937663+07	finished	2026-03-11 14:14:32.381553+07
240	5	quiz	1	2026-02-02 18:03:35.232601+07	finished	2026-03-11 14:14:32.381553+07
241	5	quiz	1	2026-02-02 18:04:33.282086+07	finished	2026-03-11 14:14:32.381553+07
242	5	quiz	1	2026-02-02 18:04:49.330896+07	finished	2026-03-11 14:14:32.381553+07
243	5	quiz	1	2026-02-02 18:05:04.176191+07	finished	2026-03-11 14:14:32.381553+07
244	5	quiz	1	2026-02-02 18:06:47.509175+07	finished	2026-03-11 14:14:32.381553+07
245	5	quiz	1	2026-02-02 18:09:00.455267+07	finished	2026-03-11 14:14:32.381553+07
246	5	quiz	1	2026-02-02 18:09:55.819541+07	finished	2026-03-11 14:14:32.381553+07
247	5	quiz	1	2026-02-02 18:16:08.728433+07	finished	2026-03-11 14:14:32.381553+07
248	5	quiz	1	2026-02-02 18:16:29.84364+07	finished	2026-03-11 14:14:32.381553+07
249	5	quiz	1	2026-02-02 18:20:32.611942+07	finished	2026-03-11 14:14:32.381553+07
250	5	quiz	1	2026-02-02 18:20:52.846865+07	finished	2026-03-11 14:14:32.381553+07
251	5	quiz	1	2026-02-02 18:27:07.48618+07	finished	2026-03-11 14:14:32.381553+07
252	5	quiz	1	2026-02-02 18:27:26.029327+07	finished	2026-03-11 14:14:32.381553+07
253	5	quiz	1	2026-02-02 18:34:04.327863+07	finished	2026-03-11 14:14:32.381553+07
254	5	quiz	1	2026-02-02 18:35:11.989234+07	finished	2026-03-11 14:14:32.381553+07
255	5	quiz	1	2026-02-02 18:35:39.271933+07	finished	2026-03-11 14:14:32.381553+07
256	5	quiz	1	2026-02-02 18:37:24.13279+07	finished	2026-03-11 14:14:32.381553+07
257	5	quiz	1	2026-02-02 18:37:33.103012+07	finished	2026-03-11 14:14:32.381553+07
258	5	quiz	1	2026-02-02 18:43:33.438577+07	finished	2026-03-11 14:14:32.381553+07
259	5	quiz	1	2026-02-02 18:52:02.007909+07	finished	2026-03-11 14:14:32.381553+07
260	5	quiz	1	2026-02-04 14:05:19.568779+07	finished	2026-03-11 14:14:32.381553+07
261	5	quiz	1	2026-02-04 14:05:53.196483+07	finished	2026-03-11 14:14:32.381553+07
262	5	quiz	1	2026-02-04 14:08:23.850001+07	finished	2026-03-11 14:14:32.381553+07
263	5	quiz	1	2026-02-04 14:11:19.081574+07	finished	2026-03-11 14:14:32.381553+07
264	5	quiz	1	2026-02-04 14:15:38.268626+07	finished	2026-03-11 14:14:32.381553+07
265	5	quiz	1	2026-02-04 14:17:35.644393+07	finished	2026-03-11 14:14:32.381553+07
266	5	quiz	1	2026-02-04 14:18:50.242596+07	finished	2026-03-11 14:14:32.381553+07
267	5	quiz	1	2026-02-04 14:19:59.429458+07	finished	2026-03-11 14:14:32.381553+07
268	5	quiz	1	2026-02-04 14:20:57.190879+07	finished	2026-03-11 14:14:32.381553+07
269	5	quiz	1	2026-02-04 14:21:47.267732+07	finished	2026-03-11 14:14:32.381553+07
270	5	quiz	1	2026-02-04 14:22:39.510263+07	finished	2026-03-11 14:14:32.381553+07
271	5	quiz	1	2026-02-04 14:58:58.641995+07	finished	2026-03-11 14:14:32.381553+07
272	5	quiz	1	2026-02-04 15:02:54.659868+07	finished	2026-03-11 14:14:32.381553+07
273	5	quiz	1	2026-02-04 15:08:27.235279+07	finished	2026-03-11 14:14:32.381553+07
274	5	quiz	1	2026-02-04 15:08:49.584284+07	finished	2026-03-11 14:14:32.381553+07
275	5	quiz	1	2026-02-04 15:10:22.266014+07	finished	2026-03-11 14:14:32.381553+07
276	5	quiz	1	2026-02-04 15:10:30.543601+07	finished	2026-03-11 14:14:32.381553+07
277	5	quiz	1	2026-02-04 15:10:52.748929+07	finished	2026-03-11 14:14:32.381553+07
278	5	quiz	1	2026-02-04 15:11:14.165665+07	finished	2026-03-11 14:14:32.381553+07
279	5	quiz	1	2026-02-04 15:12:05.007302+07	finished	2026-03-11 14:14:32.381553+07
280	5	quiz	1	2026-02-04 15:12:40.514625+07	finished	2026-03-11 14:14:32.381553+07
281	5	quiz	1	2026-02-04 15:12:55.208964+07	finished	2026-03-11 14:14:32.381553+07
282	5	quiz	1	2026-02-04 15:22:56.812497+07	finished	2026-03-11 14:14:32.381553+07
283	5	quiz	1	2026-02-04 15:32:50.510426+07	finished	2026-03-11 14:14:32.381553+07
284	5	quiz	1	2026-02-04 15:48:10.915306+07	finished	2026-03-11 14:14:32.381553+07
285	5	quiz	1	2026-02-04 15:49:23.603043+07	finished	2026-03-11 14:14:32.381553+07
286	5	quiz	1	2026-02-04 15:49:43.172365+07	finished	2026-03-11 14:14:32.381553+07
287	5	quiz	1	2026-02-04 15:50:25.22741+07	finished	2026-03-11 14:14:32.381553+07
288	5	quiz	1	2026-02-04 15:51:01.984928+07	finished	2026-03-11 14:14:32.381553+07
289	5	quiz	1	2026-02-04 15:52:55.45896+07	finished	2026-03-11 14:14:32.381553+07
290	5	quiz	1	2026-02-04 15:53:47.050756+07	finished	2026-03-11 14:14:32.381553+07
291	5	quiz	1	2026-02-04 15:54:15.803476+07	finished	2026-03-11 14:14:32.381553+07
295	5	quiz	1	2026-02-09 14:29:43.147636+07	finished	2026-03-11 14:14:32.381553+07
296	5	quiz	1	2026-02-09 14:29:53.915051+07	finished	2026-03-11 14:14:32.381553+07
298	5	quiz	1	2026-02-09 14:35:02.603765+07	finished	2026-03-11 14:14:32.381553+07
299	5	quiz	1	2026-02-09 14:35:39.357494+07	finished	2026-03-11 14:14:32.381553+07
300	5	quiz	1	2026-02-09 14:53:12.128561+07	finished	2026-03-11 14:14:32.381553+07
301	5	quiz	1	2026-02-09 14:56:03.480646+07	finished	2026-03-11 14:14:32.381553+07
302	5	quiz	1	2026-02-09 14:57:43.287069+07	finished	2026-03-11 14:14:32.381553+07
303	5	quiz	1	2026-02-09 14:58:01.251115+07	finished	2026-03-11 14:14:32.381553+07
304	5	quiz	1	2026-02-09 15:05:48.373963+07	finished	2026-03-11 14:14:32.381553+07
305	5	quiz	1	2026-02-09 15:06:41.037343+07	finished	2026-03-11 14:14:32.381553+07
306	5	quiz	1	2026-02-09 15:17:04.73971+07	finished	2026-03-11 14:14:32.381553+07
307	5	quiz	1	2026-02-09 15:26:42.845019+07	finished	2026-03-11 14:14:32.381553+07
308	5	quiz	1	2026-02-09 15:55:53.546748+07	finished	2026-03-11 14:14:32.381553+07
309	5	quiz	1	2026-02-09 15:57:19.633897+07	finished	2026-03-11 14:14:32.381553+07
311	5	quiz	1	2026-02-09 16:11:01.581689+07	finished	2026-03-11 14:14:32.381553+07
312	5	quiz	1	2026-02-09 16:11:56.65411+07	finished	2026-03-11 14:14:32.381553+07
313	5	quiz	1	2026-02-09 16:12:12.084099+07	finished	2026-03-11 14:14:32.381553+07
314	5	quiz	1	2026-02-09 16:19:52.283113+07	finished	2026-03-11 14:14:32.381553+07
316	5	quiz	1	2026-02-09 16:35:54.187693+07	finished	2026-03-11 14:14:32.381553+07
317	5	quiz	1	2026-02-09 16:46:59.896975+07	finished	2026-03-11 14:14:32.381553+07
318	5	quiz	1	2026-02-09 17:09:52.59858+07	finished	2026-03-11 14:14:32.381553+07
319	5	quiz	1	2026-02-09 17:20:33.707511+07	finished	2026-03-11 14:14:32.381553+07
321	5	quiz	1	2026-02-09 17:25:59.904394+07	finished	2026-03-11 14:14:32.381553+07
322	5	quiz	1	2026-02-09 17:27:12.985046+07	finished	2026-03-11 14:14:32.381553+07
323	5	quiz	1	2026-02-09 17:27:26.631641+07	finished	2026-03-11 14:14:32.381553+07
324	5	quiz	1	2026-02-09 17:28:33.508594+07	finished	2026-03-11 14:14:32.381553+07
325	5	quiz	1	2026-02-09 17:31:56.502494+07	finished	2026-03-11 14:14:32.381553+07
326	5	quiz	1	2026-02-09 17:35:22.673276+07	finished	2026-03-11 14:14:32.381553+07
327	5	quiz	1	2026-02-09 17:41:32.811241+07	finished	2026-03-11 14:14:32.381553+07
328	5	quiz	1	2026-02-09 17:47:06.175071+07	finished	2026-03-11 14:14:32.381553+07
329	5	quiz	1	2026-02-09 17:55:06.790938+07	finished	2026-03-11 14:14:32.381553+07
330	5	quiz	1	2026-02-09 17:55:34.029164+07	finished	2026-03-11 14:14:32.381553+07
331	5	quiz	1	2026-02-09 18:02:39.123218+07	finished	2026-03-11 14:14:32.381553+07
332	5	quiz	1	2026-02-09 18:04:52.540373+07	finished	2026-03-11 14:14:32.381553+07
333	5	quiz	1	2026-02-09 18:05:42.274502+07	finished	2026-03-11 14:14:32.381553+07
335	5	quiz	1	2026-02-09 18:06:36.30566+07	finished	2026-03-11 14:14:32.381553+07
336	5	quiz	1	2026-02-09 18:07:11.693532+07	finished	2026-03-11 14:14:32.381553+07
337	5	quiz	1	2026-02-09 18:07:22.803206+07	finished	2026-03-11 14:14:32.381553+07
338	5	quiz	1	2026-02-09 18:12:09.515116+07	finished	2026-03-11 14:14:32.381553+07
339	5	quiz	1	2026-02-09 18:16:27.713701+07	finished	2026-03-11 14:14:32.381553+07
340	5	quiz	1	2026-02-09 18:20:23.576976+07	finished	2026-03-11 14:14:32.381553+07
341	5	quiz	1	2026-02-09 18:53:13.004203+07	finished	2026-03-11 14:14:32.381553+07
342	5	quiz	1	2026-02-09 19:27:18.656488+07	finished	2026-03-11 14:14:32.381553+07
343	5	quiz	1	2026-02-09 19:31:18.351474+07	finished	2026-03-11 14:14:32.381553+07
344	5	quiz	1	2026-02-09 19:31:38.185012+07	finished	2026-03-11 14:14:32.381553+07
345	5	quiz	1	2026-02-09 19:32:18.300772+07	finished	2026-03-11 14:14:32.381553+07
346	5	quiz	1	2026-02-09 19:32:35.980817+07	finished	2026-03-11 14:14:32.381553+07
347	5	quiz	1	2026-02-09 19:34:57.261945+07	finished	2026-03-11 14:14:32.381553+07
348	5	quiz	1	2026-02-09 19:35:19.023522+07	finished	2026-03-11 14:14:32.381553+07
349	5	quiz	1	2026-02-09 19:35:39.228919+07	finished	2026-03-11 14:14:32.381553+07
350	5	quiz	1	2026-02-09 19:40:47.374099+07	finished	2026-03-11 14:14:32.381553+07
351	5	quiz	1	2026-02-09 19:41:21.455555+07	finished	2026-03-11 14:14:32.381553+07
352	5	quiz	1	2026-02-09 19:42:03.042853+07	finished	2026-03-11 14:14:32.381553+07
353	5	quiz	1	2026-02-09 19:42:25.964455+07	finished	2026-03-11 14:14:32.381553+07
354	5	quiz	1	2026-02-09 19:42:39.639225+07	finished	2026-03-11 14:14:32.381553+07
355	5	quiz	1	2026-02-09 19:42:57.852866+07	finished	2026-03-11 14:14:32.381553+07
356	5	quiz	1	2026-02-09 19:43:13.330698+07	finished	2026-03-11 14:14:32.381553+07
357	5	quiz	1	2026-02-10 09:10:16.466234+07	finished	2026-03-11 14:14:32.381553+07
359	5	quiz	1	2026-02-10 09:11:27.398185+07	finished	2026-03-11 14:14:32.381553+07
360	5	quiz	1	2026-02-10 09:11:45.830877+07	finished	2026-03-11 14:14:32.381553+07
361	5	quiz	1	2026-02-10 09:11:54.229369+07	finished	2026-03-11 14:14:32.381553+07
362	5	quiz	1	2026-02-10 09:12:20.340609+07	finished	2026-03-11 14:14:32.381553+07
363	5	quiz	1	2026-02-10 09:28:35.734089+07	finished	2026-03-11 14:14:32.381553+07
364	5	quiz	1	2026-02-10 09:31:09.094068+07	finished	2026-03-11 14:14:32.381553+07
365	5	quiz	1	2026-02-10 09:35:23.188014+07	finished	2026-03-11 14:14:32.381553+07
366	5	quiz	1	2026-02-10 09:44:15.232074+07	finished	2026-03-11 14:14:32.381553+07
367	5	quiz	1	2026-02-10 09:56:09.839755+07	finished	2026-03-11 14:14:32.381553+07
368	5	quiz	1	2026-02-10 09:58:38.119266+07	finished	2026-03-11 14:14:32.381553+07
369	5	quiz	1	2026-02-10 10:04:36.44949+07	finished	2026-03-11 14:14:32.381553+07
370	5	quiz	1	2026-02-10 10:10:07.394597+07	finished	2026-03-11 14:14:32.381553+07
371	5	quiz	1	2026-02-10 10:15:23.536593+07	finished	2026-03-11 14:14:32.381553+07
372	5	quiz	1	2026-02-10 10:24:42.117922+07	finished	2026-03-11 14:14:32.381553+07
373	5	quiz	1	2026-02-10 10:26:48.091414+07	finished	2026-03-11 14:14:32.381553+07
374	5	quiz	1	2026-02-10 10:27:50.947982+07	finished	2026-03-11 14:14:32.381553+07
375	5	quiz	1	2026-02-10 10:35:51.319844+07	finished	2026-03-11 14:14:32.381553+07
376	5	quiz	1	2026-02-10 10:36:46.928716+07	finished	2026-03-11 14:14:32.381553+07
377	5	quiz	1	2026-02-10 10:38:28.201086+07	finished	2026-03-11 14:14:32.381553+07
378	5	quiz	1	2026-02-10 10:39:01.995443+07	finished	2026-03-11 14:14:32.381553+07
379	5	quiz	1	2026-02-10 10:39:24.029865+07	finished	2026-03-11 14:14:32.381553+07
380	5	quiz	1	2026-02-10 10:40:01.392006+07	finished	2026-03-11 14:14:32.381553+07
386	5	quiz	1	2026-02-10 11:18:35.302486+07	finished	2026-03-11 14:14:32.381553+07
387	5	quiz	1	2026-02-10 11:19:10.772206+07	finished	2026-03-11 14:14:32.381553+07
388	5	quiz	1	2026-02-10 11:19:36.062068+07	finished	2026-03-11 14:14:32.381553+07
390	5	quiz	1	2026-02-10 11:26:36.189499+07	finished	2026-03-11 14:14:32.381553+07
394	5	quiz	1	2026-02-10 11:36:13.740542+07	finished	2026-03-11 14:14:32.381553+07
395	5	quiz	1	2026-02-10 11:37:02.296039+07	finished	2026-03-11 14:14:32.381553+07
396	5	quiz	1	2026-02-10 11:37:17.54398+07	finished	2026-03-11 14:14:32.381553+07
397	5	quiz	1	2026-02-10 11:47:04.051697+07	finished	2026-03-11 14:14:32.381553+07
399	5	quiz	1	2026-02-10 11:50:44.208138+07	finished	2026-03-11 14:14:32.381553+07
400	5	quiz	1	2026-02-10 11:53:21.911208+07	finished	2026-03-11 14:14:32.381553+07
401	5	quiz	1	2026-02-10 11:53:33.167277+07	finished	2026-03-11 14:14:32.381553+07
402	5	quiz	1	2026-02-10 11:56:06.03221+07	finished	2026-03-11 14:14:32.381553+07
403	5	quiz	1	2026-02-10 11:58:33.818953+07	finished	2026-03-11 14:14:32.381553+07
404	5	quiz	1	2026-02-11 13:41:31.881702+07	finished	2026-03-11 14:14:32.381553+07
405	5	quiz	1	2026-02-11 14:03:56.659245+07	finished	2026-03-11 14:14:32.381553+07
406	5	quiz	1	2026-02-11 14:04:20.53051+07	finished	2026-03-11 14:14:32.381553+07
410	5	quiz	1	2026-02-11 14:06:58.845975+07	finished	2026-03-11 14:14:32.381553+07
412	5	quiz	1	2026-02-11 14:09:28.834308+07	finished	2026-03-11 14:14:32.381553+07
418	5	quiz	1	2026-02-11 14:14:31.873531+07	finished	2026-03-11 14:14:32.381553+07
419	5	quiz	1	2026-02-11 14:14:32.67396+07	finished	2026-03-11 14:14:32.381553+07
424	5	quiz	1	2026-02-11 14:41:13.325903+07	finished	2026-03-11 14:14:32.381553+07
425	5	quiz	1	2026-02-11 14:41:27.83913+07	finished	2026-03-11 14:14:32.381553+07
426	5	quiz	1	2026-02-11 14:42:00.455935+07	finished	2026-03-11 14:14:32.381553+07
427	5	quiz	1	2026-02-11 14:42:29.568602+07	finished	2026-03-11 14:14:32.381553+07
428	5	quiz	1	2026-02-11 14:43:14.022886+07	finished	2026-03-11 14:14:32.381553+07
429	5	quiz	1	2026-02-11 14:43:29.857536+07	finished	2026-03-11 14:14:32.381553+07
430	5	quiz	1	2026-02-11 15:12:17.254118+07	finished	2026-03-11 14:14:32.381553+07
431	5	quiz	1	2026-02-11 15:15:52.397122+07	finished	2026-03-11 14:14:32.381553+07
432	5	quiz	1	2026-02-11 15:51:59.023193+07	finished	2026-03-11 14:14:32.381553+07
433	5	quiz	1	2026-02-11 15:54:38.415691+07	finished	2026-03-11 14:14:32.381553+07
434	5	quiz	1	2026-02-11 15:54:54.224231+07	finished	2026-03-11 14:14:32.381553+07
435	5	quiz	1	2026-02-11 15:55:47.024741+07	finished	2026-03-11 14:14:32.381553+07
436	5	quiz	1	2026-02-11 16:01:19.460252+07	finished	2026-03-11 14:14:32.381553+07
437	5	quiz	1	2026-02-11 16:07:34.501287+07	finished	2026-03-11 14:14:32.381553+07
438	5	quiz	1	2026-02-11 16:08:39.000445+07	finished	2026-03-11 14:14:32.381553+07
439	5	quiz	1	2026-02-11 16:10:20.835795+07	finished	2026-03-11 14:14:32.381553+07
440	5	quiz	1	2026-02-11 16:27:25.204874+07	finished	2026-03-11 14:14:32.381553+07
441	5	quiz	1	2026-02-11 16:39:52.034462+07	finished	2026-03-11 14:14:32.381553+07
442	5	quiz	1	2026-02-11 16:44:58.818379+07	finished	2026-03-11 14:14:32.381553+07
443	5	quiz	1	2026-02-11 16:46:22.608646+07	finished	2026-03-11 14:14:32.381553+07
444	5	quiz	1	2026-02-11 16:46:30.383503+07	finished	2026-03-11 14:14:32.381553+07
445	5	quiz	1	2026-02-11 16:51:54.336743+07	finished	2026-03-11 14:14:32.381553+07
446	5	quiz	1	2026-02-11 16:54:04.751852+07	finished	2026-03-11 14:14:32.381553+07
447	5	quiz	1	2026-02-11 17:00:05.75819+07	finished	2026-03-11 14:14:32.381553+07
448	5	quiz	1	2026-02-11 17:00:19.786987+07	finished	2026-03-11 14:14:32.381553+07
449	5	quiz	1	2026-02-11 17:03:16.228882+07	finished	2026-03-11 14:14:32.381553+07
450	5	quiz	1	2026-02-11 17:03:55.888355+07	finished	2026-03-11 14:14:32.381553+07
451	5	quiz	1	2026-02-11 17:04:20.991717+07	finished	2026-03-11 14:14:32.381553+07
452	5	quiz	1	2026-02-11 17:11:10.120169+07	finished	2026-03-11 14:14:32.381553+07
453	5	quiz	1	2026-02-11 17:16:58.389243+07	finished	2026-03-11 14:14:32.381553+07
454	5	quiz	1	2026-02-11 17:19:43.660593+07	finished	2026-03-11 14:14:32.381553+07
455	5	quiz	1	2026-02-11 17:19:49.932469+07	finished	2026-03-11 14:14:32.381553+07
456	5	quiz	1	2026-02-11 17:20:42.13088+07	finished	2026-03-11 14:14:32.381553+07
457	5	quiz	1	2026-02-11 17:21:27.962426+07	finished	2026-03-11 14:14:32.381553+07
458	5	quiz	1	2026-02-11 17:30:57.893235+07	finished	2026-03-11 14:14:32.381553+07
459	5	quiz	1	2026-02-11 17:31:27.368033+07	finished	2026-03-11 14:14:32.381553+07
460	5	quiz	1	2026-02-11 17:31:38.004841+07	finished	2026-03-11 14:14:32.381553+07
461	5	quiz	1	2026-02-11 17:32:23.985799+07	finished	2026-03-11 14:14:32.381553+07
462	5	quiz	1	2026-02-11 17:46:15.639848+07	finished	2026-03-11 14:14:32.381553+07
463	5	quiz	1	2026-02-11 17:47:14.122781+07	finished	2026-03-11 14:14:32.381553+07
464	5	quiz	1	2026-02-11 17:49:31.508052+07	finished	2026-03-11 14:14:32.381553+07
465	5	quiz	1	2026-02-11 17:50:31.507048+07	finished	2026-03-11 14:14:32.381553+07
466	5	quiz	1	2026-02-11 17:50:57.704935+07	finished	2026-03-11 14:14:32.381553+07
467	5	quiz	1	2026-02-11 17:52:50.697212+07	finished	2026-03-11 14:14:32.381553+07
468	5	quiz	1	2026-02-11 17:53:59.911342+07	finished	2026-03-11 14:14:32.381553+07
476	5	quiz	1	2026-02-12 13:34:42.035183+07	finished	2026-03-11 14:14:32.381553+07
479	5	quiz	1	2026-02-12 13:44:16.186881+07	finished	2026-03-11 14:14:32.381553+07
480	5	quiz	1	2026-02-12 13:46:06.496079+07	finished	2026-03-11 14:14:32.381553+07
481	5	quiz	1	2026-02-12 14:19:01.344865+07	finished	2026-03-11 14:14:32.381553+07
482	5	quiz	1	2026-02-12 14:19:22.519914+07	finished	2026-03-11 14:14:32.381553+07
484	5	quiz	1	2026-02-12 15:17:34.414554+07	finished	2026-03-11 14:14:32.381553+07
485	5	quiz	1	2026-02-12 15:18:52.855628+07	finished	2026-03-11 14:14:32.381553+07
486	5	quiz	1	2026-02-12 15:23:27.722345+07	finished	2026-03-11 14:14:32.381553+07
487	5	quiz	1	2026-02-15 13:35:52.242891+07	finished	2026-03-11 14:14:32.381553+07
488	5	quiz	1	2026-02-15 13:37:22.720115+07	finished	2026-03-11 14:14:32.381553+07
496	5	quiz	1	2026-02-15 14:12:06.314221+07	finished	2026-03-11 14:14:32.381553+07
505	5	quiz	1	2026-02-15 14:31:19.881733+07	finished	2026-03-11 14:14:32.381553+07
506	5	quiz	1	2026-02-15 14:33:35.052525+07	finished	2026-03-11 14:14:32.381553+07
512	5	quiz	1	2026-02-15 15:23:20.835213+07	finished	2026-03-11 14:14:32.381553+07
514	5	quiz	1	2026-02-15 15:29:42.437007+07	finished	2026-03-11 14:14:32.381553+07
515	5	quiz	1	2026-02-15 15:30:27.920016+07	finished	2026-03-11 14:14:32.381553+07
516	5	quiz	1	2026-02-15 15:34:06.851041+07	finished	2026-03-11 14:14:32.381553+07
518	5	quiz	1	2026-02-15 15:39:45.493044+07	finished	2026-03-11 14:14:32.381553+07
519	5	quiz	1	2026-02-15 15:39:57.396805+07	finished	2026-03-11 14:14:32.381553+07
520	5	quiz	1	2026-02-15 15:43:08.994933+07	finished	2026-03-11 14:14:32.381553+07
522	5	quiz	1	2026-02-15 15:51:57.272263+07	finished	2026-03-11 14:14:32.381553+07
523	5	quiz	1	2026-02-15 15:54:42.832052+07	finished	2026-03-11 14:14:32.381553+07
524	5	quiz	1	2026-02-15 15:56:43.11896+07	finished	2026-03-11 14:14:32.381553+07
525	5	quiz	1	2026-02-15 16:00:07.166157+07	finished	2026-03-11 14:14:32.381553+07
527	5	quiz	1	2026-02-15 16:08:13.71995+07	finished	2026-03-11 14:14:32.381553+07
528	5	quiz	1	2026-02-15 16:08:29.552613+07	finished	2026-03-11 14:14:32.381553+07
529	5	quiz	1	2026-02-15 16:10:07.675118+07	finished	2026-03-11 14:14:32.381553+07
531	5	quiz	1	2026-02-15 16:13:51.67224+07	finished	2026-03-11 14:14:32.381553+07
532	5	quiz	1	2026-02-15 16:14:12.719817+07	finished	2026-03-11 14:14:32.381553+07
533	5	quiz	1	2026-02-15 16:17:17.506786+07	finished	2026-03-11 14:14:32.381553+07
534	5	quiz	1	2026-02-15 16:18:18.165062+07	finished	2026-03-11 14:14:32.381553+07
535	5	quiz	1	2026-02-15 16:30:46.955797+07	finished	2026-03-11 14:14:32.381553+07
536	5	quiz	1	2026-02-15 16:33:16.165103+07	finished	2026-03-11 14:14:32.381553+07
537	5	quiz	1	2026-02-15 16:36:14.132273+07	finished	2026-03-11 14:14:32.381553+07
538	5	quiz	1	2026-02-15 16:37:56.023982+07	finished	2026-03-11 14:14:32.381553+07
539	5	quiz	1	2026-02-15 16:39:49.358851+07	finished	2026-03-11 14:14:32.381553+07
540	5	quiz	1	2026-02-15 16:42:50.798985+07	finished	2026-03-11 14:14:32.381553+07
541	5	quiz	1	2026-02-15 16:43:31.907896+07	finished	2026-03-11 14:14:32.381553+07
542	5	quiz	1	2026-02-15 16:44:04.025056+07	finished	2026-03-11 14:14:32.381553+07
544	5	quiz	1	2026-02-15 16:47:37.112695+07	finished	2026-03-11 14:14:32.381553+07
545	5	quiz	1	2026-02-15 16:59:37.051789+07	finished	2026-03-11 14:14:32.381553+07
546	5	quiz	1	2026-02-15 17:00:04.292386+07	finished	2026-03-11 14:14:32.381553+07
547	5	quiz	1	2026-02-15 17:00:24.919519+07	finished	2026-03-11 14:14:32.381553+07
548	5	quiz	1	2026-02-15 17:00:41.187361+07	finished	2026-03-11 14:14:32.381553+07
549	5	quiz	1	2026-02-15 17:00:55.08574+07	finished	2026-03-11 14:14:32.381553+07
558	5	quiz	1	2026-02-18 13:25:50.006592+07	finished	2026-03-11 14:14:32.381553+07
559	5	quiz	1	2026-02-18 13:33:25.180138+07	finished	2026-03-11 14:14:32.381553+07
560	5	quiz	1	2026-02-18 13:35:13.46458+07	finished	2026-03-11 14:14:32.381553+07
561	5	quiz	1	2026-02-18 13:35:40.087933+07	finished	2026-03-11 14:14:32.381553+07
562	5	quiz	1	2026-02-18 13:36:08.493187+07	finished	2026-03-11 14:14:32.381553+07
563	5	quiz	1	2026-02-18 13:40:56.349356+07	finished	2026-03-11 14:14:32.381553+07
564	5	quiz	1	2026-02-18 13:41:25.52555+07	finished	2026-03-11 14:14:32.381553+07
565	5	quiz	1	2026-02-18 13:43:19.176473+07	finished	2026-03-11 14:14:32.381553+07
566	5	quiz	1	2026-02-18 13:43:34.187535+07	finished	2026-03-11 14:14:32.381553+07
567	5	quiz	1	2026-02-18 13:49:56.357613+07	finished	2026-03-11 14:14:32.381553+07
568	5	quiz	1	2026-02-18 13:50:15.513375+07	finished	2026-03-11 14:14:32.381553+07
569	5	quiz	1	2026-02-18 13:50:47.366745+07	finished	2026-03-11 14:14:32.381553+07
571	5	quiz	1	2026-02-18 13:57:56.133819+07	finished	2026-03-11 14:14:32.381553+07
573	5	quiz	1	2026-02-18 14:08:42.582566+07	finished	2026-03-11 14:14:32.381553+07
574	5	quiz	1	2026-02-18 14:09:01.787398+07	finished	2026-03-11 14:14:32.381553+07
575	5	quiz	1	2026-02-18 14:10:16.699223+07	finished	2026-03-11 14:14:32.381553+07
577	5	quiz	1	2026-02-18 14:11:12.915906+07	finished	2026-03-11 14:14:32.381553+07
578	5	quiz	1	2026-02-18 14:15:45.45527+07	finished	2026-03-11 14:14:32.381553+07
579	5	quiz	1	2026-02-18 14:17:30.781061+07	finished	2026-03-11 14:14:32.381553+07
581	5	quiz	1	2026-02-18 14:18:27.268449+07	finished	2026-03-11 14:14:32.381553+07
582	5	quiz	1	2026-02-18 14:20:44.377402+07	finished	2026-03-11 14:14:32.381553+07
583	5	quiz	1	2026-02-18 14:20:51.856798+07	finished	2026-03-11 14:14:32.381553+07
585	5	quiz	1	2026-02-18 14:21:23.440928+07	finished	2026-03-11 14:14:32.381553+07
586	5	quiz	1	2026-02-18 14:22:13.28943+07	finished	2026-03-11 14:14:32.381553+07
587	5	quiz	1	2026-02-18 14:22:41.792641+07	finished	2026-03-11 14:14:32.381553+07
591	5	quiz	1	2026-02-18 14:27:54.279763+07	finished	2026-03-11 14:14:32.381553+07
592	5	quiz	1	2026-02-18 14:29:31.928907+07	finished	2026-03-11 14:14:32.381553+07
593	5	quiz	1	2026-02-18 14:31:28.700894+07	finished	2026-03-11 14:14:32.381553+07
594	5	quiz	1	2026-02-18 14:34:09.822731+07	finished	2026-03-11 14:14:32.381553+07
595	5	quiz	1	2026-02-18 14:35:56.276291+07	finished	2026-03-11 14:14:32.381553+07
596	5	quiz	1	2026-02-18 14:36:13.853931+07	finished	2026-03-11 14:14:32.381553+07
597	5	quiz	1	2026-02-18 14:37:01.223893+07	finished	2026-03-11 14:14:32.381553+07
598	5	quiz	1	2026-02-18 14:38:34.394388+07	finished	2026-03-11 14:14:32.381553+07
599	5	quiz	1	2026-02-18 14:39:21.036722+07	finished	2026-03-11 14:14:32.381553+07
600	5	quiz	1	2026-02-18 14:40:12.700074+07	finished	2026-03-11 14:14:32.381553+07
601	5	quiz	1	2026-02-18 14:40:43.818864+07	finished	2026-03-11 14:14:32.381553+07
602	5	quiz	1	2026-02-18 14:44:10.844775+07	finished	2026-03-11 14:14:32.381553+07
603	5	quiz	1	2026-02-18 14:48:08.811255+07	finished	2026-03-11 14:14:32.381553+07
604	5	quiz	1	2026-02-18 14:48:23.983231+07	finished	2026-03-11 14:14:32.381553+07
605	5	quiz	1	2026-02-18 14:48:49.535311+07	finished	2026-03-11 14:14:32.381553+07
606	5	quiz	1	2026-02-18 14:49:15.098864+07	finished	2026-03-11 14:14:32.381553+07
607	5	quiz	1	2026-02-18 14:51:20.883296+07	finished	2026-03-11 14:14:32.381553+07
608	5	quiz	1	2026-02-18 14:53:52.090304+07	finished	2026-03-11 14:14:32.381553+07
609	5	quiz	1	2026-02-18 14:54:00.837705+07	finished	2026-03-11 14:14:32.381553+07
611	5	quiz	1	2026-02-18 14:57:34.21804+07	finished	2026-03-11 14:14:32.381553+07
612	5	quiz	1	2026-02-18 15:02:04.830691+07	finished	2026-03-11 14:14:32.381553+07
614	5	quiz	1	2026-02-18 15:07:18.7415+07	finished	2026-03-11 14:14:32.381553+07
615	5	quiz	1	2026-02-18 15:07:39.93261+07	finished	2026-03-11 14:14:32.381553+07
616	5	quiz	1	2026-02-18 15:09:36.047762+07	finished	2026-03-11 14:14:32.381553+07
682	5	quiz	1	2026-02-19 15:45:09.803097+07	finished	2026-03-11 14:14:32.381553+07
683	5	quiz	1	2026-02-19 15:45:44.662229+07	finished	2026-03-11 14:14:32.381553+07
625	5	quiz	1	2026-02-18 15:33:29.369072+07	finished	2026-03-11 14:14:32.381553+07
626	5	quiz	1	2026-02-18 15:34:06.119791+07	finished	2026-03-11 14:14:32.381553+07
627	5	quiz	1	2026-02-18 15:35:50.36021+07	finished	2026-03-11 14:14:32.381553+07
628	5	quiz	1	2026-02-18 15:36:05.588394+07	finished	2026-03-11 14:14:32.381553+07
629	5	quiz	1	2026-02-18 15:38:16.282413+07	finished	2026-03-11 14:14:32.381553+07
630	5	quiz	1	2026-02-18 15:44:35.586923+07	finished	2026-03-11 14:14:32.381553+07
631	5	quiz	1	2026-02-18 16:26:37.106756+07	finished	2026-03-11 14:14:32.381553+07
632	5	quiz	1	2026-02-18 16:37:41.377811+07	finished	2026-03-11 14:14:32.381553+07
633	5	quiz	1	2026-02-18 16:38:35.400761+07	finished	2026-03-11 14:14:32.381553+07
634	5	quiz	1	2026-02-18 16:47:13.847637+07	finished	2026-03-11 14:14:32.381553+07
635	5	quiz	1	2026-02-19 13:34:01.719641+07	finished	2026-03-11 14:14:32.381553+07
636	5	quiz	1	2026-02-19 13:35:14.308193+07	finished	2026-03-11 14:14:32.381553+07
637	5	quiz	1	2026-02-19 13:35:51.176989+07	finished	2026-03-11 14:14:32.381553+07
638	5	quiz	1	2026-02-19 13:49:55.823167+07	finished	2026-03-11 14:14:32.381553+07
639	5	quiz	1	2026-02-19 13:51:11.330362+07	finished	2026-03-11 14:14:32.381553+07
640	5	quiz	1	2026-02-19 13:57:23.787443+07	finished	2026-03-11 14:14:32.381553+07
642	5	quiz	1	2026-02-19 14:02:34.829933+07	finished	2026-03-11 14:14:32.381553+07
643	5	quiz	1	2026-02-19 14:02:53.917689+07	finished	2026-03-11 14:14:32.381553+07
645	5	quiz	1	2026-02-19 14:07:06.820798+07	finished	2026-03-11 14:14:32.381553+07
646	5	quiz	1	2026-02-19 14:07:36.97424+07	finished	2026-03-11 14:14:32.381553+07
647	5	quiz	1	2026-02-19 14:10:05.162368+07	finished	2026-03-11 14:14:32.381553+07
648	5	quiz	1	2026-02-19 14:13:47.894968+07	finished	2026-03-11 14:14:32.381553+07
649	5	quiz	1	2026-02-19 14:14:04.590684+07	finished	2026-03-11 14:14:32.381553+07
650	5	quiz	1	2026-02-19 14:16:38.934844+07	finished	2026-03-11 14:14:32.381553+07
651	5	quiz	1	2026-02-19 14:16:49.959166+07	finished	2026-03-11 14:14:32.381553+07
652	5	quiz	1	2026-02-19 14:17:47.346809+07	finished	2026-03-11 14:14:32.381553+07
653	5	quiz	1	2026-02-19 14:18:16.922869+07	finished	2026-03-11 14:14:32.381553+07
654	5	quiz	1	2026-02-19 14:22:31.547216+07	finished	2026-03-11 14:14:32.381553+07
660	5	quiz	1	2026-02-19 14:59:51.042549+07	finished	2026-03-11 14:14:32.381553+07
661	5	quiz	1	2026-02-19 15:07:23.809652+07	finished	2026-03-11 14:14:32.381553+07
662	5	quiz	1	2026-02-19 15:07:51.612831+07	finished	2026-03-11 14:14:32.381553+07
663	5	quiz	1	2026-02-19 15:08:15.629601+07	finished	2026-03-11 14:14:32.381553+07
664	5	quiz	1	2026-02-19 15:08:41.186438+07	finished	2026-03-11 14:14:32.381553+07
665	5	quiz	1	2026-02-19 15:09:08.018235+07	finished	2026-03-11 14:14:32.381553+07
667	5	quiz	1	2026-02-19 15:14:20.197074+07	finished	2026-03-11 14:14:32.381553+07
668	5	quiz	1	2026-02-19 15:20:41.229647+07	finished	2026-03-11 14:14:32.381553+07
669	5	quiz	1	2026-02-19 15:21:06.716999+07	finished	2026-03-11 14:14:32.381553+07
670	5	quiz	1	2026-02-19 15:21:33.929424+07	finished	2026-03-11 14:14:32.381553+07
671	5	quiz	1	2026-02-19 15:25:25.154065+07	finished	2026-03-11 14:14:32.381553+07
672	5	quiz	1	2026-02-19 15:25:58.43101+07	finished	2026-03-11 14:14:32.381553+07
673	5	quiz	1	2026-02-19 15:26:26.487348+07	finished	2026-03-11 14:14:32.381553+07
674	5	quiz	1	2026-02-19 15:27:01.678519+07	finished	2026-03-11 14:14:32.381553+07
675	5	quiz	1	2026-02-19 15:30:53.116035+07	finished	2026-03-11 14:14:32.381553+07
676	5	quiz	1	2026-02-19 15:36:13.727058+07	finished	2026-03-11 14:14:32.381553+07
677	5	quiz	1	2026-02-19 15:36:46.241484+07	finished	2026-03-11 14:14:32.381553+07
678	5	quiz	1	2026-02-19 15:37:05.573178+07	finished	2026-03-11 14:14:32.381553+07
679	5	quiz	1	2026-02-19 15:37:43.883301+07	finished	2026-03-11 14:14:32.381553+07
681	5	quiz	1	2026-02-19 15:44:34.527928+07	finished	2026-03-11 14:14:32.381553+07
685	5	quiz	1	2026-02-19 15:50:00.099871+07	finished	2026-03-11 14:14:32.381553+07
686	5	quiz	1	2026-02-19 15:50:44.038108+07	finished	2026-03-11 14:14:32.381553+07
688	5	quiz	1	2026-02-19 15:56:48.688901+07	finished	2026-03-11 14:14:32.381553+07
689	5	quiz	1	2026-02-19 15:57:19.526507+07	finished	2026-03-11 14:14:32.381553+07
691	5	quiz	1	2026-02-19 15:57:52.340733+07	finished	2026-03-11 14:14:32.381553+07
692	5	quiz	1	2026-02-19 15:58:25.135056+07	finished	2026-03-11 14:14:32.381553+07
693	5	quiz	1	2026-02-19 15:58:56.954428+07	finished	2026-03-11 14:14:32.381553+07
695	5	quiz	1	2026-02-19 16:03:20.768533+07	finished	2026-03-11 14:14:32.381553+07
696	5	quiz	1	2026-02-19 16:03:42.862885+07	finished	2026-03-11 14:14:32.381553+07
697	5	quiz	1	2026-02-19 16:04:09.488887+07	finished	2026-03-11 14:14:32.381553+07
698	5	quiz	1	2026-02-19 16:10:06.211191+07	finished	2026-03-11 14:14:32.381553+07
699	5	quiz	1	2026-02-19 16:10:43.511959+07	finished	2026-03-11 14:14:32.381553+07
700	5	quiz	1	2026-02-19 16:17:34.709812+07	finished	2026-03-11 14:14:32.381553+07
701	5	quiz	1	2026-02-19 16:18:16.13843+07	finished	2026-03-11 14:14:32.381553+07
702	5	quiz	1	2026-02-19 16:31:09.883257+07	finished	2026-03-11 14:14:32.381553+07
703	5	quiz	1	2026-02-19 16:32:28.301328+07	finished	2026-03-11 14:14:32.381553+07
704	5	quiz	1	2026-02-19 16:40:08.770211+07	finished	2026-03-11 14:14:32.381553+07
705	5	quiz	1	2026-02-19 16:40:45.773406+07	finished	2026-03-11 14:14:32.381553+07
706	5	quiz	1	2026-02-19 16:41:05.058109+07	finished	2026-03-11 14:14:32.381553+07
707	5	quiz	1	2026-02-19 16:46:23.440127+07	finished	2026-03-11 14:14:32.381553+07
708	5	quiz	1	2026-02-19 16:50:27.055899+07	finished	2026-03-11 14:14:32.381553+07
709	5	quiz	1	2026-02-19 16:50:43.628451+07	finished	2026-03-11 14:14:32.381553+07
710	5	quiz	1	2026-02-19 16:55:41.69893+07	finished	2026-03-11 14:14:32.381553+07
711	5	quiz	1	2026-02-19 16:58:33.686926+07	finished	2026-03-11 14:14:32.381553+07
712	5	quiz	1	2026-02-19 17:08:10.139+07	finished	2026-03-11 14:14:32.381553+07
713	5	quiz	1	2026-02-19 17:08:22.292647+07	finished	2026-03-11 14:14:32.381553+07
714	5	quiz	1	2026-02-19 17:08:42.457731+07	finished	2026-03-11 14:14:32.381553+07
715	5	quiz	1	2026-02-19 17:20:28.43792+07	finished	2026-03-11 14:14:32.381553+07
716	5	quiz	1	2026-02-19 17:20:49.762792+07	finished	2026-03-11 14:14:32.381553+07
717	5	quiz	1	2026-02-19 17:21:51.975621+07	finished	2026-03-11 14:14:32.381553+07
718	5	quiz	1	2026-02-19 17:23:39.2887+07	finished	2026-03-11 14:14:32.381553+07
719	5	quiz	1	2026-02-19 17:25:01.454265+07	finished	2026-03-11 14:14:32.381553+07
720	5	quiz	1	2026-02-19 17:25:28.469151+07	finished	2026-03-11 14:14:32.381553+07
721	5	quiz	1	2026-02-19 17:28:43.667193+07	finished	2026-03-11 14:14:32.381553+07
722	5	quiz	1	2026-02-19 17:30:18.884624+07	finished	2026-03-11 14:14:32.381553+07
723	5	quiz	1	2026-02-19 17:30:57.075334+07	finished	2026-03-11 14:14:32.381553+07
724	5	quiz	1	2026-02-19 17:31:17.537076+07	finished	2026-03-11 14:14:32.381553+07
725	5	quiz	1	2026-02-19 17:31:34.267269+07	finished	2026-03-11 14:14:32.381553+07
726	5	quiz	1	2026-02-19 17:32:23.288829+07	finished	2026-03-11 14:14:32.381553+07
727	5	quiz	1	2026-02-19 17:34:13.544577+07	finished	2026-03-11 14:14:32.381553+07
728	5	quiz	1	2026-02-22 13:34:24.930865+07	finished	2026-03-11 14:14:32.381553+07
729	5	quiz	1	2026-02-22 13:35:13.544059+07	finished	2026-03-11 14:14:32.381553+07
730	5	quiz	1	2026-02-22 13:35:54.648267+07	finished	2026-03-11 14:14:32.381553+07
731	5	quiz	1	2026-02-22 13:36:28.866794+07	finished	2026-03-11 14:14:32.381553+07
732	5	quiz	1	2026-02-22 13:38:11.647801+07	finished	2026-03-11 14:14:32.381553+07
733	5	quiz	1	2026-02-22 13:45:21.698449+07	finished	2026-03-11 14:14:32.381553+07
734	5	quiz	1	2026-02-22 13:45:35.669491+07	finished	2026-03-11 14:14:32.381553+07
735	5	quiz	1	2026-02-22 13:45:54.519551+07	finished	2026-03-11 14:14:32.381553+07
736	5	quiz	1	2026-02-22 13:46:21.895673+07	finished	2026-03-11 14:14:32.381553+07
737	5	quiz	1	2026-02-22 13:54:53.047944+07	finished	2026-03-11 14:14:32.381553+07
738	5	quiz	1	2026-02-22 13:55:35.422001+07	finished	2026-03-11 14:14:32.381553+07
739	5	quiz	1	2026-02-22 13:55:48.88015+07	finished	2026-03-11 14:14:32.381553+07
740	5	quiz	1	2026-02-22 13:56:31.228033+07	finished	2026-03-11 14:14:32.381553+07
741	5	quiz	1	2026-02-22 13:57:05.396492+07	finished	2026-03-11 14:14:32.381553+07
743	5	quiz	1	2026-02-22 14:01:32.065296+07	finished	2026-03-11 14:14:32.381553+07
744	5	quiz	1	2026-02-22 14:01:59.801438+07	finished	2026-03-11 14:14:32.381553+07
746	5	quiz	1	2026-02-22 14:04:25.191235+07	finished	2026-03-11 14:14:32.381553+07
747	5	quiz	1	2026-02-22 14:05:44.54768+07	finished	2026-03-11 14:14:32.381553+07
748	5	quiz	1	2026-02-22 14:06:06.173155+07	finished	2026-03-11 14:14:32.381553+07
750	5	quiz	1	2026-02-22 14:08:26.779528+07	finished	2026-03-11 14:14:32.381553+07
751	5	quiz	1	2026-02-22 14:08:40.437934+07	finished	2026-03-11 14:14:32.381553+07
752	5	quiz	1	2026-02-22 14:10:26.064043+07	finished	2026-03-11 14:14:32.381553+07
754	5	quiz	1	2026-02-22 14:14:26.881914+07	finished	2026-03-11 14:14:32.381553+07
755	5	quiz	1	2026-02-22 14:14:47.48153+07	finished	2026-03-11 14:14:32.381553+07
756	5	quiz	1	2026-02-22 14:15:01.647287+07	finished	2026-03-11 14:14:32.381553+07
758	5	quiz	1	2026-02-22 14:17:37.902126+07	finished	2026-03-11 14:14:32.381553+07
759	5	quiz	1	2026-02-22 14:18:06.649329+07	finished	2026-03-11 14:14:32.381553+07
760	5	quiz	1	2026-02-22 14:18:16.338728+07	finished	2026-03-11 14:14:32.381553+07
761	5	quiz	1	2026-02-22 14:18:29.145844+07	finished	2026-03-11 14:14:32.381553+07
762	5	quiz	1	2026-02-22 14:19:11.390289+07	finished	2026-03-11 14:14:32.381553+07
763	5	quiz	1	2026-02-22 14:19:30.615288+07	finished	2026-03-11 14:14:32.381553+07
764	5	quiz	1	2026-02-22 14:20:26.59449+07	finished	2026-03-11 14:14:32.381553+07
765	5	quiz	1	2026-02-22 14:20:47.966583+07	finished	2026-03-11 14:14:32.381553+07
766	5	quiz	1	2026-02-22 14:21:17.138463+07	finished	2026-03-11 14:14:32.381553+07
767	5	quiz	1	2026-02-22 14:21:35.313675+07	finished	2026-03-11 14:14:32.381553+07
768	5	quiz	1	2026-02-22 14:21:49.232856+07	finished	2026-03-11 14:14:32.381553+07
771	5	quiz	1	2026-02-22 14:27:32.866838+07	finished	2026-03-11 14:14:32.381553+07
772	5	quiz	1	2026-02-22 14:28:04.221111+07	finished	2026-03-11 14:14:32.381553+07
773	5	quiz	1	2026-02-22 14:28:20.907703+07	finished	2026-03-11 14:14:32.381553+07
774	5	quiz	1	2026-02-22 14:28:49.388804+07	finished	2026-03-11 14:14:32.381553+07
775	5	quiz	1	2026-02-22 14:28:56.835587+07	finished	2026-03-11 14:14:32.381553+07
777	5	quiz	1	2026-02-22 14:29:09.392936+07	finished	2026-03-11 14:14:32.381553+07
778	5	quiz	1	2026-02-22 14:29:25.249364+07	finished	2026-03-11 14:14:32.381553+07
782	5	quiz	1	2026-02-22 14:39:26.723847+07	finished	2026-03-11 14:14:32.381553+07
783	5	quiz	1	2026-02-22 14:39:47.557753+07	finished	2026-03-11 14:14:32.381553+07
785	5	quiz	1	2026-02-22 14:45:10.118395+07	finished	2026-03-11 14:14:32.381553+07
786	5	quiz	1	2026-02-22 14:45:35.278434+07	finished	2026-03-11 14:14:32.381553+07
787	5	quiz	1	2026-02-22 14:45:55.953842+07	finished	2026-03-11 14:14:32.381553+07
789	5	quiz	1	2026-02-22 14:46:36.508349+07	finished	2026-03-11 14:14:32.381553+07
790	5	quiz	1	2026-02-22 14:46:50.784539+07	finished	2026-03-11 14:14:32.381553+07
791	5	quiz	1	2026-02-22 14:47:11.199038+07	finished	2026-03-11 14:14:32.381553+07
792	5	quiz	1	2026-02-22 14:50:51.871876+07	finished	2026-03-11 14:14:32.381553+07
793	5	quiz	1	2026-02-22 14:51:06.468355+07	finished	2026-03-11 14:14:32.381553+07
795	5	quiz	1	2026-02-22 14:54:46.837623+07	finished	2026-03-11 14:14:32.381553+07
796	5	quiz	1	2026-02-22 14:54:59.980694+07	finished	2026-03-11 14:14:32.381553+07
797	5	quiz	1	2026-02-22 14:56:46.103936+07	finished	2026-03-11 14:14:32.381553+07
798	5	quiz	1	2026-02-22 14:56:59.613012+07	finished	2026-03-11 14:14:32.381553+07
799	5	quiz	1	2026-02-22 14:57:20.966221+07	finished	2026-03-11 14:14:32.381553+07
800	5	quiz	1	2026-02-22 14:57:38.875039+07	finished	2026-03-11 14:14:32.381553+07
801	5	quiz	1	2026-02-22 14:58:02.399806+07	finished	2026-03-11 14:14:32.381553+07
802	5	quiz	1	2026-02-22 14:58:11.479168+07	finished	2026-03-11 14:14:32.381553+07
803	5	quiz	1	2026-02-22 14:58:19.041654+07	finished	2026-03-11 14:14:32.381553+07
804	5	quiz	1	2026-02-22 15:00:10.806018+07	finished	2026-03-11 14:14:32.381553+07
805	5	quiz	1	2026-02-22 15:00:27.073563+07	finished	2026-03-11 14:14:32.381553+07
806	5	quiz	1	2026-02-22 15:00:44.151708+07	finished	2026-03-11 14:14:32.381553+07
809	5	quiz	1	2026-02-22 15:10:37.616347+07	finished	2026-03-11 14:14:32.381553+07
810	5	quiz	1	2026-02-22 15:10:53.143659+07	finished	2026-03-11 14:14:32.381553+07
812	5	quiz	1	2026-02-22 15:13:03.158548+07	finished	2026-03-11 14:14:32.381553+07
814	5	quiz	1	2026-02-22 15:13:43.517241+07	finished	2026-03-11 14:14:32.381553+07
815	5	quiz	1	2026-02-22 15:14:07.402131+07	finished	2026-03-11 14:14:32.381553+07
816	5	quiz	1	2026-02-22 15:14:22.972565+07	finished	2026-03-11 14:14:32.381553+07
817	5	quiz	1	2026-02-22 15:14:32.735842+07	finished	2026-03-11 14:14:32.381553+07
818	5	quiz	1	2026-02-22 15:14:44.653614+07	finished	2026-03-11 14:14:32.381553+07
819	5	quiz	1	2026-02-22 15:15:03.666286+07	finished	2026-03-11 14:14:32.381553+07
821	5	quiz	1	2026-02-22 15:18:10.624502+07	finished	2026-03-11 14:14:32.381553+07
822	5	quiz	1	2026-02-22 15:18:35.782691+07	finished	2026-03-11 14:14:32.381553+07
823	5	quiz	1	2026-02-22 15:25:35.892577+07	finished	2026-03-11 14:14:32.381553+07
824	5	quiz	1	2026-02-22 15:25:53.096381+07	finished	2026-03-11 14:14:32.381553+07
825	5	quiz	1	2026-02-22 15:26:21.642613+07	finished	2026-03-11 14:14:32.381553+07
826	5	quiz	1	2026-02-22 15:26:50.717972+07	finished	2026-03-11 14:14:32.381553+07
827	5	quiz	1	2026-02-22 15:30:20.62662+07	finished	2026-03-11 14:14:32.381553+07
828	5	quiz	1	2026-02-22 15:30:48.231886+07	finished	2026-03-11 14:14:32.381553+07
829	5	quiz	1	2026-02-22 15:30:56.999191+07	finished	2026-03-11 14:14:32.381553+07
830	5	quiz	1	2026-02-22 15:31:17.998367+07	finished	2026-03-11 14:14:32.381553+07
831	5	quiz	1	2026-02-22 15:31:48.00502+07	finished	2026-03-11 14:14:32.381553+07
832	5	quiz	1	2026-02-22 15:32:28.250725+07	finished	2026-03-11 14:14:32.381553+07
833	5	quiz	1	2026-02-22 15:32:46.166422+07	finished	2026-03-11 14:14:32.381553+07
834	5	quiz	1	2026-02-22 15:33:07.596061+07	finished	2026-03-11 14:14:32.381553+07
835	5	quiz	1	2026-02-22 15:33:27.930157+07	finished	2026-03-11 14:14:32.381553+07
836	5	quiz	1	2026-02-22 15:33:51.289097+07	finished	2026-03-11 14:14:32.381553+07
837	5	quiz	1	2026-02-22 15:33:58.908033+07	finished	2026-03-11 14:14:32.381553+07
838	5	quiz	1	2026-02-22 15:34:09.585171+07	finished	2026-03-11 14:14:32.381553+07
839	5	quiz	1	2026-02-22 15:34:27.786879+07	finished	2026-03-11 14:14:32.381553+07
840	5	quiz	1	2026-02-22 15:34:45.688214+07	finished	2026-03-11 14:14:32.381553+07
841	5	quiz	1	2026-02-22 15:35:06.750772+07	finished	2026-03-11 14:14:32.381553+07
842	5	quiz	1	2026-02-22 15:39:41.177502+07	finished	2026-03-11 14:14:32.381553+07
843	5	quiz	1	2026-02-22 15:40:12.27779+07	finished	2026-03-11 14:14:32.381553+07
844	5	quiz	1	2026-02-22 15:40:31.465653+07	finished	2026-03-11 14:14:32.381553+07
845	5	quiz	1	2026-02-22 15:41:01.565508+07	finished	2026-03-11 14:14:32.381553+07
846	5	quiz	1	2026-02-22 15:41:20.692624+07	finished	2026-03-11 14:14:32.381553+07
847	5	quiz	1	2026-02-22 15:41:34.950354+07	finished	2026-03-11 14:14:32.381553+07
848	5	quiz	1	2026-02-22 15:42:08.936306+07	finished	2026-03-11 14:14:32.381553+07
849	5	quiz	1	2026-02-22 15:42:31.017781+07	finished	2026-03-11 14:14:32.381553+07
850	5	quiz	1	2026-02-22 15:46:54.204898+07	finished	2026-03-11 14:14:32.381553+07
851	5	quiz	1	2026-02-22 15:47:18.865657+07	finished	2026-03-11 14:14:32.381553+07
852	5	quiz	1	2026-02-22 15:47:38.363604+07	finished	2026-03-11 14:14:32.381553+07
853	5	quiz	1	2026-02-22 15:51:24.541542+07	finished	2026-03-11 14:14:32.381553+07
854	5	quiz	1	2026-02-22 15:52:15.046424+07	finished	2026-03-11 14:14:32.381553+07
855	5	quiz	1	2026-02-22 15:56:48.293008+07	finished	2026-03-11 14:14:32.381553+07
857	5	quiz	1	2026-02-22 15:59:04.77483+07	finished	2026-03-11 14:14:32.381553+07
858	5	quiz	1	2026-02-22 15:59:23.057931+07	finished	2026-03-11 14:14:32.381553+07
859	5	quiz	1	2026-02-22 15:59:48.354644+07	finished	2026-03-11 14:14:32.381553+07
860	5	quiz	1	2026-02-22 16:00:07.086574+07	finished	2026-03-11 14:14:32.381553+07
861	5	quiz	1	2026-02-22 16:00:22.617999+07	finished	2026-03-11 14:14:32.381553+07
871	5	quiz	1	2026-02-22 16:32:02.116559+07	finished	2026-03-11 14:14:32.381553+07
872	5	quiz	1	2026-02-22 16:33:45.301013+07	finished	2026-03-11 14:14:32.381553+07
873	5	quiz	1	2026-02-22 16:34:14.633852+07	finished	2026-03-11 14:14:32.381553+07
874	5	quiz	1	2026-02-22 16:35:11.829418+07	finished	2026-03-11 14:14:32.381553+07
875	5	quiz	1	2026-02-22 16:35:42.881467+07	finished	2026-03-11 14:14:32.381553+07
876	5	quiz	1	2026-02-22 16:36:34.789596+07	finished	2026-03-11 14:14:32.381553+07
877	5	quiz	1	2026-02-22 16:37:11.367377+07	finished	2026-03-11 14:14:32.381553+07
878	5	quiz	1	2026-02-22 16:42:20.259301+07	finished	2026-03-11 14:14:32.381553+07
879	5	quiz	1	2026-02-22 16:46:11.717133+07	finished	2026-03-11 14:14:32.381553+07
880	5	quiz	1	2026-02-22 16:46:40.624367+07	finished	2026-03-11 14:14:32.381553+07
881	5	quiz	1	2026-02-22 16:53:18.505811+07	finished	2026-03-11 14:14:32.381553+07
882	5	quiz	1	2026-02-23 13:39:59.585642+07	finished	2026-03-11 14:14:32.381553+07
883	5	quiz	1	2026-02-23 13:40:27.333103+07	finished	2026-03-11 14:14:32.381553+07
884	5	quiz	1	2026-02-23 13:40:48.281187+07	finished	2026-03-11 14:14:32.381553+07
885	5	quiz	1	2026-02-23 13:41:13.382015+07	finished	2026-03-11 14:14:32.381553+07
886	5	quiz	1	2026-02-23 13:41:33.263424+07	finished	2026-03-11 14:14:32.381553+07
887	5	quiz	1	2026-02-23 13:41:56.810549+07	finished	2026-03-11 14:14:32.381553+07
888	5	quiz	1	2026-02-23 13:42:15.377469+07	finished	2026-03-11 14:14:32.381553+07
889	5	quiz	1	2026-02-23 13:42:36.175481+07	finished	2026-03-11 14:14:32.381553+07
890	5	quiz	1	2026-02-23 13:42:57.519908+07	finished	2026-03-11 14:14:32.381553+07
891	5	quiz	1	2026-02-23 13:45:48.733015+07	finished	2026-03-11 14:14:32.381553+07
892	5	quiz	1	2026-02-23 13:46:11.047869+07	finished	2026-03-11 14:14:32.381553+07
893	5	quiz	1	2026-02-23 13:46:30.869538+07	finished	2026-03-11 14:14:32.381553+07
894	5	quiz	1	2026-02-23 13:46:50.327765+07	finished	2026-03-11 14:14:32.381553+07
895	5	quiz	1	2026-02-23 13:47:10.262669+07	finished	2026-03-11 14:14:32.381553+07
896	5	quiz	1	2026-02-23 13:47:27.325983+07	finished	2026-03-11 14:14:32.381553+07
897	5	quiz	1	2026-02-23 13:47:43.03017+07	finished	2026-03-11 14:14:32.381553+07
898	5	quiz	1	2026-02-23 13:50:52.900068+07	finished	2026-03-11 14:14:32.381553+07
899	5	quiz	1	2026-02-23 13:51:16.020248+07	finished	2026-03-11 14:14:32.381553+07
900	5	quiz	1	2026-02-23 13:52:10.624427+07	finished	2026-03-11 14:14:32.381553+07
901	5	quiz	1	2026-02-23 13:52:32.093059+07	finished	2026-03-11 14:14:32.381553+07
902	5	quiz	1	2026-02-23 13:52:47.914694+07	finished	2026-03-11 14:14:32.381553+07
903	5	quiz	1	2026-02-23 13:53:05.515372+07	finished	2026-03-11 14:14:32.381553+07
904	5	quiz	1	2026-02-23 13:53:39.598747+07	finished	2026-03-11 14:14:32.381553+07
905	5	quiz	1	2026-02-23 13:54:04.313091+07	finished	2026-03-11 14:14:32.381553+07
906	5	quiz	1	2026-02-23 13:54:20.054188+07	finished	2026-03-11 14:14:32.381553+07
907	5	quiz	1	2026-02-23 13:57:48.925172+07	finished	2026-03-11 14:14:32.381553+07
908	5	quiz	1	2026-02-23 14:00:16.750958+07	finished	2026-03-11 14:14:32.381553+07
909	5	quiz	1	2026-02-23 14:01:09.975477+07	finished	2026-03-11 14:14:32.381553+07
910	5	quiz	1	2026-02-23 14:03:39.61299+07	finished	2026-03-11 14:14:32.381553+07
911	5	quiz	1	2026-02-23 14:04:00.415754+07	finished	2026-03-11 14:14:32.381553+07
912	5	quiz	1	2026-02-23 14:04:22.272537+07	finished	2026-03-11 14:14:32.381553+07
913	5	quiz	1	2026-02-23 14:09:18.96144+07	finished	2026-03-11 14:14:32.381553+07
914	5	quiz	1	2026-02-23 14:09:40.23318+07	finished	2026-03-11 14:14:32.381553+07
915	5	quiz	1	2026-02-23 14:09:55.940985+07	finished	2026-03-11 14:14:32.381553+07
916	5	quiz	1	2026-02-23 14:10:09.775151+07	finished	2026-03-11 14:14:32.381553+07
917	5	quiz	1	2026-02-23 14:10:44.48023+07	finished	2026-03-11 14:14:32.381553+07
918	5	quiz	1	2026-02-23 14:14:25.842077+07	finished	2026-03-11 14:14:32.381553+07
919	5	quiz	1	2026-02-23 14:14:47.539135+07	finished	2026-03-11 14:14:32.381553+07
920	5	quiz	1	2026-02-23 14:17:41.251044+07	finished	2026-03-11 14:14:32.381553+07
921	5	quiz	1	2026-02-23 14:17:57.228728+07	finished	2026-03-11 14:14:32.381553+07
922	5	quiz	1	2026-02-23 14:18:33.044466+07	finished	2026-03-11 14:14:32.381553+07
923	5	quiz	1	2026-02-23 14:18:53.130952+07	finished	2026-03-11 14:14:32.381553+07
924	5	quiz	1	2026-02-23 14:19:11.796727+07	finished	2026-03-11 14:14:32.381553+07
925	5	quiz	1	2026-02-23 14:19:49.898048+07	finished	2026-03-11 14:14:32.381553+07
926	5	quiz	1	2026-02-23 14:20:06.950056+07	finished	2026-03-11 14:14:32.381553+07
927	5	quiz	1	2026-02-23 14:20:42.592704+07	finished	2026-03-11 14:14:32.381553+07
928	5	quiz	1	2026-02-23 14:21:03.830038+07	finished	2026-03-11 14:14:32.381553+07
929	5	quiz	1	2026-02-23 14:21:19.606155+07	finished	2026-03-11 14:14:32.381553+07
930	5	quiz	1	2026-02-23 14:21:34.599399+07	finished	2026-03-11 14:14:32.381553+07
931	5	quiz	1	2026-02-23 14:21:53.09554+07	finished	2026-03-11 14:14:32.381553+07
932	5	quiz	1	2026-02-23 14:22:11.980347+07	finished	2026-03-11 14:14:32.381553+07
933	5	quiz	1	2026-02-23 14:22:36.968514+07	finished	2026-03-11 14:14:32.381553+07
934	5	quiz	1	2026-02-23 14:22:52.672127+07	finished	2026-03-11 14:14:32.381553+07
935	5	quiz	1	2026-02-23 14:23:11.19721+07	finished	2026-03-11 14:14:32.381553+07
936	5	quiz	1	2026-02-23 14:25:35.208835+07	finished	2026-03-11 14:14:32.381553+07
937	5	quiz	1	2026-02-23 14:26:05.510595+07	finished	2026-03-11 14:14:32.381553+07
938	5	quiz	1	2026-02-23 14:26:26.321654+07	finished	2026-03-11 14:14:32.381553+07
939	5	quiz	1	2026-02-23 14:26:46.550038+07	finished	2026-03-11 14:14:32.381553+07
940	5	quiz	1	2026-02-23 14:27:03.125585+07	finished	2026-03-11 14:14:32.381553+07
941	5	quiz	1	2026-02-23 14:27:16.129945+07	finished	2026-03-11 14:14:32.381553+07
942	5	quiz	1	2026-02-23 14:27:33.711467+07	finished	2026-03-11 14:14:32.381553+07
943	5	quiz	1	2026-02-23 14:27:47.204589+07	finished	2026-03-11 14:14:32.381553+07
944	5	quiz	1	2026-02-23 14:27:59.161155+07	finished	2026-03-11 14:14:32.381553+07
945	5	quiz	1	2026-02-23 14:28:13.78535+07	finished	2026-03-11 14:14:32.381553+07
946	5	quiz	1	2026-02-23 14:28:33.537649+07	finished	2026-03-11 14:14:32.381553+07
947	5	quiz	1	2026-02-23 15:13:30.265261+07	finished	2026-03-11 14:14:32.381553+07
948	5	quiz	1	2026-02-23 15:14:21.34932+07	finished	2026-03-11 14:14:32.381553+07
949	5	quiz	1	2026-02-23 15:14:30.49986+07	finished	2026-03-11 14:14:32.381553+07
950	5	quiz	1	2026-02-23 15:17:50.430299+07	finished	2026-03-11 14:14:32.381553+07
951	5	quiz	1	2026-02-23 15:22:47.586819+07	finished	2026-03-11 14:14:32.381553+07
952	5	quiz	1	2026-02-23 15:26:26.01701+07	finished	2026-03-11 14:14:32.381553+07
953	5	quiz	1	2026-02-23 15:33:00.603361+07	finished	2026-03-11 14:14:32.381553+07
954	5	quiz	1	2026-02-23 15:33:57.950307+07	finished	2026-03-11 14:14:32.381553+07
955	5	quiz	1	2026-02-23 15:34:40.500551+07	finished	2026-03-11 14:14:32.381553+07
956	5	quiz	1	2026-02-23 15:41:48.714901+07	finished	2026-03-11 14:14:32.381553+07
957	5	quiz	1	2026-02-23 15:52:20.741584+07	finished	2026-03-11 14:14:32.381553+07
958	5	quiz	1	2026-02-23 16:02:33.186993+07	finished	2026-03-11 14:14:32.381553+07
959	5	quiz	1	2026-02-23 16:03:16.307418+07	finished	2026-03-11 14:14:32.381553+07
960	5	quiz	1	2026-02-23 16:06:29.135626+07	finished	2026-03-11 14:14:32.381553+07
961	5	quiz	1	2026-02-23 16:09:34.930373+07	finished	2026-03-11 14:14:32.381553+07
962	5	quiz	1	2026-02-23 16:11:18.71274+07	finished	2026-03-11 14:14:32.381553+07
963	5	quiz	1	2026-02-23 16:13:18.072593+07	finished	2026-03-11 14:14:32.381553+07
964	5	quiz	1	2026-02-23 16:13:59.844439+07	finished	2026-03-11 14:14:32.381553+07
965	5	quiz	1	2026-02-23 16:16:31.355629+07	finished	2026-03-11 14:14:32.381553+07
966	5	quiz	1	2026-02-23 16:18:11.370957+07	finished	2026-03-11 14:14:32.381553+07
967	5	quiz	1	2026-02-23 16:20:23.319477+07	finished	2026-03-11 14:14:32.381553+07
968	5	quiz	1	2026-02-23 16:28:16.691922+07	finished	2026-03-11 14:14:32.381553+07
969	5	quiz	1	2026-02-23 16:28:35.18913+07	finished	2026-03-11 14:14:32.381553+07
970	5	quiz	1	2026-02-23 16:28:45.699156+07	finished	2026-03-11 14:14:32.381553+07
971	5	quiz	1	2026-02-23 16:30:31.128502+07	finished	2026-03-11 14:14:32.381553+07
972	5	quiz	1	2026-02-23 16:59:44.307684+07	finished	2026-03-11 14:14:32.381553+07
973	5	quiz	1	2026-02-23 17:06:47.125795+07	finished	2026-03-11 14:14:32.381553+07
974	5	quiz	1	2026-02-23 17:11:15.386008+07	finished	2026-03-11 14:14:32.381553+07
975	5	quiz	1	2026-02-23 17:20:24.823437+07	finished	2026-03-11 14:14:32.381553+07
976	5	quiz	1	2026-02-23 17:20:52.076776+07	finished	2026-03-11 14:14:32.381553+07
977	5	quiz	1	2026-02-23 17:21:26.745477+07	finished	2026-03-11 14:14:32.381553+07
978	5	quiz	1	2026-02-23 17:21:51.707686+07	finished	2026-03-11 14:14:32.381553+07
979	5	quiz	1	2026-02-23 17:29:56.489657+07	finished	2026-03-11 14:14:32.381553+07
980	5	quiz	1	2026-02-23 17:30:04.593943+07	finished	2026-03-11 14:14:32.381553+07
981	5	quiz	1	2026-02-23 17:30:25.851626+07	finished	2026-03-11 14:14:32.381553+07
982	5	quiz	1	2026-02-23 17:34:50.378737+07	finished	2026-03-11 14:14:32.381553+07
983	5	quiz	1	2026-02-23 17:41:11.034912+07	finished	2026-03-11 14:14:32.381553+07
984	5	quiz	1	2026-02-23 17:41:25.925029+07	finished	2026-03-11 14:14:32.381553+07
985	5	quiz	1	2026-02-23 17:41:32.838728+07	finished	2026-03-11 14:14:32.381553+07
986	5	quiz	1	2026-02-23 17:51:42.218587+07	finished	2026-03-11 14:14:32.381553+07
987	5	quiz	1	2026-02-23 17:56:36.585162+07	finished	2026-03-11 14:14:32.381553+07
988	5	quiz	1	2026-02-25 14:52:41.800724+07	finished	2026-03-11 14:14:32.381553+07
989	5	quiz	1	2026-02-25 15:17:31.780316+07	finished	2026-03-11 14:14:32.381553+07
990	5	quiz	1	2026-02-25 15:18:35.162705+07	finished	2026-03-11 14:14:32.381553+07
991	5	quiz	1	2026-02-25 15:26:10.987331+07	finished	2026-03-11 14:14:32.381553+07
994	5	quiz	1	2026-03-02 14:27:29.027792+07	finished	2026-03-11 14:14:32.381553+07
995	5	quiz	1	2026-03-02 14:28:13.690687+07	finished	2026-03-11 14:14:32.381553+07
998	5	quiz	1	2026-03-02 14:40:47.320197+07	finished	2026-03-11 14:14:32.381553+07
1000	5	quiz	1	2026-03-02 15:18:48.035143+07	finished	2026-03-11 14:14:32.381553+07
1006	5	quiz	1	2026-03-02 15:26:10.268136+07	finished	2026-03-11 14:14:32.381553+07
1017	5	quiz	1	2026-03-02 15:42:55.96209+07	finished	2026-03-11 14:14:32.381553+07
1040	5	quiz	1	2026-03-02 16:40:27.405692+07	finished	2026-03-11 14:14:32.381553+07
1028	5	quiz	1	2026-03-02 16:18:22.4379+07	finished	2026-03-11 14:14:32.381553+07
1029	5	quiz	1	2026-03-02 16:19:53.149531+07	finished	2026-03-11 14:14:32.381553+07
1032	5	quiz	1	2026-03-02 16:30:39.886511+07	finished	2026-03-11 14:14:32.381553+07
1034	5	quiz	1	2026-03-02 16:34:13.773298+07	finished	2026-03-11 14:14:32.381553+07
1037	5	quiz	1	2026-03-02 16:38:07.117317+07	finished	2026-03-11 14:14:32.381553+07
1038	5	quiz	1	2026-03-02 16:38:40.91045+07	finished	2026-03-11 14:14:32.381553+07
1039	5	quiz	1	2026-03-02 16:39:15.061934+07	finished	2026-03-11 14:14:32.381553+07
1042	5	quiz	1	2026-03-02 16:47:54.695155+07	finished	2026-03-11 14:14:32.381553+07
1043	5	quiz	1	2026-03-02 16:48:15.66793+07	finished	2026-03-11 14:14:32.381553+07
1049	5	quiz	1	2026-03-02 17:09:41.953812+07	finished	2026-03-11 14:14:32.381553+07
1052	5	quiz	1	2026-03-02 17:34:08.751952+07	finished	2026-03-11 14:14:32.381553+07
1053	5	quiz	1	2026-03-04 13:09:39.823767+07	finished	2026-03-11 14:14:32.381553+07
1057	5	quiz	1	2026-03-04 13:16:09.194273+07	finished	2026-03-11 14:14:32.381553+07
1059	5	quiz	1	2026-03-04 13:24:17.945617+07	finished	2026-03-11 14:14:32.381553+07
1063	5	quiz	1	2026-03-04 13:39:14.110208+07	finished	2026-03-11 14:14:32.381553+07
1073	5	quiz	1	2026-03-04 14:11:14.717+07	finished	2026-03-11 14:14:32.381553+07
1074	5	quiz	1	2026-03-04 14:12:09.300098+07	finished	2026-03-11 14:14:32.381553+07
1077	5	quiz	1	2026-03-04 14:31:41.669695+07	finished	2026-03-11 14:14:32.381553+07
1079	5	quiz	1	2026-03-04 14:34:07.179578+07	finished	2026-03-11 14:14:32.381553+07
1081	5	quiz	1	2026-03-04 14:40:14.610076+07	finished	2026-03-11 14:14:32.381553+07
1082	5	quiz	1	2026-03-04 14:40:30.478469+07	finished	2026-03-11 14:14:32.381553+07
1083	5	quiz	1	2026-03-04 14:40:58.600357+07	finished	2026-03-11 14:14:32.381553+07
1085	5	quiz	1	2026-03-04 14:41:43.741097+07	finished	2026-03-11 14:14:32.381553+07
1086	5	quiz	1	2026-03-04 14:42:14.507722+07	finished	2026-03-11 14:14:32.381553+07
1088	5	quiz	1	2026-03-04 14:45:05.241406+07	finished	2026-03-11 14:14:32.381553+07
1089	5	quiz	1	2026-03-04 14:53:38.192593+07	finished	2026-03-11 14:14:32.381553+07
1090	5	quiz	1	2026-03-04 14:54:13.49983+07	finished	2026-03-11 14:14:32.381553+07
1092	5	quiz	1	2026-03-04 14:58:29.074268+07	finished	2026-03-11 14:14:32.381553+07
1093	5	quiz	1	2026-03-04 14:59:30.379974+07	finished	2026-03-11 14:14:32.381553+07
1094	5	quiz	1	2026-03-04 14:59:54.700647+07	finished	2026-03-11 14:14:32.381553+07
1095	5	quiz	1	2026-03-04 15:03:36.365243+07	finished	2026-03-11 14:14:32.381553+07
1097	5	quiz	1	2026-03-04 15:06:20.116751+07	finished	2026-03-11 14:14:32.381553+07
1098	5	quiz	1	2026-03-04 15:06:32.34675+07	finished	2026-03-11 14:14:32.381553+07
1099	5	quiz	1	2026-03-04 15:18:14.201416+07	finished	2026-03-11 14:14:32.381553+07
1100	5	quiz	1	2026-03-04 15:18:40.854956+07	finished	2026-03-11 14:14:32.381553+07
1101	5	quiz	1	2026-03-04 15:21:28.198638+07	finished	2026-03-11 14:14:32.381553+07
1102	5	quiz	1	2026-03-04 15:21:44.469143+07	finished	2026-03-11 14:14:32.381553+07
1103	5	quiz	1	2026-03-04 15:44:59.166888+07	finished	2026-03-11 14:14:32.381553+07
1104	5	quiz	1	2026-03-04 15:47:43.992879+07	finished	2026-03-11 14:14:32.381553+07
1105	5	quiz	1	2026-03-04 15:47:56.550992+07	finished	2026-03-11 14:14:32.381553+07
1106	5	quiz	1	2026-03-04 15:49:51.126208+07	finished	2026-03-11 14:14:32.381553+07
1107	5	quiz	1	2026-03-04 15:58:21.871612+07	finished	2026-03-11 14:14:32.381553+07
1108	5	quiz	1	2026-03-04 15:59:25.041626+07	finished	2026-03-11 14:14:32.381553+07
1109	5	quiz	1	2026-03-04 16:10:01.998425+07	finished	2026-03-11 14:14:32.381553+07
1110	5	quiz	1	2026-03-04 16:21:57.127115+07	finished	2026-03-11 14:14:32.381553+07
1111	5	quiz	1	2026-03-04 16:25:11.471033+07	finished	2026-03-11 14:14:32.381553+07
1112	5	quiz	1	2026-03-04 16:31:29.749346+07	finished	2026-03-11 14:14:32.381553+07
1113	5	quiz	1	2026-03-04 16:31:47.369556+07	finished	2026-03-11 14:14:32.381553+07
1114	5	quiz	1	2026-03-04 16:32:05.095244+07	finished	2026-03-11 14:14:32.381553+07
1115	5	quiz	1	2026-03-04 16:45:08.167007+07	finished	2026-03-11 14:14:32.381553+07
1116	5	quiz	1	2026-03-04 16:45:57.470767+07	finished	2026-03-11 14:14:32.381553+07
1117	5	quiz	1	2026-03-04 16:54:42.15926+07	finished	2026-03-11 14:14:32.381553+07
1118	5	quiz	1	2026-03-04 16:56:55.94612+07	finished	2026-03-11 14:14:32.381553+07
1120	5	quiz	1	2026-03-04 17:02:36.369647+07	finished	2026-03-11 14:14:32.381553+07
1121	5	quiz	1	2026-03-04 17:03:41.408274+07	finished	2026-03-11 14:14:32.381553+07
1122	5	quiz	1	2026-03-04 17:04:40.165405+07	finished	2026-03-11 14:14:32.381553+07
1125	5	quiz	1	2026-03-04 17:16:53.384965+07	finished	2026-03-11 14:14:32.381553+07
1134	5	quiz	1	2026-03-04 17:38:44.589224+07	finished	2026-03-11 14:14:32.381553+07
1127	5	quiz	1	2026-03-04 17:26:56.782182+07	finished	2026-03-11 14:14:32.381553+07
1128	5	quiz	1	2026-03-04 17:33:56.522617+07	finished	2026-03-11 14:14:32.381553+07
1129	5	quiz	1	2026-03-04 17:35:04.346233+07	finished	2026-03-11 14:14:32.381553+07
1130	5	quiz	1	2026-03-04 17:35:44.04201+07	finished	2026-03-11 14:14:32.381553+07
1152	5	quiz	1	2026-03-04 18:22:10.270803+07	finished	2026-03-11 14:14:32.381553+07
1131	5	quiz	1	2026-03-04 17:36:54.2314+07	finished	2026-03-11 14:14:32.381553+07
1132	5	quiz	1	2026-03-04 17:38:04.938092+07	finished	2026-03-11 14:14:32.381553+07
1133	5	quiz	1	2026-03-04 17:38:29.675595+07	finished	2026-03-11 14:14:32.381553+07
1135	5	quiz	1	2026-03-04 17:39:18.137197+07	finished	2026-03-11 14:14:32.381553+07
1136	5	quiz	1	2026-03-04 17:41:49.091026+07	finished	2026-03-11 14:14:32.381553+07
1137	5	quiz	1	2026-03-04 17:42:22.323921+07	finished	2026-03-11 14:14:32.381553+07
1138	5	quiz	1	2026-03-04 17:43:08.380343+07	finished	2026-03-11 14:14:32.381553+07
1139	5	quiz	1	2026-03-04 17:43:53.898148+07	finished	2026-03-11 14:14:32.381553+07
1140	5	quiz	1	2026-03-04 17:44:40.353054+07	finished	2026-03-11 14:14:32.381553+07
1141	5	quiz	1	2026-03-04 17:51:55.535739+07	finished	2026-03-11 14:14:32.381553+07
1142	5	quiz	1	2026-03-04 17:52:23.43012+07	finished	2026-03-11 14:14:32.381553+07
1143	5	quiz	1	2026-03-04 17:52:47.097785+07	finished	2026-03-11 14:14:32.381553+07
1146	5	quiz	1	2026-03-04 18:01:34.464062+07	finished	2026-03-11 14:14:32.381553+07
1147	5	quiz	1	2026-03-04 18:05:26.243343+07	finished	2026-03-11 14:14:32.381553+07
1148	5	quiz	1	2026-03-04 18:08:46.292102+07	finished	2026-03-11 14:14:32.381553+07
1149	5	quiz	1	2026-03-04 18:09:11.171993+07	finished	2026-03-11 14:14:32.381553+07
1150	5	quiz	1	2026-03-04 18:12:27.714618+07	finished	2026-03-11 14:14:32.381553+07
1151	5	quiz	1	2026-03-04 18:21:58.255527+07	finished	2026-03-11 14:14:32.381553+07
1153	5	quiz	1	2026-03-04 18:22:54.662859+07	finished	2026-03-11 14:14:32.381553+07
1154	5	quiz	1	2026-03-04 18:23:43.290425+07	finished	2026-03-11 14:14:32.381553+07
1155	5	quiz	1	2026-03-05 13:10:39.45285+07	finished	2026-03-11 14:14:32.381553+07
1156	5	quiz	1	2026-03-05 13:33:38.392973+07	finished	2026-03-11 14:14:32.381553+07
1157	5	quiz	1	2026-03-05 13:35:36.92084+07	finished	2026-03-11 14:14:32.381553+07
1158	5	quiz	1	2026-03-05 13:36:35.004916+07	finished	2026-03-11 14:14:32.381553+07
1159	5	quiz	1	2026-03-05 13:40:14.64146+07	finished	2026-03-11 14:14:32.381553+07
1160	5	quiz	1	2026-03-05 13:43:25.489091+07	finished	2026-03-11 14:14:32.381553+07
1161	5	quiz	1	2026-03-05 13:43:42.203729+07	finished	2026-03-11 14:14:32.381553+07
1162	5	quiz	1	2026-03-05 13:48:04.56448+07	finished	2026-03-11 14:14:32.381553+07
1163	5	quiz	1	2026-03-05 13:50:31.427086+07	finished	2026-03-11 14:14:32.381553+07
1164	5	quiz	1	2026-03-05 13:52:24.965152+07	finished	2026-03-11 14:14:32.381553+07
1165	5	quiz	1	2026-03-05 13:56:18.164965+07	finished	2026-03-11 14:14:32.381553+07
1173	5	quiz	1	2026-03-05 14:22:16.593116+07	finished	2026-03-11 14:14:32.381553+07
1174	5	quiz	1	2026-03-05 14:32:19.255789+07	finished	2026-03-11 14:14:32.381553+07
1181	5	quiz	1	2026-03-05 15:21:46.150414+07	finished	2026-03-11 14:14:32.381553+07
1185	5	quiz	1	2026-03-05 15:27:05.675765+07	finished	2026-03-11 14:14:32.381553+07
1186	5	quiz	1	2026-03-05 15:27:05.777971+07	finished	2026-03-11 14:14:32.381553+07
1198	5	quiz	1	2026-03-05 16:03:27.129604+07	finished	2026-03-11 14:14:32.381553+07
1260	5	quiz	1	2026-03-08 14:52:49.497115+07	finished	2026-03-11 14:14:32.381553+07
1277	5	quiz	1	2026-03-08 15:03:22.425019+07	finished	2026-03-11 14:14:32.381553+07
1307	5	quiz	1	2026-03-08 15:45:43.18603+07	finished	2026-03-11 14:14:32.381553+07
1309	5	quiz	1	2026-03-08 15:51:51.176433+07	finished	2026-03-11 14:14:32.381553+07
1310	5	quiz	1	2026-03-08 15:57:40.878069+07	finished	2026-03-11 14:14:32.381553+07
1311	5	quiz	1	2026-03-08 15:58:19.314836+07	finished	2026-03-11 14:14:32.381553+07
1312	5	quiz	1	2026-03-08 16:05:03.129392+07	finished	2026-03-11 14:14:32.381553+07
1313	5	quiz	1	2026-03-08 16:08:43.44591+07	finished	2026-03-11 14:14:32.381553+07
1317	5	quiz	1	2026-03-08 16:18:18.969133+07	finished	2026-03-11 14:14:32.381553+07
1320	5	quiz	1	2026-03-08 16:26:01.815421+07	finished	2026-03-11 14:14:32.381553+07
1324	5	quiz	1	2026-03-08 16:28:40.750969+07	finished	2026-03-11 14:14:32.381553+07
1335	5	quiz	1	2026-03-08 16:39:36.766437+07	finished	2026-03-11 14:14:32.381553+07
1336	5	quiz	1	2026-03-08 16:44:25.971873+07	finished	2026-03-11 14:14:32.381553+07
1337	5	quiz	1	2026-03-08 16:47:34.042538+07	finished	2026-03-11 14:14:32.381553+07
1359	5	quiz	1	2026-03-08 17:26:56.242381+07	finished	2026-03-11 14:14:32.381553+07
1509	5	chat	1	2026-03-09 17:36:16.06327+07	finished	2026-03-11 14:14:32.381553+07
1550	5	quiz	1	2026-03-11 12:54:20.90434+07	finished	2026-03-11 14:14:32.381553+07
1563	5	quiz	1	2026-03-11 14:04:32.032808+07	finished	2026-03-11 14:14:32.381553+07
1578	5	quiz	1	2026-03-11 16:32:54.147548+07	finished	2026-03-11 17:10:08.456119+07
1593	5	quiz	1	2026-03-11 18:25:05.854983+07	finished	2026-03-11 18:25:32.544648+07
1623	14	quiz	1	2026-03-12 12:17:11.462961+07	finished	2026-03-12 12:17:41.676749+07
1609	5	quiz	1	2026-03-12 11:02:19.80809+07	finished	2026-03-12 12:47:57.869932+07
1636	5	quiz	1	2026-03-12 14:56:27.543502+07	finished	2026-03-12 14:56:51.444579+07
1648	5	quiz	1	2026-03-12 15:16:12.878381+07	finished	2026-03-12 15:16:19.501648+07
1660	5	quiz	1	2026-03-14 17:22:22.586533+07	finished	2026-03-14 17:22:31.783811+07
1672	5	quiz	1	2026-03-14 18:02:26.986308+07	finished	2026-03-14 18:02:39.219804+07
1688	5	quiz	1	2026-03-15 13:23:33.056696+07	finished	2026-03-15 13:24:08.239763+07
1701	5	poll	1	2026-03-15 13:45:40.103256+07	finished	2026-03-15 13:45:45.75705+07
1713	5	poll	1	2026-03-15 14:23:51.544134+07	finished	2026-03-15 14:23:54.500229+07
1726	5	poll	1	2026-03-15 14:51:01.915331+07	finished	2026-03-15 14:51:12.823862+07
1736	5	chat	1	2026-03-15 15:25:54.785591+07	finished	2026-03-15 15:26:18.143999+07
1746	5	quiz	1	2026-03-15 16:46:05.307067+07	finished	2026-03-15 16:46:15.351903+07
1765	55	poll	1	2026-03-16 17:59:39.230753+07	finished	2026-03-16 17:59:44.788214+07
1776	55	quiz	1	2026-03-16 19:50:41.799683+07	finished	2026-03-16 19:51:12.238927+07
1790	55	quiz	1	2026-03-16 22:58:09.394711+07	finished	2026-03-18 13:10:05.33353+07
1800	60	quiz	24	2026-03-18 13:51:06.983473+07	finished	2026-03-18 13:51:11.252711+07
1811	60	quiz	24	2026-03-18 16:15:12.71899+07	finished	2026-03-18 16:16:27.263692+07
1822	17	poll	24	2026-03-18 19:27:21.806147+07	finished	2026-03-18 19:28:11.174789+07
1833	17	quiz	24	2026-03-18 19:49:37.226432+07	finished	2026-03-18 19:50:11.833744+07
1844	17	quiz	24	2026-03-19 12:59:03.290056+07	finished	2026-03-19 12:59:13.193016+07
1855	17	quiz	24	2026-03-19 13:31:39.122905+07	finished	2026-03-19 13:31:59.454995+07
\.


--
-- TOC entry 5296 (class 0 OID 17325)
-- Dependencies: 256
-- Data for Name: AssignedInteractiveBoards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AssignedInteractiveBoards" ("AssignedInteractiveBoard_ID", "ActivitySession_ID", "Allow_Anonymous", "Created_At", "Board_Name") FROM stdin;
1	1458	f	2026-03-09 13:48:15.685947+07	qwertyuiop'
2	1459	f	2026-03-09 13:49:16.791457+07	dfghjkl
3	1460	f	2026-03-09 14:04:39.595083+07	test chat
4	1462	f	2026-03-09 14:19:13.765454+07	ดเ้่าสเ้่าสเ้่าส
5	1463	f	2026-03-09 14:22:47.133834+07	วืสวืงสืงืวนืวน่วน่
6	1464	f	2026-03-09 14:26:53.327851+07	wojgajg[pak
7	1471	f	2026-03-09 14:44:24.945557+07	dfghjkl
8	1472	f	2026-03-09 14:53:22.018543+07	dfghjkjhgfghj
9	1473	f	2026-03-09 14:53:37.961724+07	dfghjkkjhgfdfghjklkjhg
10	1475	f	2026-03-09 14:56:37.898769+07	jyfujokkjhj
11	1476	f	2026-03-09 15:01:19.197975+07	ghio;
12	1477	f	2026-03-09 15:06:35.056626+07	้าีเสรเวเย
13	1478	f	2026-03-09 15:06:56.460458+07	้่อสเส้นรเยรเยรเ
14	1479	f	2026-03-09 15:07:25.781509+07	อเรยเยนเ้บน
15	1480	f	2026-03-09 15:11:26.696498+07	slgns;gns'gn
16	1481	f	2026-03-09 15:21:13.583087+07	ทดสอบระบบคับผม
17	1482	f	2026-03-09 15:23:05.382542+07	หเ
18	1483	f	2026-03-09 15:27:13.143939+07	เแา่อ้สาวรด
19	1484	f	2026-03-09 15:28:44.563143+07	ด
20	1507	f	2026-03-09 17:07:37.430819+07	ดีจ้า
21	1509	f	2026-03-09 17:36:16.094207+07	เปิดเทอมวันแรก
22	1510	f	2026-03-09 17:38:18.263677+07	กิน
23	1620	f	2026-03-12 12:14:40.982331+07	ฮาย
24	1651	f	2026-03-12 15:17:21.727814+07	hi
25	1732	f	2026-03-15 14:56:01.528234+07	Interactive Board
26	1733	f	2026-03-15 15:00:23.048597+07	หปหฟ
27	1736	f	2026-03-15 15:25:54.888882+07	กำไห
28	1740	f	2026-03-15 15:46:43.512559+07	าส
29	1741	f	2026-03-15 15:58:50.568232+07	ทเดิก
30	1757	f	2026-03-16 17:19:34.937718+07	เทสเซอร์เวอร์
31	1758	f	2026-03-16 17:33:57.593736+07	หกดเ้่า
32	1779	f	2026-03-16 19:52:20.406466+07	5555
33	1787	f	2026-03-16 20:27:19.588211+07	มีคำถามอะไรมั้ย
34	1803	f	2026-03-18 13:56:13.06977+07	มีใครสงสัยอะไรไหม
35	1823	f	2026-03-18 19:28:40.885017+07	มีอะไรสงสัยไหมคะ 18/3/69
36	1862	f	2026-03-19 14:27:27.102877+07	วันนี้มีอะไรถามไหม
37	1868	f	2026-03-20 10:59:24.468568+07	test
\.


--
-- TOC entry 5290 (class 0 OID 17193)
-- Dependencies: 250
-- Data for Name: AssignedPoll; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AssignedPoll" ("AssignedPoll_ID", "ActivitySession_ID", "Poll_Question", "Allow_Multiple", "Duration", "Created_At") FROM stdin;
1	2		f	\N	2026-01-25 15:23:04.394902+07
2	1252	test	f	\N	2026-03-08 14:46:55.718309+07
3	1259	5	f	\N	2026-03-08 14:49:52.398658+07
4	1265	5	f	\N	2026-03-08 14:56:33.573207+07
5	1270	5	f	\N	2026-03-08 14:59:02.321487+07
6	1274	5	f	\N	2026-03-08 15:01:44.662429+07
7	1283	5	f	\N	2026-03-08 15:09:26.038882+07
8	1284	ทดสอบ	f	\N	2026-03-08 15:12:17.252064+07
9	1286	yyyy	f	\N	2026-03-08 15:22:13.331457+07
10	1291	who r u	f	\N	2026-03-08 15:26:40.25632+07
11	1294	5	f	\N	2026-03-08 15:27:57.911578+07
12	1295	8	f	\N	2026-03-08 15:28:20.184125+07
13	1302	2	f	\N	2026-03-08 15:33:08.889144+07
14	1303	4	f	\N	2026-03-08 15:33:26.178701+07
15	1304	58	f	\N	2026-03-08 15:35:46.024011+07
16	1305	ljg	f	\N	2026-03-08 15:37:28.405343+07
17	1306	fff	f	\N	2026-03-08 15:38:47.08078+07
18	1308	l	f	\N	2026-03-08 15:49:08.694372+07
19	1314	วสา่้เด	f	\N	2026-03-08 16:14:00.155198+07
20	1315	asdfg	f	\N	2026-03-08 16:15:26.003439+07
21	1316	cvbnm,	f	\N	2026-03-08 16:17:57.497577+07
22	1318	xcvbnm,	f	\N	2026-03-08 16:18:30.785195+07
23	1319	asdfghm	f	\N	2026-03-08 16:21:46.011654+07
24	1327	า่้ัเะพ	f	\N	2026-03-08 16:33:03.124117+07
25	1330	wertyuiokjhb	f	\N	2026-03-08 16:34:19.129607+07
26	1331	fghjkl	f	\N	2026-03-08 16:35:36.702863+07
27	1338	หกดเ้่า	f	\N	2026-03-08 16:51:08.59005+07
28	1339	kutdclj	f	\N	2026-03-08 16:52:15.813131+07
29	1341	dfghjk	f	\N	2026-03-08 16:54:34.190241+07
30	1348	พ่ด่หะ้	f	\N	2026-03-08 17:00:10.151193+07
31	1349	wrhrtj	f	\N	2026-03-08 17:00:51.668346+07
32	1350	asdfghj	f	\N	2026-03-08 17:08:19.49435+07
33	1357	่สวส้กเหดว	f	\N	2026-03-08 17:17:07.773966+07
34	1358	aqwertyhj	f	\N	2026-03-08 17:25:40.735445+07
35	1370	posjrg[sejg[psr	f	\N	2026-03-08 17:31:47.853132+07
36	1391	jghfdgffhdg	f	\N	2026-03-08 18:10:49.328854+07
37	1392	kjhgfdshgfdhg	f	\N	2026-03-08 18:12:07.166585+07
38	1393	'r;,jr'kj'r	f	\N	2026-03-08 18:14:01.773675+07
39	1394	วันนี้เลิกกี่โมง	f	\N	2026-03-08 18:14:57.89676+07
40	1396	้่เด้ก	f	\N	2026-03-08 18:24:20.248906+07
41	1397	สวัสดี	f	\N	2026-03-08 18:25:19.302773+07
42	1398	mgl	f	\N	2026-03-08 18:26:30.015196+07
43	1399	jpj	f	\N	2026-03-08 18:27:30.839817+07
44	1401	845	f	\N	2026-03-08 18:33:06.155809+07
45	1402	84585	f	\N	2026-03-08 18:33:48.422408+07
46	1403	ๆไำพะัีรนย	f	\N	2026-03-08 18:39:45.950093+07
47	1405	ทดสอบ	f	\N	2026-03-08 18:40:45.012882+07
48	1406	กดเ้่	f	\N	2026-03-08 18:41:10.200819+07
49	1407	mhvjuyf	f	\N	2026-03-08 18:42:47.343496+07
50	1409	jgjyf	f	\N	2026-03-08 18:43:36.001616+07
51	1410	jvkjb	f	\N	2026-03-08 18:45:16.123956+07
52	1411	kvlk	f	\N	2026-03-08 18:45:40.526274+07
53	1425	พกะดัเ่า	f	\N	2026-03-08 19:01:57.53378+07
54	1450	กะ้ดสะง่วมด	f	\N	2026-03-08 19:41:43.634112+07
55	1465	jd/l:e	f	\N	2026-03-09 14:38:24.903825+07
56	1467	;lm';m	f	\N	2026-03-09 14:39:59.197291+07
57	1468	;lj';j';k	f	\N	2026-03-09 14:41:25.604406+07
58	1469	kn;lm;lm	f	\N	2026-03-09 14:43:17.640723+07
59	1470	;m'm'm	f	\N	2026-03-09 14:43:36.865256+07
60	1474	testtttttttttt	f	\N	2026-03-09 14:56:25.313295+07
61	1508	กินข้าวหรือยัง	f	\N	2026-03-09 17:35:50.534949+07
62	1619	กินข้าว	f	\N	2026-03-12 12:13:41.890014+07
63	1650	20	f	\N	2026-03-12 15:17:02.463021+07
64	1679	10	f	\N	2026-03-15 12:58:01.670613+07
65	1680	10	f	\N	2026-03-15 13:01:37.608679+07
66	1681	15	f	\N	2026-03-15 13:04:03.111672+07
67	1682	htfdsa	f	\N	2026-03-15 13:14:00.64045+07
68	1683	บงยว	f	\N	2026-03-15 13:16:53.919499+07
69	1684	poiuy	f	\N	2026-03-15 13:18:04.759178+07
70	1685	iujyh	f	\N	2026-03-15 13:19:45.599234+07
71	1690	tgrfe	f	\N	2026-03-15 13:29:35.397824+07
72	1691	sds	f	\N	2026-03-15 13:31:48.798918+07
73	1692	rdf	f	\N	2026-03-15 13:34:51.495177+07
74	1693	\\	f	\N	2026-03-15 13:35:30.759688+07
75	1694	gfb	f	\N	2026-03-15 13:35:52.015508+07
76	1695	gtrf	f	\N	2026-03-15 13:36:06.409654+07
77	1696	พเะ	f	\N	2026-03-15 13:37:51.877029+07
78	1697	2	f	\N	2026-03-15 13:40:32.689269+07
79	1698	kuj	f	\N	2026-03-15 13:43:06.807142+07
80	1699	hg	f	\N	2026-03-15 13:43:33.620129+07
81	1700	yht	f	\N	2026-03-15 13:45:26.928736+07
82	1701	ef	f	\N	2026-03-15 13:45:40.205925+07
83	1702	ygtrf	f	\N	2026-03-15 14:05:04.901224+07
84	1703	de	f	\N	2026-03-15 14:05:20.47501+07
85	1704	]'[	f	\N	2026-03-15 14:05:35.028814+07
86	1705	/'[;p	f	\N	2026-03-15 14:05:49.519646+07
87	1706	p;lo	f	\N	2026-03-15 14:06:14.678393+07
88	1707	]'[	f	\N	2026-03-15 14:06:56.258399+07
89	1708	[p;ol	f	\N	2026-03-15 14:10:53.909402+07
90	1709	บยวนส	f	\N	2026-03-15 14:18:47.259474+07
91	1710	กำไ	f	\N	2026-03-15 14:21:53.855956+07
92	1711	่ั้ท่้ื	f	\N	2026-03-15 14:22:19.861897+07
93	1712	ดอก	f	\N	2026-03-15 14:23:39.430018+07
94	1713	้ะเ	f	\N	2026-03-15 14:23:51.566987+07
95	1714	ั้ะเ	f	\N	2026-03-15 14:24:03.589618+07
96	1715	นสร	f	\N	2026-03-15 14:27:51.267589+07
97	1716	-[=0p	f	\N	2026-03-15 14:31:43.33123+07
98	1717	'[;po	f	\N	2026-03-15 14:31:57.620641+07
99	1718	]'[;pol	f	\N	2026-03-15 14:34:51.42854+07
100	1719	rewd	f	\N	2026-03-15 14:35:12.881286+07
101	1720	rfe	f	\N	2026-03-15 14:38:30.546153+07
102	1721	กห	f	\N	2026-03-15 14:49:10.506974+07
103	1722	ั้ะเพถ	f	\N	2026-03-15 14:49:23.90594+07
104	1723	ำกไ	f	\N	2026-03-15 14:50:45.026338+07
105	1724	ะพเำภ	f	\N	2026-03-15 14:50:58.276266+07
106	1725	ะพเำภ	f	\N	2026-03-15 14:51:01.931496+07
107	1726	ะพเำภ	f	\N	2026-03-15 14:51:01.933312+07
108	1727	oliku	f	\N	2026-03-15 14:52:11.629412+07
109	1728	rfedw	f	\N	2026-03-15 14:52:39.323133+07
110	1729	dfsca	f	\N	2026-03-15 14:52:57.18575+07
111	1730	polikuj	f	\N	2026-03-15 14:53:09.187703+07
112	1731		f	\N	2026-03-15 14:53:58.239803+07
113	1734	dc	f	\N	2026-03-15 15:13:01.126713+07
114	1735	frs	f	\N	2026-03-15 15:13:16.967989+07
115	1737	ำได	f	\N	2026-03-15 15:32:52.177116+07
116	1759	หกดเ้่	f	\N	2026-03-16 17:39:06.656172+07
117	1760	กดเ้่า	f	\N	2026-03-16 17:41:27.703158+07
118	1761	กดเ้่า	f	\N	2026-03-16 17:43:22.855811+07
119	1762	แอิืท	f	\N	2026-03-16 17:54:57.919543+07
120	1763	้ดแ่กแ่	f	\N	2026-03-16 17:56:02.033962+07
121	1764	ีะกำักาี	f	\N	2026-03-16 17:59:16.289945+07
122	1765	่แ	f	\N	2026-03-16 17:59:39.247297+07
123	1766	5	f	\N	2026-03-16 17:59:57.003128+07
124	1778	ggerg	f	\N	2026-03-16 19:52:08.904867+07
125	1785	วันนี้จะทำการบ้านไหม	f	\N	2026-03-16 20:19:02.830694+07
126	1786	พรุ่งนี้ใส่ชุดอะไร	f	\N	2026-03-16 20:26:57.87389+07
127	1801	สัปดาห์หน้าจะเรียนออนไลน์หรือไม่	f	\N	2026-03-18 13:55:09.289326+07
128	1802	กะะเ	f	\N	2026-03-18 13:56:02.089841+07
129	1822	วันนี้ต้องการส่งงานตอนไหน	f	\N	2026-03-18 19:27:21.969175+07
130	1858	อาทิตย์หน้าเรียนออนไลน์หรือออนไซต์	f	\N	2026-03-19 13:54:51.385732+07
131	1861	อาทิตย์หน้าเรียนออนไลน์หรือออนไซต์	f	\N	2026-03-19 14:12:46.270626+07
132	1866	456	f	\N	2026-03-20 10:58:43.886319+07
133	1867	55	f	\N	2026-03-20 10:59:10.193567+07
\.


--
-- TOC entry 5285 (class 0 OID 17110)
-- Dependencies: 245
-- Data for Name: AssignedQuiz; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AssignedQuiz" ("AssignedQuiz_ID", "ActivitySession_ID", "Quiz_ID", "Mode", "Student_Per_Team", "Timer_Type", "Question_Time", "Quiz_Time") FROM stdin;
1	1	24	individual	\N	teacher	\N	\N
2	3	36	individual	\N	teacher	\N	\N
3	4	39	individual	\N	teacher	\N	\N
4	5	38	individual	\N	teacher	\N	\N
5	6	39	individual	\N	question	20	\N
6	7	38	individual	\N	teacher	\N	\N
7	8	39	individual	\N	teacher	\N	\N
8	9	39	individual	\N	question	20	\N
9	10	39	individual	\N	teacher	\N	\N
10	11	39	individual	\N	teacher	\N	\N
11	12	39	individual	\N	question	20	\N
12	13	39	individual	\N	question	20	\N
13	14	39	individual	\N	teacher	\N	\N
14	15	39	individual	\N	question	20	\N
15	16	38	individual	\N	question	20	\N
16	17	37	individual	\N	question	20	\N
17	18	39	individual	\N	question	20	\N
18	19	36	individual	\N	question	20	\N
19	20	39	individual	\N	teacher	\N	\N
20	21	39	individual	\N	question	20	\N
21	22	39	individual	\N	teacher	\N	\N
22	23	39	individual	\N	teacher	\N	\N
23	24	39	individual	\N	teacher	\N	\N
24	25	39	individual	\N	teacher	\N	\N
25	26	39	individual	\N	teacher	\N	\N
26	27	19	individual	\N	teacher	\N	\N
27	28	32	individual	\N	teacher	\N	\N
28	29	39	individual	\N	teacher	\N	\N
29	30	33	individual	\N	teacher	\N	\N
30	31	39	individual	\N	question	50	\N
31	32	36	individual	\N	teacher	\N	\N
32	33	36	individual	\N	teacher	\N	\N
33	34	39	individual	\N	teacher	\N	\N
34	35	39	individual	\N	teacher	\N	\N
35	36	39	individual	\N	teacher	\N	\N
36	37	39	individual	\N	teacher	\N	\N
37	38	39	individual	\N	teacher	\N	\N
38	39	25	individual	\N	teacher	\N	\N
39	40	39	individual	\N	teacher	\N	\N
40	41	38	individual	\N	teacher	\N	\N
41	42	39	individual	\N	teacher	\N	\N
42	43	39	individual	\N	teacher	\N	\N
43	44	22	individual	\N	teacher	\N	\N
44	45	26	individual	\N	teacher	\N	\N
45	46	27	individual	\N	question	15	\N
46	47	20	individual	\N	teacher	\N	\N
47	48	20	individual	\N	question	\N	\N
48	49	20	individual	\N	question	18	\N
49	50	39	individual	\N	teacher	\N	\N
50	51	39	individual	\N	teacher	\N	\N
51	52	39	individual	\N	teacher	\N	\N
52	53	39	individual	\N	teacher	\N	\N
53	54	39	individual	\N	teacher	\N	\N
54	55	39	individual	\N	teacher	\N	\N
55	56	39	individual	\N	teacher	\N	\N
56	57	39	individual	\N	teacher	\N	\N
57	58	39	individual	\N	teacher	\N	\N
58	59	39	individual	\N	teacher	\N	\N
59	60	39	individual	\N	teacher	\N	\N
60	61	39	individual	\N	teacher	20	\N
61	62	19	individual	\N	question	14	\N
62	63	20	individual	\N	question	14	\N
63	64	20	individual	\N	question	15	\N
64	65	20	individual	\N	question	14	\N
65	66	39	individual	\N	teacher	10	\N
66	67	35	individual	\N	teacher	10	\N
67	68	32	individual	\N	teacher	10	\N
68	69	32	individual	\N	teacher	5	\N
69	70	32	individual	\N	teacher	5	\N
70	71	32	individual	\N	teacher	10	\N
71	72	32	individual	\N	teacher	300	\N
72	73	19	individual	\N	question	14	\N
73	74	20	individual	\N	question	14	\N
74	75	19	individual	\N	question	14	\N
75	76	32	individual	\N	teacher	20	\N
76	77	32	individual	\N	teacher	10	\N
77	78	39	individual	\N	teacher	5	\N
78	79	39	individual	\N	teacher	5	\N
79	80	39	individual	\N	teacher	5	\N
80	81	39	individual	\N	teacher	5	\N
81	82	39	individual	\N	teacher	5	\N
82	83	20	individual	\N	question	14	\N
83	84	19	individual	\N	question	14	\N
84	85	20	individual	\N	question	14	\N
85	86	39	individual	\N	teacher	5	\N
86	87	32	individual	\N	teacher	5	\N
87	88	19	individual	\N	question	20	\N
88	89	19	individual	\N	question	15	\N
89	90	39	individual	\N	teacher	5	\N
90	91	39	individual	\N	teacher	10	\N
91	92	19	individual	\N	question	1	\N
92	93	39	individual	\N	teacher	5	\N
93	94	39	individual	\N	teacher	5	\N
94	95	19	individual	\N	question	20	\N
95	96	19	individual	\N	question	20	\N
96	97	19	individual	\N	question	20	\N
97	98	19	individual	\N	question	20	\N
98	99	39	individual	\N	teacher	5	\N
99	100	19	individual	\N	question	20	\N
100	101	19	individual	\N	question	20	\N
101	102	39	individual	\N	teacher	5	\N
102	103	19	individual	\N	question	20	\N
103	104	19	individual	\N	question	20	\N
104	105	39	individual	\N	teacher	5	\N
105	106	39	individual	\N	teacher	5	\N
106	107	39	individual	\N	teacher	5	\N
107	108	19	individual	\N	teacher	20	\N
108	109	19	individual	\N	question	20	\N
109	110	19	individual	\N	question	20	\N
110	111	19	individual	\N	question	20	\N
111	112	19	individual	\N	question	20	\N
112	113	19	individual	\N	question	20	\N
113	114	19	individual	\N	question	20	\N
114	115	19	individual	\N	question	20	\N
115	116	19	individual	\N	question	20	\N
116	117	19	individual	\N	question	20	\N
117	118	19	individual	\N	question	20	\N
118	119	19	individual	\N	question	20	\N
119	120	19	individual	\N	question	20	\N
120	121	19	individual	\N	question	20	\N
121	122	19	individual	\N	question	20	\N
122	123	19	individual	\N	question	20	\N
123	124	19	individual	\N	question	20	\N
124	125	19	individual	\N	question	20	\N
125	126	19	individual	\N	question	20	\N
126	127	19	individual	\N	question	20	\N
127	128	19	individual	\N	question	21	\N
128	129	19	individual	\N	teacher	21	\N
129	130	19	individual	\N	teacher	21	\N
130	131	19	individual	\N	teacher	20	\N
131	132	19	individual	\N	teacher	25	\N
132	133	19	individual	\N	question	20	\N
133	134	19	individual	\N	question	12	\N
134	135	19	individual	\N	teacher	20	\N
135	136	19	individual	\N	teacher	20	\N
136	137	39	individual	\N	teacher	5	\N
137	138	39	individual	\N	teacher	5	\N
138	139	39	individual	\N	teacher	5	\N
139	140	39	individual	\N	teacher	5	\N
140	141	19	individual	\N	teacher	20	\N
141	142	19	individual	\N	question	20	\N
142	143	19	individual	\N	teacher	20	\N
143	144	19	individual	\N	question	20	\N
144	145	19	individual	\N	teacher	20	\N
145	146	19	individual	\N	teacher	20	\N
146	147	39	individual	\N	teacher	5	\N
147	148	19	individual	\N	teacher	20	\N
148	149	19	individual	\N	teacher	20	\N
149	150	19	individual	\N	teacher	11	\N
150	151	19	individual	\N	teacher	14	\N
151	152	39	individual	\N	teacher	50	\N
152	153	19	individual	\N	teacher	20	\N
153	154	19	individual	\N	teacher	15	\N
154	155	19	individual	\N	question	18	\N
155	156	39	individual	\N	teacher	500	\N
156	157	19	individual	\N	question	20	\N
157	158	19	individual	\N	question	20	\N
158	159	20	individual	\N	question	11	\N
159	160	25	individual	\N	question	14	\N
160	161	19	individual	\N	question	25	\N
161	162	19	individual	\N	teacher	32	\N
162	163	19	individual	\N	teacher	14	\N
163	164	19	individual	\N	question	12	\N
164	165	19	individual	\N	teacher	14	\N
165	166	39	individual	\N	teacher	30	\N
166	167	39	individual	\N	teacher	30	\N
167	168	19	individual	\N	teacher	14	\N
168	169	39	individual	\N	teacher	50	\N
169	170	19	individual	\N	teacher	14	\N
170	171	19	individual	\N	teacher	25	\N
171	172	19	individual	\N	teacher	14	\N
172	173	19	individual	\N	teacher	14	\N
173	174	19	individual	\N	teacher	14	\N
174	175	19	individual	\N	teacher	25	\N
175	176	19	individual	\N	teacher	12	\N
176	177	39	individual	\N	teacher	60	\N
177	178	39	individual	\N	teacher	5	\N
178	179	19	individual	\N	question	14	\N
179	180	19	individual	\N	teacher	14	\N
180	181	19	individual	\N	teacher	12	\N
181	182	19	individual	\N	teacher	14	\N
182	183	19	individual	\N	teacher	14	\N
183	184	19	individual	\N	teacher	12	\N
184	185	19	individual	\N	teacher	14	\N
185	186	19	individual	\N	teacher	14	\N
186	187	19	individual	\N	teacher	14	\N
187	188	19	individual	\N	teacher	14	\N
188	189	19	individual	\N	teacher	15	\N
189	190	19	individual	\N	teacher	14	\N
190	191	19	individual	\N	teacher	14	\N
191	192	19	individual	\N	teacher	25	\N
192	193	19	individual	\N	question	14	\N
193	194	19	individual	\N	teacher	2	\N
194	195	19	individual	\N	teacher	2	\N
195	196	39	individual	\N	teacher	15	\N
196	197	19	individual	\N	teacher	12	\N
197	198	19	individual	\N	teacher	18	\N
198	199	39	individual	\N	teacher	50	\N
199	200	20	individual	\N	teacher	14	\N
200	201	19	individual	\N	teacher	14	\N
201	202	19	individual	\N	teacher	14	\N
202	203	19	individual	\N	teacher	12	\N
203	204	19	individual	\N	teacher	12	\N
204	205	19	individual	\N	teacher	14	\N
205	206	19	individual	\N	teacher	14	\N
206	207	19	individual	\N	teacher	12	\N
207	208	19	individual	\N	teacher	12	\N
208	209	19	individual	\N	teacher	12	\N
209	210	20	individual	\N	question	15	\N
210	211	39	individual	\N	teacher	30	\N
211	212	22	individual	\N	teacher	25	\N
212	213	19	individual	\N	question	20	\N
213	214	19	individual	\N	teacher	14	\N
214	215	19	individual	\N	teacher	14	\N
215	216	19	individual	\N	question	14	\N
216	217	19	individual	\N	question	14	\N
217	218	19	individual	\N	teacher	14	\N
218	219	19	individual	\N	teacher	14	\N
219	220	19	individual	\N	question	14	\N
220	221	39	individual	\N	teacher	30	\N
221	222	19	individual	\N	teacher	12	\N
222	223	32	individual	\N	teacher	20	\N
223	224	32	individual	\N	teacher	25	\N
224	225	32	individual	\N	teacher	15	\N
225	226	32	individual	\N	teacher	14	\N
226	227	32	individual	\N	teacher	15	\N
227	228	32	individual	\N	question	17	\N
228	229	32	individual	\N	teacher	14	\N
229	230	32	individual	\N	quiz	\N	2
230	231	19	individual	\N	quiz	\N	2
231	232	20	individual	\N	quiz	\N	2
232	233	22	individual	\N	quiz	\N	2
233	234	22	individual	\N	quiz	\N	2
234	235	19	individual	\N	quiz	\N	2
235	236	22	individual	\N	quiz	\N	2
236	237	20	individual	\N	quiz	\N	14
237	238	20	individual	\N	quiz	\N	2
238	239	19	individual	\N	question	15	\N
239	240	19	individual	\N	teacher	14	\N
240	241	19	individual	\N	teacher	14	\N
241	242	19	individual	\N	question	11	\N
242	243	20	individual	\N	quiz	\N	2
243	244	19	individual	\N	quiz	\N	2
244	245	19	individual	\N	quiz	\N	2
245	246	19	individual	\N	question	14	\N
246	247	19	individual	\N	teacher	14	\N
247	248	19	individual	\N	quiz	\N	2
248	249	19	individual	\N	teacher	15	\N
249	250	19	individual	\N	question	15	\N
250	251	19	individual	\N	teacher	14	\N
251	252	20	individual	\N	question	17	\N
252	253	19	individual	\N	teacher	15	\N
253	254	19	individual	\N	question	18	\N
254	255	19	individual	\N	quiz	\N	2
255	256	19	individual	\N	teacher	14	\N
256	257	20	individual	\N	teacher	14	\N
257	258	19	individual	\N	teacher	12	\N
258	259	19	individual	\N	teacher	14	\N
259	260	19	individual	\N	teacher	15	\N
260	261	20	individual	\N	question	20	\N
261	262	19	individual	\N	teacher	14	\N
262	263	19	individual	\N	teacher	14	\N
263	264	19	individual	\N	teacher	14	\N
264	265	19	individual	\N	teacher	14	\N
265	266	19	individual	\N	teacher	25	\N
266	267	19	individual	\N	teacher	15	\N
267	268	19	individual	\N	teacher	14	\N
268	269	19	individual	\N	question	10	\N
269	270	19	individual	\N	teacher	10	\N
270	271	19	individual	\N	quiz	\N	2
271	272	19	individual	\N	teacher	14	\N
272	273	19	individual	\N	teacher	14	\N
273	274	19	individual	\N	quiz	\N	1
274	275	19	individual	\N	quiz	\N	1
275	276	19	individual	\N	quiz	\N	1
276	277	19	individual	\N	teacher	14	\N
277	278	20	individual	\N	teacher	14	\N
278	279	19	individual	\N	teacher	14	\N
279	280	19	individual	\N	question	14	\N
280	281	19	individual	\N	quiz	\N	1
281	282	19	individual	\N	quiz	\N	1
282	283	19	individual	\N	quiz	\N	1
283	284	19	individual	\N	quiz	\N	1
284	285	19	individual	\N	quiz	\N	1
285	286	19	individual	\N	teacher	14	\N
286	287	19	individual	\N	quiz	\N	1
287	288	19	individual	\N	quiz	\N	1
288	289	19	individual	\N	teacher	14	\N
289	290	19	individual	\N	question	14	\N
290	291	19	individual	\N	quiz	\N	1
291	292	39	individual	\N	question	30	\N
292	293	39	individual	\N	manual	\N	\N
293	294	39	individual	\N	question	30	\N
294	295	19	individual	\N	quiz	\N	120
295	296	19	individual	\N	quiz	\N	1
296	297	39	individual	\N	teacher	5	\N
297	298	19	individual	\N	quiz	\N	1
298	299	19	individual	\N	question	120	\N
299	300	19	individual	\N	quiz	\N	1
300	301	19	individual	\N	quiz	\N	1
301	302	19	individual	\N	quiz	\N	1
302	303	19	individual	\N	quiz	\N	14
303	304	19	individual	\N	quiz	\N	1
304	305	19	individual	\N	quiz	\N	2
305	306	19	individual	\N	quiz	\N	2
306	307	19	individual	\N	quiz	\N	1
307	308	19	individual	\N	teacher	14	\N
308	309	19	individual	\N	question	14	\N
309	310	39	individual	\N	teacher	5	\N
310	311	19	individual	\N	teacher	15	\N
311	312	19	individual	\N	question	14	\N
312	313	19	individual	\N	quiz	\N	1
313	314	19	individual	\N	question	14	\N
314	315	39	individual	\N	teacher	5	\N
315	316	19	individual	\N	teacher	14	\N
316	317	19	individual	\N	teacher	14	\N
317	318	19	individual	\N	teacher	14	\N
318	319	19	individual	\N	teacher	14	\N
319	320	39	individual	\N	teacher	5	\N
320	321	20	individual	\N	teacher	14	\N
321	322	19	individual	\N	teacher	14	\N
322	323	19	individual	\N	teacher	14	\N
323	324	19	individual	\N	teacher	14	\N
324	325	19	individual	\N	teacher	14	\N
325	326	19	individual	\N	quiz	\N	1
326	327	19	individual	\N	teacher	14	\N
327	328	19	individual	\N	quiz	\N	1
328	329	39	individual	\N	quiz	\N	5
329	330	39	individual	\N	teacher	14	\N
330	331	39	individual	\N	teacher	14	\N
331	332	39	individual	\N	teacher	14	\N
332	333	39	individual	\N	teacher	14	\N
333	334	39	individual	\N	teacher	5	\N
334	335	39	individual	\N	teacher	14	\N
335	336	39	individual	\N	teacher	14	\N
336	337	19	individual	\N	teacher	14	\N
337	338	39	individual	\N	teacher	14	\N
338	339	39	individual	\N	teacher	14	\N
339	340	39	individual	\N	teacher	14	\N
340	341	19	individual	\N	teacher	14	\N
341	342	19	individual	\N	teacher	14	\N
342	343	19	individual	\N	teacher	14	\N
343	344	19	individual	\N	question	14	\N
344	345	19	individual	\N	question	14	\N
345	346	39	individual	\N	quiz	\N	5
346	347	39	individual	\N	quiz	\N	5
347	348	39	individual	\N	teacher	52	\N
348	349	39	individual	\N	question	15	\N
349	350	37	individual	\N	teacher	14	\N
350	351	39	individual	\N	teacher	14	\N
351	352	19	individual	\N	teacher	14	\N
352	353	19	individual	\N	teacher	14	\N
353	354	19	individual	\N	question	15	\N
354	355	19	individual	\N	question	15	\N
355	356	19	individual	\N	quiz	\N	2
356	357	19	individual	\N	teacher	14	\N
357	358	19	individual	\N	teacher	15	\N
358	359	19	individual	\N	question	17	\N
359	360	19	individual	\N	quiz	\N	2
360	361	19	individual	\N	quiz	\N	2
361	362	19	individual	\N	teacher	100	\N
362	363	19	individual	\N	teacher	15	\N
363	364	19	individual	\N	teacher	17	\N
364	365	19	individual	\N	teacher	17	\N
365	366	19	individual	\N	teacher	18	\N
366	367	19	individual	\N	question	14	\N
367	368	19	individual	\N	teacher	18	\N
368	369	19	individual	\N	teacher	25	\N
369	370	19	individual	\N	teacher	18	\N
370	371	19	individual	\N	teacher	14	\N
371	372	39	individual	\N	question	28	\N
372	373	39	individual	\N	quiz	\N	2
373	374	39	individual	\N	quiz	\N	5
374	375	39	individual	\N	quiz	\N	5
375	376	39	individual	\N	quiz	\N	2
376	377	39	individual	\N	quiz	\N	3
377	378	39	individual	\N	quiz	\N	3
378	379	39	individual	\N	quiz	\N	2
379	380	39	individual	\N	quiz	\N	3
380	382	39	individual	\N	teacher	5	\N
381	383	39	individual	\N	teacher	5	\N
382	384	39	individual	\N	teacher	5	\N
383	385	39	individual	\N	teacher	30	\N
384	386	39	individual	\N	quiz	\N	2
385	387	19	individual	\N	quiz	\N	3
386	388	39	individual	\N	quiz	\N	3
387	389	32	individual	\N	teacher	20	\N
388	390	39	individual	\N	quiz	\N	3
389	391	38	individual	\N	teacher	30	\N
390	392	39	individual	\N	teacher	30	\N
391	393	19	individual	\N	teacher	30	\N
392	394	39	individual	\N	quiz	\N	2
393	395	39	individual	\N	quiz	\N	1
394	396	39	individual	\N	quiz	\N	2
395	397	39	individual	\N	quiz	\N	2
396	398	39	individual	\N	teacher	30	\N
397	399	39	individual	\N	quiz	\N	3
398	400	39	individual	\N	quiz	\N	2
399	401	39	individual	\N	quiz	\N	2
400	402	39	individual	\N	quiz	\N	2
401	403	39	individual	\N	quiz	\N	2
402	404	39	individual	\N	quiz	\N	2
403	405	19	individual	\N	quiz	\N	2
404	406	39	individual	\N	quiz	\N	2
405	407	29	individual	\N	question	30	\N
406	408	30	individual	\N	manual	\N	\N
407	409	38	individual	\N	question	5	\N
408	410	39	individual	\N	quiz	\N	2
409	411	39	individual	\N	teacher	5	\N
410	412	19	individual	\N	quiz	\N	1
411	413	36	individual	\N	teacher	5	\N
412	414	23	individual	\N	teacher	5	\N
413	415	37	individual	\N	teacher	5	\N
414	416	38	individual	\N	teacher	5	\N
415	417	39	individual	\N	teacher	10	\N
416	418	19	individual	\N	question	12	\N
417	420	39	individual	\N	quiz	\N	5
418	421	39	individual	\N	manual	\N	\N
419	422	39	individual	\N	teacher	5	\N
420	423	36	individual	\N	teacher	5	\N
421	424	39	individual	\N	teacher	15	\N
422	425	19	individual	\N	teacher	1	\N
423	426	19	individual	\N	teacher	15	\N
424	427	39	individual	\N	question	15	\N
425	428	19	individual	\N	quiz	\N	5
426	429	39	individual	\N	quiz	\N	5
427	430	39	individual	\N	quiz	\N	2
428	431	39	individual	\N	teacher	30	\N
429	432	39	individual	\N	teacher	14	\N
430	433	39	individual	\N	question	18	\N
431	434	39	individual	\N	teacher	15	\N
432	435	39	individual	\N	teacher	15	\N
433	436	39	individual	\N	teacher	14	\N
434	437	39	individual	\N	teacher	14	\N
435	438	39	individual	\N	teacher	25	\N
436	439	39	individual	\N	teacher	25	\N
437	440	39	individual	\N	teacher	25	\N
438	441	39	individual	\N	teacher	50	\N
439	442	39	individual	\N	teacher	58	\N
440	443	39	individual	\N	teacher	27	\N
441	444	39	individual	\N	teacher	14	\N
442	445	39	individual	\N	teacher	25	\N
443	446	39	individual	\N	teacher	25	\N
444	447	19	individual	\N	teacher	25	\N
445	448	39	individual	\N	teacher	52	\N
446	449	39	individual	\N	teacher	25	\N
447	450	39	individual	\N	teacher	52	\N
448	451	39	individual	\N	teacher	50	\N
449	452	39	individual	\N	teacher	52	\N
450	453	39	individual	\N	teacher	52	\N
451	454	19	individual	\N	teacher	52	\N
452	455	19	individual	\N	teacher	52	\N
453	456	19	individual	\N	teacher	52	\N
454	457	19	individual	\N	teacher	52	\N
455	458	39	individual	\N	teacher	50	\N
456	459	39	individual	\N	question	50	\N
457	460	39	individual	\N	teacher	50	\N
458	461	39	individual	\N	teacher	25	\N
459	462	19	individual	\N	teacher	52	\N
460	463	19	individual	\N	teacher	52	\N
461	464	19	individual	\N	teacher	52	\N
462	465	19	individual	\N	teacher	52	\N
463	466	39	individual	\N	teacher	25	\N
464	467	39	individual	\N	teacher	25	\N
465	468	39	individual	\N	teacher	25	\N
466	469	40	individual	\N	teacher	10	\N
467	470	40	individual	\N	teacher	60	\N
468	471	34	individual	\N	teacher	1	\N
469	472	34	individual	\N	teacher	5	\N
470	473	22	individual	\N	teacher	5	\N
471	474	20	individual	\N	manual	\N	\N
472	475	19	individual	\N	teacher	1	\N
473	476	40	individual	\N	teacher	14	\N
474	477	19	individual	\N	teacher	3	\N
475	478	40	individual	\N	teacher	5	\N
476	479	19	individual	\N	teacher	41	\N
477	480	40	individual	\N	quiz	\N	2
478	481	19	individual	\N	teacher	14	\N
479	482	40	individual	\N	teacher	25	\N
480	483	40	individual	\N	teacher	5	\N
481	484	19	individual	\N	teacher	25	\N
482	485	40	individual	\N	teacher	15	\N
483	486	40	individual	\N	teacher	14	\N
484	487	19	individual	\N	teacher	20	\N
485	488	39	individual	\N	quiz	\N	2
486	489	19	individual	\N	question	30	\N
487	490	19	individual	\N	manual	\N	\N
488	491	24	individual	\N	manual	\N	\N
489	492	19	individual	\N	manual	\N	\N
490	493	20	individual	\N	quiz	\N	15
491	494	19	individual	\N	question	5	\N
492	495	19	individual	\N	quiz	\N	50
493	496	39	individual	\N	question	25	\N
494	497	19	individual	\N	quiz	\N	52
495	498	20	individual	\N	quiz	\N	60
496	499	19	individual	\N	quiz	\N	30
497	500	20	individual	\N	quiz	\N	30
498	501	23	individual	\N	question	50	\N
499	502	20	individual	\N	teacher	2	\N
500	503	20	individual	\N	question	2	\N
501	504	20	individual	\N	question	2	\N
502	505	40	individual	\N	teacher	25	\N
503	506	19	individual	\N	teacher	25	\N
504	507	40	individual	\N	manual	\N	\N
505	508	40	individual	\N	manual	\N	\N
506	509	19	individual	\N	manual	\N	\N
507	510	40	individual	\N	manual	\N	\N
508	511	40	individual	\N	manual	\N	\N
509	512	40	individual	\N	teacher	25	\N
510	513	40	individual	\N	question	20	\N
511	514	40	individual	\N	teacher	25	\N
512	515	40	individual	\N	teacher	25	\N
513	516	40	individual	\N	teacher	25	\N
514	517	40	individual	\N	manual	\N	\N
515	518	40	individual	\N	teacher	25	\N
516	519	40	individual	\N	teacher	25	\N
517	520	40	individual	\N	question	25	\N
518	521	40	individual	\N	manual	\N	\N
519	522	40	individual	\N	teacher	25	\N
520	523	40	individual	\N	teacher	23	\N
521	524	40	individual	\N	teacher	25	\N
522	525	40	individual	\N	teacher	20	\N
523	526	40	individual	\N	manual	\N	\N
524	527	40	individual	\N	teacher	22	\N
525	528	40	individual	\N	teacher	22	\N
526	529	40	individual	\N	teacher	25	\N
527	530	40	individual	\N	teacher	20	\N
528	531	19	individual	\N	question	25	\N
529	532	40	individual	\N	quiz	\N	2
530	533	40	individual	\N	teacher	25	\N
531	534	40	individual	\N	teacher	20	\N
532	535	40	individual	\N	teacher	25	\N
533	536	40	individual	\N	teacher	25	\N
534	537	40	individual	\N	teacher	14	\N
535	538	40	individual	\N	teacher	12	\N
536	539	40	individual	\N	teacher	14	\N
537	540	40	individual	\N	teacher	14	\N
538	541	40	individual	\N	question	18	\N
539	542	40	individual	\N	teacher	25	\N
540	543	40	individual	\N	teacher	30	\N
541	544	39	individual	\N	teacher	25	\N
542	545	39	individual	\N	teacher	12	\N
543	546	29	individual	\N	question	41	\N
544	547	40	individual	\N	question	15	\N
545	548	40	individual	\N	quiz	\N	14
546	549	39	individual	\N	manual	\N	\N
547	550	40	individual	\N	teacher	50	\N
548	551	40	individual	\N	teacher	30	\N
549	552	40	individual	\N	teacher	50	\N
550	553	39	individual	\N	teacher	60	\N
551	554	40	individual	\N	teacher	30	\N
552	555	22	individual	\N	manual	\N	\N
553	556	40	individual	\N	teacher	50	\N
554	557	19	individual	\N	manual	\N	\N
555	558	40	individual	\N	question	14	\N
556	559	40	individual	\N	question	14	\N
557	560	40	individual	\N	question	14	\N
558	561	40	individual	\N	question	14	\N
559	562	39	individual	\N	manual	\N	\N
560	563	39	individual	\N	question	14	\N
561	564	20	individual	\N	manual	\N	\N
562	565	40	individual	\N	question	14	\N
563	566	39	individual	\N	teacher	14	\N
564	567	19	individual	\N	question	25	\N
565	568	39	individual	\N	teacher	15	\N
566	569	19	individual	\N	manual	\N	\N
567	570	40	individual	\N	teacher	30	\N
568	571	39	individual	\N	manual	\N	\N
569	572	40	individual	\N	teacher	30	\N
570	573	40	individual	\N	question	15	\N
571	574	40	individual	\N	question	12	\N
572	575	40	individual	\N	question	36	\N
573	576	40	individual	\N	teacher	40	\N
574	577	39	individual	\N	teacher	14	\N
575	578	39	individual	\N	teacher	15	\N
576	579	40	individual	\N	teacher	12	\N
577	580	40	individual	\N	teacher	20	\N
578	581	19	individual	\N	question	13	\N
579	582	19	individual	\N	question	141	\N
580	583	19	individual	\N	teacher	14	\N
581	584	40	individual	\N	teacher	20	\N
582	585	19	individual	\N	teacher	14	\N
583	586	19	individual	\N	teacher	15	\N
584	587	19	individual	\N	teacher	14	\N
585	588	40	individual	\N	teacher	20	\N
586	589	40	individual	\N	teacher	20	\N
587	590	40	individual	\N	teacher	20	\N
588	591	19	individual	\N	teacher	14	\N
589	592	19	individual	\N	teacher	14	\N
590	593	19	individual	\N	question	14	\N
591	594	40	individual	\N	question	14	\N
592	595	40	individual	\N	teacher	14	\N
593	596	40	individual	\N	teacher	14	\N
594	597	40	individual	\N	teacher	14	\N
595	598	40	individual	\N	teacher	15	\N
596	599	40	individual	\N	question	15	\N
597	600	40	individual	\N	question	15	\N
598	601	19	individual	\N	question	15	\N
599	602	40	individual	\N	quiz	\N	2
600	603	19	individual	\N	teacher	14	\N
601	604	40	individual	\N	teacher	10	\N
602	605	39	individual	\N	question	12	\N
603	606	40	individual	\N	quiz	\N	1
604	607	40	individual	\N	manual	\N	\N
605	608	40	individual	\N	question	14	\N
606	609	40	individual	\N	teacher	14	\N
607	610	40	individual	\N	teacher	25	\N
608	611	40	individual	\N	manual	\N	\N
609	612	40	individual	\N	teacher	15	\N
610	613	39	individual	\N	manual	\N	\N
611	614	40	individual	\N	teacher	15	\N
612	615	40	individual	\N	quiz	\N	2
613	616	40	individual	\N	teacher	15	\N
614	617	40	individual	\N	manual	\N	\N
615	618	40	individual	\N	question	30	\N
616	619	40	individual	\N	question	30	\N
617	620	40	individual	\N	manual	\N	\N
618	621	40	individual	\N	quiz	\N	30
619	622	40	individual	\N	quiz	\N	30
620	623	40	individual	\N	quiz	\N	1
621	624	40	individual	\N	question	10	\N
622	625	40	individual	\N	question	15	\N
623	626	40	individual	\N	teacher	14	\N
624	627	40	individual	\N	teacher	14	\N
625	628	39	individual	\N	quiz	\N	1
626	629	40	individual	\N	teacher	14	\N
627	630	40	individual	\N	teacher	14	\N
628	631	40	individual	\N	teacher	12	\N
629	632	40	individual	\N	teacher	14	\N
630	633	40	individual	\N	teacher	14	\N
631	634	40	individual	\N	teacher	15	\N
632	635	40	individual	\N	manual	\N	\N
633	636	40	individual	\N	manual	\N	\N
634	637	40	individual	\N	manual	\N	\N
635	638	40	individual	\N	teacher	25	\N
636	639	40	individual	\N	teacher	20	\N
637	640	40	individual	\N	quiz	\N	25
638	641	40	team	2	teacher	60	\N
639	642	40	individual	\N	question	25	\N
640	643	40	individual	\N	question	20	\N
641	644	40	team	2	teacher	60	\N
642	645	40	individual	\N	question	4	\N
643	646	40	individual	\N	question	4	\N
644	647	40	individual	\N	question	14	\N
645	648	40	individual	\N	question	14	\N
646	649	40	individual	\N	question	14	\N
647	650	40	individual	\N	question	12	\N
648	651	40	individual	\N	question	14	\N
649	652	40	individual	\N	teacher	14	\N
650	653	40	individual	\N	teacher	4	\N
651	654	40	individual	\N	teacher	10	\N
652	655	40	team	2	teacher	59	\N
653	656	40	team	2	teacher	60	\N
654	657	40	team	2	teacher	60	\N
655	658	40	team	2	teacher	60	\N
656	659	40	individual	\N	teacher	80	\N
657	660	40	individual	\N	question	14	\N
658	661	40	individual	\N	question	14	\N
659	662	39	individual	\N	teacher	14	\N
660	663	39	individual	\N	teacher	14	\N
661	664	40	individual	\N	question	14	\N
662	665	39	individual	\N	teacher	14	\N
663	666	40	individual	\N	manual	\N	\N
664	667	40	individual	\N	teacher	14	\N
665	668	40	individual	\N	teacher	14	\N
666	669	40	individual	\N	teacher	14	\N
667	670	40	individual	\N	question	14	\N
668	671	40	individual	\N	question	14	\N
669	672	40	individual	\N	teacher	10	\N
670	673	40	individual	\N	teacher	14	\N
671	674	40	individual	\N	question	14	\N
672	675	40	individual	\N	teacher	10	\N
673	676	39	individual	\N	teacher	14	\N
674	677	40	individual	\N	teacher	12	\N
675	678	40	individual	\N	question	14	\N
676	679	40	individual	\N	quiz	\N	2
677	680	40	team	2	teacher	80	\N
678	681	40	individual	\N	question	14	\N
679	682	40	individual	\N	teacher	14	\N
680	683	40	individual	\N	question	14	\N
681	684	40	team	2	teacher	80	\N
682	685	40	individual	\N	question	14	\N
683	686	40	individual	\N	teacher	14	\N
684	687	40	team	2	teacher	80	\N
685	688	40	individual	\N	question	14	\N
686	689	40	individual	\N	question	14	\N
687	690	19	team	2	teacher	80	\N
688	691	40	individual	\N	question	12	\N
689	692	40	individual	\N	question	14	\N
690	693	40	individual	\N	teacher	12	\N
691	694	19	team	2	teacher	80	\N
692	695	40	individual	\N	teacher	14	\N
693	696	40	individual	\N	question	12	\N
694	697	40	individual	\N	question	14	\N
695	698	40	individual	\N	question	14	\N
696	699	40	individual	\N	teacher	15	\N
697	700	40	individual	\N	teacher	12	\N
698	701	40	individual	\N	question	14	\N
699	702	40	individual	\N	question	12	\N
700	703	40	individual	\N	teacher	14	\N
701	704	40	individual	\N	teacher	14	\N
702	705	40	individual	\N	question	20	\N
703	706	40	individual	\N	question	20	\N
704	707	40	individual	\N	question	14	\N
705	708	19	individual	\N	teacher	14	\N
706	709	40	individual	\N	teacher	14	\N
707	710	40	individual	\N	teacher	20	\N
708	711	40	individual	\N	teacher	12	\N
709	712	40	individual	\N	question	12	\N
710	713	40	individual	\N	question	14	\N
711	714	40	individual	\N	question	20	\N
712	715	40	individual	\N	question	14	\N
713	716	40	individual	\N	teacher	41	\N
714	717	40	individual	\N	question	40	\N
715	718	40	individual	\N	teacher	14	\N
716	719	40	individual	\N	question	14	\N
717	720	40	individual	\N	teacher	20	\N
718	721	40	individual	\N	teacher	14	\N
719	722	40	individual	\N	teacher	20	\N
720	723	40	individual	\N	question	10	\N
721	724	40	individual	\N	quiz	\N	2
722	725	40	individual	\N	manual	\N	\N
723	726	40	individual	\N	teacher	12	\N
724	727	40	individual	\N	quiz	\N	1
725	728	40	individual	\N	quiz	\N	15
726	729	40	individual	\N	teacher	14	\N
727	730	40	individual	\N	question	12	\N
728	731	40	individual	\N	quiz	\N	2
729	732	40	individual	\N	manual	\N	\N
730	733	40	individual	\N	teacher	14	\N
731	734	40	individual	\N	question	10	\N
732	735	40	individual	\N	quiz	\N	1
733	736	40	individual	\N	manual	\N	\N
734	737	40	individual	\N	quiz	\N	1
735	738	40	individual	\N	teacher	20	\N
736	739	40	individual	\N	quiz	\N	1
737	740	40	individual	\N	quiz	\N	1
738	741	40	individual	\N	quiz	\N	1
739	742	40	team	2	teacher	80	\N
740	743	40	individual	\N	teacher	14	\N
741	744	40	individual	\N	teacher	14	\N
742	745	40	team	2	teacher	80	\N
743	746	40	individual	\N	teacher	14	\N
744	747	40	individual	\N	teacher	13	\N
745	748	40	individual	\N	quiz	\N	1
746	749	40	team	2	teacher	80	\N
747	750	40	individual	\N	quiz	\N	1
748	751	40	individual	\N	quiz	\N	1
749	752	40	individual	\N	quiz	\N	1
750	753	40	team	2	teacher	80	\N
751	754	40	individual	\N	quiz	\N	1
752	755	40	individual	\N	manual	\N	\N
753	756	40	individual	\N	teacher	14	\N
754	757	40	team	2	teacher	80	\N
755	758	40	individual	\N	teacher	14	\N
756	759	40	individual	\N	question	14	\N
757	760	40	individual	\N	question	14	\N
758	761	40	individual	\N	quiz	\N	1
759	762	40	individual	\N	quiz	\N	1
760	763	40	individual	\N	manual	\N	\N
761	764	40	individual	\N	teacher	14	\N
762	765	40	individual	\N	teacher	14	\N
763	766	40	individual	\N	question	14	\N
764	767	40	individual	\N	quiz	\N	1
765	768	40	individual	\N	manual	\N	\N
766	769	39	team	2	teacher	80	\N
767	770	40	team	2	teacher	80	\N
768	771	40	individual	\N	teacher	14	\N
769	772	40	individual	\N	question	14	\N
770	773	40	individual	\N	quiz	\N	1
771	774	40	individual	\N	quiz	\N	1
772	775	40	individual	\N	quiz	\N	1
773	776	40	team	2	teacher	80	\N
774	777	40	individual	\N	quiz	\N	1
775	778	40	individual	\N	manual	\N	\N
776	779	40	team	2	teacher	80	\N
777	780	40	team	2	teacher	80	\N
778	781	40	individual	\N	manual	\N	\N
779	782	40	individual	\N	teacher	20	\N
780	783	40	individual	\N	question	20	\N
781	784	40	individual	\N	teacher	60	\N
782	785	40	individual	\N	teacher	14	\N
783	786	40	individual	\N	question	14	\N
784	787	40	individual	\N	quiz	\N	1
785	788	40	individual	\N	teacher	60	\N
786	789	40	individual	\N	quiz	\N	1
787	790	40	individual	\N	manual	\N	\N
788	791	40	individual	\N	manual	\N	\N
789	792	40	individual	\N	quiz	\N	1
790	793	40	individual	\N	quiz	\N	1
791	794	40	individual	\N	teacher	60	\N
792	795	40	individual	\N	quiz	\N	1
793	796	40	individual	\N	quiz	\N	1
794	797	40	individual	\N	teacher	14	\N
795	798	40	individual	\N	teacher	14	\N
796	799	40	individual	\N	question	12	\N
797	800	40	individual	\N	question	41	\N
798	801	40	individual	\N	quiz	\N	1
799	802	40	individual	\N	quiz	\N	1
800	803	40	individual	\N	quiz	\N	1
801	804	40	individual	\N	quiz	\N	1
802	805	40	individual	\N	quiz	\N	1
803	806	40	individual	\N	quiz	\N	1
804	807	19	individual	\N	teacher	60	\N
805	808	19	individual	\N	teacher	60	\N
806	809	40	individual	\N	quiz	\N	1
807	810	40	individual	\N	quiz	\N	1
808	811	40	individual	\N	teacher	60	\N
809	812	40	individual	\N	quiz	\N	1
810	813	40	individual	\N	teacher	60	\N
811	814	40	individual	\N	teacher	13	\N
812	815	40	individual	\N	question	20	\N
813	816	40	individual	\N	teacher	20	\N
814	817	40	individual	\N	quiz	\N	1
815	818	40	individual	\N	quiz	\N	1
816	819	40	individual	\N	quiz	\N	1
817	820	40	individual	\N	teacher	60	\N
818	821	40	individual	\N	quiz	\N	1
819	822	40	individual	\N	quiz	\N	1
820	823	40	individual	\N	teacher	20	\N
821	824	40	individual	\N	quiz	\N	1
822	825	40	individual	\N	manual	\N	\N
823	826	40	individual	\N	manual	\N	\N
824	827	40	individual	\N	quiz	\N	1
825	828	40	individual	\N	teacher	1	\N
826	829	40	individual	\N	quiz	\N	1
827	830	40	individual	\N	quiz	\N	1
828	831	40	individual	\N	quiz	\N	1
829	832	40	individual	\N	manual	\N	\N
830	833	40	individual	\N	manual	\N	\N
831	834	40	individual	\N	manual	\N	\N
832	835	40	individual	\N	quiz	\N	1
833	836	40	individual	\N	question	13	\N
834	837	40	individual	\N	teacher	14	\N
835	838	40	individual	\N	question	20	\N
836	839	40	individual	\N	teacher	14	\N
837	840	40	individual	\N	question	40	\N
838	841	40	individual	\N	question	10	\N
839	842	40	individual	\N	quiz	\N	1
840	843	40	individual	\N	quiz	\N	1
841	844	40	individual	\N	manual	\N	\N
842	845	40	individual	\N	teacher	14	\N
843	846	40	individual	\N	question	10	\N
844	847	40	individual	\N	quiz	\N	1
845	848	40	individual	\N	quiz	\N	1
846	849	40	individual	\N	quiz	\N	1
847	850	40	individual	\N	quiz	\N	1
848	851	40	individual	\N	manual	\N	\N
849	852	40	individual	\N	manual	\N	\N
850	853	40	individual	\N	quiz	\N	1
851	854	40	individual	\N	quiz	\N	1
852	855	40	individual	\N	quiz	\N	1
853	856	40	individual	\N	teacher	60	\N
854	857	40	individual	\N	quiz	\N	1
855	858	40	individual	\N	quiz	\N	1
856	859	40	individual	\N	teacher	41	\N
857	860	40	individual	\N	question	20	\N
858	861	40	individual	\N	manual	\N	\N
859	862	40	individual	\N	teacher	60	\N
860	863	40	individual	\N	manual	\N	\N
861	864	40	team	2	teacher	80	\N
862	865	40	team	2	teacher	80	\N
863	866	40	team	2	teacher	80	\N
864	867	19	team	2	teacher	80	\N
865	868	40	team	2	teacher	80	\N
866	869	19	team	2	teacher	80	\N
867	870	19	team	2	teacher	80	\N
868	871	39	individual	\N	question	10	\N
869	872	40	individual	\N	teacher	18	\N
870	873	40	individual	\N	teacher	20	\N
871	874	40	individual	\N	teacher	17	\N
872	875	40	individual	\N	teacher	18	\N
873	876	40	individual	\N	teacher	48	\N
874	877	40	individual	\N	teacher	20	\N
875	878	39	individual	\N	teacher	20	\N
876	879	39	individual	\N	teacher	20	\N
877	880	19	individual	\N	teacher	40	\N
878	881	40	individual	\N	teacher	100	\N
879	882	40	individual	\N	teacher	14	\N
880	883	40	individual	\N	question	20	\N
881	884	40	individual	\N	question	20	\N
882	885	40	individual	\N	question	20	\N
883	886	40	individual	\N	quiz	\N	1
884	887	40	individual	\N	quiz	\N	1
885	888	40	individual	\N	manual	\N	\N
886	889	40	individual	\N	question	20	\N
887	890	40	individual	\N	question	20	\N
888	891	40	individual	\N	teacher	20	\N
889	892	40	individual	\N	question	19	\N
890	893	40	individual	\N	question	20	\N
891	894	40	individual	\N	teacher	20	\N
892	895	40	individual	\N	question	20	\N
893	896	40	individual	\N	question	20	\N
894	897	40	individual	\N	teacher	17	\N
895	898	40	individual	\N	teacher	20	\N
896	899	40	individual	\N	teacher	20	\N
897	900	40	individual	\N	teacher	20	\N
898	901	40	individual	\N	question	20	\N
899	902	40	individual	\N	question	20	\N
900	903	40	individual	\N	teacher	10	\N
901	904	40	individual	\N	teacher	20	\N
902	905	40	individual	\N	quiz	\N	1
903	906	40	individual	\N	manual	\N	\N
904	907	40	individual	\N	teacher	20	\N
905	908	40	individual	\N	teacher	20	\N
906	909	40	individual	\N	question	20	\N
907	910	40	individual	\N	teacher	20	\N
908	911	40	individual	\N	teacher	20	\N
909	912	40	individual	\N	question	20	\N
910	913	40	individual	\N	teacher	52	\N
911	914	40	individual	\N	teacher	20	\N
912	915	40	individual	\N	question	20	\N
913	916	40	individual	\N	quiz	\N	1
914	917	40	individual	\N	manual	\N	\N
915	918	40	individual	\N	teacher	20	\N
916	919	40	individual	\N	quiz	\N	2
917	920	40	individual	\N	teacher	20	\N
918	921	40	individual	\N	question	19	\N
919	922	40	individual	\N	teacher	20	\N
920	923	40	individual	\N	question	20	\N
921	924	40	individual	\N	quiz	\N	1
922	925	40	individual	\N	teacher	20	\N
923	926	40	individual	\N	quiz	\N	1
924	927	40	individual	\N	teacher	20	\N
925	928	40	individual	\N	quiz	\N	1
926	929	40	individual	\N	quiz	\N	1
927	930	40	individual	\N	teacher	10	\N
928	931	40	individual	\N	teacher	48	\N
929	932	40	individual	\N	question	20	\N
930	933	40	individual	\N	teacher	10	\N
931	934	40	individual	\N	question	19	\N
932	935	40	individual	\N	question	20	\N
933	936	40	individual	\N	teacher	19	\N
934	937	40	individual	\N	quiz	\N	1
935	938	40	individual	\N	teacher	20	\N
936	939	40	individual	\N	teacher	20	\N
937	940	40	individual	\N	question	20	\N
938	941	40	individual	\N	question	20	\N
939	942	40	individual	\N	question	15	\N
940	943	40	individual	\N	question	15	\N
941	944	40	individual	\N	teacher	20	\N
942	945	40	individual	\N	quiz	\N	1
943	946	40	individual	\N	quiz	\N	2
944	947	40	individual	\N	teacher	20	\N
945	948	40	individual	\N	teacher	50	\N
946	949	40	individual	\N	teacher	20	\N
947	950	40	individual	\N	teacher	20	\N
948	951	40	individual	\N	teacher	20	\N
949	952	40	individual	\N	teacher	20	\N
950	953	40	individual	\N	teacher	19	\N
951	954	40	individual	\N	teacher	20	\N
952	955	40	individual	\N	teacher	20	\N
953	956	40	individual	\N	teacher	20	\N
954	957	40	individual	\N	teacher	20	\N
955	958	40	individual	\N	teacher	20	\N
956	959	40	individual	\N	teacher	20	\N
957	960	40	individual	\N	teacher	20	\N
958	961	40	individual	\N	teacher	20	\N
959	962	40	individual	\N	teacher	20	\N
960	963	40	individual	\N	teacher	20	\N
961	964	40	individual	\N	teacher	20	\N
962	965	40	individual	\N	teacher	19	\N
963	966	40	individual	\N	teacher	19	\N
964	967	40	individual	\N	teacher	20	\N
965	968	40	individual	\N	quiz	\N	1
966	969	40	individual	\N	question	20	\N
967	970	40	individual	\N	teacher	20	\N
968	971	40	individual	\N	teacher	20	\N
969	972	40	individual	\N	teacher	20	\N
970	973	40	individual	\N	teacher	20	\N
971	974	40	individual	\N	teacher	18	\N
972	975	40	individual	\N	teacher	9	\N
973	976	40	individual	\N	question	6	\N
974	977	40	individual	\N	quiz	\N	1
975	978	40	individual	\N	manual	\N	\N
976	979	19	individual	\N	manual	\N	\N
977	980	19	individual	\N	teacher	10	\N
978	981	39	individual	\N	teacher	10	\N
979	982	39	individual	\N	teacher	20	\N
980	983	39	individual	\N	manual	\N	\N
981	984	39	individual	\N	teacher	10	\N
982	985	39	individual	\N	manual	\N	\N
983	986	39	individual	\N	manual	\N	\N
984	987	39	individual	\N	manual	\N	\N
985	988	40	individual	\N	question	20	\N
986	989	40	individual	\N	teacher	20	\N
987	990	40	individual	\N	teacher	20	\N
988	991	40	individual	\N	teacher	11	\N
989	992	40	team	2	teacher	80	\N
990	993	40	team	2	teacher	80	\N
991	994	40	individual	\N	teacher	10	\N
992	995	40	individual	\N	teacher	20	\N
993	996	19	individual	\N	teacher	5	\N
994	997	20	individual	\N	teacher	5	\N
995	998	40	individual	\N	teacher	10	\N
996	999	40	individual	\N	teacher	70	\N
997	1000	40	individual	\N	teacher	20	\N
998	1001	24	individual	\N	teacher	60	\N
999	1002	35	individual	\N	teacher	60	\N
1000	1003	33	individual	\N	teacher	80	\N
1001	1004	37	individual	\N	teacher	50	\N
1002	1005	32	individual	\N	teacher	70	\N
1003	1006	40	individual	\N	teacher	10	\N
1004	1007	32	individual	\N	teacher	100	\N
1005	1008	40	individual	\N	teacher	10	\N
1006	1009	40	individual	\N	teacher	10	\N
1007	1010	32	individual	\N	teacher	10	\N
1008	1011	40	individual	\N	teacher	10	\N
1009	1012	40	individual	\N	question	10	\N
1010	1013	39	individual	\N	quiz	\N	1
1011	1014	39	individual	\N	manual	\N	\N
1012	1015	40	individual	\N	teacher	20	\N
1013	1016	40	individual	\N	teacher	10	\N
1014	1017	40	individual	\N	teacher	10	\N
1015	1018	32	individual	\N	teacher	10	\N
1016	1019	32	individual	\N	teacher	10	\N
1017	1020	40	individual	\N	teacher	10	\N
1018	1021	32	individual	\N	teacher	50	\N
1019	1022	32	individual	\N	teacher	10	\N
1020	1023	32	individual	\N	teacher	10	\N
1021	1024	33	individual	\N	teacher	10	\N
1022	1025	32	individual	\N	teacher	10	\N
1023	1026	32	individual	\N	teacher	10	\N
1024	1027	34	individual	\N	teacher	50	\N
1025	1028	40	team	2	teacher	10	\N
1026	1029	40	team	-2	teacher	10	\N
1027	1030	32	individual	\N	teacher	10	\N
1028	1031	32	individual	\N	teacher	10	\N
1029	1032	40	team	-1	teacher	20	\N
1030	1033	19	individual	\N	teacher	60	\N
1031	1034	40	team	-1	teacher	10	\N
1032	1035	19	team	2	teacher	30	\N
1033	1036	19	team	2	teacher	10	\N
1034	1037	40	individual	\N	teacher	10	\N
1035	1038	23	individual	\N	teacher	5	\N
1036	1039	40	team	2	teacher	8	\N
1037	1040	40	team	2	teacher	10	\N
1038	1041	32	team	2	teacher	100	\N
1039	1042	40	team	2	teacher	10	\N
1040	1043	40	team	\N	teacher	10	\N
1041	1044	19	individual	\N	teacher	10	\N
1042	1045	33	individual	\N	teacher	10	\N
1043	1046	33	individual	\N	teacher	10	\N
1044	1047	19	individual	\N	teacher	100	\N
1045	1048	33	individual	\N	teacher	100	\N
1046	1049	20	team	2	teacher	10	\N
1047	1050	19	team	2	teacher	80	\N
1048	1051	40	team	2	teacher	80	\N
1049	1052	40	team	2	teacher	10	\N
1050	1053	19	team	2	teacher	10	\N
1051	1054	20	individual	\N	teacher	5	\N
1052	1055	20	individual	\N	manual	\N	\N
1053	1056	32	individual	\N	teacher	10	\N
1054	1057	40	team	2	teacher	10	\N
1055	1058	32	individual	\N	teacher	10	\N
1056	1059	40	team	2	teacher	10	\N
1057	1060	40	individual	\N	teacher	10	\N
1058	1061	20	individual	\N	teacher	50	\N
1059	1062	40	individual	\N	teacher	10	\N
1060	1063	40	team	2	teacher	10	\N
1061	1064	40	individual	\N	teacher	100	\N
1062	1065	40	individual	\N	teacher	50	\N
1063	1066	20	individual	\N	teacher	50	\N
1064	1067	24	individual	\N	teacher	10	\N
1065	1068	19	individual	\N	teacher	40	\N
1066	1069	40	individual	\N	teacher	10	\N
1067	1070	40	team	\N	quiz	\N	4
1068	1071	40	individual	\N	quiz	\N	4
1069	1072	40	team	2	quiz	\N	4
1070	1073	40	team	2	teacher	10	\N
1071	1074	40	team	2	teacher	10	\N
1072	1075	40	individual	\N	teacher	50	\N
1073	1076	40	individual	\N	teacher	25	\N
1074	1077	40	team	2	teacher	10	\N
1075	1078	40	individual	\N	teacher	20	\N
1076	1079	40	team	2	teacher	10	\N
1077	1080	34	team	1	teacher	10	\N
1078	1081	40	team	2	teacher	10	\N
1079	1082	40	team	2	teacher	10	\N
1080	1083	40	team	2	teacher	10	\N
1081	1084	40	individual	\N	teacher	20	\N
1082	1085	40	team	2	teacher	10	\N
1083	1086	40	team	2	teacher	10	\N
1084	1087	40	team	2	teacher	20	\N
1085	1088	40	team	2	teacher	10	\N
1086	1089	40	team	1	teacher	10	\N
1087	1090	40	team	2	teacher	10	\N
1088	1091	40	individual	\N	teacher	20	\N
1089	1092	40	team	2	teacher	10	\N
1090	1093	40	team	1	teacher	10	\N
1091	1094	40	team	1	teacher	10	\N
1092	1095	40	team	2	teacher	10	\N
1093	1096	40	individual	\N	teacher	10	\N
1094	1097	40	team	2	teacher	10	\N
1095	1098	40	team	1	teacher	10	\N
1096	1099	40	team	1	teacher	19	\N
1097	1100	40	team	2	teacher	10	\N
1098	1101	40	team	1	teacher	10	\N
1099	1102	40	team	1	teacher	10	\N
1100	1103	40	team	1	teacher	18	\N
1101	1104	40	team	1	teacher	10	\N
1102	1105	40	team	1	teacher	19	\N
1103	1106	40	individual	\N	teacher	10	\N
1104	1107	40	team	1	teacher	10	\N
1105	1108	40	team	1	teacher	20	\N
1106	1109	40	team	1	teacher	10	\N
1107	1110	40	team	1	teacher	10	\N
1108	1111	40	team	1	teacher	10	\N
1109	1112	40	team	1	teacher	8	\N
1110	1113	40	team	1	teacher	10	\N
1111	1114	40	team	1	teacher	10	\N
1112	1115	40	team	1	teacher	10	\N
1113	1116	40	team	1	teacher	100	\N
1114	1117	40	team	1	teacher	100	\N
1115	1118	40	team	1	question	10	\N
1116	1119	40	team	1	teacher	20	\N
1117	1120	40	team	1	teacher	10	\N
1118	1121	40	team	1	teacher	10	\N
1119	1122	40	team	1	teacher	20	\N
1120	1123	40	team	2	teacher	50	\N
1121	1124	40	individual	\N	teacher	10	\N
1122	1125	40	team	2	teacher	49	\N
1123	1126	40	team	2	teacher	40	\N
1124	1127	40	team	1	teacher	10	\N
1125	1128	40	team	1	teacher	20	\N
1126	1129	40	team	1	teacher	10	\N
1127	1130	40	team	1	teacher	20	\N
1128	1131	19	team	1	teacher	20	\N
1129	1132	40	team	1	teacher	10	\N
1130	1133	40	team	1	teacher	20	\N
1131	1134	33	team	2	teacher	20	\N
1132	1135	40	team	1	teacher	17	\N
1133	1136	40	team	1	teacher	20	\N
1134	1137	40	team	1	teacher	17	\N
1135	1138	40	team	1	teacher	20	\N
1136	1139	40	team	1	teacher	20	\N
1137	1140	40	team	1	teacher	20	\N
1138	1141	40	team	1	teacher	10	\N
1139	1142	32	team	1	teacher	19	\N
1140	1143	37	team	2	teacher	10	\N
1141	1144	20	individual	\N	teacher	2	\N
1142	1145	22	individual	\N	teacher	2	\N
1143	1146	40	team	1	teacher	20	\N
1144	1147	40	team	1	teacher	20	\N
1145	1148	19	team	1	teacher	20	\N
1146	1149	40	team	1	teacher	20	\N
1147	1150	32	team	1	teacher	20	\N
1148	1151	32	team	1	teacher	20	\N
1149	1152	30	team	1	teacher	18	\N
1150	1153	40	team	1	teacher	20	\N
1151	1154	19	team	1	teacher	20	\N
1152	1155	40	team	1	teacher	20	\N
1153	1156	40	team	1	teacher	20	\N
1154	1157	40	team	1	teacher	20	\N
1155	1158	40	team	1	teacher	20	\N
1156	1159	40	team	1	teacher	20	\N
1157	1160	40	team	1	teacher	17	\N
1158	1161	34	team	1	teacher	20	\N
1159	1162	40	team	1	teacher	20	\N
1160	1163	40	team	1	teacher	20	\N
1161	1164	40	team	1	teacher	20	\N
1162	1165	40	team	1	teacher	20	\N
1163	1166	40	team	1	teacher	20	\N
1164	1167	40	team	2	teacher	20	\N
1165	1168	39	team	1	teacher	20	\N
1166	1169	40	team	2	teacher	20	\N
1167	1170	40	team	2	teacher	20	\N
1168	1171	40	individual	\N	question	20	\N
1169	1172	40	team	2	question	20	\N
1170	1173	40	team	20	teacher	10	\N
1171	1174	40	team	2	teacher	17	\N
1172	1175	40	individual	\N	teacher	20	\N
1173	1176	40	individual	\N	question	19	\N
1174	1177	40	team	2	teacher	19	\N
1175	1178	40	team	1	teacher	16	\N
1176	1179	40	team	20	question	20	\N
1177	1180	40	individual	\N	question	8	\N
1178	1181	40	team	1	question	20	\N
1179	1182	40	team	1	teacher	20	\N
1180	1183	40	team	1	question	20	\N
1181	1184	40	team	1	question	20	\N
1182	1185	40	team	2	question	20	\N
1183	1186	40	team	2	question	20	\N
1184	1187	40	individual	\N	question	20	\N
1185	1188	40	team	1	question	20	\N
1186	1189	40	team	1	question	20	\N
1187	1190	40	team	2	question	20	\N
1188	1191	40	team	2	question	18	\N
1189	1192	40	team	2	question	20	\N
1190	1193	40	team	2	quiz	\N	19
1191	1194	40	team	2	question	20	\N
1192	1195	40	individual	\N	quiz	\N	2
1193	1196	40	team	2	quiz	\N	2
1194	1197	40	individual	\N	question	20	\N
1195	1198	40	team	2	question	20	\N
1196	1199	40	team	2	question	20	\N
1197	1200	40	individual	\N	question	20	\N
1198	1201	40	team	2	quiz	\N	1
1199	1202	40	individual	\N	manual	\N	\N
1200	1203	40	individual	\N	question	20	\N
1201	1204	40	team	2	question	20	\N
1202	1205	40	team	2	quiz	\N	1
1203	1206	40	team	2	question	20	\N
1204	1207	40	team	2	question	20	\N
1205	1208	40	individual	\N	manual	\N	\N
1206	1209	40	team	2	manual	\N	\N
1207	1210	47	individual	\N	teacher	50	\N
1208	1211	49	individual	\N	teacher	20	\N
1209	1212	47	individual	\N	teacher	20	\N
1210	1213	49	individual	\N	teacher	10	\N
1211	1214	51	individual	\N	teacher	10	\N
1212	1215	47	individual	\N	teacher	20	\N
1213	1216	40	team	1	teacher	6	\N
1214	1217	40	team	1	teacher	10	\N
1215	1218	40	team	1	teacher	20	\N
1216	1219	40	team	2	teacher	10	\N
1217	1220	40	team	1	teacher	10	\N
1218	1221	40	team	1	teacher	17	\N
1219	1222	40	individual	\N	teacher	10	\N
1220	1223	40	team	2	question	20	\N
1221	1224	40	individual	\N	question	20	\N
1222	1225	40	individual	\N	question	10	\N
1223	1226	40	individual	\N	teacher	10	\N
1224	1227	40	individual	\N	teacher	10	\N
1225	1228	40	individual	\N	question	10	\N
1226	1229	40	individual	\N	teacher	10	\N
1227	1230	40	individual	\N	question	10	\N
1228	1231	40	individual	\N	teacher	10	\N
1229	1232	40	individual	\N	question	10	\N
1230	1233	39	individual	\N	quiz	\N	1
1231	1234	40	individual	\N	manual	\N	\N
1232	1235	40	team	2	teacher	20	\N
1233	1236	40	team	2	question	11	\N
1234	1237	40	team	\N	question	10	\N
1235	1238	40	team	1	teacher	10	\N
1236	1239	40	team	1	question	10	\N
1237	1240	19	individual	\N	teacher	10	\N
1238	1241	19	individual	\N	teacher	10	\N
1239	1242	19	individual	\N	question	10	\N
1240	1243	40	individual	\N	teacher	10	\N
1241	1244	40	individual	\N	question	10	\N
1242	1245	40	individual	\N	teacher	10	\N
1243	1246	40	individual	\N	question	10	\N
1244	1247	40	individual	\N	teacher	10	\N
1245	1248	40	individual	\N	question	10	\N
1246	1249	40	individual	\N	quiz	\N	1
1247	1250	40	individual	\N	quiz	\N	1
1248	1251	40	individual	\N	manual	\N	\N
1249	1253	40	individual	\N	question	10	\N
1250	1254	40	individual	\N	quiz	\N	1
1251	1255	40	individual	\N	manual	\N	\N
1252	1256	40	individual	\N	manual	\N	\N
1253	1257	40	individual	\N	question	10	\N
1254	1258	40	individual	\N	quiz	\N	2
1255	1260	40	team	1	teacher	10	\N
1256	1261	40	team	1	question	10	\N
1257	1262	40	team	1	teacher	10	\N
1258	1263	40	team	1	question	10	\N
1259	1264	40	individual	\N	quiz	\N	2
1260	1266	40	team	1	manual	\N	\N
1261	1267	40	team	1	manual	\N	\N
1262	1268	40	team	1	question	10	\N
1263	1269	40	team	1	quiz	\N	10
1264	1271	40	team	2	teacher	10	\N
1265	1272	40	team	2	question	10	\N
1266	1273	40	individual	\N	question	20	\N
1267	1275	40	team	2	question	20	\N
1268	1276	40	individual	\N	question	10	\N
1269	1277	40	team	2	question	10	\N
1270	1278	40	team	2	question	20	\N
1271	1279	40	individual	\N	quiz	\N	10
1272	1280	40	individual	\N	question	20	\N
1273	1281	40	team	2	teacher	10	\N
1274	1282	40	team	2	question	20	\N
1275	1285	40	individual	\N	question	20	\N
1276	1287	40	team	2	question	20	\N
1277	1288	40	team	2	question	19	\N
1278	1289	40	team	2	question	20	\N
1279	1290	40	team	2	question	20	\N
1280	1292	40	team	2	question	20	\N
1281	1293	40	individual	\N	quiz	\N	2
1282	1296	40	team	2	quiz	\N	2
1283	1297	40	team	2	question	10	\N
1284	1298	40	team	2	quiz	\N	10
1285	1299	40	individual	\N	manual	\N	\N
1286	1300	40	team	2	manual	\N	\N
1287	1301	40	team	2	manual	\N	\N
1288	1307	40	team	2	question	20	\N
1289	1309	40	team	2	question	20	\N
1290	1310	40	team	2	question	20	\N
1291	1311	40	team	2	question	20	\N
1292	1312	40	team	2	teacher	20	\N
1293	1313	40	team	2	question	20	\N
1294	1317	40	team	2	question	20	\N
1295	1320	39	team	2	teacher	20	\N
1296	1321	40	team	2	question	20	\N
1297	1322	40	individual	\N	manual	\N	\N
1298	1323	40	individual	\N	quiz	\N	2
1299	1324	40	team	2	quiz	\N	2
1300	1325	40	team	2	question	20	\N
1301	1326	40	individual	\N	quiz	\N	2
1302	1328	40	team	2	quiz	\N	2
1303	1329	40	individual	\N	quiz	\N	2
1304	1332	40	team	2	question	20	\N
1305	1333	40	individual	\N	quiz	\N	2
1306	1334	40	individual	\N	manual	\N	\N
1307	1335	40	team	2	question	50	\N
1308	1336	40	team	2	question	80	\N
1309	1337	40	team	2	question	20	\N
1310	1340	51	individual	\N	teacher	752	\N
1311	1342	40	team	2	question	80	\N
1312	1343	40	individual	\N	quiz	\N	2
1313	1344	40	individual	\N	quiz	\N	2
1314	1345	40	team	2	question	20	\N
1315	1346	40	individual	\N	quiz	\N	2
1316	1347	40	individual	\N	manual	\N	\N
1317	1351	40	team	2	question	80	\N
1318	1352	40	individual	\N	quiz	\N	8
1319	1353	40	team	2	quiz	\N	5
1320	1354	40	individual	\N	manual	\N	\N
1321	1355	40	team	2	manual	\N	\N
1322	1356	40	team	2	manual	\N	\N
1323	1359	40	team	2	question	20	\N
1324	1360	40	team	2	question	50	\N
1325	1361	40	individual	\N	manual	\N	\N
1326	1362	40	team	2	quiz	\N	5
1327	1363	40	team	2	manual	\N	\N
1328	1364	40	individual	\N	manual	\N	\N
1329	1365	40	team	2	manual	\N	\N
1330	1366	40	team	2	manual	\N	\N
1331	1367	40	individual	\N	quiz	\N	5
1332	1368	40	team	2	quiz	\N	5
1333	1369	40	individual	\N	question	50	\N
1334	1371	40	individual	\N	teacher	10	\N
1335	1372	40	individual	\N	teacher	10	\N
1336	1373	40	individual	\N	question	50	\N
1337	1374	40	individual	\N	quiz	\N	2
1338	1375	40	individual	\N	manual	\N	\N
1339	1376	40	team	2	teacher	20	\N
1340	1377	40	team	2	question	50	\N
1341	1378	40	team	2	quiz	\N	2
1342	1379	40	individual	\N	manual	\N	\N
1343	1380	40	team	2	manual	\N	\N
1344	1381	40	team	2	manual	\N	\N
1345	1382	40	individual	\N	quiz	\N	20
1346	1383	40	team	2	quiz	\N	2
1347	1384	40	individual	\N	quiz	\N	2
1348	1385	40	team	2	quiz	\N	2
1349	1386	40	team	2	quiz	\N	2
1350	1387	40	team	2	quiz	\N	2
1351	1388	40	team	2	quiz	\N	8
1352	1389	40	team	2	question	50	\N
1353	1390	40	team	2	quiz	\N	5
1354	1395	40	team	2	question	50	\N
1355	1400	40	team	2	question	17	\N
1356	1404	40	team	2	quiz	\N	5
1357	1408	40	team	2	quiz	\N	2
1358	1412	40	individual	\N	question	20	\N
1359	1413	39	individual	\N	question	5	\N
1360	1414	40	team	\N	question	50	\N
1361	1415	40	team	2	quiz	\N	5
1362	1416	40	individual	\N	teacher	10	\N
1363	1417	40	individual	\N	question	40	\N
1364	1418	40	individual	\N	teacher	20	\N
1365	1419	40	individual	\N	question	20	\N
1366	1420	40	individual	\N	quiz	\N	5
1367	1421	40	individual	\N	manual	\N	\N
1368	1422	40	team	2	teacher	30	\N
1369	1423	40	team	2	question	60	\N
1370	1424	40	team	2	question	20	\N
1371	1426	40	team	2	question	30	\N
1372	1427	40	team	2	teacher	30	\N
1373	1428	40	team	2	question	30	\N
1374	1429	40	team	2	quiz	\N	9
1375	1430	40	team	2	manual	\N	\N
1376	1431	40	team	2	teacher	30	\N
1377	1432	40	individual	\N	question	20	\N
1378	1433	40	individual	\N	question	40	\N
1379	1434	40	individual	\N	teacher	50	\N
1380	1435	40	individual	\N	question	30	\N
1381	1436	40	individual	\N	quiz	\N	3
1382	1437	40	individual	\N	manual	\N	\N
1383	1438	40	team	2	question	30	\N
1384	1439	40	team	2	question	30	\N
1385	1440	40	team	2	question	30	\N
1386	1441	40	team	2	question	30	\N
1387	1442	40	team	2	question	30	\N
1388	1443	40	individual	\N	teacher	30	\N
1389	1444	40	individual	\N	question	60	\N
1390	1445	40	individual	\N	manual	\N	\N
1391	1446	40	team	2	teacher	30	\N
1392	1447	40	team	2	question	60	\N
1393	1448	40	team	2	quiz	\N	2
1394	1449	40	team	2	manual	\N	\N
1395	1451	40	individual	\N	question	30	\N
1396	1452	40	individual	\N	question	50	\N
1397	1453	40	individual	\N	quiz	\N	3
1398	1454	40	individual	\N	manual	\N	\N
1399	1455	40	individual	\N	question	30	\N
1400	1461	39	individual	\N	question	20	\N
1401	1466	40	individual	\N	teacher	20	\N
1402	1485	47	team	1	teacher	30	\N
1403	1486	47	team	1	teacher	30	\N
1404	1487	47	team	1	teacher	30	\N
1405	1488	47	individual	\N	teacher	29	\N
1406	1489	47	individual	\N	teacher	50	\N
1407	1490	47	individual	\N	teacher	20	\N
1408	1491	47	individual	\N	teacher	30	\N
1409	1492	47	individual	\N	teacher	30	\N
1410	1493	47	individual	\N	question	30	\N
1411	1494	47	individual	\N	quiz	\N	2
1412	1495	47	individual	\N	teacher	20	\N
1413	1496	47	team	1	teacher	20	\N
1414	1497	47	team	2	teacher	29	\N
1415	1498	47	individual	\N	question	28	\N
1416	1499	47	individual	\N	quiz	\N	1
1417	1500	47	individual	\N	teacher	20	\N
1418	1501	47	individual	\N	teacher	20	\N
1419	1502	47	individual	\N	teacher	30	\N
1420	1503	47	individual	\N	teacher	20	\N
1421	1504	47	individual	\N	teacher	10	\N
1422	1505	47	individual	\N	teacher	20	\N
1423	1506	47	individual	\N	question	30	\N
1424	1511	47	individual	\N	teacher	20	\N
1425	1512	47	individual	\N	question	20	\N
1426	1513	47	team	2	teacher	20	\N
1427	1514	47	team	2	question	20	\N
1428	1515	47	team	2	manual	\N	\N
1429	1516	47	individual	\N	teacher	20	\N
1430	1517	47	individual	\N	teacher	5	\N
1431	1518	49	individual	\N	teacher	20	\N
1432	1519	47	individual	\N	teacher	20	\N
1433	1520	52	individual	\N	manual	\N	\N
1434	1521	52	individual	\N	manual	\N	\N
1435	1522	52	individual	\N	manual	\N	\N
1436	1523	52	individual	\N	manual	\N	\N
1437	1524	52	individual	\N	manual	\N	\N
1438	1525	47	individual	\N	teacher	20	\N
1439	1526	52	individual	\N	teacher	20	\N
1440	1527	52	individual	\N	teacher	80	\N
1441	1528	52	team	2	teacher	20	\N
1442	1529	52	team	2	teacher	8	\N
1443	1530	52	team	1	question	20	\N
1444	1531	52	individual	\N	question	10	\N
1445	1532	52	individual	\N	teacher	19	\N
1446	1533	52	individual	\N	teacher	10	\N
1447	1534	52	individual	\N	teacher	10	\N
1448	1535	52	individual	\N	question	10	\N
1449	1536	52	individual	\N	teacher	10	\N
1450	1537	52	individual	\N	question	10	\N
1451	1538	52	individual	\N	question	10	\N
1452	1539	52	individual	\N	question	10	\N
1453	1540	52	individual	\N	question	10	\N
1454	1541	52	team	1	teacher	10	\N
1455	1542	52	team	2	teacher	8	\N
1456	1543	47	team	2	teacher	53	\N
1457	1544	49	individual	\N	question	90	\N
1458	1545	49	individual	\N	quiz	\N	90
1459	1546	49	individual	\N	quiz	\N	50
1460	1547	49	individual	\N	teacher	60	\N
1461	1548	47	individual	\N	teacher	60	\N
1462	1549	52	individual	\N	teacher	9	\N
1463	1550	47	team	2	teacher	30	\N
1464	1551	52	individual	\N	question	50	\N
1465	1552	52	individual	\N	manual	\N	\N
1466	1553	52	individual	\N	manual	\N	\N
1467	1554	52	individual	\N	manual	\N	\N
1468	1555	52	individual	\N	manual	\N	\N
1469	1556	52	individual	\N	manual	\N	\N
1470	1557	52	individual	\N	manual	\N	\N
1471	1558	52	individual	\N	question	20	\N
1472	1559	52	individual	\N	manual	\N	\N
1473	1560	52	individual	\N	manual	\N	\N
1474	1561	52	individual	\N	manual	\N	\N
1475	1562	52	individual	\N	manual	\N	\N
1476	1563	52	individual	\N	manual	\N	\N
1477	1564	52	individual	\N	manual	\N	\N
1478	1565	52	individual	\N	manual	\N	\N
1479	1566	52	individual	\N	manual	\N	\N
1480	1567	52	individual	\N	manual	\N	\N
1481	1568	52	individual	\N	manual	\N	\N
1482	1569	52	individual	\N	manual	\N	\N
1483	1570	52	individual	\N	manual	\N	\N
1484	1571	52	individual	\N	manual	\N	\N
1485	1572	52	individual	\N	manual	\N	\N
1486	1573	52	individual	\N	manual	\N	\N
1487	1574	52	individual	\N	manual	\N	\N
1488	1575	52	individual	\N	manual	\N	\N
1489	1576	52	individual	\N	manual	\N	\N
1490	1577	52	individual	\N	manual	\N	\N
1491	1578	52	individual	\N	manual	\N	\N
1492	1579	52	individual	\N	manual	\N	\N
1493	1580	52	individual	\N	manual	\N	\N
1494	1581	52	individual	\N	teacher	10	\N
1495	1582	52	individual	\N	question	30	\N
1496	1583	52	team	2	question	20	\N
1497	1584	52	team	2	question	20	\N
1498	1585	52	team	\N	teacher	10	\N
1499	1586	52	team	2	teacher	10	\N
1500	1587	52	individual	\N	question	10	\N
1501	1588	52	individual	\N	question	10	\N
1502	1589	52	individual	\N	question	10	\N
1503	1590	52	team	2	question	20	\N
1504	1591	52	individual	\N	teacher	10	\N
1505	1592	52	team	2	teacher	10	\N
1506	1593	94	individual	\N	teacher	10	\N
1507	1594	94	individual	\N	teacher	50	\N
1508	1595	86	individual	\N	teacher	52	\N
1509	1596	47	individual	\N	teacher	10	\N
1510	1597	47	individual	\N	manual	\N	\N
1511	1598	47	individual	\N	manual	\N	\N
1512	1599	52	individual	\N	manual	\N	\N
1513	1600	94	individual	\N	manual	\N	\N
1514	1601	47	individual	\N	teacher	30	\N
1515	1602	32	individual	\N	teacher	50	\N
1516	1603	49	individual	\N	teacher	30	\N
1517	1604	51	individual	\N	teacher	50	\N
1518	1605	39	individual	\N	teacher	50	\N
1519	1606	47	individual	\N	manual	\N	\N
1520	1607	32	individual	\N	teacher	50	\N
1521	1608	32	individual	\N	teacher	50	\N
1522	1609	47	individual	\N	manual	\N	\N
1523	1610	83	individual	\N	teacher	10	\N
1524	1611	47	individual	\N	teacher	10	\N
1525	1612	47	individual	\N	manual	\N	\N
1526	1613	47	individual	\N	teacher	20	\N
1527	1614	47	individual	\N	manual	\N	\N
1528	1615	47	individual	\N	teacher	10	\N
1529	1616	52	individual	\N	manual	\N	\N
1530	1617	47	individual	\N	manual	\N	\N
1531	1618	47	individual	\N	question	10	\N
1532	1621	47	individual	\N	teacher	20	\N
1533	1622	49	individual	\N	teacher	50	\N
1534	1623	51	individual	\N	teacher	10	\N
1535	1624	47	individual	\N	manual	\N	\N
1536	1625	47	individual	\N	manual	\N	\N
1537	1626	47	individual	\N	manual	\N	\N
1538	1627	47	individual	\N	teacher	10	\N
1539	1628	52	team	\N	question	10	\N
1540	1629	47	individual	\N	quiz	\N	2
1541	1630	52	individual	\N	quiz	\N	2
1542	1631	52	individual	\N	quiz	\N	10
1543	1632	94	team	\N	manual	\N	\N
1544	1633	47	individual	\N	teacher	10	\N
1545	1634	47	team	\N	question	10	\N
1546	1635	47	individual	\N	teacher	10	\N
1547	1636	47	individual	\N	teacher	10	\N
1548	1637	47	individual	\N	question	20	\N
1549	1638	47	individual	\N	question	10	\N
1550	1639	52	individual	\N	quiz	\N	2
1551	1640	47	individual	\N	quiz	\N	2
1552	1641	47	individual	\N	teacher	10	\N
1553	1642	52	team	2	teacher	10	\N
1554	1643	47	individual	\N	question	10	\N
1555	1644	52	team	2	question	20	\N
1556	1645	52	individual	\N	teacher	20	\N
1557	1646	52	team	2	question	20	\N
1558	1647	47	team	2	quiz	\N	2
1559	1648	47	individual	\N	manual	\N	\N
1560	1649	52	team	2	manual	\N	\N
1561	1652	47	individual	\N	teacher	10	\N
1562	1653	47	individual	\N	question	9	\N
1563	1654	47	individual	\N	question	10	\N
1564	1655	47	individual	\N	question	10	\N
1565	1656	47	individual	\N	question	9	\N
1566	1657	47	individual	\N	teacher	10	\N
1567	1658	47	individual	\N	question	10	\N
1568	1659	47	individual	\N	question	10	\N
1569	1660	47	individual	\N	question	10	\N
1570	1661	47	individual	\N	question	10	\N
1571	1662	47	individual	\N	question	10	\N
1572	1663	47	individual	\N	question	10	\N
1573	1664	47	individual	\N	quiz	\N	2
1574	1665	47	individual	\N	question	10	\N
1575	1666	47	individual	\N	teacher	10	\N
1576	1667	47	individual	\N	question	10	\N
1577	1668	47	individual	\N	teacher	60	\N
1578	1669	47	individual	\N	teacher	10	\N
1579	1670	47	individual	\N	question	10	\N
1580	1671	47	individual	\N	question	10	\N
1581	1672	47	individual	\N	question	20	\N
1582	1673	47	individual	\N	teacher	10	\N
1583	1674	47	individual	\N	teacher	20	\N
1584	1675	47	individual	\N	teacher	10	\N
1585	1676	47	individual	\N	quiz	\N	10
1586	1677	47	individual	\N	teacher	8	\N
1587	1678	103	individual	\N	teacher	10	\N
1588	1686	47	team	2	teacher	12	\N
1589	1687	47	individual	\N	teacher	20	\N
1590	1688	47	team	2	teacher	10	\N
1591	1689	47	team	2	question	10	\N
1592	1738	47	team	2	teacher	10	\N
1593	1739	23	team	2	manual	\N	\N
1594	1742	47	individual	\N	teacher	10	\N
1595	1743	47	individual	\N	teacher	10	\N
1596	1744	103	individual	\N	teacher	10	\N
1597	1745	47	individual	\N	teacher	10	\N
1598	1746	47	individual	\N	question	10	\N
1599	1747	47	individual	\N	quiz	\N	1
1600	1748	47	individual	\N	manual	\N	\N
1601	1749	47	team	2	teacher	10	\N
1602	1750	47	team	2	teacher	10	\N
1603	1751	47	team	2	question	10	\N
1604	1752	47	individual	\N	teacher	10	\N
1605	1753	47	individual	\N	question	10	\N
1606	1754	47	team	2	question	10	\N
1607	1755	47	individual	\N	quiz	\N	20
1608	1756	47	individual	\N	question	55	\N
1609	1767	47	individual	\N	teacher	50	\N
1610	1768	47	individual	\N	teacher	20	\N
1611	1769	47	individual	\N	teacher	20	\N
1612	1770	47	individual	\N	teacher	50	\N
1613	1771	47	individual	\N	teacher	50	\N
1614	1772	47	individual	\N	teacher	50	\N
1615	1773	47	individual	\N	teacher	502	\N
1616	1774	47	team	2	teacher	50	\N
1617	1775	47	individual	\N	question	50	\N
1618	1776	47	individual	\N	quiz	\N	30
1619	1777	47	individual	\N	manual	\N	\N
1620	1780	117	individual	\N	teacher	10	\N
1621	1781	117	individual	\N	question	10	\N
1622	1782	117	individual	\N	quiz	\N	10
1623	1783	117	individual	\N	manual	\N	\N
1624	1784	117	team	2	teacher	10	\N
1625	1788	47	team	2	teacher	50	\N
1626	1789	47	team	2	teacher	50	\N
1627	1790	47	team	2	teacher	50	\N
1628	1791	47	team	2	teacher	35	\N
1629	1792	47	team	2	teacher	60	\N
1630	1793	47	team	2	teacher	80	\N
1631	1794	47	individual	\N	teacher	50	\N
1632	1795	47	team	2	teacher	50	\N
1633	1796	47	team	2	teacher	50	\N
1634	1797	47	team	2	teacher	50	\N
1635	1798	47	team	2	teacher	50	\N
1636	1799	47	individual	\N	teacher	5	\N
1637	1800	117	individual	\N	teacher	20	\N
1638	1804	47	team	2	teacher	30	\N
1639	1805	47	team	2	teacher	20	\N
1640	1806	47	team	2	teacher	30	\N
1641	1807	49	team	2	teacher	80	\N
1642	1808	47	team	2	teacher	12	\N
1643	1809	124	individual	\N	question	20	\N
1644	1810	47	individual	\N	teacher	50	\N
1645	1811	124	individual	\N	teacher	10	\N
1646	1812	124	individual	\N	teacher	100	\N
1647	1813	124	individual	\N	teacher	100	\N
1648	1814	124	individual	\N	question	20	\N
1649	1815	124	individual	\N	question	20	\N
1650	1816	124	individual	\N	quiz	\N	2
1651	1817	124	individual	\N	manual	\N	\N
1652	1818	117	individual	\N	teacher	10	\N
1653	1819	117	individual	\N	teacher	10	\N
1654	1820	124	team	2	manual	\N	\N
1655	1821	124	team	2	manual	\N	\N
1656	1824	124	individual	\N	teacher	20	\N
1657	1825	124	individual	\N	question	10	\N
1658	1826	117	individual	\N	question	20	\N
1659	1827	124	individual	\N	teacher	20	\N
1660	1828	124	individual	\N	question	20	\N
1661	1829	124	individual	\N	quiz	\N	2
1662	1830	124	individual	\N	manual	\N	\N
1663	1831	124	team	2	teacher	10	\N
1664	1832	124	team	2	question	20	\N
1665	1833	124	individual	\N	question	20	\N
1666	1834	124	team	2	quiz	\N	2
1667	1835	124	team	\N	question	10	\N
1668	1836	47	team	2	question	50	\N
1669	1837	49	team	2	quiz	\N	2
1670	1838	47	team	2	quiz	\N	30
1671	1839	125	individual	\N	teacher	30	\N
1672	1840	125	individual	\N	teacher	30	\N
1673	1841	125	individual	\N	teacher	30	\N
1674	1842	125	individual	\N	teacher	30	\N
1675	1843	126	individual	\N	teacher	30	\N
1676	1844	124	individual	\N	quiz	\N	2
1677	1845	126	individual	\N	quiz	\N	2
1678	1846	124	individual	\N	question	30	\N
1679	1847	126	individual	\N	question	20	\N
1680	1848	126	team	\N	teacher	30	\N
1681	1849	126	individual	\N	question	30	\N
1682	1850	126	team	2	question	30	\N
1683	1851	126	individual	\N	quiz	\N	30
1684	1852	124	team	2	quiz	\N	2
1685	1853	126	team	2	question	30	\N
1686	1854	126	individual	\N	question	30	\N
1687	1855	126	team	\N	question	30	\N
1688	1856	117	individual	\N	question	20	\N
1689	1857	117	individual	\N	question	20	\N
1690	1859	126	team	\N	teacher	2	\N
1691	1860	126	team	2	teacher	20	\N
1692	1863	47	individual	\N	teacher	20	\N
1693	1864	47	team	2	manual	\N	\N
1694	1865	47	team	2	teacher	50	\N
\.


--
-- TOC entry 5265 (class 0 OID 16537)
-- Dependencies: 225
-- Data for Name: AvatarAccessories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AvatarAccessories" ("Accessory_ID", "Accessory_Image") FROM stdin;
0	https://res.cloudinary.com/dyswafidd/image/upload/v1772001210/accessory1_qmlkhy.png
1	https://res.cloudinary.com/dyswafidd/image/upload/v1772002301/accessory1_ib1jv1.png
2	https://res.cloudinary.com/dyswafidd/image/upload/v1772002379/accessory2_stxorg.png
3	https://res.cloudinary.com/dyswafidd/image/upload/v1772002941/accessory3_fe03ei.png
4	https://res.cloudinary.com/dyswafidd/image/upload/v1772002995/accessory4_bwsm2k.png
5	https://res.cloudinary.com/dyswafidd/image/upload/v1772002999/accessory5_v3osil.png
6	https://res.cloudinary.com/dyswafidd/image/upload/v1772002997/accessory6_gfwwub.png
7	https://res.cloudinary.com/dyswafidd/image/upload/v1772002996/accessory7_o5uuwl.png
8	https://res.cloudinary.com/dyswafidd/image/upload/v1772002998/accessory8_tpqaet.png
\.


--
-- TOC entry 5266 (class 0 OID 16546)
-- Dependencies: 226
-- Data for Name: AvatarBodies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AvatarBodies" ("Body_ID", "Body_Image") FROM stdin;
8	https://res.cloudinary.com/dyswafidd/image/upload/v1772003008/body8_ssofym.png
7	https://res.cloudinary.com/dyswafidd/image/upload/v1772003002/body7_fczjvv.png
6	https://res.cloudinary.com/dyswafidd/image/upload/v1772003001/body6_db1j42.png
5	https://res.cloudinary.com/dyswafidd/image/upload/v1772002999/body5_hwkeuy.png
4	https://res.cloudinary.com/dyswafidd/image/upload/v1772003000/body4_irydx6.png
3	https://res.cloudinary.com/dyswafidd/image/upload/v1772002998/body3_tyxdsf.png
2	https://res.cloudinary.com/dyswafidd/image/upload/v1772003001/body2_wptmwq.png
1	https://res.cloudinary.com/dyswafidd/image/upload/v1772002997/body1_kggp19.png
0	https://res.cloudinary.com/dyswafidd/image/upload/v1772003002/body0_yutfjx.png
\.


--
-- TOC entry 5264 (class 0 OID 16518)
-- Dependencies: 224
-- Data for Name: AvatarCostumes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AvatarCostumes" ("Costume_ID", "Costume_Image") FROM stdin;
1	https://res.cloudinary.com/dyswafidd/image/upload/v1772003006/costume1_kcq2kq.png
0	https://res.cloudinary.com/dyswafidd/image/upload/v1772003004/costume0_m5yaem.png
2	https://res.cloudinary.com/dyswafidd/image/upload/v1772003006/costume2_ihtu2s.png
3	https://res.cloudinary.com/dyswafidd/image/upload/v1772003006/costume3_cszjbz.png
4	https://res.cloudinary.com/dyswafidd/image/upload/v1772003008/costume4_kgeoca.png
5	https://res.cloudinary.com/dyswafidd/image/upload/v1772003007/costume5_jlzobl.png
6	https://res.cloudinary.com/dyswafidd/image/upload/v1772003009/costume6_aazhfv.png
7	https://res.cloudinary.com/dyswafidd/image/upload/v1772003009/costume7_efbhfr.png
8	https://res.cloudinary.com/dyswafidd/image/upload/v1773304950/costume8_svs6du.png
\.


--
-- TOC entry 5263 (class 0 OID 16492)
-- Dependencies: 223
-- Data for Name: AvatarMasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AvatarMasks" ("Mask_ID", "Mask_Image") FROM stdin;
0	https://res.cloudinary.com/dyswafidd/image/upload/v1772003010/mask0_snscbt.png
1	https://res.cloudinary.com/dyswafidd/image/upload/v1772003011/mask1_ulwvmy.png
2	https://res.cloudinary.com/dyswafidd/image/upload/v1772003011/mask2_wtegcq.png
3	https://res.cloudinary.com/dyswafidd/image/upload/v1772003012/mask3_v8doli.png
4	https://res.cloudinary.com/dyswafidd/image/upload/v1772003014/mask4_wfq2nr.png
5	https://res.cloudinary.com/dyswafidd/image/upload/v1772003014/mask5_vefhzx.png
6	https://res.cloudinary.com/dyswafidd/image/upload/v1772003015/mask6_blymfa.png
7	https://res.cloudinary.com/dyswafidd/image/upload/v1772003015/mask7_kkg1jo.png
8	https://res.cloudinary.com/dyswafidd/image/upload/v1772003016/mask8_cpixwh.png
\.


--
-- TOC entry 5267 (class 0 OID 16566)
-- Dependencies: 227
-- Data for Name: Avatars; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Avatars" ("Avatar_ID", "Mask_ID", "Costume_ID", "Accessory_ID", "Body_ID") FROM stdin;
1	0	0	1	1
2	2	0	0	1
3	0	0	2	1
4	0	0	1	2
5	0	8	0	1
6	0	0	0	1
7	0	0	1	0
8	1	1	1	1
9	0	0	0	0
10	0	0	1	0
11	2	0	4	1
12	0	0	0	0
13	0	0	0	7
14	0	0	0	7
15	1	0	0	1
16	0	0	0	1
17	0	0	0	1
18	1	0	0	4
19	4	0	2	7
20	0	0	6	1
21	0	0	0	1
22	0	0	0	0
23	0	0	0	0
24	0	0	0	0
25	0	0	0	0
26	0	0	0	4
27	0	0	0	4
28	0	0	0	0
29	0	0	0	1
30	0	0	0	1
31	0	0	0	1
32	0	0	0	4
33	0	0	0	0
34	0	0	0	0
35	2	0	0	4
36	0	0	0	7
37	0	0	5	1
38	0	0	0	1
39	0	0	0	4
40	0	0	1	1
41	0	0	0	1
42	0	0	0	0
43	0	0	0	1
44	0	0	0	0
45	0	0	0	0
46	0	0	0	4
47	0	0	0	0
48	0	0	0	0
49	0	0	0	0
50	0	0	0	0
51	0	0	0	0
52	0	0	0	0
53	0	0	0	0
54	0	0	0	0
55	0	0	0	0
56	0	0	0	0
57	0	0	0	0
58	0	0	0	0
59	0	0	0	0
60	0	0	0	0
61	0	0	0	7
62	0	0	0	0
63	0	0	0	0
64	0	0	0	0
65	0	0	0	0
66	0	0	0	0
67	0	0	0	0
68	0	0	0	0
69	0	0	0	0
70	0	0	0	0
71	0	0	0	0
72	0	0	0	0
73	0	0	1	0
74	0	0	0	0
75	0	0	0	0
76	0	0	0	0
77	0	0	0	0
78	0	0	0	0
79	0	0	0	0
80	0	0	0	0
81	0	0	0	0
82	0	0	0	0
83	0	0	0	0
84	0	0	0	0
85	0	0	0	0
86	0	0	0	0
87	0	0	0	0
88	0	0	0	0
89	0	0	0	0
90	0	0	0	0
91	0	0	0	0
92	0	0	0	0
93	0	0	0	0
94	0	0	0	0
95	0	0	0	0
96	0	0	0	0
97	0	0	0	0
98	0	0	0	0
99	0	0	0	0
100	0	0	0	0
101	0	0	0	0
102	0	0	0	1
103	0	0	0	0
104	0	0	0	0
105	0	0	0	0
106	0	0	0	0
107	0	0	0	0
108	0	0	0	0
109	0	0	0	0
110	0	0	0	0
111	0	0	0	0
112	0	0	0	0
113	0	0	0	0
114	0	0	0	0
115	0	0	0	0
116	0	0	0	0
117	0	0	0	4
118	0	0	0	0
119	0	0	0	4
120	0	0	0	1
121	0	0	0	0
122	0	0	0	0
123	0	0	0	0
124	0	0	0	0
125	0	0	0	0
126	0	0	0	0
127	0	0	0	0
128	0	0	0	0
129	0	0	0	0
130	0	0	0	0
131	0	0	0	0
132	0	0	0	0
133	0	0	0	0
134	0	0	0	0
135	0	0	0	0
136	0	0	0	0
137	0	0	0	0
138	0	0	0	0
139	0	0	0	0
140	0	0	0	0
141	0	0	0	0
142	0	0	0	0
143	0	0	0	0
144	0	0	4	3
145	0	0	0	0
146	0	0	0	0
147	0	0	0	0
148	0	0	0	0
149	0	0	0	0
150	0	0	0	0
151	0	0	0	0
152	0	0	0	0
153	0	0	0	0
154	0	0	0	0
155	0	0	0	0
156	0	0	0	0
157	0	0	0	0
158	0	0	0	0
159	0	0	0	0
160	0	0	0	0
161	0	0	0	0
162	0	0	0	0
163	0	0	0	0
164	0	0	0	0
165	0	0	0	0
166	0	0	0	0
167	0	0	0	0
168	0	0	0	0
169	0	0	0	0
170	0	0	0	0
171	0	0	0	0
172	0	0	0	0
173	0	0	0	0
174	0	0	0	0
175	0	0	0	0
176	0	0	0	0
177	0	0	0	0
178	0	0	0	0
179	0	0	0	0
180	0	0	0	0
181	0	0	0	0
182	0	0	0	0
183	0	0	0	0
184	0	0	0	0
185	0	0	0	0
186	0	0	0	0
187	0	0	0	0
188	0	0	0	0
189	0	0	0	0
190	0	0	0	0
191	0	0	0	0
192	1	1	4	3
193	0	0	0	0
194	0	0	0	0
195	0	0	0	0
196	0	0	0	0
197	0	0	0	0
198	0	0	0	0
199	0	0	0	0
200	0	0	0	0
201	0	0	0	0
202	0	0	0	0
203	0	0	0	0
204	0	0	0	0
205	0	0	0	0
206	0	0	0	0
207	0	0	0	0
208	0	0	0	0
209	0	0	0	0
210	0	0	0	0
211	0	0	0	0
212	0	0	0	0
213	0	0	0	0
214	0	0	0	0
215	0	0	0	0
216	0	0	0	0
217	0	0	0	0
218	0	0	0	0
219	0	0	0	0
220	0	0	0	0
221	0	0	0	0
222	0	0	0	0
223	0	0	0	0
224	0	0	0	0
225	0	0	0	0
226	0	0	0	0
227	0	0	0	0
228	0	0	0	0
229	0	0	0	0
230	0	0	0	0
231	0	0	0	0
232	0	0	0	0
233	0	0	0	0
234	0	0	0	0
235	0	0	0	0
236	0	0	0	0
237	0	0	0	0
238	0	0	0	0
239	0	0	0	0
240	0	0	0	0
241	0	0	0	0
242	0	0	0	0
243	0	0	0	0
244	0	0	0	0
245	0	0	0	0
246	0	0	0	0
247	0	0	0	0
248	0	0	0	0
249	0	0	0	0
250	0	0	0	0
251	0	0	0	0
252	0	0	0	0
253	0	0	0	0
254	0	0	0	0
255	0	0	0	0
256	0	0	0	0
257	0	0	0	0
258	0	0	0	0
259	0	0	0	0
260	0	0	0	0
261	0	0	0	0
262	0	0	0	0
263	0	0	0	0
264	0	0	0	0
265	0	0	0	0
266	0	0	0	0
267	0	0	0	0
268	0	0	0	0
269	0	0	0	0
270	0	0	0	0
271	0	0	0	0
272	0	0	0	0
273	0	0	0	0
274	0	0	0	0
275	0	0	0	0
276	0	0	0	0
277	0	0	0	0
278	0	0	0	0
279	0	0	0	0
280	0	0	0	0
281	0	0	0	0
282	0	0	0	0
283	0	0	0	0
284	0	0	0	0
285	0	0	0	0
286	0	0	0	0
287	0	0	0	0
288	0	0	0	0
289	0	0	0	0
290	0	0	0	0
291	0	0	0	0
292	0	0	0	0
293	0	0	0	7
294	0	0	0	0
295	0	0	0	0
296	0	0	0	0
297	0	0	0	0
298	0	0	0	0
299	0	0	0	0
300	0	0	0	0
301	0	0	0	0
302	0	0	0	0
303	0	0	0	0
304	0	0	0	0
305	0	0	0	0
306	0	0	0	0
307	0	0	0	0
308	0	0	0	0
309	0	0	0	0
310	0	0	0	0
311	0	0	0	0
312	0	0	0	0
313	0	0	0	0
314	0	0	0	0
315	0	0	0	0
316	0	0	0	0
317	0	0	0	0
318	0	0	0	0
319	0	0	0	0
320	0	0	0	0
321	0	0	0	0
322	0	0	0	0
323	0	0	0	0
324	0	0	0	0
325	0	0	0	0
326	0	0	0	0
327	0	0	0	0
328	0	0	0	0
329	0	0	0	0
330	0	0	0	0
331	0	0	0	0
332	0	0	0	0
333	0	0	0	0
334	0	0	0	0
335	0	0	0	0
336	0	0	0	0
337	0	0	0	0
338	0	0	0	0
339	0	0	0	0
340	0	0	0	0
341	0	0	0	0
342	0	0	0	0
343	0	0	0	0
344	0	0	0	0
345	0	0	0	0
346	0	0	0	0
347	0	0	5	1
348	0	0	0	0
349	0	0	0	0
350	0	0	0	0
351	0	0	0	0
352	0	0	0	0
353	0	0	0	0
354	0	0	0	0
355	0	0	0	0
356	0	0	0	0
357	0	0	0	0
358	0	0	0	0
359	0	0	0	0
360	0	0	0	0
361	0	0	0	0
362	0	0	0	0
363	0	0	0	0
364	0	0	0	0
365	0	0	0	0
366	0	0	0	0
367	0	0	0	0
368	0	0	0	0
369	0	0	0	0
370	0	0	0	0
371	0	0	0	0
372	0	0	0	0
373	0	0	0	0
374	0	0	0	0
375	0	0	0	0
376	0	0	0	0
377	0	0	0	0
378	0	0	0	0
379	0	0	0	0
380	0	0	0	0
381	0	0	0	0
382	0	0	0	0
383	2	7	4	8
384	0	0	0	0
385	0	0	0	2
386	0	6	2	5
387	0	0	0	5
388	4	4	5	8
389	0	0	0	0
390	0	0	0	0
391	0	0	0	0
392	0	0	0	1
393	0	0	0	0
394	0	0	0	0
395	0	0	0	0
396	0	0	0	0
397	0	0	0	0
398	0	0	0	0
399	0	0	0	0
400	0	0	0	0
401	0	0	0	0
402	0	0	0	0
403	0	0	0	0
404	0	0	0	0
405	0	0	0	0
406	0	0	0	0
407	0	0	0	0
408	0	0	0	0
409	0	0	0	7
410	0	0	0	0
411	0	0	0	0
412	0	0	0	1
413	0	0	0	0
414	0	0	0	0
415	0	0	0	0
416	0	0	0	0
417	0	0	0	0
418	0	0	0	1
419	0	8	2	2
420	3	3	8	6
421	0	0	0	0
422	0	0	0	0
423	0	0	0	0
424	0	0	0	0
425	1	2	2	8
426	0	0	0	0
427	0	0	0	0
428	0	0	0	0
429	0	0	0	0
430	0	0	0	0
431	0	0	0	0
432	0	0	0	0
433	0	0	0	0
434	2	3	2	2
435	0	0	2	0
436	0	0	0	0
437	0	0	0	1
438	0	0	0	0
439	0	0	0	0
440	0	0	0	7
441	1	4	1	1
442	0	0	0	0
443	0	0	0	0
444	0	0	0	8
445	0	0	0	0
446	0	0	0	5
447	0	0	0	0
448	0	0	0	0
449	0	0	0	0
450	0	0	0	2
451	0	0	0	0
452	0	0	0	0
453	0	0	0	0
454	0	0	0	0
455	0	0	0	0
456	0	0	0	0
457	0	0	0	0
458	0	0	0	0
459	0	0	0	0
460	0	0	0	0
461	0	0	0	0
462	3	2	8	4
463	6	6	3	5
464	0	0	0	0
465	8	6	2	4
466	0	0	0	0
467	0	0	0	2
468	0	0	0	0
469	0	0	0	0
470	0	0	0	0
471	0	0	0	0
472	0	0	0	1
473	0	0	0	0
474	0	0	0	0
475	0	0	0	0
476	4	7	5	1
477	4	8	5	1
478	0	0	0	0
479	0	0	0	0
480	0	0	0	0
481	0	0	0	0
482	0	0	0	0
483	0	0	0	1
484	0	0	0	0
485	0	0	0	0
486	0	0	0	0
487	0	0	0	0
488	0	2	2	1
489	0	0	0	0
490	0	0	0	0
491	0	0	0	0
492	0	0	0	0
493	0	0	0	0
494	5	0	4	1
495	2	6	8	2
496	4	7	0	1
497	0	0	0	0
498	0	0	4	1
499	2	2	7	1
500	0	0	5	0
501	0	3	0	1
502	0	0	0	0
503	0	0	0	0
504	0	0	0	0
505	0	0	0	0
506	0	0	0	0
507	0	0	0	0
508	0	0	0	0
509	0	0	0	0
510	0	0	0	0
511	0	0	0	0
512	0	0	0	0
513	0	0	0	0
514	0	0	0	0
515	0	0	0	0
516	0	0	0	0
517	0	0	0	0
518	0	0	0	0
519	0	0	0	0
520	0	0	0	0
521	0	0	0	0
522	0	0	0	0
523	0	0	0	0
524	0	0	0	0
525	0	0	0	0
526	0	0	0	0
527	0	0	0	0
528	0	0	0	0
529	0	0	0	0
530	0	0	0	0
531	0	0	0	0
532	0	0	0	0
533	0	0	0	0
534	0	0	0	0
535	0	0	0	0
536	0	0	0	0
537	0	0	0	0
538	0	0	0	0
539	0	0	0	0
540	0	0	0	0
541	0	0	0	0
542	0	0	0	0
543	0	0	0	0
544	0	0	0	0
545	0	0	0	0
546	0	0	0	0
547	0	0	0	0
548	2	0	2	1
549	0	0	0	0
550	0	0	0	0
551	0	0	0	0
552	0	0	0	0
553	0	0	0	0
554	0	0	0	0
555	0	0	0	0
556	0	0	0	0
557	0	0	0	0
558	0	0	0	0
559	0	0	0	0
560	0	0	0	0
561	0	0	0	0
562	0	0	0	0
563	0	0	0	0
564	0	0	0	0
565	0	0	0	0
566	0	0	0	0
567	0	0	0	0
568	0	0	0	0
569	0	0	0	0
570	0	0	0	2
571	0	0	0	0
572	0	0	0	0
573	0	0	0	0
574	0	0	0	0
575	0	0	0	0
576	0	0	0	0
577	0	0	0	0
578	0	0	0	0
579	0	0	0	0
580	0	0	0	0
581	5	6	8	0
582	0	0	0	0
583	0	0	0	0
584	0	0	0	0
585	0	0	0	0
586	0	0	0	0
587	0	0	0	0
588	0	0	0	0
589	0	0	0	0
590	0	0	0	0
591	0	0	0	0
592	0	0	0	0
593	0	0	0	0
594	0	0	0	0
595	0	0	0	0
596	0	0	0	0
597	0	0	0	0
598	0	0	0	0
599	0	0	0	0
600	0	0	0	7
601	0	0	0	0
602	0	0	0	0
603	0	0	0	0
604	0	0	0	0
605	0	0	0	0
606	0	0	0	0
607	0	0	0	6
608	0	0	0	0
609	0	0	0	0
610	0	0	0	0
611	0	0	0	0
612	0	0	0	0
613	0	0	0	0
614	0	0	0	0
615	0	0	0	0
616	0	0	0	0
617	0	0	0	0
618	0	0	0	0
619	0	0	0	0
620	0	0	0	0
621	0	0	0	0
622	0	0	0	0
623	0	0	0	0
624	0	0	0	1
625	0	0	0	0
626	0	0	0	0
627	0	0	0	0
628	0	0	0	0
629	0	0	0	0
630	0	0	0	0
631	0	0	0	0
632	0	0	0	0
633	0	0	0	0
634	0	0	0	0
635	0	0	0	0
636	0	0	0	0
637	0	0	0	0
638	0	0	0	0
639	0	0	0	0
640	0	0	0	0
641	0	0	0	0
642	0	0	0	7
643	0	0	0	0
644	0	0	0	0
645	0	0	0	0
646	0	0	0	1
647	0	0	0	0
648	0	0	0	0
649	0	0	0	0
650	0	0	0	0
651	0	0	0	0
652	0	0	0	0
653	0	0	0	2
654	4	2	4	0
655	0	2	5	0
656	0	0	0	0
657	0	0	0	7
658	2	1	4	4
659	0	0	0	0
660	0	0	0	3
661	0	0	0	0
662	0	0	0	0
663	3	6	4	1
664	5	4	2	2
665	0	0	0	0
666	0	0	0	0
667	0	0	0	0
668	0	0	0	0
669	0	0	0	0
670	0	0	0	0
671	0	0	0	0
672	0	0	0	4
673	6	3	4	5
674	0	0	0	0
675	0	0	0	0
676	0	2	0	3
677	0	0	0	0
678	0	0	0	0
679	0	0	0	0
680	0	0	0	0
681	0	0	0	8
682	0	0	0	0
683	0	0	0	2
684	0	0	0	0
685	0	0	0	0
686	0	0	0	0
687	0	0	0	0
688	0	0	0	0
689	0	0	0	0
690	0	0	0	0
691	0	0	0	0
692	0	0	0	0
693	0	0	0	0
694	0	0	0	0
695	0	0	0	0
696	0	0	0	0
697	0	0	0	0
698	0	0	0	0
699	0	0	0	0
700	0	0	0	0
701	0	0	0	0
702	0	0	0	0
703	0	0	0	8
704	0	0	0	0
705	0	0	0	7
706	0	0	0	0
707	0	0	0	0
708	0	0	0	0
709	0	0	0	7
710	0	0	0	0
711	0	0	0	0
712	0	0	0	0
713	0	0	0	0
714	0	0	0	0
715	0	0	0	0
716	0	0	0	0
717	0	0	0	0
718	0	0	0	0
719	0	0	0	0
720	0	0	0	0
721	0	0	0	0
722	0	0	0	0
723	0	0	0	0
724	0	0	0	0
725	0	0	0	0
726	0	0	0	0
727	0	0	0	0
728	0	0	0	0
729	0	0	0	0
730	0	0	0	0
731	0	0	0	0
732	0	0	0	0
733	0	0	0	0
734	0	0	0	0
735	0	0	0	0
736	0	0	0	0
737	0	0	0	0
738	0	0	0	0
739	0	0	0	0
740	0	0	0	0
741	0	0	0	0
742	0	0	0	0
743	0	0	0	0
744	0	0	0	0
745	0	0	0	0
746	0	0	0	0
747	0	0	0	0
748	0	0	0	0
749	0	0	0	0
750	0	0	0	0
751	0	0	0	0
752	0	0	0	0
753	0	0	0	0
754	0	0	0	0
755	0	0	0	0
756	0	0	0	0
757	0	0	0	0
758	0	0	0	0
759	0	0	0	0
760	0	0	0	0
761	0	0	0	0
762	5	0	0	3
763	4	2	4	1
764	0	0	0	0
765	0	0	0	0
766	0	0	0	0
767	0	0	0	0
768	0	0	0	0
769	0	0	0	4
770	0	0	0	0
771	0	0	0	0
772	0	0	0	0
773	0	0	0	0
774	0	0	0	0
775	0	0	0	0
776	0	0	0	0
777	0	0	0	0
778	0	0	0	0
779	0	0	0	0
780	0	0	0	0
781	0	0	0	0
782	0	0	0	0
783	0	0	0	0
784	0	0	0	0
785	0	0	0	0
786	0	0	0	0
787	0	0	0	1
788	0	0	0	0
789	0	0	0	0
790	0	0	0	0
791	0	0	0	0
792	0	0	0	0
793	0	0	0	0
794	0	0	0	0
795	0	0	0	0
796	0	0	0	1
797	0	0	0	0
798	0	0	0	0
799	0	0	0	0
800	0	0	0	0
801	0	0	0	0
802	2	6	8	2
803	0	0	0	0
804	0	0	0	0
805	0	0	0	7
806	0	0	0	0
807	0	0	0	0
808	0	0	0	0
809	0	0	0	0
810	0	0	0	0
811	0	0	0	0
812	0	0	0	0
813	0	0	0	0
814	0	0	0	0
815	0	0	0	0
816	0	0	0	0
817	0	0	0	0
818	0	0	0	0
819	0	0	0	0
820	0	0	0	0
821	0	0	0	0
822	0	0	0	0
823	0	0	0	0
824	0	0	0	0
825	0	0	0	0
826	0	0	0	0
827	0	0	0	0
828	0	0	0	0
829	0	0	0	0
830	0	0	0	0
831	0	0	0	0
832	0	0	0	0
833	0	0	0	0
834	0	0	0	0
835	0	0	0	0
836	0	0	0	0
837	0	0	0	0
838	0	0	0	0
839	0	0	0	0
840	0	0	0	0
841	0	0	0	0
842	0	0	0	0
843	0	0	0	0
844	0	0	0	0
845	0	0	0	7
846	0	0	0	0
847	0	0	0	0
848	0	0	0	0
849	0	0	0	0
850	0	0	0	0
851	0	0	0	0
852	0	0	0	0
853	0	0	0	0
854	0	0	0	0
855	0	0	0	0
856	0	0	0	0
857	0	0	0	0
858	0	0	0	0
859	0	0	0	0
860	0	0	0	0
861	0	0	0	0
862	0	0	0	0
863	0	0	0	0
864	0	0	0	0
865	0	0	0	7
866	0	0	0	0
867	0	0	0	0
868	0	0	0	0
869	0	0	0	0
870	0	0	0	0
871	0	0	0	0
872	0	0	0	0
873	0	0	0	0
874	0	0	0	0
875	0	0	0	0
876	0	0	0	3
877	0	0	0	0
878	0	0	0	0
879	0	0	0	0
880	0	0	0	0
881	0	0	0	0
882	0	0	0	0
883	0	0	0	0
884	0	0	0	0
885	0	0	0	0
886	0	0	0	0
887	0	0	0	8
888	0	0	0	2
889	0	0	0	0
890	0	0	0	0
891	0	0	0	0
892	0	0	0	0
893	0	0	0	0
894	0	0	0	4
895	0	0	0	0
896	0	0	0	2
897	0	0	0	0
898	0	0	0	0
899	8	2	1	2
900	0	0	0	0
901	0	0	0	5
902	0	0	0	8
903	0	0	0	0
904	0	0	0	7
905	0	0	0	0
906	0	0	0	0
907	0	0	0	0
908	0	0	0	0
909	0	0	0	0
910	0	0	0	5
911	0	0	0	0
912	0	0	0	0
913	0	0	0	2
914	0	0	0	4
915	0	0	0	5
916	0	0	1	0
917	0	0	0	2
918	0	0	0	0
919	0	0	0	7
920	0	0	0	8
921	2	7	8	5
922	0	0	0	0
923	0	0	0	0
924	0	0	0	1
925	0	0	0	5
926	0	0	0	2
927	3	5	2	0
928	0	0	0	0
929	0	8	5	0
930	2	2	5	8
931	0	0	0	4
932	0	0	0	0
933	0	0	0	3
934	0	0	0	0
935	0	0	0	0
936	0	0	0	0
937	0	0	0	8
938	0	0	0	3
939	2	7	4	7
940	0	0	0	4
941	0	0	0	0
942	0	0	0	2
943	0	0	0	4
944	0	0	0	0
945	0	7	3	4
946	0	0	0	2
947	2	7	5	7
948	0	0	0	0
949	0	0	0	2
950	0	0	0	0
\.


--
-- TOC entry 5271 (class 0 OID 16665)
-- Dependencies: 231
-- Data for Name: ClassRooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ClassRooms" ("Class_ID", "Teacher_ID", "Class_Name", "Class_Section", "Class_Subject", "Join_Code", is_open, "Is_Hidden") FROM stdin;
8	5	OOP	first	OOP	ComSci	f	f
50	1	ก	ก	ก	6D3EnGFv	f	t
13	1	Test CSV	-	-	testcsv1	f	t
49	1	ก	ก	ก	Qj7x6nnv	f	t
48	1	ก	ก	ก	gNYWiF1l	f	t
47	1	ก	ก	ก	gyNfsh0A	f	t
46	1	ฟห	้่กเพ	ห	NPzyuMVG	f	t
45	1	หฟ	ฟห	ฟห	Qg5uWbct	f	t
44	1	ฟห	ฟห	ห	QwC1jqwn	f	t
10	4	65_Math_68	1	Math	codemath	f	f
7	4	LoveU	520	Eiei	ILoveYou	f	f
51	1	ก	ก	ก	cmwjHU5u	f	t
6	3	Test	1-156	Test	TestCode	f	f
53	1	เ	เ	เ	ik6Il50G	f	t
52	1	ก	ก	ก	BUXn1lQa	f	t
16	1	พเหเ	ฟดฟหด	ฟดฟหดฟด	oooooooo	f	t
4	1	test	1	math55	testcode	f	f
3	1	Biology	56-45	Bio	BioRoom	t	t
54	1	ด	ด	ด	awqVz4EV	f	t
2	1	Myclass	4/5	Bio	Secrete	f	t
56	1	ด	ด	ด	OoTBRjUt	f	f
15	1	Syu	Fhus	Ghj	GskbqGq0	f	t
55	1	ทดสอบแก้ server	ด	ด	nsakhols	t	f
21	1	หก	กห	กห	tAo6syZU	f	t
20	1	ห	กห	หก	KOMZZt39	f	t
12	1	New Class	2	-	vIS7w5NQ	f	t
11	1	Add Class	-	-	HqgHg4ua	t	t
19	1	ห	หก	หก	GgxU11X6	f	t
18	1	หเพ	หกเ	หก	CZyfJwVx	f	t
22	1	กอกป	กอก	ปอก	LJ5UhPJn	f	t
23	1	ดอ	ก	ดป	n0T32qFD	f	t
25	1	เกเป	กกปเ	ปกเ	HhRE6Dli	f	t
24	1	กเืก	ะ้ก้	กเ้ก้	5M0cwLVh	f	t
26	1	หเหกเ	กด้กด	กด	Dsbxpv0R	f	t
37	1	กห	กห	กห	ONL9HEnK	f	t
36	1	กห	กห	กห	gwZMvRVa	f	t
35	1	กห	กห	กห	IbtBWXdd	f	t
34	1	กห	กห	กห	JsNWMDUd	f	t
33	1	กหห	กห	กห	UBJRPvMF	f	t
32	1	กห	กห	กห	Bcxq5nFQ	f	t
31	1	กห	กห	กห	JJPeKgxz	f	t
30	1	หก	กห	หก	IgYOZA49	f	t
29	1	รี	า	ี้่้่หกดห	538zHA0A	f	t
28	1	าี	มีา	ามี	TkkkqWlO	f	t
27	1	ี้เ	ะ	พ	L9ujVmHx	f	t
40	1	กห	กห	กห	cuV5G2wP	f	t
39	1	กห	กห	กห	vGGxqHsH	f	t
38	1	กห	กห	กห	7PK1fDP1	f	t
1	1	Math 101	A	Mathematics	ABC123	f	t
41	1	ฟห	หฟ	ฟห	FTw3UZVm	f	t
42	1	ฟห	ฟห	หฟ	f0DH05G8	f	t
43	1	ฟห	ฟห	ฟห	0K1o8RfC	f	t
60	24	คณิตศาสตร์พื้นฐาน	2	English For Business	ZJHMBBcU	f	t
17	24	701/คณิต	1	คณิตศาสตร์	C5EpcCxQ	t	f
5	1	testnew	1	test	new	f	f
14	1	เอาไว้เทส csv	-	-	testcsv2	f	f
59	24	ComSci	110	Computer Science	zXMCuuAa	f	f
57	24	702/คณิต	702	คณิตศาสตร์	lklo3d53	f	f
58	24	Calculus	901	Calculus	TCFd99XI	f	t
\.


--
-- TOC entry 5298 (class 0 OID 17339)
-- Dependencies: 258
-- Data for Name: InteractiveBoardMessages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."InteractiveBoardMessages" ("InteractiveBoardMessage_ID", "Message", "Sent_At", "ActivityParticipant_ID", "Sender_Type", "AssignedInteractiveBoard_ID") FROM stdin;
1	lkhgifug;lj	2026-03-09 13:49:24.058417+07	\N	teacher	\N
2	ืสวืวสืวส	2026-03-09 14:22:51.254865+07	\N	teacher	\N
3	หกดเ้่าสา่้เดเ้่าสา่้เดดเ้่าสา่้เ้่า่้เอิ่าส	2026-03-09 14:22:55.98675+07	\N	teacher	\N
4	สวัสดีค่า	2026-03-09 14:56:45.374604+07	4556	student	\N
5	555555	2026-03-09 14:56:52.915342+07	4554	student	\N
6	\\shv;sh;sod	2026-03-09 14:56:54.965997+07	4554	student	\N
7	hslh;sof	2026-03-09 14:57:09.420803+07	\N	teacher	\N
8	kjlhdfs	2026-03-09 14:57:10.841901+07	\N	teacher	\N
9	Galhdgkakkdvja	2026-03-09 15:07:33.690034+07	4566	student	\N
10	ีเนรเงยรเ	2026-03-09 15:07:39.000047+07	\N	teacher	\N
11	Vjjvvj	2026-03-09 15:07:42.585353+07	4566	student	\N
12	้ร้ยน้บน้	2026-03-09 15:07:45.159289+07	\N	teacher	\N
13	เชิญๆ	2026-03-09 15:21:19.393784+07	\N	teacher	\N
14	5	2026-03-09 15:21:24.139138+07	4573	student	\N
15	G	2026-03-09 15:21:26.969491+07	4574	student	\N
16	888	2026-03-09 15:21:30.349143+07	4573	student	\N
17	าาืดไ	2026-03-09 15:21:32.261573+07	4573	student	\N
18	สท่ยำ	2026-03-09 15:21:35.138081+07	\N	teacher	\N
19	สาืวื	2026-03-09 15:21:39.754867+07	\N	teacher	\N
20	้่าสว	2026-03-09 15:22:04.251778+07	4573	student	\N
21	ร้ยน้ยน้ไเยนห้เยน้หยเ้หยน้เยหน้เยฟน้ดยน็ฆญฌน้หญเ้นหญฯ็เหฐ	2026-03-09 15:22:08.123675+07	4573	student	\N
22	หิเยหนเบหำน้เบหำน่เบน่เบฤญ๋ฌำฟนำ่เบฟยน่เฟ	2026-03-09 15:22:11.505114+07	4573	student	\N
23	ฟดฟยนด้ฟนดว๋ศฆแวห่แฟ่กอฟ	2026-03-09 15:22:13.866694+07	4573	student	\N
24	หรหฟ้เยฟหน้อวผหสอวหกอฟห	2026-03-09 15:22:15.580564+07	4573	student	\N
25	ฟหดวฟหนวอวผสอวผก	2026-03-09 15:22:17.04014+07	4573	student	\N
26	ง่งย่ง	2026-03-09 15:27:16.083149+07	4582	student	\N
27	บน่บนบ	2026-03-09 15:27:17.145572+07	4582	student	\N
28	นน่นบ	2026-03-09 15:27:18.019034+07	4582	student	\N
29	น่	2026-03-09 15:27:21.082807+07	\N	teacher	\N
30	่บน	2026-03-09 15:27:22.024577+07	\N	teacher	\N
31	นบ่บ่บน	2026-03-09 15:27:23.519001+07	\N	teacher	\N
32	นบ่บ	2026-03-09 15:27:24.552912+07	\N	teacher	\N
33	O FCC kyckfxi	2026-03-09 15:27:27.778179+07	4581	student	\N
34	Kfjdiffk	2026-03-09 15:27:29.974915+07	4581	student	\N
35	Jkajshd	2026-03-09 15:37:39.359366+07	4586	student	\N
36	Hdshs	2026-03-09 15:37:40.798582+07	4586	student	\N
37	Hdjsjdh	2026-03-09 15:37:42.048679+07	4586	student	\N
38	ดีจ้า	2026-03-09 17:07:42.342887+07	4678	student	\N
39	ดีคับๆ	2026-03-09 17:07:48.464411+07	4677	student	\N
40	สวัสดี	2026-03-09 17:07:55.664501+07	\N	teacher	\N
41	เปิดเทอม	2026-03-09 17:36:36.652334+07	4690	student	\N
42	กินอะไรดีคะ	2026-03-09 17:38:26.915681+07	4693	student	\N
43	ไม่รู้สิ	2026-03-09 17:38:37.753184+07	\N	teacher	\N
44	ดีค้าบบบ	2026-03-12 12:14:45.6435+07	7426	student	\N
45	edaw	2026-03-12 15:17:24.075887+07	7554	student	\N
46	wddw	2026-03-12 15:17:25.858182+07	\N	teacher	\N
47	wdefdw	2026-03-12 15:17:28.576212+07	7554	student	\N
48	ีรเะาีักสรีั	2026-03-16 17:19:54.399928+07	\N	teacher	30
49	Shdndnnfy	2026-03-16 17:19:55.788475+07	8068	student	30
50	า้าอ	2026-03-16 17:33:59.65056+07	\N	teacher	31
51	Yfcugc	2026-03-16 17:34:02.335839+07	8073	student	31
52	ส่้าาดสดสรเ	2026-03-16 17:34:07.853365+07	\N	teacher	31
53	Ihbihbho	2026-03-16 17:34:10.465703+07	8073	student	31
54	Khbojboj	2026-03-16 17:34:12.563617+07	8073	student	31
55	Ljno)nip	2026-03-16 17:34:14.586971+07	8073	student	31
56	kvoi	2026-03-16 19:52:22.375125+07	\N	teacher	32
57	Xttxyc	2026-03-16 19:52:24.83344+07	8175	student	32
58	Hijh	2026-03-16 19:52:31.053388+07	8173	student	32
59	อาจารย์จะให้ส่งงานวันที่เท่าไหร่คะ	2026-03-16 20:28:10.049359+07	8199	student	33
60	แล้วต้องส่งทุกคนในกลุ่มมั้ยคะ หรือว่าส่งแค่ตัวแทนกลุ่ม	2026-03-16 20:28:47.864908+07	8199	student	33
61	งานวันนี้ขอส่งภายในเที่ยงคืนได้ไหมคะ	2026-03-18 13:56:34.899375+07	8298	student	34
62	อาจารย์ช่วยอธิบายโปรเจกต์ให้หนูหน่อยได้ไหมคะ	2026-03-18 13:56:59.959892+07	8298	student	34
63	งานที่อาจารย์สั่งสามารถส่งได้ถึงวันไหนคะ	2026-03-18 19:29:02.256077+07	8483	student	35
64	กลุ่มละ 4 คนได้มั้ยคะ	2026-03-18 19:29:20.375428+07	8482	student	35
65	ได้ถึงวันที่ 30 มีนาคม 2569 ค่ะ	2026-03-18 19:29:51.607084+07	\N	teacher	35
66	วันนี้เลิกกี่โมงคะอาจารย์	2026-03-19 14:27:46.325274+07	8683	student	36
67	เที่ยงครับ	2026-03-19 14:28:00.2643+07	\N	teacher	36
68	srdtyguil;'	2026-03-20 10:59:28.511142+07	8753	student	37
69	So gghjko	2026-03-20 10:59:32.161844+07	8755	student	37
70	เย้	2026-03-20 10:59:32.836604+07	8756	student	37
71	gpppppppppppppppppph	2026-03-20 10:59:38.508103+07	\N	teacher	37
72	Fshsuiwiwiwjejjejejeiieoe	2026-03-20 10:59:40.897697+07	8755	student	37
73	sdfgygvugkbl	2026-03-20 10:59:41.90673+07	\N	teacher	37
74	jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj	2026-03-20 10:59:45.691845+07	\N	teacher	37
75	544754545	2026-03-20 10:59:48.859522+07	\N	teacher	37
76	Udhej	2026-03-20 10:59:54.11075+07	8755	student	37
77	g8ug8g8ihi	2026-03-20 11:00:04.071249+07	\N	teacher	37
78	lplopkiu	2026-03-20 11:00:07.507324+07	\N	teacher	37
79	9j9999999999999999999999999999	2026-03-20 11:00:11.300893+07	\N	teacher	37
80	yyyyyyyyyynuuuo	2026-03-20 11:00:23.850991+07	\N	teacher	37
\.


--
-- TOC entry 5294 (class 0 OID 17217)
-- Dependencies: 254
-- Data for Name: PollAnswers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PollAnswers" ("PollAnswer_ID", "PollOption_ID", "Answered_At", "ActivityParticipant_ID") FROM stdin;
2	74	2026-03-08 17:16:41.247449+07	\N
3	76	2026-03-08 17:17:10.224061+07	\N
4	80	2026-03-08 17:31:49.880474+07	\N
5	81	2026-03-08 18:10:51.416279+07	\N
6	84	2026-03-08 18:12:09.002647+07	\N
7	86	2026-03-08 18:14:03.512082+07	\N
8	87	2026-03-08 18:14:59.922214+07	\N
9	92	2026-03-08 18:25:21.96684+07	\N
10	94	2026-03-08 18:26:32.076659+07	\N
11	95	2026-03-08 18:27:32.167885+07	\N
12	98	2026-03-08 18:33:07.428168+07	\N
13	102	2026-03-08 18:39:47.339563+07	\N
14	101	2026-03-08 18:39:49.37676+07	\N
15	106	2026-03-08 18:40:46.810729+07	\N
16	104	2026-03-08 18:40:51.816634+07	\N
17	107	2026-03-08 18:41:12.321993+07	\N
18	110	2026-03-08 18:42:49.224243+07	\N
19	109	2026-03-08 18:42:52.609918+07	\N
20	111	2026-03-08 18:43:38.125418+07	\N
21	111	2026-03-08 18:43:43.727542+07	\N
22	113	2026-03-08 18:45:17.973551+07	\N
23	114	2026-03-08 18:45:20.014953+07	\N
24	114	2026-03-08 18:45:23.847266+07	\N
25	115	2026-03-08 18:45:42.634065+07	\N
26	116	2026-03-08 18:45:43.595421+07	\N
27	117	2026-03-08 19:02:09.281081+07	\N
28	118	2026-03-08 19:02:10.880988+07	\N
29	127	2026-03-09 14:43:19.891395+07	\N
30	128	2026-03-09 14:43:21.463539+07	\N
31	129	2026-03-09 14:43:40.809836+07	\N
32	132	2026-03-09 14:56:26.968529+07	\N
33	133	2026-03-09 14:56:28.083739+07	\N
34	135	2026-03-09 17:35:52.483516+07	\N
35	138	2026-03-12 12:13:43.417233+07	\N
36	140	2026-03-12 15:17:07.323524+07	\N
37	144	2026-03-15 13:01:40.244471+07	\N
38	146	2026-03-15 13:04:06.656084+07	\N
39	148	2026-03-15 13:14:04.582074+07	\N
40	149	2026-03-15 13:16:55.638254+07	\N
41	151	2026-03-15 13:18:10.691819+07	\N
42	151	2026-03-15 13:19:32.475444+07	\N
43	154	2026-03-15 13:19:49.838111+07	\N
44	156	2026-03-15 13:29:37.027113+07	\N
45	158	2026-03-15 13:31:50.971517+07	\N
46	160	2026-03-15 13:34:52.946325+07	\N
47	162	2026-03-15 13:35:33.635562+07	\N
48	163	2026-03-15 13:35:36.482004+07	\N
49	164	2026-03-15 13:35:53.230109+07	\N
50	165	2026-03-15 13:35:54.89165+07	\N
51	166	2026-03-15 13:36:19.725786+07	\N
52	166	2026-03-15 13:36:24.267752+07	\N
53	170	2026-03-15 13:40:50.610309+07	\N
54	172	2026-03-15 13:43:11.10791+07	\N
55	172	2026-03-15 13:43:12.659026+07	\N
56	177	2026-03-15 13:45:30.478187+07	\N
57	176	2026-03-15 13:45:32.338163+07	\N
58	178	2026-03-15 13:45:42.071995+07	\N
59	179	2026-03-15 13:45:43.292668+07	\N
60	183	2026-03-15 14:05:22.539555+07	\N
61	184	2026-03-15 14:05:37.207786+07	\N
62	187	2026-03-15 14:05:50.900381+07	\N
63	189	2026-03-15 14:06:16.744852+07	\N
64	190	2026-03-15 14:07:00.258993+07	\N
65	192	2026-03-15 14:10:55.108339+07	\N
66	194	2026-03-15 14:18:48.96397+07	\N
67	196	2026-03-15 14:21:56.387191+07	\N
68	198	2026-03-15 14:22:21.127965+07	\N
69	200	2026-03-15 14:23:40.843713+07	\N
70	202	2026-03-15 14:24:07.759269+07	\N
71	203	2026-03-15 14:24:09.048471+07	\N
72	204	2026-03-15 14:27:52.702204+07	\N
73	205	2026-03-15 14:27:54.364073+07	\N
74	206	2026-03-15 14:31:44.767851+07	\N
75	208	2026-03-15 14:31:58.43483+07	\N
76	209	2026-03-15 14:31:59.229171+07	\N
77	210	2026-03-15 14:34:53.000018+07	\N
78	212	2026-03-15 14:35:14.109617+07	\N
79	213	2026-03-15 14:35:14.691803+07	\N
80	214	2026-03-15 14:38:32.562717+07	\N
81	214	2026-03-15 14:38:33.315993+07	\N
82	216	2026-03-15 14:49:11.722336+07	\N
83	218	2026-03-15 14:49:26.375001+07	\N
84	219	2026-03-15 14:49:28.101187+07	\N
85	220	2026-03-15 14:50:46.681886+07	\N
86	228	2026-03-15 14:52:14.013538+07	\N
87	230	2026-03-15 14:52:40.660474+07	\N
88	231	2026-03-15 14:52:42.948838+07	\N
89	232	2026-03-15 14:52:58.790573+07	\N
90	233	2026-03-15 14:53:00.717345+07	\N
91	235	2026-03-15 14:53:10.831794+07	\N
92	235	2026-03-15 14:53:11.80085+07	\N
93	253	2026-03-16 17:59:17.927746+07	8117
94	252	2026-03-16 17:59:19.595473+07	8116
95	255	2026-03-16 17:59:40.127357+07	8121
96	255	2026-03-16 17:59:41.140976+07	8120
97	257	2026-03-16 17:59:58.215122+07	8126
98	259	2026-03-16 19:52:10.42283+07	8169
99	261	2026-03-16 20:19:05.802586+07	8190
100	264	2026-03-16 20:27:02.823082+07	8196
101	265	2026-03-18 13:55:11.628644+07	8291
102	267	2026-03-18 13:56:03.637355+07	8295
103	269	2026-03-18 19:27:32.47426+07	8477
104	269	2026-03-18 19:27:41.255209+07	8476
105	271	2026-03-19 13:54:58.494855+07	8661
106	271	2026-03-19 13:55:08.887013+07	8662
107	273	2026-03-19 14:12:47.625833+07	8678
108	274	2026-03-19 14:12:54.027903+07	8679
109	276	2026-03-20 10:58:46.16652+07	8730
110	277	2026-03-20 10:58:47.150347+07	8729
111	278	2026-03-20 10:58:49.002202+07	8728
112	280	2026-03-20 10:59:11.295116+07	8744
113	280	2026-03-20 10:59:11.501936+07	8746
\.


--
-- TOC entry 5292 (class 0 OID 17207)
-- Dependencies: 252
-- Data for Name: PollOptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PollOptions" ("PollOption_ID", "AssignedPoll_ID", "Option_Text") FROM stdin;
1	2	1
2	2	2
3	3	1
4	3	2
5	3	3
6	3	4
7	4	1
8	4	2
9	4	3
10	4	4
11	5	1
12	5	2
13	5	3
14	5	4
15	6	1
16	6	2
17	6	3
18	6	4
19	7	1
20	7	2
21	7	3
22	7	4
23	8	1
24	8	2
25	8	3
26	9	u
27	9	l
28	9	h
29	10	u
30	10	me
31	11	5
32	11	5
33	12	4
34	12	5
35	13	5
36	13	5
37	14	4
38	14	54
39	15	5
40	15	5
41	16	,b
42	16	lj
43	17	f
44	17	f
45	18	l
46	18	l
47	19	สาทืิอ
48	19	วสา่้ิอ
49	20	sdfg
50	20	sdfg
51	21	xcvbnm,
52	21	xcvbnm,
53	22	xcvghjk
54	22	xcvbnm
55	23	asdfg
56	23	asdfg
57	24	เะดพกำ
58	24	้เดก
59	25	ertyuilkjhbv
60	25	dfghjklkjnhbv
61	26	fghjk
62	26	dfghj
63	27	กดเ้่
64	27	หกดเ้่
65	28	jgclj
66	28	jgvcljv
67	29	dfghjk
68	29	dfghjk
69	30	้ะห
70	30	หะ้
71	31	rjyjedx
72	31	dtjjjjjjjjjjyj
73	32	asdfgh
74	32	sdfrtgyhj
75	33	ื้มเดทเกม
76	33	้กเหด
77	34	aswedrftgh
78	34	asedrty
79	35	sogjrs;djgsprg
80	35	kdgndr;gndr;o
81	36	hfdgsf
82	36	hfgd
83	37	1
84	37	2
85	38	3333
86	38	5555
87	39	ตอนนี้
88	39	เที่ยง
89	40	่าเด้เ
90	40	าเ่ด้ก
91	41	1
92	41	2
93	42	dgr
94	42	her
95	43	kjnpn
96	43	kopjk
97	44	89645
98	44	98458
99	45	852
100	45	7854
101	46	ๆไำพะัีรนย
102	46	ๆไำพะัีรนย
103	47	เทส
104	47	โหล
105	47	ว้าว
106	47	กรี๊ด
107	48	ดเ้่
108	48	ดเ้่
109	49	jhfuyf
110	49	jhvfifiu
111	50	mhcug
112	50	mhvkh 
113	51	ckbvb
114	51	fgghjkm
115	52	kjblk
116	52	lknkln
117	53	หกดเ้่าใ
118	53	หกดเ้่า
119	54	้ทงวด้ทกด้
120	54	สกวท้กพวสท้
121	55	lihpho
122	55	oihpoh
123	56	lm
124	56	lm
125	57	lih;o
126	57	lkn;j;
127	58	lkn;lm'k
128	58	lm';lmk
129	59	;lm'm'm
130	59	;lmlm;lm
131	60	1
132	60	2
133	60	3
134	60	4
135	61	แล้ว
136	61	ยัง
137	62	แล้ว
138	62	ยัง
139	63	2
140	63	2
141	64	1
142	64	2
143	65	1
144	65	0
145	66	1
146	66	2
147	67	gbfvdc
148	67	fvdcz
149	68	นรสีา
150	68	รา
151	69	ujyht
152	69	yuthyh
153	69	tgrhtgr
154	70	tgr
155	70	trge
156	71	df
157	71	df
158	72	ds
159	72	sd
160	73	ref
161	73	rfe
162	74	\\]
163	74	\\]
164	75	fd
165	75	fdgr
166	76	tg
167	76	tgr
168	77	พำะ
169	77	พะ้ั
170	78	;po
171	78	iju
172	79	yht
173	79	yhtgr
174	80	dse
175	80	desw
176	81	y6t
177	81	y6t
178	82	fsew
179	82	ewd
180	83	fred
181	83	fredws
182	84	dew
183	84	edws
184	85	'[;0p-9o
185	85	[;0p90
186	86	'/;o
187	86	';pol
188	87	o09i
189	87	pl9oki9
190	88	]'[p
191	88	['];p
192	89	[;po
193	89	[p;o
194	90	นสรา
195	90	ราี่
196	91	หก
197	91	หก
198	92	เ้ั
199	92	้ัเเะ
200	93	ดกอ
201	93	ดอก
202	95	่้ีเัะ
203	95	าี่ั้ะ
204	96	ีั้
205	96	ีั้ะะ
206	97	[-0p
207	97	[p;
208	98	['p;o'p;o
209	98	[;0p9o
210	99	loki
211	99	loikuj
212	100	ref
213	100	ferdw
214	101	fed
215	101	frewd
216	102	กไห
217	102	กำไ
218	103	ัะ้พเถ
219	103	ะัุ้ถ
220	104	ำกไ
221	104	ำกไ
222	105	ำพภไ-
223	105	ำไ-ๆ/
224	106	ำพภไ-
225	107	ำพภไ-
226	107	ำไ-ๆ/
227	106	ำไ-ๆ/
228	108	y6t5
229	108	gtrf
230	109	fredw
231	109	efrdw
232	110	dsa
233	110	dsaw
234	111	ikujyjuy
235	111	htgr
236	113	dcs
237	113	dcsv
238	114	sfrd
239	114	rsf
240	115	ดำไ
241	115	ำได
242	116	แอิืท
243	116	แอิืทม
244	117	ดเ้่
245	117	กดเ้่
246	118	กดเ้่า
247	118	หกดเ้่
248	119	กดเ้่
249	119	หกดเ้่
250	120	่้อดา้ทิ
251	120	อ่ทา
252	121	้่แก
253	121	่าแ่
254	122	า
255	122	ส
256	123	5
257	123	5
258	123	5
259	124	1
260	124	2
261	125	ไม่
262	125	ใช่
263	126	นักศึกษา
264	126	ไปรเวท
265	127	ออนไลน์คือที่
266	127	ไม่ ออนไซต์ดีกว่า
267	128	ด
268	128	ก
269	129	ภายในคาบ
270	129	ภายในเที่ยงคืน
271	130	ออนไลน์คือที่
272	130	ไม่ ออนไซต์ดีกว่า
273	131	ออนไลน์คือที่
274	131	ไม่ ออนไซต์ดีกว่า
275	132	2
276	132	1
277	132	4
278	132	5
279	132	8
280	133	4
281	133	5
\.


--
-- TOC entry 5262 (class 0 OID 16443)
-- Dependencies: 222
-- Data for Name: QuestionOptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuestionOptions" ("Option_ID", "Question_ID", "Option_Text") FROM stdin;
113	47	2316547
114	47	5168764
115	47	1546576
116	48	55
117	48	22
118	49	kn;l
119	49	k;l
120	49	kn'
121	49	;o;
122	50	fcycgvbn;'l
123	50	khv;
124	50	fhcgvjhbkjnkm
125	50	ifoudly
470	153	1
471	153	2
472	153	3
473	153	4
474	154	ๆไำพะัีรนย
475	154	ฟหกดเ้่าส
476	155	1
477	155	4
134	53	่แดวรี
135	53	่สแสีะเส
136	53	786
137	53	56566
478	155	22
479	155	9
480	156	27
481	156	93
142	55	มันเหมือนเสียงคนร้องไห้
143	55	ไม่รู้ จุ๊บ ๆ
144	56	เข้าว่ารักจริง ๆ
145	56	โอ้เมื่อนกเข้าจูกรู๊ก
146	56	แหะ ๆ ๆ ๆ
482	156	12
483	156	21
484	157	2
485	157	1
486	157	0
487	157	3
488	158	1
489	158	4
490	158	22
491	158	9
492	159	27
493	159	93
494	159	12
495	159	21
496	160	2
497	160	1
498	160	0
499	160	3
500	161	2
501	161	1
502	161	3
503	161	4
57	24	ดเ้่าส
58	24	ดเ้่าส
59	25	ำพะ่าสว
60	25	แอิืทม
61	26	กาดสืเืกวสเ
62	26	กสาดืเกวาเื
63	26	กวดวเาืกวเส
504	162	2
505	162	1
506	162	5
507	162	4
508	163	1
509	163	2
70	30	มันเหมือนเสียงคนร้องไห้
71	30	ไม่รู้ จุ๊บ ๆ
72	31	เข้าว่ารักจริง ๆ
73	31	โอ้เมื่อนกเข้าจูกรู๊ก
74	31	แหะ ๆ ๆ ๆ
510	164	4
511	164	3
512	165	1
513	165	2
514	166	4
84	35	5765324
85	35	6875343
86	35	2434737
87	36	5741654
88	36	7676
89	37	5741654
90	37	7676
91	38	dogkd
92	38	d;mgd
515	166	3
516	167	True
408	130	เปดม้
409	130	่้ดส่้แอใ
410	130	ปแอิืทมใ
411	131	หสา้เวนฟร้เบฟ้าเ2
412	131	ฟำเ่ิฟนร้ำเงฟ้เ4
413	131	หพเ้ร่ฟหย่เลยหเ1
414	132	643535
415	132	213535
416	133	1
417	133	4
418	133	22
419	133	9
420	134	27
108	45	มันเหมือนเสียงคนร้องไห้
109	45	ไม่รู้ จุ๊บ ๆ
110	46	เข้าว่ารักจริง ๆ
111	46	โอ้เมื่อนกเข้าจูกรู๊ก
112	46	แหะ ๆ ๆ ๆ
421	134	93
422	134	12
423	134	21
424	135	2
425	135	1
517	167	False
518	168	จันทร์
519	168	อังคาร
426	135	0
427	135	3
428	136	649865
360	115	fcycgvbn;'l
361	115	khv;
362	115	fhcgvjhbkjnkm
363	115	ifoudly
364	116	574254
365	116	42247537
366	117	fcycgvbn;'l
367	117	khv;
429	136	689865465
434	139	af
435	139	f
436	140	5
437	140	4
438	140	3
368	117	fhcgvjhbkjnkm
369	117	ifoudly
370	118	57574
371	118	547276
439	141	s;lbn'sadlbn
440	141	sl;nmga'dl
441	142	d/lnf/l
442	142	/blzdxb
456	148	2
457	148	1
458	148	2
459	148	2
460	149	่ิส่ิ
461	149	า่ิส่ิ
462	149	า่ิส
463	150	1
464	150	2
465	150	3
466	151	1
467	151	2
468	152	4
469	152	3
520	168	พุธ
521	168	พฤหัส
522	168	ศุกร์
523	169	5
524	169	10
525	170	bhb
526	170	acd
527	171	ร
528	171	ร
529	172	ร
530	172	ร
531	173	บล
532	173	บล
533	174	ฃ
534	174	ฃ
535	175	17
536	175	ฃ1
537	176	1ฃ
538	176	ฃ1
539	177	ฃ
540	177	ฃ
541	178	ฃล
542	178	ฃ
543	179	ฃล
544	179	ฃฃ
545	179	ลฃ
546	180	ฃล
547	180	ฃล
548	181	ยงบ
549	181	รีั้ะเำพด
550	182	ัพะเ
551	182	ดำฟกไ
552	183	ยจรนต
553	183	นคร
554	184	นตีค
555	184	นตคร
556	185	ชนบ
557	185	บ
558	186	งยวาน
559	186	วนสร่
560	187	ขชจ
561	187	จบต
562	188	จ่บจ
563	188	ตจย
564	189	ลชบขน
565	189	บขยจ
566	190	บจร
567	190	บขจร
568	191	ขชล
569	191	ลชจ
570	192	บขจย
571	192	ชจบขน
572	193	ลช
573	193	ชจล
574	194	ขบจย
575	194	บขจย
576	195	ชจบขช
577	195	ลจบข
578	196	ชลจข
579	196	ขตบ
580	197	ยนน
581	197	ชงขน
582	197	ชขข
583	198	บนย
584	198	บยนงย
585	199	ขลช
586	199	ขชลจ
587	200	ข
588	200	ขร
589	201	ไกๆ
590	201	กไำๆ
591	202	ๆ/
592	202	ำกไ
593	203	ำก
594	203	ำด
595	204	ๆไก
596	204	ไๆก
597	205	ไๆก
598	205	ไกๆ
599	206	dfs
600	206	df
601	207	14
602	207	41
603	208	71
604	208	-
605	209	\\\\\\\\\\7\\
606	209	17\\
607	209	\\p\\
608	210	-;
609	210	'-[
610	211	0'
611	211	0;'
612	212	[ypo;
613	212	'i[
614	212	oi[';
615	213	'p[
616	213	['
617	214	[p
618	214	'pi'
619	215	4\\4
620	215	\\4\\
621	216	p9oi8
622	216	refw
623	217	efw
624	217	ewf
625	218	ewf
626	218	efw
627	219	ewf
628	219	efswa
629	220	few
630	220	efw
631	221	efw
632	221	fe
633	222	dfew
634	222	fdew
635	222	fcs
636	223	sefd
637	223	sfed
638	224	sfe
639	224	dvs
640	225	sedf
641	225	sef
642	226	efs
643	226	efs
644	227	sed
645	227	fes
646	228	sedf
647	228	efs
648	229	sfd
649	229	feds
650	230	esaf
651	230	efsaw
652	231	asef
653	231	aefs
654	232	asef
655	232	fe
656	233	aef
657	233	aef
658	234	af
659	234	wsfa
660	235	afe
661	235	af
662	236	aedf
663	236	asf
664	237	afe
665	237	wfas
666	238	aefcs
667	238	efacs
668	239	aesf
669	239	asde
670	240	afec
671	240	eafc
672	241	aef
673	241	efa
674	242	sfa
675	242	fas
676	243	edf
677	243	afe
678	244	aws
679	244	fae
680	245	fea
681	245	eaf
682	246	we
683	246	weq
684	247	14
685	247	41
686	248	71
687	248	-
688	249	\\\\\\\\\\7\\
689	249	17\\
690	249	\\p\\
691	250	-;
692	250	'-[
693	251	0'
694	251	0;'
695	252	[ypo;
696	252	'i[
697	252	oi[';
698	253	'p[
699	253	['
700	254	[p
701	254	'pi'
702	255	4\\4
703	255	\\4\\
704	256	p9oi8
705	256	refw
706	257	efw
707	257	ewf
708	258	ewf
709	258	efw
710	259	ewf
711	259	efswa
712	260	few
713	260	efw
714	261	efw
715	261	fe
716	262	dfew
717	262	fdew
718	262	fcs
719	263	sefd
720	263	sfed
721	264	sfe
722	264	dvs
723	265	sedf
724	265	sef
725	266	efs
726	266	efs
727	267	sed
728	267	fes
729	268	sedf
730	268	efs
731	269	sfd
732	269	feds
733	270	esaf
734	270	efsaw
735	271	asef
736	271	aefs
737	272	asef
738	272	fe
739	273	aef
740	273	aef
741	274	af
742	274	wsfa
743	275	afe
744	275	af
745	276	aedf
746	276	asf
747	277	afe
748	277	wfas
749	278	aefcs
750	278	efacs
751	279	aesf
752	279	asde
753	280	afec
754	280	eafc
755	281	aef
756	281	efa
757	282	sfa
758	282	fas
759	283	edf
760	283	afe
761	284	aws
762	284	fae
763	285	fea
764	285	eaf
765	286	we
766	286	weq
767	287	14
768	287	41
769	288	71
770	288	-
771	289	\\\\\\\\\\7\\
772	289	17\\
773	289	\\p\\
774	290	-;
775	290	'-[
776	291	0'
777	291	0;'
778	292	[ypo;
779	292	'i[
780	292	oi[';
781	293	'p[
782	293	['
783	294	[p
784	294	'pi'
785	295	4\\4
786	295	\\4\\
787	296	p9oi8
788	296	refw
789	297	efw
790	297	ewf
791	298	ewf
792	298	efw
793	299	ewf
794	299	efswa
795	300	few
796	300	efw
797	301	efw
798	301	fe
799	302	dfew
800	302	fdew
801	302	fcs
802	303	sefd
803	303	sfed
804	304	sfe
805	304	dvs
806	305	sedf
807	305	sef
808	306	efs
809	306	efs
810	307	sed
811	307	fes
812	308	sedf
813	308	efs
814	309	sfd
815	309	feds
816	310	esaf
817	310	efsaw
818	311	asef
819	311	aefs
820	312	asef
821	312	fe
822	313	aef
823	313	aef
824	314	af
825	314	wsfa
826	315	afe
827	315	af
828	316	aedf
829	316	asf
830	317	afe
831	317	wfas
832	318	aefcs
833	318	efacs
834	319	aesf
835	319	asde
836	320	afec
837	320	eafc
838	321	aef
839	321	efa
840	322	sfa
841	322	fas
842	323	edf
843	323	afe
844	324	aws
845	324	fae
846	325	fea
847	325	eaf
848	326	we
849	326	weq
850	327	71
851	327	-
852	328	\\\\\\\\\\7\\
853	328	17\\
854	328	\\p\\
855	329	-;
856	329	'-[
857	330	0'
858	330	0;'
859	331	[ypo;
860	331	'i[
861	331	oi[';
862	332	'p[
863	332	['
864	333	[p
865	333	'pi'
866	334	4\\4
867	334	\\4\\
868	335	p9oi8
869	335	refw
870	336	efw
871	336	ewf
872	337	ewf
873	337	efw
874	338	ewf
875	338	efswa
876	339	few
877	339	efw
878	340	efw
879	340	fe
880	341	dfew
881	341	fdew
882	341	fcs
883	342	sefd
884	342	sfed
885	343	sfe
886	343	dvs
887	344	sedf
888	344	sef
889	345	efs
890	345	efs
891	346	sed
892	346	fes
893	347	sedf
894	347	efs
895	348	sfd
896	348	feds
897	349	esaf
898	349	efsaw
899	350	asef
900	350	aefs
901	351	asef
902	351	fe
903	352	aef
904	352	aef
905	353	af
906	353	wsfa
907	354	afe
908	354	af
909	355	aedf
910	355	asf
911	356	afe
912	356	wfas
913	357	aefcs
914	357	efacs
915	358	aesf
916	358	asde
917	359	afec
918	359	eafc
919	360	aef
920	360	efa
921	361	sfa
922	361	fas
923	362	edf
924	362	afe
925	363	aws
926	363	fae
927	364	fea
928	364	eaf
929	365	we
930	365	weq
931	366	ๆเำพดำพ
932	366	ำดดำ
933	367	71
934	367	-
935	368	\\\\\\\\\\7\\
936	368	17\\
937	368	\\p\\
938	369	-;
939	369	'-[
940	370	0'
941	370	0;'
942	371	[ypo;
943	371	'i[
944	371	oi[';
945	372	'p[
946	372	['
947	373	[p
948	373	'pi'
949	374	4\\4
950	374	\\4\\
951	375	p9oi8
952	375	refw
953	376	efw
954	376	ewf
955	377	ewf
956	377	efw
957	378	ewf
958	378	efswa
959	379	few
960	379	efw
961	380	efw
962	380	fe
963	381	dfew
964	381	fdew
965	381	fcs
966	382	sefd
967	382	sfed
968	383	sfe
969	383	dvs
970	384	sedf
971	384	sef
972	385	efs
973	385	efs
974	386	sed
975	386	fes
976	387	sedf
977	387	efs
978	388	sfd
979	388	feds
980	389	esaf
981	389	efsaw
982	390	asef
983	390	aefs
984	391	asef
985	391	fe
986	392	aef
987	392	aef
988	393	af
989	393	wsfa
990	394	afe
991	394	af
992	395	aedf
993	395	asf
994	396	afe
995	396	wfas
996	397	aefcs
997	397	efacs
998	398	aesf
999	398	asde
1000	399	afec
1001	399	eafc
1002	400	aef
1003	400	efa
1004	401	sfa
1005	401	fas
1006	402	edf
1007	402	afe
1008	403	aws
1009	403	fae
1010	404	fea
1011	404	eaf
1012	405	we
1013	405	weq
1014	406	ๆเำพดำพ
1015	406	ำดดำ
1016	407	gr
1017	407	grf
1018	408	gre
1019	408	grfe
1020	408	gr
1021	408	grgb
1022	408	rrg
1023	409	grfewr
1024	409	rgfe
1025	410	gr
1026	410	grf
1027	411	gre
1028	411	grfe
1029	411	gr
1030	411	grgb
1031	411	rrg
1032	412	grfewr
1033	412	rgfe
1034	413	]'
1035	413	'[
1036	414	gr
1037	414	grf
1038	415	gre
1039	415	grfe
1040	415	gr
1041	415	grgb
1042	415	rrg
1043	416	grfewr
1044	416	rgfe
1045	417	]'
1046	417	'[
1047	418	nhgbf
1048	418	bgfvd
1049	419	กั้กพั
1050	419	กพ้ักพั
1051	420	กั้กพั
1052	420	กพ้ักพั
1053	421	กั้กพั
1054	421	กพ้ักพั
1055	422	กั้กพั
1056	422	กพ้ักพั
1057	423	df
1058	423	df
1059	424	df
1060	424	df
1061	425	กั้กพั
1062	425	กพ้ักพั
1063	426	am
1064	426	are
1065	426	is
1066	427	am
1067	427	are
1068	427	is
1069	428	2
1070	428	4
1071	428	6
1072	428	8
1073	429	10
1074	429	8
1075	430	10
1076	430	8
1077	431	-1
1078	431	-2
1079	432	fe
1080	432	gr
1081	433	vybu
1082	433	ftyghu
1083	434	fe
1084	434	gr
1085	435	vybu
1086	435	ftyghu
1087	436	fe
1088	436	gr
1089	437	vybu
1090	437	ftyghu
1091	438	fe
1092	438	gr
1093	439	vybu
1094	439	ftyghu
1095	440	fe
1096	440	gr
1097	441	vybu
1098	441	ftyghu
1099	442	wefefwf
1100	442	wefewffe
1101	443	10
1102	443	8
1103	444	5
1104	444	6
1105	444	7
1106	445	5
1107	445	6
1108	445	7
1109	446	efs
1110	446	esf
1111	447	1
1112	447	2
1113	447	3
1114	447	4
1115	448	10
1116	448	12
1117	448	27
1118	448	28
1119	449	2
1120	449	1
1121	449	-1
1122	449	-2
1123	450	2
1124	450	1
1125	450	-1
1126	450	-2
1127	451	1/2
1128	451	2
1129	452	1
1130	452	2
1131	453	16
1132	453	18
1133	453	20
1134	454	1
1135	454	2
1136	454	3
1137	454	4
1138	455	10
1139	455	12
1140	455	27
1141	455	28
1142	456	2
1143	456	1
1144	456	-1
1145	456	-2
1146	457	2
1147	457	1
1148	457	-1
1149	457	-2
1150	458	1/2
1151	458	2
1152	459	1
1153	459	2
1154	460	16
1155	460	18
1156	460	20
1157	461	11
1158	461	12
1159	461	13
1160	461	14
1161	462	5
1162	462	9
1163	462	7
1164	462	10
1165	462	13
1166	463	2
1167	463	5
1168	463	8
1169	463	9
1170	464	11
1171	464	12
1172	464	13
1173	464	14
1174	465	5
1175	465	9
1176	465	7
1177	465	10
1178	465	13
1179	466	2
1180	466	5
1181	466	8
1182	466	9
1183	467	(2,8)
1184	467	(3,12)
1185	467	(1,4)
1186	468	ฐงฝบง
1187	468	ฝย
1188	469	กหอ
1189	469	กอห
1190	470	3
1191	470	2
1192	470	1
1193	471	gcf
1194	471	gfc
1195	471	fcd
1196	471	fcdx
1197	471	;plok
1198	472	1
1199	472	2
1200	472	3
\.


--
-- TOC entry 5260 (class 0 OID 16398)
-- Dependencies: 220
-- Data for Name: QuestionSets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuestionSets" ("Set_ID", "Teacher_ID", "Title", "Question_Last_Edit", "Parent_Set_ID", "Is_Latest", "Is_Archived") FROM stdin;
25	1	แบบทดสอบ 3	2025-12-14 00:00:00+07	\N	t	f
29	1	57432	2025-12-22 00:00:00+07	\N	t	f
30	1	654646	2025-12-22 00:00:00+07	\N	t	f
31	1	654646l	2025-12-22 00:00:00+07	\N	t	f
20	1	แบบทดสอบ 3	2025-12-22 00:00:00+07	\N	t	f
32	1	หนีห่าวเหล่ากง	2025-12-24 00:00:00+07	\N	t	f
35	1	k;n[po	2026-01-14 00:00:00+07	\N	t	f
36	1	781948	2026-01-14 00:00:00+07	\N	t	f
39	1	ฟหกดเ้่าสวง6	2026-01-14 00:00:00+07	\N	t	f
24	1	kb;k123	2026-02-25 17:12:36.122+07	\N	t	f
104	1	edit quiz4	2026-03-14 18:04:19.856+07	98	t	t
23	1	ลองแก้ไข	2026-03-05 13:53:16.953+07	\N	t	f
110	24	Quiz Name	2026-03-16 16:06:38.410369+07	\N	t	t
92	1	pjijw	2026-03-11 18:16:58.905+07	90	f	f
90	1	Quiz Name	2026-03-11 18:16:07.905495+07	\N	f	f
91	1	Quiz Name	2026-03-11 18:16:29.343+07	90	f	f
93	1	pjijw	2026-03-11 18:19:42.036+07	90	f	f
26	1	ทดสอบ4	2026-03-05 15:37:51.41+07	\N	t	f
44	1	456	2026-03-02 13:38:20.43+07	\N	t	t
22	1	ทดสอบ อิอิ	2026-03-05 15:05:47.873+07	\N	t	t
27	1	า่ิส่สิ	2026-03-05 15:14:28.049+07	\N	t	t
37	1	Quiz Name	2025-12-24 00:00:00+07	\N	t	t
38	1	89652	2026-01-07 00:00:00+07	\N	t	t
33	1	ipn[p	2025-12-24 00:00:00+07	\N	t	t
34	1	Quiz Nameojo;	2025-12-24 00:00:00+07	\N	t	t
40	1	คณิตศาสตร์เบื้องต้น	2026-02-12 00:00:00+07	\N	f	f
46	1	คณิตศาสตร์เบื้องต้น เวอร์ชันแก้ไขหลังจาก assign	2026-03-05 16:22:47.065+07	40	f	f
47	1	คณิตศาสตร์เบื้องต้น เวอร์ชันแก้ไขหลังจาก assign	2026-03-05 16:23:02.343+07	40	t	f
86	1	33	2026-03-11 17:41:00.901443+07	\N	t	t
45	1	ตอบตามที่โจทย์บอก	2026-03-05 14:45:28.764725+07	\N	f	f
48	1	ตอบตามที่โจทย์บอก	2026-03-05 16:28:12.88+07	45	f	f
49	1	ตอบตามที่โจทย์บอก	2026-03-05 16:28:54.075+07	45	t	f
19	1	แบบทดสอบ525	2026-03-04 17:28:09.734+07	\N	t	t
28	1	ทิท	2026-03-05 15:33:15.227+07	\N	f	f
50	1	ทิท	2026-03-05 16:36:15.881+07	28	f	f
51	1	ทิท	2026-03-05 16:36:59.019+07	28	t	f
52	1	abcd	2026-03-09 19:03:32.160083+07	\N	t	f
53	1	QuizName1	2026-03-11 17:28:08.033657+07	\N	t	t
54	1	1	2026-03-11 17:33:18.031685+07	\N	t	f
55	1	2	2026-03-11 17:33:38.528296+07	\N	t	f
56	1	3	2026-03-11 17:34:00.335127+07	\N	t	f
57	1	4	2026-03-11 17:34:30.208468+07	\N	t	f
58	1	5	2026-03-11 17:34:42.05486+07	\N	t	f
59	1	6	2026-03-11 17:34:58.752166+07	\N	t	f
60	1	7	2026-03-11 17:35:13.138499+07	\N	t	f
61	1	8	2026-03-11 17:35:23.818446+07	\N	t	f
62	1	9	2026-03-11 17:35:41.227482+07	\N	t	f
63	1	10	2026-03-11 17:35:58.664091+07	\N	t	f
64	1	11	2026-03-11 17:36:11.195331+07	\N	t	f
65	1	12	2026-03-11 17:36:26.833311+07	\N	t	f
66	1	13	2026-03-11 17:36:45.335443+07	\N	t	f
67	1	14	2026-03-11 17:36:58.007911+07	\N	t	f
68	1	15	2026-03-11 17:37:13.828763+07	\N	t	f
69	1	16	2026-03-11 17:37:31.013659+07	\N	t	f
70	1	17	2026-03-11 17:37:42.26325+07	\N	t	f
71	1	18	2026-03-11 17:37:53.213307+07	\N	t	f
72	1	19	2026-03-11 17:38:04.360929+07	\N	t	f
73	1	20	2026-03-11 17:38:15.049636+07	\N	t	f
74	1	21	2026-03-11 17:38:25.773636+07	\N	t	f
75	1	22	2026-03-11 17:38:37.10778+07	\N	t	f
76	1	23	2026-03-11 17:38:51.509843+07	\N	t	f
77	1	24	2026-03-11 17:39:01.407084+07	\N	t	f
78	1	25	2026-03-11 17:39:10.537927+07	\N	t	f
79	1	26	2026-03-11 17:39:23.187299+07	\N	t	f
80	1	27	2026-03-11 17:39:42.052297+07	\N	t	f
87	1	34	2026-03-11 17:41:11.875451+07	\N	t	t
88	1	35	2026-03-11 17:41:43.043309+07	\N	t	t
89	1	34	2026-03-11 17:54:37.945696+07	\N	t	t
122	24	esf	2026-03-18 13:05:54.256494+07	\N	t	t
95	1	rsf	2026-03-12 15:19:04.209528+07	\N	f	f
96	1	rsf	2026-03-12 15:21:08.123+07	95	f	f
97	1	rsf	2026-03-12 15:21:49.583+07	95	t	t
94	1	เด็กดี	2026-03-11 18:24:36.095+07	90	t	t
85	1	32	2026-03-11 17:40:50.49556+07	\N	t	t
120	24	Quiz Name	2026-03-16 17:58:03.252+07	118	t	t
102	1	Quiz Name	2026-03-14 17:38:32.333933+07	\N	f	f
98	1	Quiz Name	2026-03-14 16:25:22.02337+07	\N	f	f
99	1	edit quiz	2026-03-14 17:32:33.789+07	98	f	f
100	1	edit quiz2	2026-03-14 17:33:19.147+07	98	f	f
101	1	edit quiz3	2026-03-14 17:38:13.123+07	98	f	f
116	24	efwef	2026-03-16 16:18:28.667527+07	\N	t	t
108	24	คณิต2	2026-03-16 16:02:30.29388+07	\N	f	f
112	24	Quiz Name	2026-03-16 16:14:21.329796+07	\N	f	f
113	24	Quiz Name	2026-03-16 16:16:32.031+07	112	f	f
114	24	lond	2026-03-16 16:16:56.237+07	112	f	f
115	24	londfesf	2026-03-16 16:17:55.551+07	112	t	t
111	24	Quiz Name	2026-03-16 16:14:13.166399+07	\N	t	t
109	24	คณิต2	2026-03-16 16:02:34.406+07	108	f	f
117	24	คณิต2	2026-03-16 16:18:59.838+07	108	t	f
105	24	Quiz Name	2026-03-16 15:27:09.434611+07	\N	f	f
118	24	Quiz Name	2026-03-16 17:40:25.765363+07	\N	f	f
119	24	Quiz Name	2026-03-16 17:56:00.218+07	118	f	f
106	24	Verb To Be	2026-03-16 15:27:45.195+07	105	f	f
107	24	คณิตศาสตร์	2026-03-16 15:37:28.707+07	105	f	f
121	24	คณิตศาสตร์	2026-03-18 13:05:21.143+07	105	t	t
103	1	Quiz Name EiEi	2026-03-14 17:38:42.82+07	102	t	t
84	1	31	2026-03-11 17:40:34.099406+07	\N	t	t
83	1	30	2026-03-11 17:40:23.10059+07	\N	t	t
82	1	29	2026-03-11 17:40:08.323425+07	\N	t	t
81	1	28	2026-03-11 17:39:53.209822+07	\N	t	t
123	24	Quiz Name	2026-03-18 14:54:43.857726+07	\N	f	f
124	24	คณิตศาสตร์ 2	2026-03-18 14:54:59.682+07	123	t	f
125	24	คณิต3	2026-03-19 12:31:49.963222+07	\N	f	f
126	24	คณิต3	2026-03-19 12:56:16.463+07	125	t	f
127	24	Quiz Name	2026-03-19 18:49:21.066709+07	\N	t	t
128	24	Quiz Nameหแก	2026-03-19 19:10:18.333221+07	\N	t	t
129	24	Quiz Name	2026-03-20 10:19:18.807162+07	\N	t	f
\.


--
-- TOC entry 5280 (class 0 OID 17026)
-- Dependencies: 240
-- Data for Name: Question_Correct_Options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Question_Correct_Options" ("Question_ID", "Option_ID") FROM stdin;
36	88
36	87
37	90
37	89
38	92
47	114
47	115
48	117
53	134
53	135
53	136
53	137
116	365
118	371
130	408
131	411
131	412
131	413
132	415
133	417
134	420
135	427
136	428
139	434
140	437
141	439
142	442
148	457
149	461
150	464
151	466
152	469
153	471
154	474
155	477
156	480
157	487
158	490
159	492
160	499
161	502
162	506
163	509
164	511
165	513
166	515
167	516
168	518
168	520
168	521
169	523
169	524
170	525
171	527
172	529
173	532
174	534
175	535
176	538
177	539
178	541
179	545
180	547
181	549
182	551
183	552
184	555
185	556
186	559
187	560
188	562
189	564
190	566
191	568
192	570
193	572
194	574
195	577
196	579
197	582
198	583
199	585
200	588
201	589
202	592
203	593
204	596
205	597
206	600
207	601
208	603
209	606
210	609
211	611
212	613
213	616
214	618
215	619
216	622
217	623
218	626
219	628
220	630
221	632
222	634
223	636
224	639
225	641
226	643
227	645
228	647
229	648
230	650
231	653
232	654
233	657
234	659
235	661
236	663
237	664
238	666
239	668
240	671
241	673
242	674
243	676
244	679
245	681
246	682
247	684
248	686
249	689
250	692
251	694
252	696
253	699
254	701
255	702
256	705
257	706
258	709
259	711
260	713
261	715
262	717
263	719
264	722
265	724
266	726
267	728
268	730
269	731
270	733
271	736
272	737
273	740
274	742
275	744
276	746
277	747
278	749
279	751
280	754
281	756
282	757
283	759
284	762
285	764
286	765
287	767
288	769
289	772
290	775
291	777
292	779
293	782
294	784
295	785
296	788
297	789
298	792
299	794
300	796
301	798
302	800
303	802
304	805
305	807
306	809
307	811
308	813
309	814
310	816
311	819
312	820
313	823
314	825
315	827
316	829
317	830
318	832
319	834
320	837
321	839
322	840
323	842
324	845
325	847
326	848
327	850
328	853
329	856
330	858
331	860
332	863
333	865
334	866
335	869
336	870
337	873
338	875
339	877
340	879
341	881
342	883
343	886
344	888
345	890
346	892
347	894
348	895
349	897
350	900
351	901
352	904
353	906
354	908
355	910
356	911
357	913
358	915
359	918
360	920
361	921
362	923
363	926
364	928
365	929
366	932
367	933
368	936
369	939
370	941
371	943
372	946
373	948
374	949
375	952
376	953
377	956
378	958
379	960
380	962
381	964
382	966
383	969
384	971
385	973
386	975
387	977
388	978
389	980
390	983
391	984
392	987
393	989
394	991
395	993
396	994
397	996
398	998
399	1001
400	1003
401	1004
402	1006
403	1009
404	1011
405	1012
406	1015
407	1016
408	1019
409	1023
409	1024
410	1025
411	1028
412	1032
412	1033
413	1034
414	1036
415	1039
416	1043
416	1044
417	1045
418	1047
419	1050
420	1052
421	1054
422	1056
423	1057
424	1059
425	1061
426	1063
427	1066
428	1070
429	1074
430	1076
431	1078
432	1079
433	1081
434	1083
435	1086
436	1087
437	1089
438	1091
439	1093
440	1095
441	1097
442	1099
443	1101
444	1103
445	1106
446	1109
447	1114
448	1117
449	1119
450	1126
451	1128
452	1130
453	1132
454	1137
455	1140
456	1142
457	1149
458	1151
459	1153
460	1155
461	1160
462	1162
462	1165
462	1164
463	1166
463	1167
463	1168
463	1169
464	1173
465	1175
465	1178
465	1177
466	1179
466	1180
466	1181
466	1182
467	1184
468	1187
469	1189
470	1190
471	1195
471	1194
471	1196
472	1198
472	1199
472	1200
\.


--
-- TOC entry 5261 (class 0 OID 16428)
-- Dependencies: 221
-- Data for Name: Questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Questions" ("Question_ID", "Set_ID", "Question_Type", "Question_Text", "Question_Image") FROM stdin;
115	35	ordering	ljguughj	\N
116	35	single	7753735	\N
117	36	ordering	ljguughj	\N
118	36	single	74742	\N
24	22	single	กดเ้่าสวง	\N
25	22	single	หกดเ้่าสวง	\N
26	22	single	สกาืเกสา	\N
151	28	single	ทิท	https://res.cloudinary.com/dyswafidd/image/upload/v1766387644/quiz-questions/tctwtzvg7jiekt4kerye.webp
152	28	single	ตอบ3	https://res.cloudinary.com/dyswafidd/image/upload/v1772695975/quiz-questions/e8qstgwyes60hdczoqim.png
30	25	single	ไก่จ๋า ได้ยินไหมว่าเสียงใคร	\N
31	25	multiple	ลิงจั๊ก ๆ	\N
153	26	single	มาทดสอบกันจ้า2	\N
154	26	multiple	ๆไำพะัีรนยบ	\N
35	29	multiple	7354324	\N
36	30	multiple	75\\55763	\N
37	31	multiple	75\\55763	\N
38	31	single	dohjosp	\N
130	39	single	แก้โจทย์	https://res.cloudinary.com/dyswafidd/image/upload/v1767778526/quiz-questions/iy1bl2od3tc6x7hlirxp.png
131	39	ordering	ๆไำพะัีรนยบลฃฟหกดเ้่าสวง	https://res.cloudinary.com/dyswafidd/image/upload/v1767770579/quiz-questions/hjvkz5qgc5grgjgfggry.png
132	39	single	84654153	\N
133	40	single	2+2	\N
134	40	single	9*3	\N
45	20	single	ไก่จ๋า ได้ยินไหมว่าเสียงใคร	\N
46	20	multiple	ลิงจั๊ก ๆ	\N
47	32	multiple	16845	https://res.cloudinary.com/dyswafidd/image/upload/v1766397231/quiz-questions/o5a9dzpriakh2k02pkxr.webp
48	32	single	543	https://res.cloudinary.com/dyswafidd/image/upload/v1766397266/quiz-questions/uw7pdscjmd82c6bnysl3.jpg
49	33	ordering	uogigu	https://res.cloudinary.com/dyswafidd/image/upload/v1766567075/quiz-questions/icewss7bki071yn0xvw8.png
50	34	ordering	ljguughj	\N
53	37	ordering	ักดีัเา้สเา่เแือิ	\N
55	19	single	ไก่จ๋า ได้ยินไหมว่าเสียงใคร	\N
56	19	multiple	ลิงจั๊ก ๆ	\N
135	40	single	9/3	\N
136	24	single	4\n5\n5	\N
139	44	single	fafasf	\N
140	44	single	456	\N
141	23	single	'algm;elgn	https://res.cloudinary.com/dyswafidd/image/upload/v1772693590/quiz-questions/nm5ylkppayylveamfrvp.png
142	23	single	'lfnb'xsf	\N
148	45	single	ตอบ1	https://res.cloudinary.com/dyswafidd/image/upload/v1772696041/quiz-questions/rkx2b9shctzds9bymfsq.png
149	27	single	้อ ส่าอส	\N
150	27	single	ตอบ2	https://res.cloudinary.com/dyswafidd/image/upload/v1772695939/quiz-questions/nfsynck98fzqm4wq6jhz.png
155	46	single	2+2	\N
156	46	single	9*3	\N
157	46	single	9/3	\N
158	47	single	2+2	\N
159	47	single	9*3	\N
160	47	single	9/3	\N
161	48	single	ตอบ3	https://res.cloudinary.com/dyswafidd/image/upload/v1772696041/quiz-questions/rkx2b9shctzds9bymfsq.png
162	49	single	ตอบ5	https://res.cloudinary.com/dyswafidd/image/upload/v1772696041/quiz-questions/rkx2b9shctzds9bymfsq.png
163	50	single	ทิท	https://res.cloudinary.com/dyswafidd/image/upload/v1766387644/quiz-questions/tctwtzvg7jiekt4kerye.webp
164	50	single	ตอบ3	https://res.cloudinary.com/dyswafidd/image/upload/v1772695975/quiz-questions/e8qstgwyes60hdczoqim.png
165	51	single	ทิท	https://res.cloudinary.com/dyswafidd/image/upload/v1766387644/quiz-questions/tctwtzvg7jiekt4kerye.webp
166	51	single	ตอบ3	https://res.cloudinary.com/dyswafidd/image/upload/v1772695975/quiz-questions/e8qstgwyes60hdczoqim.png
167	52	single	วันที่ 30 มีนาคม 69 เป็นวันจันทร์	https://res.cloudinary.com/dyswafidd/image/upload/v1773057712/quiz-questions/k889pg2ephdbbmcsa1z2.png
168	52	multiple	วันไหนที่เรานัดกันทำงาน	\N
169	52	ordering	เรียงลำดับเลขน้อยไปมาก	\N
170	53	single	mkmakwo	\N
171	54	single	ร	\N
172	55	single	ร	\N
173	56	single	บล\n	\N
174	57	single	\nฃ	\N
175	58	single	ฃ1	\N
176	59	single	ฃล1	\N
177	60	single	ฃ\n	\N
178	61	single	4	\N
179	62	single	\nลฃ	\N
180	63	single	ลฃ\n	\N
181	64	single	ฃ\nล	\N
182	65	single	ำก	\N
183	66	single	ฃ\n	\N
184	67	single	ล	\N
185	68	single	ชล	\N
186	69	single	วน่สร\n	\N
187	70	single	\nช	\N
188	71	single	\nชจ	\N
189	72	single	ขชล	\N
190	73	single	ขชจบขข	\N
191	74	single	ขลช	\N
192	75	single	ลบนจ	\N
193	76	single	ขลช	\N
194	77	single	ชบขนยจ	\N
195	78	single	ชขลบข	\N
196	79	single	ชลจข	\N
197	80	single	\nช	\N
198	81	single	ลยบ	\N
199	82	single	ชขช	\N
200	83	single	ีขร\n	\N
201	84	single	ำไก	\N
202	85	single	ำดไ	\N
203	86	single	ไำกฟ	\N
204	87	single	ไกๆ	\N
205	88	single	ไๆก	\N
206	89	single	dsd	\N
207	90	single	41	\N
208	90	single	-1	\N
209	90	single	1\\	\N
210	90	single	'[0;o	\N
211	90	single	';op	\N
247	91	single	41	\N
248	91	single	-1	\N
212	90	single	0'o[;	https://res.cloudinary.com/dyswafidd/image/upload/v1773226911/quiz-questions/m1k1aoan4zksq8hqbhnx.png
213	90	single	o0';[	\N
214	90	single	p'[	\N
215	90	single	47\\4	\N
216	90	single	\\4\n1	\N
217	90	single	ewf	\N
218	90	single	ewf	\N
219	90	single	efw	\N
220	90	single	ewfw	\N
221	90	single	fedw	\N
222	90	single	fedw	\N
223	90	single	efs	\N
224	90	single	fsesfe	\N
225	90	single	edcfs	\N
226	90	single	eds	\N
227	90	single	fs	\N
228	90	single	cdfse	\N
229	90	single	sedf	\N
230	90	single	csad	\N
231	90	single	aesf	\N
232	90	single	aefs	\N
233	90	single	asef	\N
234	90	single	afe	\N
235	90	single	fae	\N
236	90	single	dcesa	\N
237	90	single	awf	\N
238	90	single	afes	\N
239	90	single	aef	\N
240	90	single	aesf	\N
241	90	single	asf	\N
242	90	single	aef	\N
243	90	single	awf	\N
244	90	single	afc	\N
245	90	single	aef	\N
246	90	single	grfe	\N
249	91	single	1\\	\N
250	91	single	'[0;o	\N
251	91	single	';op	\N
252	91	single	0'o[;	https://res.cloudinary.com/dyswafidd/image/upload/v1773226911/quiz-questions/m1k1aoan4zksq8hqbhnx.png
253	91	single	o0';[	\N
254	91	single	p'[	\N
255	91	single	47\\4	\N
256	91	single	\\4\n1	\N
257	91	single	ewf	\N
258	91	single	ewf	\N
259	91	single	efw	\N
260	91	single	ewfw	\N
261	91	single	fedw	\N
262	91	single	fedw	\N
263	91	single	efs	\N
264	91	single	fsesfe	\N
265	91	single	edcfs	\N
266	91	single	eds	\N
267	91	single	fs	\N
268	91	single	cdfse	\N
269	91	single	sedf	\N
270	91	single	csad	\N
271	91	single	aesf	\N
272	91	single	aefs	\N
273	91	single	asef	\N
274	91	single	afe	\N
275	91	single	fae	\N
276	91	single	dcesa	\N
277	91	single	awf	\N
278	91	single	afes	\N
279	91	single	aef	\N
280	91	single	aesf	\N
281	91	single	asf	\N
282	91	single	aef	\N
283	91	single	awf	\N
284	91	single	afc	\N
285	91	single	aef	\N
286	91	single	grfe	\N
287	92	single	41	\N
288	92	single	-1	\N
289	92	single	1\\	\N
290	92	single	'[0;o	\N
291	92	single	';op	\N
292	92	single	0'o[;	https://res.cloudinary.com/dyswafidd/image/upload/v1773226911/quiz-questions/m1k1aoan4zksq8hqbhnx.png
293	92	single	o0';[	\N
294	92	single	p'[	\N
295	92	single	47\\4	\N
296	92	single	\\4\n1	\N
297	92	single	ewf	\N
298	92	single	ewf	\N
299	92	single	efw	\N
300	92	single	ewfw	\N
301	92	single	fedw	\N
302	92	single	fedw	\N
303	92	single	efs	\N
304	92	single	fsesfe	\N
305	92	single	edcfs	\N
306	92	single	eds	\N
307	92	single	fs	\N
308	92	single	cdfse	\N
309	92	single	sedf	\N
310	92	single	csad	\N
311	92	single	aesf	\N
312	92	single	aefs	\N
313	92	single	asef	\N
314	92	single	afe	\N
315	92	single	fae	\N
316	92	single	dcesa	\N
317	92	single	awf	\N
318	92	single	afes	\N
319	92	single	aef	\N
320	92	single	aesf	\N
321	92	single	asf	\N
322	92	single	aef	\N
323	92	single	awf	\N
324	92	single	afc	\N
325	92	single	aef	\N
326	92	single	grfe	\N
327	93	single	-1	\N
328	93	single	1\\	\N
329	93	single	'[0;o	\N
330	93	single	';op	\N
331	93	single	0'o[;	https://res.cloudinary.com/dyswafidd/image/upload/v1773226911/quiz-questions/m1k1aoan4zksq8hqbhnx.png
332	93	single	o0';[	\N
333	93	single	p'[	\N
334	93	single	47\\4	\N
335	93	single	\\4\n1	\N
336	93	single	ewf	\N
337	93	single	ewf	\N
338	93	single	efw	\N
339	93	single	ewfw	\N
340	93	single	fedw	\N
341	93	single	fedw	\N
342	93	single	efs	\N
343	93	single	fsesfe	\N
344	93	single	edcfs	\N
345	93	single	eds	\N
346	93	single	fs	\N
347	93	single	cdfse	\N
348	93	single	sedf	\N
349	93	single	csad	\N
350	93	single	aesf	\N
351	93	single	aefs	\N
352	93	single	asef	\N
353	93	single	afe	\N
354	93	single	fae	\N
355	93	single	dcesa	\N
356	93	single	awf	\N
357	93	single	afes	\N
358	93	single	aef	\N
359	93	single	aesf	\N
360	93	single	asf	\N
361	93	single	aef	\N
362	93	single	awf	\N
363	93	single	afc	\N
364	93	single	aef	\N
365	93	single	grfe	\N
366	93	single	หกไ	\N
367	94	single	-1	\N
368	94	single	1\\	\N
369	94	single	'[0;o	\N
370	94	single	';op	\N
371	94	single	0'o[;	https://res.cloudinary.com/dyswafidd/image/upload/v1773226911/quiz-questions/m1k1aoan4zksq8hqbhnx.png
372	94	single	o0';[	\N
373	94	single	p'[	\N
374	94	single	47\\4	\N
375	94	single	\\4\n1	\N
376	94	single	ewf	\N
377	94	single	ewf	\N
378	94	single	efw	\N
379	94	single	ewfw	\N
380	94	single	fedw	\N
381	94	single	fedw	\N
382	94	single	efs	\N
383	94	single	fsesfe	\N
384	94	single	edcfs	\N
385	94	single	eds	\N
386	94	single	fs	\N
387	94	single	cdfse	\N
388	94	single	sedf	\N
389	94	single	csad	\N
390	94	single	aesf	\N
391	94	single	aefs	\N
392	94	single	asef	\N
393	94	single	afe	\N
394	94	single	fae	\N
395	94	single	dcesa	\N
396	94	single	awf	\N
397	94	single	afes	\N
398	94	single	aef	\N
399	94	single	aesf	\N
400	94	single	asf	\N
401	94	single	aef	\N
402	94	single	awf	\N
403	94	single	afc	\N
404	94	single	aef	\N
405	94	single	grfe	\N
406	94	single	หกไ	\N
407	95	single	rfse	\N
408	95	multiple	rgef	https://res.cloudinary.com/dyswafidd/image/upload/v1773303529/quiz-questions/dybqjxarubuqonldhv5i.png
409	95	ordering	rgfe	\N
410	96	single	rfse	\N
411	96	multiple	rgef	https://res.cloudinary.com/dyswafidd/image/upload/v1773303529/quiz-questions/dybqjxarubuqonldhv5i.png
412	96	ordering	rgfe	\N
413	96	single	\n]\n-'[0	\N
414	97	single	rfse	\N
415	97	multiple	rgef	https://res.cloudinary.com/dyswafidd/image/upload/v1773303529/quiz-questions/dybqjxarubuqonldhv5i.png
416	97	ordering	rgfe	\N
417	97	single	\n]\n-'[0	\N
418	97	single	l,kjmh	\N
419	98	single	หพัำพ้	\N
420	99	single	หพัำพ้	\N
421	100	single	หพัำพ้	\N
422	101	single	หพัำพ้	\N
423	102	single	df	\N
424	103	single	df	\N
425	104	single	หพัำพ้	\N
426	105	single	I __ Happy.	\N
427	106	single	I __ Happy.	\N
428	107	single	2+2	\N
429	108	single	5 * 2	\N
430	109	single	5 * 2	\N
431	110	single	2-3	\N
432	111	single	gtrfv	\N
433	111	single	ftgbyh	\N
434	112	single	gtrfv	\N
435	112	single	ftgbyh	\N
436	113	single	gtrfv	\N
437	113	single	ftgbyh	\N
438	114	single	gtrfv	\N
439	114	single	dbo-hv;	\N
440	115	single	gtrfv	\N
441	115	single	dbo-hv;	\N
442	116	single	wefwf	\N
443	117	single	5 * 2	\N
444	118	single	2+3	\N
445	119	single	2+3	\N
446	122	single	esf	\N
447	123	single	2+2	\N
448	123	single	9*3	\N
449	123	single	5-3	\N
450	123	single	3-5	\N
451	123	single	4/2	\N
452	123	single	8-7+1	\N
453	123	single	9*2	\N
454	124	single	2+2	\N
455	124	single	9*3	\N
456	124	single	5-3	\N
457	124	single	3-5	\N
458	124	single	4/2	\N
459	124	single	8-7+1	\N
460	124	single	9*2	\N
461	125	single	5+9	\N
462	125	multiple	ตัวเลขใดมีค่ามากกว่า 8	\N
463	125	ordering	จงเรียงเลขจากน้อยไปมาก	\N
464	126	single	5+9	\N
465	126	multiple	ตัวเลขใดมีค่ามากกว่า 8	\N
466	126	ordering	จงเรียงเลขจากน้อยไปมาก	\N
467	126	single	จากรูปจุด P คือจุดไหน	https://res.cloudinary.com/dyswafidd/image/upload/v1773899775/quiz-questions/ygbzicgn975gndbb1ztq.png
468	127	multiple	ฃ\n\n	\N
469	128	single	กอห	\N
470	129	single	5-2	\N
471	129	multiple	jnbh	\N
472	129	ordering	fd	\N
\.


--
-- TOC entry 5288 (class 0 OID 17157)
-- Dependencies: 248
-- Data for Name: QuizAnswers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuizAnswers" ("QuizAnswer_ID", "Question_ID", "Choice_ID", "Is_Correct", "Answered_At", "Answer_Order", "Time_Spent", "AssignedQuiz_ID", "ActivityParticipant_ID") FROM stdin;
1	130	408	t	2026-02-01 18:09:11.813575+07	\N	\N	\N	\N
2	130	409	f	2026-02-01 18:09:06.813575+07	\N	\N	\N	\N
3	130	408	t	2026-02-01 18:09:09.813575+07	\N	\N	\N	\N
4	130	410	f	2026-02-01 18:09:04.813575+07	\N	\N	\N	\N
5	130	408	t	2026-02-01 18:09:10.813575+07	\N	\N	\N	\N
6	130	408	t	2026-02-01 18:23:44.782561+07	\N	\N	\N	\N
7	130	409	f	2026-02-01 18:23:39.782561+07	\N	\N	\N	\N
8	130	408	t	2026-02-01 18:23:42.782561+07	\N	\N	\N	\N
9	130	410	f	2026-02-01 18:23:37.782561+07	\N	\N	\N	\N
10	130	408	t	2026-02-01 18:23:43.782561+07	\N	\N	\N	\N
2435	165	512	\N	2026-03-08 16:53:28.556978+07	\N	3	\N	\N
2446	133	417	\N	2026-03-08 16:58:24.379061+07	\N	0	\N	\N
2458	134	420	\N	2026-03-08 17:10:13.995889+07	\N	0	\N	\N
2459	135	427	\N	2026-03-08 17:10:16.211838+07	\N	1	\N	\N
2467	134	420	\N	2026-03-08 17:28:16.815214+07	\N	0	\N	\N
16	130	408	t	2026-02-01 18:28:07.041044+07	\N	5	\N	\N
17	130	409	f	2026-02-01 18:28:07.041044+07	\N	6	\N	\N
18	130	408	t	2026-02-01 18:28:07.041044+07	\N	9	\N	\N
19	130	410	f	2026-02-01 18:28:07.041044+07	\N	7	\N	\N
20	130	408	t	2026-02-01 18:28:07.041044+07	\N	3	\N	\N
21	130	408	t	2026-02-01 18:29:51.5607+07	\N	5	\N	\N
22	130	409	f	2026-02-01 18:29:51.5607+07	\N	6	\N	\N
23	130	408	t	2026-02-01 18:29:51.5607+07	\N	9	\N	\N
24	130	410	f	2026-02-01 18:29:51.5607+07	\N	7	\N	\N
25	130	408	t	2026-02-01 18:29:51.5607+07	\N	3	\N	\N
26	130	408	t	2026-02-01 18:38:09.179275+07	\N	5	\N	\N
27	130	409	f	2026-02-01 18:38:09.179275+07	\N	6	\N	\N
28	130	408	t	2026-02-01 18:38:09.179275+07	\N	9	\N	\N
29	130	410	f	2026-02-01 18:38:09.179275+07	\N	7	\N	\N
30	130	408	t	2026-02-01 18:38:09.179275+07	\N	3	\N	\N
31	131	411	t	2026-02-01 19:12:57.216319+07	1	6	\N	\N
32	131	412	t	2026-02-01 19:12:57.216319+07	2	6	\N	\N
33	131	413	t	2026-02-01 19:12:57.216319+07	3	6	\N	\N
34	131	412	f	2026-02-01 19:12:57.216319+07	1	8	\N	\N
35	131	411	f	2026-02-01 19:12:57.216319+07	2	8	\N	\N
36	131	413	t	2026-02-01 19:12:57.216319+07	3	8	\N	\N
37	131	411	t	2026-02-01 19:12:57.216319+07	1	9	\N	\N
38	131	413	f	2026-02-01 19:12:57.216319+07	2	9	\N	\N
39	131	412	f	2026-02-01 19:12:57.216319+07	3	9	\N	\N
40	131	412	f	2026-02-01 19:12:57.216319+07	1	7	\N	\N
41	131	413	f	2026-02-01 19:12:57.216319+07	2	7	\N	\N
42	131	411	f	2026-02-01 19:12:57.216319+07	3	7	\N	\N
43	131	411	t	2026-02-01 19:12:57.216319+07	1	10	\N	\N
44	131	412	t	2026-02-01 19:12:57.216319+07	2	10	\N	\N
45	131	413	t	2026-02-01 19:12:57.216319+07	3	10	\N	\N
2476	134	420	\N	2026-03-08 17:29:25.395986+07	\N	0	\N	\N
2487	133	417	\N	2026-03-08 17:30:53.882665+07	\N	0	\N	\N
2489	135	427	\N	2026-03-08 17:30:58.03078+07	\N	1	\N	\N
2496	133	417	\N	2026-03-08 17:32:07.28025+07	\N	1	\N	\N
2504	133	417	\N	2026-03-08 17:36:30.61319+07	\N	0	\N	\N
2506	135	427	\N	2026-03-08 17:36:34.359006+07	\N	0	\N	\N
2507	133	417	\N	2026-03-08 17:36:44.681779+07	\N	0	\N	\N
2509	135	427	\N	2026-03-08 17:36:48.253948+07	\N	0	\N	\N
2514	134	420	\N	2026-03-08 17:37:53.283107+07	\N	0	\N	\N
2523	134	420	\N	2026-03-08 17:39:37.151907+07	\N	0	\N	\N
2532	134	420	\N	2026-03-08 18:00:07.126411+07	\N	0	\N	\N
2541	133	417	\N	2026-03-08 18:08:37.882461+07	\N	1	\N	\N
2549	133	417	\N	2026-03-08 18:31:11.095219+07	\N	0	\N	\N
2551	135	427	\N	2026-03-08 18:31:14.724551+07	\N	1	\N	\N
2558	133	417	\N	2026-03-08 18:47:55.577751+07	\N	1	\N	\N
61	130	408	t	2026-02-01 19:16:52.694627+07	\N	5	\N	\N
62	130	409	f	2026-02-01 19:16:52.694627+07	\N	6	\N	\N
63	130	408	t	2026-02-01 19:16:52.694627+07	\N	9	\N	\N
64	130	410	f	2026-02-01 19:16:52.694627+07	\N	7	\N	\N
65	130	408	t	2026-02-01 19:16:52.694627+07	\N	3	\N	\N
66	131	411	t	2026-02-01 19:16:52.694627+07	1	6	\N	\N
67	131	412	t	2026-02-01 19:16:52.694627+07	2	6	\N	\N
68	131	413	t	2026-02-01 19:16:52.694627+07	3	6	\N	\N
69	131	412	f	2026-02-01 19:16:52.694627+07	1	8	\N	\N
70	131	411	f	2026-02-01 19:16:52.694627+07	2	8	\N	\N
71	131	413	t	2026-02-01 19:16:52.694627+07	3	8	\N	\N
72	131	411	t	2026-02-01 19:16:52.694627+07	1	9	\N	\N
73	131	413	f	2026-02-01 19:16:52.694627+07	2	9	\N	\N
74	131	412	f	2026-02-01 19:16:52.694627+07	3	9	\N	\N
75	131	412	f	2026-02-01 19:16:52.694627+07	1	7	\N	\N
76	131	413	f	2026-02-01 19:16:52.694627+07	2	7	\N	\N
77	131	411	f	2026-02-01 19:16:52.694627+07	3	7	\N	\N
78	131	411	t	2026-02-01 19:16:52.694627+07	1	10	\N	\N
79	131	412	t	2026-02-01 19:16:52.694627+07	2	10	\N	\N
80	131	413	t	2026-02-01 19:16:52.694627+07	3	10	\N	\N
81	132	415	t	2026-02-01 19:16:52.694627+07	\N	4	\N	\N
82	132	414	f	2026-02-01 19:16:52.694627+07	\N	6	\N	\N
83	132	415	t	2026-02-01 19:16:52.694627+07	\N	8	\N	\N
84	132	414	f	2026-02-01 19:16:52.694627+07	\N	5	\N	\N
85	132	415	t	2026-02-01 19:16:52.694627+07	\N	7	\N	\N
86	130	408	t	2026-02-02 14:15:41.506139+07	\N	5	\N	\N
87	130	409	f	2026-02-02 14:15:41.506139+07	\N	6	\N	\N
88	130	408	t	2026-02-02 14:15:41.506139+07	\N	4	\N	\N
89	130	410	f	2026-02-02 14:15:41.506139+07	\N	7	\N	\N
90	130	408	t	2026-02-02 14:15:41.506139+07	\N	6	\N	\N
91	131	411	t	2026-02-02 14:15:41.506139+07	1	8	\N	\N
92	131	412	t	2026-02-02 14:15:41.506139+07	2	8	\N	\N
93	131	413	t	2026-02-02 14:15:41.506139+07	3	8	\N	\N
94	131	411	t	2026-02-02 14:15:41.506139+07	1	9	\N	\N
95	131	413	f	2026-02-02 14:15:41.506139+07	2	9	\N	\N
96	131	412	f	2026-02-02 14:15:41.506139+07	3	9	\N	\N
97	131	411	t	2026-02-02 14:15:41.506139+07	1	10	\N	\N
98	131	412	t	2026-02-02 14:15:41.506139+07	3	10	\N	\N
99	131	413	t	2026-02-02 14:15:41.506139+07	2	10	\N	\N
100	131	412	f	2026-02-02 14:15:41.506139+07	1	12	\N	\N
101	131	411	f	2026-02-02 14:15:41.506139+07	2	12	\N	\N
102	131	413	t	2026-02-02 14:15:41.506139+07	3	12	\N	\N
103	131	411	t	2026-02-02 14:15:41.506139+07	1	15	\N	\N
104	131	412	t	2026-02-02 14:15:41.506139+07	2	15	\N	\N
105	131	413	t	2026-02-02 14:15:41.506139+07	3	15	\N	\N
106	132	415	t	2026-02-02 14:15:41.506139+07	\N	4	\N	\N
107	132	414	f	2026-02-02 14:15:41.506139+07	\N	6	\N	\N
108	132	415	t	2026-02-02 14:15:41.506139+07	\N	5	\N	\N
109	132	414	f	2026-02-02 14:15:41.506139+07	\N	7	\N	\N
110	132	415	t	2026-02-02 14:15:41.506139+07	\N	6	\N	\N
111	130	408	t	2026-02-02 15:07:06.297839+07	\N	5	\N	\N
112	130	409	f	2026-02-02 15:07:06.297839+07	\N	6	\N	\N
113	130	408	t	2026-02-02 15:07:06.297839+07	\N	4	\N	\N
114	130	410	f	2026-02-02 15:07:06.297839+07	\N	7	\N	\N
115	130	408	t	2026-02-02 15:07:06.297839+07	\N	6	\N	\N
116	131	411	t	2026-02-02 15:07:06.297839+07	1	8	\N	\N
117	131	412	t	2026-02-02 15:07:06.297839+07	2	8	\N	\N
118	131	413	t	2026-02-02 15:07:06.297839+07	3	8	\N	\N
119	131	411	t	2026-02-02 15:07:06.297839+07	1	9	\N	\N
120	131	413	f	2026-02-02 15:07:06.297839+07	2	9	\N	\N
121	131	412	f	2026-02-02 15:07:06.297839+07	3	9	\N	\N
122	131	411	t	2026-02-02 15:07:06.297839+07	1	10	\N	\N
123	131	412	t	2026-02-02 15:07:06.297839+07	3	10	\N	\N
124	131	413	t	2026-02-02 15:07:06.297839+07	2	10	\N	\N
125	131	412	f	2026-02-02 15:07:06.297839+07	1	12	\N	\N
126	131	411	f	2026-02-02 15:07:06.297839+07	2	12	\N	\N
127	131	413	t	2026-02-02 15:07:06.297839+07	3	12	\N	\N
128	131	411	t	2026-02-02 15:07:06.297839+07	1	15	\N	\N
129	131	412	t	2026-02-02 15:07:06.297839+07	2	15	\N	\N
130	131	413	t	2026-02-02 15:07:06.297839+07	3	15	\N	\N
131	132	415	t	2026-02-02 15:07:06.297839+07	\N	4	\N	\N
132	132	414	f	2026-02-02 15:07:06.297839+07	\N	6	\N	\N
133	132	415	t	2026-02-02 15:07:06.297839+07	\N	5	\N	\N
134	132	414	f	2026-02-02 15:07:06.297839+07	\N	7	\N	\N
135	132	415	t	2026-02-02 15:07:06.297839+07	\N	6	\N	\N
138	55	143	\N	2026-02-02 15:21:05.591449+07	\N	2	\N	\N
139	55	142	\N	2026-02-02 15:21:08.480061+07	\N	5	\N	\N
140	55	143	\N	2026-02-02 15:23:27.41019+07	\N	1	\N	\N
141	55	142	\N	2026-02-02 15:23:30.85237+07	\N	4	\N	\N
142	56	144	\N	2026-02-02 15:23:49.452679+07	\N	7	\N	\N
143	56	145	\N	2026-02-02 15:23:49.483478+07	\N	7	\N	\N
144	56	146	\N	2026-02-02 15:23:49.616765+07	\N	6	\N	\N
145	56	145	\N	2026-02-02 15:28:59.30298+07	\N	12	\N	\N
146	56	146	\N	2026-02-02 15:28:59.334705+07	\N	12	\N	\N
147	55	143	\N	2026-02-02 15:34:12.477579+07	\N	2	\N	\N
148	55	143	\N	2026-02-02 15:45:24.993807+07	\N	2	\N	\N
149	55	143	\N	2026-02-02 15:46:42.326459+07	\N	2	\N	\N
150	56	145	\N	2026-02-02 15:46:53.863553+07	\N	4	\N	\N
151	56	146	\N	2026-02-02 15:46:53.875716+07	\N	4	\N	\N
152	56	146	\N	2026-02-02 15:46:56.745938+07	\N	6	\N	\N
153	55	143	\N	2026-02-02 15:51:20.835134+07	\N	2	\N	\N
154	56	145	\N	2026-02-02 15:54:11.075628+07	\N	3	\N	\N
155	56	144	\N	2026-02-02 15:54:11.112501+07	\N	3	\N	\N
156	56	146	\N	2026-02-02 15:54:14.528927+07	\N	6	\N	\N
157	56	145	\N	2026-02-02 15:54:14.543862+07	\N	6	\N	\N
158	130	408	t	2026-02-02 16:12:42.112522+07	\N	5	\N	\N
159	130	409	f	2026-02-02 16:12:42.112522+07	\N	6	\N	\N
160	130	408	t	2026-02-02 16:12:42.112522+07	\N	4	\N	\N
161	130	410	f	2026-02-02 16:12:42.112522+07	\N	7	\N	\N
162	130	408	t	2026-02-02 16:12:42.112522+07	\N	6	\N	\N
163	131	411	t	2026-02-02 16:12:42.112522+07	1	8	\N	\N
164	131	412	t	2026-02-02 16:12:42.112522+07	2	8	\N	\N
165	131	413	t	2026-02-02 16:12:42.112522+07	3	8	\N	\N
166	131	411	t	2026-02-02 16:12:42.112522+07	1	9	\N	\N
167	131	413	f	2026-02-02 16:12:42.112522+07	2	9	\N	\N
168	131	412	f	2026-02-02 16:12:42.112522+07	3	9	\N	\N
169	131	411	t	2026-02-02 16:12:42.112522+07	1	10	\N	\N
170	131	412	t	2026-02-02 16:12:42.112522+07	3	10	\N	\N
171	131	413	t	2026-02-02 16:12:42.112522+07	2	10	\N	\N
172	131	412	f	2026-02-02 16:12:42.112522+07	1	12	\N	\N
173	131	411	f	2026-02-02 16:12:42.112522+07	2	12	\N	\N
174	131	413	t	2026-02-02 16:12:42.112522+07	3	12	\N	\N
175	131	411	t	2026-02-02 16:12:42.112522+07	1	15	\N	\N
176	131	412	t	2026-02-02 16:12:42.112522+07	2	15	\N	\N
177	131	413	t	2026-02-02 16:12:42.112522+07	3	15	\N	\N
178	132	415	t	2026-02-02 16:12:42.112522+07	\N	4	\N	\N
179	132	414	f	2026-02-02 16:12:42.112522+07	\N	6	\N	\N
180	132	415	t	2026-02-02 16:12:42.112522+07	\N	5	\N	\N
181	132	414	f	2026-02-02 16:12:42.112522+07	\N	7	\N	\N
182	132	415	t	2026-02-02 16:12:42.112522+07	\N	6	\N	\N
183	25	59	\N	2026-02-02 16:22:13.560719+07	\N	2	\N	\N
184	26	62	\N	2026-02-02 16:22:28.824381+07	\N	8	\N	\N
185	55	143	\N	2026-02-02 16:23:10.984462+07	\N	1	\N	\N
186	56	146	\N	2026-02-02 16:33:41.987885+07	\N	1	\N	\N
187	55	143	\N	2026-02-02 16:33:59.193035+07	\N	2	\N	\N
188	55	142	\N	2026-02-02 16:39:04.286424+07	\N	1	\N	\N
189	56	145	\N	2026-02-02 16:39:07.964594+07	\N	1	\N	\N
190	55	143	\N	2026-02-02 16:39:22.942572+07	\N	1	\N	\N
191	56	146	\N	2026-02-02 16:39:31.75877+07	\N	3	\N	\N
192	56	145	\N	2026-02-02 16:43:38.956191+07	\N	1	\N	\N
193	55	143	\N	2026-02-02 16:43:51.3084+07	\N	1	\N	\N
194	56	146	\N	2026-02-02 16:43:54.942476+07	\N	1	\N	\N
195	130	408	t	2026-02-02 16:55:32.559305+07	\N	5	\N	\N
196	130	409	f	2026-02-02 16:55:32.559305+07	\N	6	\N	\N
197	130	408	t	2026-02-02 16:55:32.559305+07	\N	4	\N	\N
198	130	410	f	2026-02-02 16:55:32.559305+07	\N	7	\N	\N
199	130	408	t	2026-02-02 16:55:32.559305+07	\N	6	\N	\N
200	131	411	t	2026-02-02 16:55:32.559305+07	1	8	\N	\N
201	131	412	t	2026-02-02 16:55:32.559305+07	2	8	\N	\N
202	131	413	t	2026-02-02 16:55:32.559305+07	3	8	\N	\N
203	131	411	t	2026-02-02 16:55:32.559305+07	1	9	\N	\N
204	131	413	f	2026-02-02 16:55:32.559305+07	2	9	\N	\N
205	131	412	f	2026-02-02 16:55:32.559305+07	3	9	\N	\N
206	131	411	t	2026-02-02 16:55:32.559305+07	1	10	\N	\N
207	131	412	t	2026-02-02 16:55:32.559305+07	3	10	\N	\N
208	131	413	t	2026-02-02 16:55:32.559305+07	2	10	\N	\N
209	131	412	f	2026-02-02 16:55:32.559305+07	1	12	\N	\N
210	131	411	f	2026-02-02 16:55:32.559305+07	2	12	\N	\N
211	131	413	t	2026-02-02 16:55:32.559305+07	3	12	\N	\N
212	131	411	t	2026-02-02 16:55:32.559305+07	1	15	\N	\N
213	131	412	t	2026-02-02 16:55:32.559305+07	2	15	\N	\N
214	131	413	t	2026-02-02 16:55:32.559305+07	3	15	\N	\N
215	132	415	t	2026-02-02 16:55:32.559305+07	\N	4	\N	\N
216	132	414	f	2026-02-02 16:55:32.559305+07	\N	6	\N	\N
217	132	415	t	2026-02-02 16:55:32.559305+07	\N	5	\N	\N
218	132	414	f	2026-02-02 16:55:32.559305+07	\N	7	\N	\N
219	132	415	t	2026-02-02 16:55:32.559305+07	\N	6	\N	\N
220	55	143	\N	2026-02-02 17:15:21.452216+07	\N	2	\N	\N
221	56	144	\N	2026-02-02 17:15:35.495111+07	\N	5	\N	\N
222	56	145	\N	2026-02-02 17:15:35.508893+07	\N	5	\N	\N
223	47	113	\N	2026-02-02 17:19:54.111499+07	\N	6	\N	\N
224	48	117	\N	2026-02-02 17:20:03.080053+07	\N	2	\N	\N
225	47	114	\N	2026-02-02 17:20:24.568235+07	\N	2	\N	\N
226	47	115	\N	2026-02-02 17:20:24.586424+07	\N	2	\N	\N
2436	166	515	\N	2026-03-08 16:53:45.346276+07	\N	1	\N	\N
2447	133	417	\N	2026-03-08 16:58:43.404422+07	\N	0	\N	\N
229	47	114	\N	2026-02-02 17:26:37.473299+07	\N	2	\N	\N
230	47	115	\N	2026-02-02 17:26:37.5025+07	\N	2	\N	\N
231	48	116	\N	2026-02-02 17:26:47.314653+07	\N	3	\N	\N
232	47	113	\N	2026-02-02 17:27:10.140237+07	\N	2	\N	\N
233	47	114	\N	2026-02-02 17:27:10.175499+07	\N	2	\N	\N
234	48	117	\N	2026-02-02 17:27:17.161407+07	\N	1	\N	\N
235	47	114	\N	2026-02-02 17:27:31.848176+07	\N	2	\N	\N
236	47	113	\N	2026-02-02 17:27:31.862281+07	\N	2	\N	\N
237	48	117	\N	2026-02-02 17:27:34.664687+07	\N	0	\N	\N
238	48	117	\N	2026-02-02 17:28:27.027401+07	\N	3	\N	\N
239	46	112	\N	2026-02-02 17:41:43.952819+07	\N	2	\N	\N
240	25	60	\N	2026-02-02 17:42:20.357598+07	\N	2	\N	\N
241	24	57	\N	2026-02-02 17:51:42.194349+07	\N	9	\N	\N
242	25	60	\N	2026-02-02 17:51:51.082095+07	\N	3	\N	\N
243	26	61	\N	2026-02-02 17:51:55.43797+07	\N	1	\N	\N
244	24	58	\N	2026-02-02 17:54:18.679849+07	\N	2	\N	\N
245	45	109	\N	2026-02-02 18:02:01.896663+07	\N	3	\N	\N
246	46	112	\N	2026-02-02 18:02:08.038008+07	\N	3	\N	\N
247	55	143	\N	2026-02-02 18:03:23.191956+07	\N	2	\N	\N
248	56	145	\N	2026-02-02 18:03:27.453074+07	\N	1	\N	\N
249	56	146	\N	2026-02-02 18:03:41.564539+07	\N	1	\N	\N
250	56	145	\N	2026-02-02 18:04:38.559277+07	\N	1	\N	\N
251	55	143	\N	2026-02-02 18:04:52.856596+07	\N	3	\N	\N
252	56	145	\N	2026-02-02 18:04:55.678679+07	\N	1	\N	\N
253	56	145	\N	2026-02-02 18:16:16.359242+07	\N	1	\N	\N
254	56	146	\N	2026-02-02 18:20:40.974811+07	\N	2	\N	\N
255	55	143	\N	2026-02-02 18:20:54.397113+07	\N	1	\N	\N
256	56	145	\N	2026-02-02 18:20:57.803333+07	\N	1	\N	\N
257	56	145	\N	2026-02-02 18:27:15.368277+07	\N	4	\N	\N
258	56	146	\N	2026-02-02 18:27:15.39959+07	\N	4	\N	\N
259	45	108	\N	2026-02-02 18:27:27.405206+07	\N	1	\N	\N
260	46	111	\N	2026-02-02 18:27:29.526699+07	\N	0	\N	\N
261	56	145	\N	2026-02-02 18:34:38.109393+07	\N	6	\N	\N
262	56	146	\N	2026-02-02 18:34:38.149461+07	\N	6	\N	\N
263	55	142	\N	2026-02-02 18:35:18.892842+07	\N	6	\N	\N
264	56	145	\N	2026-02-02 18:35:22.868699+07	\N	1	\N	\N
265	55	143	\N	2026-02-02 18:35:52.993+07	\N	13	\N	\N
266	56	144	\N	2026-02-02 18:35:56.7027+07	\N	1	\N	\N
267	56	145	\N	2026-02-02 18:35:56.72015+07	\N	1	\N	\N
268	45	109	\N	2026-02-02 18:37:35.765058+07	\N	2	\N	\N
269	55	142	\N	2026-02-02 18:43:38.839377+07	\N	5	\N	\N
270	55	143	\N	2026-02-02 18:43:42.285833+07	\N	8	\N	\N
271	55	142	\N	2026-02-02 18:52:04.771271+07	\N	2	\N	\N
272	55	142	\N	2026-02-04 14:17:38.587999+07	\N	2	\N	\N
273	55	142	\N	2026-02-04 14:20:03.040699+07	\N	3	\N	\N
274	55	143	\N	2026-02-04 14:20:05.022946+07	\N	5	\N	\N
275	56	145	\N	2026-02-04 14:20:25.868296+07	\N	9	\N	\N
276	55	142	\N	2026-02-04 14:21:02.81619+07	\N	5	\N	\N
277	55	143	\N	2026-02-04 14:21:04.499463+07	\N	6	\N	\N
278	56	144	\N	2026-02-04 14:21:21.447296+07	\N	5	\N	\N
279	56	145	\N	2026-02-04 14:21:21.498362+07	\N	5	\N	\N
280	55	143	\N	2026-02-04 14:21:50.34338+07	\N	2	\N	\N
281	56	145	\N	2026-02-04 14:22:12.357329+07	\N	3	\N	\N
282	56	145	\N	2026-02-04 14:22:12.445764+07	\N	4	\N	\N
283	56	146	\N	2026-02-04 14:22:59.548133+07	\N	1	\N	\N
284	56	145	\N	2026-02-04 15:03:06.59471+07	\N	3	\N	\N
285	55	142	\N	2026-02-04 15:10:34.667631+07	\N	3	\N	\N
286	56	146	\N	2026-02-04 15:10:38.722425+07	\N	2	\N	\N
287	56	145	\N	2026-02-04 15:10:38.753236+07	\N	2	\N	\N
288	45	109	\N	2026-02-04 15:11:17.907625+07	\N	3	\N	\N
289	55	142	\N	2026-02-04 15:12:09.154763+07	\N	3	\N	\N
290	55	142	\N	2026-02-04 15:12:42.391453+07	\N	1	\N	\N
291	56	146	\N	2026-02-04 15:12:44.788045+07	\N	1	\N	\N
292	55	143	\N	2026-02-04 15:12:57.66409+07	\N	2	\N	\N
293	55	143	\N	2026-02-04 15:23:04.199195+07	\N	7	\N	\N
294	56	146	\N	2026-02-04 15:23:07.20788+07	\N	1	\N	\N
295	55	143	\N	2026-02-04 15:32:53.03318+07	\N	2	\N	\N
296	55	142	\N	2026-02-04 15:51:07.43842+07	\N	5	\N	\N
297	56	146	\N	2026-02-04 15:51:12.546555+07	\N	1	\N	\N
298	55	143	\N	2026-02-04 15:56:12.385899+07	\N	116	\N	\N
299	56	146	\N	2026-02-04 15:56:15.676417+07	\N	1	\N	\N
300	130	408	t	2026-02-09 13:53:53.660227+07	\N	5	\N	\N
301	130	409	f	2026-02-09 13:53:53.660227+07	\N	6	\N	\N
302	130	408	t	2026-02-09 13:53:53.660227+07	\N	4	\N	\N
303	130	410	f	2026-02-09 13:53:53.660227+07	\N	7	\N	\N
304	130	408	t	2026-02-09 13:53:53.660227+07	\N	6	\N	\N
305	130	409	f	2026-02-09 13:53:53.660227+07	\N	5	\N	\N
306	130	408	t	2026-02-09 13:53:53.660227+07	\N	4	\N	\N
307	130	410	f	2026-02-09 13:53:53.660227+07	\N	6	\N	\N
308	130	408	t	2026-02-09 13:53:53.660227+07	\N	5	\N	\N
309	130	409	f	2026-02-09 13:53:53.660227+07	\N	7	\N	\N
310	131	411	t	2026-02-09 13:54:36.060681+07	1	8	\N	\N
311	131	412	t	2026-02-09 13:54:36.060681+07	2	8	\N	\N
312	131	413	t	2026-02-09 13:54:36.060681+07	3	8	\N	\N
313	131	411	t	2026-02-09 13:54:36.060681+07	1	9	\N	\N
314	131	413	f	2026-02-09 13:54:36.060681+07	2	9	\N	\N
315	131	412	f	2026-02-09 13:54:36.060681+07	3	9	\N	\N
316	131	411	t	2026-02-09 13:54:36.060681+07	1	10	\N	\N
317	131	412	t	2026-02-09 13:54:36.060681+07	3	10	\N	\N
318	131	413	t	2026-02-09 13:54:36.060681+07	2	10	\N	\N
319	131	412	f	2026-02-09 13:54:36.060681+07	1	12	\N	\N
320	131	411	f	2026-02-09 13:54:36.060681+07	2	12	\N	\N
321	131	413	t	2026-02-09 13:54:36.060681+07	3	12	\N	\N
322	131	411	t	2026-02-09 13:54:36.060681+07	1	15	\N	\N
323	131	412	t	2026-02-09 13:54:36.060681+07	2	15	\N	\N
324	131	413	t	2026-02-09 13:54:36.060681+07	3	15	\N	\N
325	131	411	t	2026-02-09 13:54:36.060681+07	1	6	\N	\N
326	131	412	t	2026-02-09 13:54:36.060681+07	2	6	\N	\N
327	131	413	t	2026-02-09 13:54:36.060681+07	3	6	\N	\N
328	131	412	f	2026-02-09 13:54:36.060681+07	1	9	\N	\N
329	131	411	f	2026-02-09 13:54:36.060681+07	2	9	\N	\N
330	131	413	t	2026-02-09 13:54:36.060681+07	3	9	\N	\N
331	131	411	t	2026-02-09 13:54:36.060681+07	1	10	\N	\N
332	131	412	t	2026-02-09 13:54:36.060681+07	2	10	\N	\N
333	131	413	f	2026-02-09 13:54:36.060681+07	3	10	\N	\N
334	131	413	f	2026-02-09 13:54:36.060681+07	1	11	\N	\N
335	131	411	f	2026-02-09 13:54:36.060681+07	2	11	\N	\N
336	131	412	f	2026-02-09 13:54:36.060681+07	3	11	\N	\N
337	131	411	t	2026-02-09 13:54:36.060681+07	1	18	\N	\N
338	131	412	t	2026-02-09 13:54:36.060681+07	2	18	\N	\N
339	131	413	t	2026-02-09 13:54:36.060681+07	3	18	\N	\N
340	132	415	t	2026-02-09 13:54:55.394808+07	\N	4	\N	\N
341	132	414	f	2026-02-09 13:54:55.394808+07	\N	6	\N	\N
342	132	415	t	2026-02-09 13:54:55.394808+07	\N	5	\N	\N
343	132	414	f	2026-02-09 13:54:55.394808+07	\N	7	\N	\N
344	132	415	t	2026-02-09 13:54:55.394808+07	\N	6	\N	\N
345	132	415	t	2026-02-09 13:54:55.394808+07	\N	4	\N	\N
346	132	414	f	2026-02-09 13:54:55.394808+07	\N	6	\N	\N
347	132	415	t	2026-02-09 13:54:55.394808+07	\N	5	\N	\N
348	132	414	f	2026-02-09 13:54:55.394808+07	\N	7	\N	\N
349	132	415	t	2026-02-09 13:54:55.394808+07	\N	6	\N	\N
350	130	408	t	2026-02-09 13:56:45.42893+07	\N	5	\N	\N
351	130	409	f	2026-02-09 13:56:45.42893+07	\N	6	\N	\N
352	130	408	t	2026-02-09 13:56:45.42893+07	\N	4	\N	\N
353	130	410	f	2026-02-09 13:56:45.42893+07	\N	7	\N	\N
354	130	408	t	2026-02-09 13:56:45.42893+07	\N	6	\N	\N
355	130	409	f	2026-02-09 13:56:45.42893+07	\N	5	\N	\N
356	130	408	t	2026-02-09 13:56:45.42893+07	\N	4	\N	\N
357	130	410	f	2026-02-09 13:56:45.42893+07	\N	6	\N	\N
358	130	408	t	2026-02-09 13:56:45.42893+07	\N	5	\N	\N
359	130	409	f	2026-02-09 13:56:45.42893+07	\N	7	\N	\N
360	130	408	t	2026-02-09 14:14:15.566862+07	\N	5	\N	\N
361	130	409	f	2026-02-09 14:14:15.566862+07	\N	6	\N	\N
362	130	408	t	2026-02-09 14:14:15.566862+07	\N	4	\N	\N
363	130	410	f	2026-02-09 14:14:15.566862+07	\N	7	\N	\N
364	130	408	t	2026-02-09 14:14:15.566862+07	\N	6	\N	\N
365	130	409	f	2026-02-09 14:14:15.566862+07	\N	5	\N	\N
366	130	408	t	2026-02-09 14:14:15.566862+07	\N	4	\N	\N
367	130	410	f	2026-02-09 14:14:15.566862+07	\N	6	\N	\N
368	130	408	t	2026-02-09 14:14:15.566862+07	\N	5	\N	\N
369	130	409	f	2026-02-09 14:14:15.566862+07	\N	7	\N	\N
370	55	142	\N	2026-02-09 14:29:57.322073+07	\N	3	\N	\N
371	56	146	\N	2026-02-09 14:30:03.98039+07	\N	4	\N	\N
372	130	408	t	2026-02-09 14:33:42.20575+07	\N	5	\N	\N
373	130	409	f	2026-02-09 14:33:42.20575+07	\N	6	\N	\N
374	130	408	t	2026-02-09 14:33:42.20575+07	\N	4	\N	\N
375	130	410	f	2026-02-09 14:33:42.20575+07	\N	7	\N	\N
376	130	408	t	2026-02-09 14:33:42.20575+07	\N	6	\N	\N
377	130	409	f	2026-02-09 14:33:42.20575+07	\N	5	\N	\N
378	130	408	t	2026-02-09 14:33:42.20575+07	\N	4	\N	\N
379	130	410	f	2026-02-09 14:33:42.20575+07	\N	6	\N	\N
380	130	408	t	2026-02-09 14:33:42.20575+07	\N	5	\N	\N
381	130	409	f	2026-02-09 14:33:42.20575+07	\N	7	\N	\N
382	55	143	\N	2026-02-09 14:35:05.800067+07	\N	3	\N	\N
383	56	146	\N	2026-02-09 14:35:22.136249+07	\N	7	\N	\N
384	55	143	\N	2026-02-09 14:35:41.298809+07	\N	1	\N	\N
385	131	411	t	2026-02-09 14:37:58.475713+07	1	8	\N	\N
386	131	412	t	2026-02-09 14:37:58.475713+07	2	8	\N	\N
387	131	413	t	2026-02-09 14:37:58.475713+07	3	8	\N	\N
388	131	411	t	2026-02-09 14:37:58.475713+07	1	9	\N	\N
389	131	413	f	2026-02-09 14:37:58.475713+07	2	9	\N	\N
390	131	412	f	2026-02-09 14:37:58.475713+07	3	9	\N	\N
391	131	411	t	2026-02-09 14:37:58.475713+07	1	10	\N	\N
392	131	412	t	2026-02-09 14:37:58.475713+07	3	10	\N	\N
393	131	413	t	2026-02-09 14:37:58.475713+07	2	10	\N	\N
394	131	412	f	2026-02-09 14:37:58.475713+07	1	12	\N	\N
395	131	411	f	2026-02-09 14:37:58.475713+07	2	12	\N	\N
396	131	413	t	2026-02-09 14:37:58.475713+07	3	12	\N	\N
397	131	411	t	2026-02-09 14:37:58.475713+07	1	15	\N	\N
398	131	412	t	2026-02-09 14:37:58.475713+07	2	15	\N	\N
399	131	413	t	2026-02-09 14:37:58.475713+07	3	15	\N	\N
400	132	415	t	2026-02-09 14:37:58.475713+07	\N	4	\N	\N
401	132	414	f	2026-02-09 14:37:58.475713+07	\N	6	\N	\N
402	132	415	t	2026-02-09 14:37:58.475713+07	\N	5	\N	\N
403	132	414	f	2026-02-09 14:37:58.475713+07	\N	7	\N	\N
404	132	415	t	2026-02-09 14:37:58.475713+07	\N	6	\N	\N
405	55	143	\N	2026-02-09 14:53:14.118005+07	\N	1	\N	\N
406	55	143	\N	2026-02-09 14:56:06.042681+07	\N	2	\N	\N
407	55	143	\N	2026-02-09 14:57:45.893707+07	\N	2	\N	\N
408	55	143	\N	2026-02-09 14:58:04.074036+07	\N	2	\N	\N
409	55	143	\N	2026-02-09 15:05:50.625219+07	\N	2	\N	\N
411	55	143	\N	2026-02-09 15:14:33.426644+07	\N	2	\N	\N
412	55	143	\N	2026-02-09 15:17:06.984351+07	\N	2	\N	\N
413	55	143	\N	2026-02-09 15:55:55.96578+07	\N	1	\N	\N
418	130	408	t	2026-02-09 16:05:57.370162+07	\N	5	\N	\N
419	130	409	f	2026-02-09 16:05:57.370162+07	\N	6	\N	\N
420	130	408	t	2026-02-09 16:05:57.370162+07	\N	4	\N	\N
421	130	410	f	2026-02-09 16:05:57.370162+07	\N	7	\N	\N
422	130	408	t	2026-02-09 16:05:57.370162+07	\N	6	\N	\N
423	131	411	t	2026-02-09 16:05:57.370162+07	1	8	\N	\N
424	131	412	t	2026-02-09 16:05:57.370162+07	2	8	\N	\N
425	131	413	t	2026-02-09 16:05:57.370162+07	3	8	\N	\N
426	131	411	t	2026-02-09 16:05:57.370162+07	1	9	\N	\N
427	131	413	f	2026-02-09 16:05:57.370162+07	2	9	\N	\N
428	131	412	f	2026-02-09 16:05:57.370162+07	3	9	\N	\N
429	131	411	t	2026-02-09 16:05:57.370162+07	1	10	\N	\N
430	131	412	t	2026-02-09 16:05:57.370162+07	3	10	\N	\N
431	131	413	t	2026-02-09 16:05:57.370162+07	2	10	\N	\N
432	131	412	f	2026-02-09 16:05:57.370162+07	1	12	\N	\N
433	131	411	f	2026-02-09 16:05:57.370162+07	2	12	\N	\N
434	131	413	t	2026-02-09 16:05:57.370162+07	3	12	\N	\N
435	131	411	t	2026-02-09 16:05:57.370162+07	1	15	\N	\N
436	131	412	t	2026-02-09 16:05:57.370162+07	2	15	\N	\N
437	131	413	t	2026-02-09 16:05:57.370162+07	3	15	\N	\N
438	132	415	t	2026-02-09 16:05:57.370162+07	\N	4	\N	\N
439	132	414	f	2026-02-09 16:05:57.370162+07	\N	6	\N	\N
440	132	415	t	2026-02-09 16:05:57.370162+07	\N	5	\N	\N
441	132	414	f	2026-02-09 16:05:57.370162+07	\N	7	\N	\N
442	132	415	t	2026-02-09 16:05:57.370162+07	\N	6	\N	\N
446	56	145	\N	2026-02-09 16:08:56.679086+07	\N	1	\N	\N
447	55	143	\N	2026-02-09 16:11:58.963012+07	\N	2	\N	\N
448	56	146	\N	2026-02-09 16:12:01.504879+07	\N	0	\N	\N
449	55	143	\N	2026-02-09 16:12:14.073819+07	\N	1	\N	\N
450	56	146	\N	2026-02-09 16:12:22.4848+07	\N	1	\N	\N
451	55	143	\N	2026-02-09 16:19:53.730807+07	\N	1	\N	\N
452	56	146	\N	2026-02-09 16:19:55.938346+07	\N	0	\N	\N
453	130	408	t	2026-02-09 16:27:19.342051+07	\N	5	\N	\N
454	130	409	f	2026-02-09 16:27:19.342051+07	\N	6	\N	\N
455	130	408	t	2026-02-09 16:27:19.342051+07	\N	4	\N	\N
456	130	410	f	2026-02-09 16:27:19.342051+07	\N	7	\N	\N
457	130	408	t	2026-02-09 16:27:19.342051+07	\N	6	\N	\N
458	131	411	t	2026-02-09 16:27:19.342051+07	1	8	\N	\N
459	131	412	t	2026-02-09 16:27:19.342051+07	2	8	\N	\N
460	131	413	t	2026-02-09 16:27:19.342051+07	3	8	\N	\N
461	131	411	t	2026-02-09 16:27:19.342051+07	1	9	\N	\N
462	131	413	f	2026-02-09 16:27:19.342051+07	2	9	\N	\N
463	131	412	f	2026-02-09 16:27:19.342051+07	3	9	\N	\N
464	131	411	t	2026-02-09 16:27:19.342051+07	1	10	\N	\N
465	131	412	t	2026-02-09 16:27:19.342051+07	3	10	\N	\N
466	131	413	t	2026-02-09 16:27:19.342051+07	2	10	\N	\N
467	131	412	f	2026-02-09 16:27:19.342051+07	1	12	\N	\N
468	131	411	f	2026-02-09 16:27:19.342051+07	2	12	\N	\N
469	131	413	t	2026-02-09 16:27:19.342051+07	3	12	\N	\N
470	131	411	t	2026-02-09 16:27:19.342051+07	1	15	\N	\N
471	131	412	t	2026-02-09 16:27:19.342051+07	2	15	\N	\N
472	131	413	t	2026-02-09 16:27:19.342051+07	3	15	\N	\N
473	132	415	t	2026-02-09 16:27:19.342051+07	\N	4	\N	\N
474	132	414	f	2026-02-09 16:27:19.342051+07	\N	6	\N	\N
475	132	415	t	2026-02-09 16:27:19.342051+07	\N	5	\N	\N
476	132	414	f	2026-02-09 16:27:19.342051+07	\N	7	\N	\N
477	132	415	t	2026-02-09 16:27:19.342051+07	\N	6	\N	\N
478	130	408	t	2026-02-09 17:25:08.876928+07	\N	5	\N	\N
479	130	409	f	2026-02-09 17:25:08.876928+07	\N	6	\N	\N
480	130	408	t	2026-02-09 17:25:08.876928+07	\N	4	\N	\N
481	130	410	f	2026-02-09 17:25:08.876928+07	\N	7	\N	\N
482	130	408	t	2026-02-09 17:25:08.876928+07	\N	6	\N	\N
483	131	411	t	2026-02-09 17:25:08.876928+07	1	8	\N	\N
484	131	412	t	2026-02-09 17:25:08.876928+07	2	8	\N	\N
485	131	413	t	2026-02-09 17:25:08.876928+07	3	8	\N	\N
486	131	411	t	2026-02-09 17:25:08.876928+07	1	9	\N	\N
487	131	413	f	2026-02-09 17:25:08.876928+07	2	9	\N	\N
488	131	412	f	2026-02-09 17:25:08.876928+07	3	9	\N	\N
489	131	411	t	2026-02-09 17:25:08.876928+07	1	10	\N	\N
490	131	412	t	2026-02-09 17:25:08.876928+07	3	10	\N	\N
491	131	413	t	2026-02-09 17:25:08.876928+07	2	10	\N	\N
492	131	412	f	2026-02-09 17:25:08.876928+07	1	12	\N	\N
493	131	411	f	2026-02-09 17:25:08.876928+07	2	12	\N	\N
494	131	413	t	2026-02-09 17:25:08.876928+07	3	12	\N	\N
495	131	411	t	2026-02-09 17:25:08.876928+07	1	15	\N	\N
496	131	412	t	2026-02-09 17:25:08.876928+07	2	15	\N	\N
497	131	413	t	2026-02-09 17:25:08.876928+07	3	15	\N	\N
498	132	415	t	2026-02-09 17:25:08.876928+07	\N	4	\N	\N
499	132	414	f	2026-02-09 17:25:08.876928+07	\N	6	\N	\N
500	132	415	t	2026-02-09 17:25:08.876928+07	\N	5	\N	\N
501	132	414	f	2026-02-09 17:25:08.876928+07	\N	7	\N	\N
502	132	415	t	2026-02-09 17:25:08.876928+07	\N	6	\N	\N
503	55	143	\N	2026-02-09 17:35:26.852845+07	\N	3	\N	\N
504	56	145	\N	2026-02-09 17:35:29.28731+07	\N	1	\N	\N
505	55	143	\N	2026-02-09 17:47:08.005186+07	\N	1	\N	\N
506	56	144	\N	2026-02-09 17:47:12.522232+07	\N	1	\N	\N
508	130	410	\N	2026-02-09 18:04:55.627133+07	\N	2	\N	\N
509	130	408	\N	2026-02-09 18:05:48.553182+07	\N	6	\N	\N
510	130	410	\N	2026-02-09 18:12:11.346788+07	\N	1	\N	\N
511	130	410	\N	2026-02-09 18:16:29.776231+07	\N	1	\N	\N
512	130	409	\N	2026-02-09 18:20:25.62083+07	\N	1	\N	\N
513	55	143	\N	2026-02-09 18:53:14.680177+07	\N	1	\N	\N
514	56	145	\N	2026-02-09 18:53:20.792937+07	\N	1	\N	\N
515	55	143	\N	2026-02-09 19:27:20.304366+07	\N	1	\N	\N
516	56	146	\N	2026-02-09 19:27:26.700498+07	\N	1	\N	\N
518	56	146	\N	2026-02-09 19:31:26.126616+07	\N	1	\N	\N
519	55	142	\N	2026-02-09 19:31:41.84406+07	\N	6	\N	\N
520	55	143	\N	2026-02-09 19:32:19.75904+07	\N	1	\N	\N
521	56	145	\N	2026-02-09 19:32:22.003649+07	\N	1	\N	\N
522	130	409	\N	2026-02-09 19:32:37.777386+07	\N	1	\N	\N
523	130	410	\N	2026-02-09 19:34:59.532579+07	\N	2	\N	\N
524	130	410	\N	2026-02-09 19:35:20.726047+07	\N	1	\N	\N
525	130	410	\N	2026-02-09 19:35:44.029606+07	\N	4	\N	\N
526	130	408	\N	2026-02-09 19:41:23.111746+07	\N	1	\N	\N
527	132	414	\N	2026-02-09 19:41:45.741089+07	\N	2	\N	\N
528	55	142	\N	2026-02-09 19:42:04.664083+07	\N	1	\N	\N
529	56	145	\N	2026-02-09 19:42:10.806112+07	\N	2	\N	\N
530	55	143	\N	2026-02-09 19:42:59.774953+07	\N	1	\N	\N
531	56	145	\N	2026-02-09 19:43:02.801863+07	\N	1	\N	\N
2437	133	417	\N	2026-03-08 16:56:35.467803+07	\N	1	\N	\N
533	56	145	\N	2026-02-09 19:43:19.673033+07	\N	1	\N	\N
534	55	143	\N	2026-02-10 09:10:20.193812+07	\N	3	\N	\N
535	56	145	\N	2026-02-10 09:10:28.563733+07	\N	2	\N	\N
536	55	142	\N	2026-02-10 09:11:01.612087+07	\N	8	\N	\N
537	56	145	\N	2026-02-10 09:11:10.287543+07	\N	2	\N	\N
538	55	143	\N	2026-02-10 09:11:29.565781+07	\N	1	\N	\N
539	56	145	\N	2026-02-10 09:11:33.043343+07	\N	1	\N	\N
540	55	142	\N	2026-02-10 09:11:56.889993+07	\N	2	\N	\N
541	56	146	\N	2026-02-10 09:12:01.601901+07	\N	2	\N	\N
542	56	145	\N	2026-02-10 09:12:01.617644+07	\N	2	\N	\N
543	55	143	\N	2026-02-10 09:12:23.310336+07	\N	2	\N	\N
544	56	144	\N	2026-02-10 09:12:30.683305+07	\N	2	\N	\N
545	56	145	\N	2026-02-10 09:12:30.785895+07	\N	2	\N	\N
546	55	143	f	2026-02-10 09:35:24.88647+07	\N	1	\N	\N
547	56	146	f	2026-02-10 09:35:55.243731+07	\N	2	\N	\N
548	56	145	f	2026-02-10 09:35:55.342293+07	\N	2	\N	\N
549	55	143	f	2026-02-10 09:44:19.215695+07	\N	3	\N	\N
550	56	146	f	2026-02-10 09:44:26.736972+07	\N	2	\N	\N
551	56	145	f	2026-02-10 09:44:26.771983+07	\N	2	\N	\N
552	55	142	f	2026-02-10 09:56:12.312473+07	\N	2	\N	\N
553	56	145	f	2026-02-10 09:56:20.202786+07	\N	2	\N	\N
554	55	143	f	2026-02-10 09:58:40.542661+07	\N	2	\N	\N
555	55	142	f	2026-02-10 10:10:10.567104+07	\N	2	\N	\N
556	56	146	f	2026-02-10 10:10:32.909486+07	\N	2	\N	\N
557	56	145	f	2026-02-10 10:10:32.993099+07	\N	2	\N	\N
2439	135	427	\N	2026-03-08 16:56:39.392969+07	\N	0	\N	\N
559	130	409	f	2026-02-10 10:24:44.267655+07	\N	1	\N	\N
2448	133	417	\N	2026-03-08 17:09:03.731989+07	\N	1	\N	\N
561	132	415	t	2026-02-10 10:27:36.244235+07	\N	1	\N	\N
562	130	408	t	2026-02-10 10:27:54.856284+07	\N	14	\N	\N
563	130	409	f	2026-02-10 10:35:54.021749+07	\N	2	\N	\N
564	130	410	f	2026-02-10 10:36:49.423496+07	\N	2	\N	\N
565	130	410	f	2026-02-10 10:38:30.044436+07	\N	1	\N	\N
566	130	409	f	2026-02-10 10:39:04.262196+07	\N	1	\N	\N
567	130	410	f	2026-02-10 10:39:25.994341+07	\N	1	\N	\N
2450	135	427	\N	2026-03-08 17:09:07.75402+07	\N	1	\N	\N
569	132	415	t	2026-02-10 10:40:13.501152+07	\N	1	\N	\N
570	130	408	t	2026-02-10 11:14:10.449487+07	\N	5	\N	\N
571	130	409	f	2026-02-10 11:14:10.449487+07	\N	6	\N	\N
572	130	408	t	2026-02-10 11:14:10.449487+07	\N	4	\N	\N
573	130	410	f	2026-02-10 11:14:10.449487+07	\N	7	\N	\N
574	130	408	t	2026-02-10 11:14:10.449487+07	\N	6	\N	\N
575	130	409	f	2026-02-10 11:14:10.449487+07	\N	5	\N	\N
576	130	408	t	2026-02-10 11:14:10.449487+07	\N	4	\N	\N
577	130	410	f	2026-02-10 11:14:10.449487+07	\N	6	\N	\N
578	130	408	t	2026-02-10 11:14:10.449487+07	\N	5	\N	\N
579	130	409	f	2026-02-10 11:14:10.449487+07	\N	7	\N	\N
580	131	411	t	2026-02-10 11:14:10.449487+07	1	8	\N	\N
581	131	412	t	2026-02-10 11:14:10.449487+07	2	8	\N	\N
582	131	413	t	2026-02-10 11:14:10.449487+07	3	8	\N	\N
583	131	411	t	2026-02-10 11:14:10.449487+07	1	9	\N	\N
584	131	413	f	2026-02-10 11:14:10.449487+07	2	9	\N	\N
585	131	412	f	2026-02-10 11:14:10.449487+07	3	9	\N	\N
586	131	411	t	2026-02-10 11:14:10.449487+07	1	10	\N	\N
587	131	412	t	2026-02-10 11:14:10.449487+07	3	10	\N	\N
588	131	413	t	2026-02-10 11:14:10.449487+07	2	10	\N	\N
589	131	412	f	2026-02-10 11:14:10.449487+07	1	12	\N	\N
590	131	411	f	2026-02-10 11:14:10.449487+07	2	12	\N	\N
591	131	413	t	2026-02-10 11:14:10.449487+07	3	12	\N	\N
592	131	411	t	2026-02-10 11:14:10.449487+07	1	15	\N	\N
593	131	412	t	2026-02-10 11:14:10.449487+07	2	15	\N	\N
594	131	413	t	2026-02-10 11:14:10.449487+07	3	15	\N	\N
595	131	411	t	2026-02-10 11:14:10.449487+07	1	6	\N	\N
596	131	412	t	2026-02-10 11:14:10.449487+07	2	6	\N	\N
597	131	413	t	2026-02-10 11:14:10.449487+07	3	6	\N	\N
598	131	412	f	2026-02-10 11:14:10.449487+07	1	9	\N	\N
599	131	411	f	2026-02-10 11:14:10.449487+07	2	9	\N	\N
600	131	413	t	2026-02-10 11:14:10.449487+07	3	9	\N	\N
601	131	411	t	2026-02-10 11:14:10.449487+07	1	10	\N	\N
602	131	412	t	2026-02-10 11:14:10.449487+07	2	10	\N	\N
603	131	413	f	2026-02-10 11:14:10.449487+07	3	10	\N	\N
604	131	413	f	2026-02-10 11:14:10.449487+07	1	11	\N	\N
605	131	412	f	2026-02-10 11:14:10.449487+07	2	11	\N	\N
606	131	411	f	2026-02-10 11:14:10.449487+07	3	11	\N	\N
607	131	411	t	2026-02-10 11:14:10.449487+07	1	9	\N	\N
608	131	412	t	2026-02-10 11:14:10.449487+07	2	9	\N	\N
609	131	413	t	2026-02-10 11:14:10.449487+07	3	9	\N	\N
610	132	415	t	2026-02-10 11:14:10.449487+07	\N	4	\N	\N
611	132	414	f	2026-02-10 11:14:10.449487+07	\N	6	\N	\N
612	132	415	t	2026-02-10 11:14:10.449487+07	\N	5	\N	\N
613	132	414	f	2026-02-10 11:14:10.449487+07	\N	7	\N	\N
614	132	415	t	2026-02-10 11:14:10.449487+07	\N	6	\N	\N
615	132	415	t	2026-02-10 11:14:10.449487+07	\N	4	\N	\N
616	132	414	f	2026-02-10 11:14:10.449487+07	\N	5	\N	\N
617	132	415	t	2026-02-10 11:14:10.449487+07	\N	6	\N	\N
618	132	414	f	2026-02-10 11:14:10.449487+07	\N	7	\N	\N
619	132	415	t	2026-02-10 11:14:10.449487+07	\N	5	\N	\N
620	130	408	t	2026-02-10 11:18:37.513253+07	\N	2	\N	\N
621	130	408	t	2026-02-10 11:19:18.505588+07	\N	5	\N	\N
622	130	409	f	2026-02-10 11:19:18.505588+07	\N	6	\N	\N
623	130	408	t	2026-02-10 11:19:18.505588+07	\N	4	\N	\N
624	130	410	f	2026-02-10 11:19:18.505588+07	\N	7	\N	\N
625	130	408	t	2026-02-10 11:19:18.505588+07	\N	6	\N	\N
626	130	409	f	2026-02-10 11:19:18.505588+07	\N	5	\N	\N
627	130	408	t	2026-02-10 11:19:18.505588+07	\N	4	\N	\N
628	130	410	f	2026-02-10 11:19:18.505588+07	\N	6	\N	\N
629	130	408	t	2026-02-10 11:19:18.505588+07	\N	5	\N	\N
630	130	409	f	2026-02-10 11:19:18.505588+07	\N	7	\N	\N
631	131	411	t	2026-02-10 11:19:18.505588+07	1	8	\N	\N
2460	133	417	\N	2026-03-08 17:10:36.053223+07	\N	0	\N	\N
632	131	412	t	2026-02-10 11:19:18.505588+07	2	8	\N	\N
633	131	413	t	2026-02-10 11:19:18.505588+07	3	8	\N	\N
634	131	411	t	2026-02-10 11:19:18.505588+07	1	9	\N	\N
635	131	413	f	2026-02-10 11:19:18.505588+07	2	9	\N	\N
636	131	412	f	2026-02-10 11:19:18.505588+07	3	9	\N	\N
637	131	411	t	2026-02-10 11:19:18.505588+07	1	10	\N	\N
638	131	412	t	2026-02-10 11:19:18.505588+07	3	10	\N	\N
639	131	413	t	2026-02-10 11:19:18.505588+07	2	10	\N	\N
640	131	412	f	2026-02-10 11:19:18.505588+07	1	12	\N	\N
641	131	411	f	2026-02-10 11:19:18.505588+07	2	12	\N	\N
642	131	413	t	2026-02-10 11:19:18.505588+07	3	12	\N	\N
643	131	411	t	2026-02-10 11:19:18.505588+07	1	15	\N	\N
644	131	412	t	2026-02-10 11:19:18.505588+07	2	15	\N	\N
645	131	413	t	2026-02-10 11:19:18.505588+07	3	15	\N	\N
646	131	411	t	2026-02-10 11:19:18.505588+07	1	6	\N	\N
647	131	412	t	2026-02-10 11:19:18.505588+07	2	6	\N	\N
648	131	413	t	2026-02-10 11:19:18.505588+07	3	6	\N	\N
649	131	412	f	2026-02-10 11:19:18.505588+07	1	9	\N	\N
650	131	411	f	2026-02-10 11:19:18.505588+07	2	9	\N	\N
651	131	413	t	2026-02-10 11:19:18.505588+07	3	9	\N	\N
652	131	411	t	2026-02-10 11:19:18.505588+07	1	10	\N	\N
653	131	412	t	2026-02-10 11:19:18.505588+07	2	10	\N	\N
654	131	413	f	2026-02-10 11:19:18.505588+07	3	10	\N	\N
655	131	413	f	2026-02-10 11:19:18.505588+07	1	11	\N	\N
656	131	412	f	2026-02-10 11:19:18.505588+07	2	11	\N	\N
657	131	411	f	2026-02-10 11:19:18.505588+07	3	11	\N	\N
658	131	411	t	2026-02-10 11:19:18.505588+07	1	9	\N	\N
659	131	412	t	2026-02-10 11:19:18.505588+07	2	9	\N	\N
660	131	413	t	2026-02-10 11:19:18.505588+07	3	9	\N	\N
661	132	415	t	2026-02-10 11:19:18.505588+07	\N	4	\N	\N
662	132	414	f	2026-02-10 11:19:18.505588+07	\N	6	\N	\N
663	132	415	t	2026-02-10 11:19:18.505588+07	\N	5	\N	\N
664	132	414	f	2026-02-10 11:19:18.505588+07	\N	7	\N	\N
665	132	415	t	2026-02-10 11:19:18.505588+07	\N	6	\N	\N
666	132	415	t	2026-02-10 11:19:18.505588+07	\N	4	\N	\N
667	132	414	f	2026-02-10 11:19:18.505588+07	\N	5	\N	\N
668	132	415	t	2026-02-10 11:19:18.505588+07	\N	6	\N	\N
669	132	414	f	2026-02-10 11:19:18.505588+07	\N	7	\N	\N
670	132	415	t	2026-02-10 11:19:18.505588+07	\N	5	\N	\N
671	130	408	t	2026-02-10 11:19:40.493234+07	\N	4	\N	\N
672	130	409	f	2026-02-10 11:26:40.048745+07	\N	3	\N	\N
673	130	409	f	2026-02-10 11:36:15.632678+07	\N	1	\N	\N
674	131	411	\N	2026-02-10 11:36:19.365369+07	1	120	\N	\N
675	131	412	\N	2026-02-10 11:36:19.37929+07	2	120	\N	\N
676	131	413	\N	2026-02-10 11:36:19.395239+07	3	120	\N	\N
677	132	415	t	2026-02-10 11:36:22.897009+07	\N	1	\N	\N
678	130	408	t	2026-02-10 11:37:19.314882+07	\N	1	\N	\N
679	131	411	\N	2026-02-10 11:37:24.439063+07	1	120	\N	\N
680	131	412	\N	2026-02-10 11:37:24.458799+07	2	120	\N	\N
681	131	413	\N	2026-02-10 11:37:24.471561+07	3	120	\N	\N
682	132	415	t	2026-02-10 11:37:30.07759+07	\N	1	\N	\N
683	130	409	f	2026-02-10 11:47:06.009799+07	\N	1	\N	\N
684	131	411	\N	2026-02-10 11:47:10.654353+07	1	120	\N	\N
685	131	412	\N	2026-02-10 11:47:10.670468+07	2	120	\N	\N
686	131	413	\N	2026-02-10 11:47:10.689623+07	3	120	\N	\N
687	132	415	t	2026-02-10 11:47:26.436842+07	\N	1	\N	\N
688	130	408	t	2026-02-10 11:50:46.156304+07	\N	1	\N	\N
689	131	411	\N	2026-02-10 11:50:50.516172+07	1	180	\N	\N
690	131	412	\N	2026-02-10 11:50:50.534796+07	2	180	\N	\N
691	131	413	\N	2026-02-10 11:50:50.553504+07	3	180	\N	\N
692	132	415	t	2026-02-10 11:50:54.376941+07	\N	1	\N	\N
693	130	409	f	2026-02-10 11:53:36.331012+07	\N	3	\N	\N
694	131	411	\N	2026-02-10 11:53:43.214851+07	1	120	\N	\N
695	131	412	\N	2026-02-10 11:53:43.235735+07	2	120	\N	\N
696	131	413	\N	2026-02-10 11:53:43.24956+07	3	120	\N	\N
697	132	415	t	2026-02-10 11:53:49.217429+07	\N	1	\N	\N
698	130	409	f	2026-02-10 11:56:07.893764+07	\N	1	\N	\N
699	131	411	\N	2026-02-10 11:56:12.979443+07	1	120	\N	\N
700	131	412	\N	2026-02-10 11:56:12.99743+07	2	120	\N	\N
701	131	413	\N	2026-02-10 11:56:13.016377+07	3	120	\N	\N
702	132	415	t	2026-02-10 11:56:24.539365+07	\N	1	\N	\N
703	130	409	f	2026-02-10 11:58:36.17779+07	\N	2	\N	\N
704	131	411	\N	2026-02-10 11:58:46.729988+07	1	120	\N	\N
705	131	412	\N	2026-02-10 11:58:46.776194+07	2	120	\N	\N
706	131	413	\N	2026-02-10 11:58:46.797493+07	3	120	\N	\N
707	130	408	t	2026-02-11 13:41:34.186656+07	\N	2	\N	\N
708	131	411	\N	2026-02-11 13:41:41.993044+07	1	120	\N	\N
709	131	412	\N	2026-02-11 13:41:42.01589+07	2	120	\N	\N
710	131	413	\N	2026-02-11 13:41:42.028749+07	3	120	\N	\N
711	55	143	f	2026-02-11 14:03:59.439414+07	\N	2	\N	\N
712	130	409	f	2026-02-11 14:04:22.337764+07	\N	1	\N	\N
713	131	411	\N	2026-02-11 14:04:30.891612+07	1	120	\N	\N
714	131	412	\N	2026-02-11 14:04:30.906136+07	2	120	\N	\N
715	131	413	\N	2026-02-11 14:04:30.920695+07	3	120	\N	\N
716	130	408	\N	2026-02-11 14:41:17.608816+07	\N	4	\N	\N
717	56	145	\N	2026-02-11 14:42:08.712401+07	\N	1	\N	\N
718	130	408	\N	2026-02-11 14:42:33.48557+07	\N	3	\N	\N
719	132	415	\N	2026-02-11 14:42:57.06632+07	\N	1	\N	\N
720	130	408	\N	2026-02-11 14:43:34.792488+07	\N	4	\N	\N
721	132	415	\N	2026-02-11 14:43:48.522778+07	\N	1	\N	\N
722	130	408	\N	2026-02-11 15:12:21.613124+07	\N	4	\N	\N
723	131	411	\N	2026-02-11 15:12:30.364318+07	1	120	\N	\N
724	131	412	\N	2026-02-11 15:12:30.376181+07	2	120	\N	\N
725	131	413	\N	2026-02-11 15:12:30.39219+07	3	120	\N	\N
726	132	414	\N	2026-02-11 15:12:33.996384+07	\N	1	\N	\N
727	130	408	\N	2026-02-11 15:15:54.546759+07	\N	2	\N	\N
728	131	411	\N	2026-02-11 15:16:04.17105+07	1	30	\N	\N
729	131	412	\N	2026-02-11 15:16:04.184565+07	2	30	\N	\N
730	131	413	\N	2026-02-11 15:16:04.198418+07	3	30	\N	\N
731	132	415	\N	2026-02-11 15:16:13.209451+07	\N	2	\N	\N
732	130	409	\N	2026-02-11 15:52:01.335161+07	\N	2	\N	\N
733	131	411	\N	2026-02-11 15:52:11.485755+07	1	14	\N	\N
734	131	412	\N	2026-02-11 15:52:11.505788+07	2	14	\N	\N
735	131	413	\N	2026-02-11 15:52:11.522665+07	3	14	\N	\N
736	132	415	\N	2026-02-11 15:52:20.266712+07	\N	1	\N	\N
737	130	409	\N	2026-02-11 15:54:40.996431+07	\N	2	\N	\N
738	130	408	\N	2026-02-11 15:54:57.33776+07	\N	2	\N	\N
739	131	411	\N	2026-02-11 15:55:09.99521+07	1	15	\N	\N
740	131	412	\N	2026-02-11 15:55:10.021428+07	2	15	\N	\N
741	131	413	\N	2026-02-11 15:55:10.041807+07	3	15	\N	\N
742	132	415	\N	2026-02-11 15:55:25.671853+07	\N	1	\N	\N
743	130	408	\N	2026-02-11 15:55:49.859148+07	\N	2	\N	\N
744	131	411	\N	2026-02-11 15:56:01.014507+07	1	15	\N	\N
745	131	412	\N	2026-02-11 15:56:01.032744+07	2	15	\N	\N
746	131	413	\N	2026-02-11 15:56:01.051385+07	3	15	\N	\N
747	130	409	\N	2026-02-11 16:01:21.701649+07	\N	1	\N	\N
748	131	411	\N	2026-02-11 16:01:34.092921+07	1	14	\N	\N
749	131	412	\N	2026-02-11 16:01:34.109856+07	2	14	\N	\N
750	131	413	\N	2026-02-11 16:01:34.142219+07	3	14	\N	\N
751	130	409	\N	2026-02-11 16:07:36.570827+07	\N	1	\N	\N
752	131	411	\N	2026-02-11 16:07:46.161618+07	1	14	\N	\N
753	131	412	\N	2026-02-11 16:07:46.178711+07	2	14	\N	\N
754	131	413	\N	2026-02-11 16:07:46.198721+07	3	14	\N	\N
755	130	408	\N	2026-02-11 16:08:40.907277+07	\N	1	\N	\N
756	131	411	\N	2026-02-11 16:08:49.072996+07	1	25	\N	\N
757	131	412	\N	2026-02-11 16:08:49.088172+07	2	25	\N	\N
758	131	413	\N	2026-02-11 16:08:49.100703+07	3	25	\N	\N
759	130	408	\N	2026-02-11 16:10:23.154525+07	\N	2	\N	\N
760	131	411	\N	2026-02-11 16:10:30.478029+07	1	25	\N	\N
761	131	412	\N	2026-02-11 16:10:30.492339+07	2	25	\N	\N
762	131	413	\N	2026-02-11 16:10:30.523704+07	3	25	\N	\N
763	130	408	\N	2026-02-11 16:27:27.764512+07	\N	2	\N	\N
764	131	411	\N	2026-02-11 16:27:36.237219+07	1	3	\N	\N
765	131	412	\N	2026-02-11 16:27:36.255514+07	2	3	\N	\N
766	131	413	\N	2026-02-11 16:27:36.273239+07	3	3	\N	\N
767	130	408	\N	2026-02-11 16:39:54.715419+07	\N	2	\N	\N
768	130	408	\N	2026-02-11 16:45:01.276762+07	\N	1	\N	\N
769	131	411	\N	2026-02-11 16:45:10.377482+07	1	3	\N	\N
770	131	412	\N	2026-02-11 16:45:10.391064+07	2	3	\N	\N
771	131	413	\N	2026-02-11 16:45:10.423359+07	3	3	\N	\N
772	132	414	\N	2026-02-11 16:45:17.507935+07	\N	2	\N	\N
791	130	409	\N	2026-02-11 16:51:56.075012+07	\N	1	\N	\N
792	131	411	\N	2026-02-11 16:52:06.434039+07	1	1	\N	\N
793	131	412	\N	2026-02-11 16:52:06.451084+07	2	1	\N	\N
794	131	413	\N	2026-02-11 16:52:06.469832+07	3	1	\N	\N
795	130	408	\N	2026-02-11 16:54:06.845077+07	\N	1	\N	\N
796	131	411	\N	2026-02-11 16:54:15.945444+07	1	2	\N	\N
797	131	412	\N	2026-02-11 16:54:15.967667+07	2	2	\N	\N
798	131	413	\N	2026-02-11 16:54:16.067472+07	3	2	\N	\N
799	132	414	\N	2026-02-11 16:54:22.723061+07	\N	1	\N	\N
800	55	143	\N	2026-02-11 17:00:08.21612+07	\N	1	\N	\N
801	130	408	\N	2026-02-11 17:00:21.748614+07	\N	1	\N	\N
802	130	408	\N	2026-02-11 17:03:17.932348+07	\N	1	\N	\N
803	130	408	\N	2026-02-11 17:03:57.880512+07	\N	1	\N	\N
804	130	410	\N	2026-02-11 17:04:22.794104+07	\N	1	\N	\N
805	130	408	\N	2026-02-11 17:11:12.057564+07	\N	1	\N	\N
806	55	142	\N	2026-02-11 17:20:43.956794+07	\N	1	\N	\N
807	55	142	\N	2026-02-11 17:21:29.649393+07	\N	1	\N	\N
808	130	408	\N	2026-02-11 17:30:59.970114+07	\N	1	\N	\N
809	130	409	\N	2026-02-11 17:31:40.462569+07	\N	2	\N	\N
810	131	411	\N	2026-02-11 17:31:51.133166+07	1	4	\N	\N
811	131	412	\N	2026-02-11 17:31:51.152535+07	2	4	\N	\N
812	131	413	\N	2026-02-11 17:31:51.170497+07	3	4	\N	\N
813	130	408	\N	2026-02-11 17:32:25.653047+07	\N	1	\N	\N
814	131	411	\N	2026-02-11 17:32:33.215636+07	1	3	\N	\N
815	131	412	\N	2026-02-11 17:32:33.232848+07	2	3	\N	\N
816	131	413	\N	2026-02-11 17:32:33.301563+07	3	3	\N	\N
817	55	142	\N	2026-02-11 17:46:17.58425+07	\N	1	\N	\N
818	55	142	\N	2026-02-11 17:47:17.731102+07	\N	3	\N	\N
819	56	145	\N	2026-02-11 17:47:23.625454+07	\N	1	\N	\N
820	55	142	\N	2026-02-11 17:49:33.284143+07	\N	1	\N	\N
821	56	145	\N	2026-02-11 17:49:39.515441+07	\N	1	\N	\N
822	55	143	\N	2026-02-11 17:50:32.850253+07	\N	1	\N	\N
823	56	145	\N	2026-02-11 17:50:37.555779+07	\N	1	\N	\N
824	130	408	\N	2026-02-11 17:50:59.721035+07	\N	1	\N	\N
825	131	411	\N	2026-02-11 17:51:11.161902+07	1	5	\N	\N
826	131	412	\N	2026-02-11 17:51:11.177207+07	2	5	\N	\N
827	131	413	\N	2026-02-11 17:51:11.191083+07	3	5	\N	\N
828	132	415	\N	2026-02-11 17:51:18.244081+07	\N	2	\N	\N
829	130	408	\N	2026-02-11 17:52:53.036324+07	\N	2	\N	\N
830	130	408	\N	2026-02-11 17:54:01.683279+07	\N	1	\N	\N
831	131	411	\N	2026-02-11 17:54:10.941843+07	1	4	\N	\N
832	131	412	\N	2026-02-11 17:54:10.955224+07	2	4	\N	\N
833	131	413	\N	2026-02-11 17:54:10.971621+07	3	4	\N	\N
834	133	417	\N	2026-02-12 13:26:35.638949+07	\N	4	\N	\N
835	134	421	\N	2026-02-12 13:27:17.731551+07	\N	3	\N	\N
836	133	416	\N	2026-02-12 13:34:45.118757+07	\N	2	\N	\N
837	134	420	\N	2026-02-12 13:34:54.028373+07	\N	3	\N	\N
838	135	427	\N	2026-02-12 13:36:20.341544+07	\N	6	\N	\N
839	133	416	\N	2026-02-12 13:46:11.415502+07	\N	4	\N	\N
840	134	420	\N	2026-02-12 13:46:16.482594+07	\N	1	\N	\N
841	135	427	\N	2026-02-12 13:46:21.466276+07	\N	2	\N	\N
842	55	142	\N	2026-02-12 14:19:03.878901+07	\N	2	\N	\N
843	56	145	\N	2026-02-12 14:19:08.969337+07	\N	2	\N	\N
844	133	417	\N	2026-02-12 14:19:24.791312+07	\N	2	\N	\N
845	134	422	\N	2026-02-12 14:19:32.732525+07	\N	3	\N	\N
846	135	427	\N	2026-02-12 14:19:37.987233+07	\N	2	\N	\N
847	55	143	\N	2026-02-12 15:17:37.736926+07	\N	3	\N	\N
848	133	417	\N	2026-02-12 15:18:57.958831+07	\N	5	\N	\N
849	134	421	\N	2026-02-12 15:19:26.906046+07	\N	3	\N	\N
850	135	425	\N	2026-02-12 15:19:38.981903+07	\N	3	\N	\N
851	133	417	\N	2026-02-12 15:23:30.350594+07	\N	2	\N	\N
852	133	417	\N	2026-02-12 15:23:30.973092+07	\N	2	\N	\N
853	134	420	\N	2026-02-12 15:23:38.424013+07	\N	2	\N	\N
854	134	420	\N	2026-02-12 15:23:39.333876+07	\N	3	\N	\N
855	135	427	\N	2026-02-12 15:23:44.310668+07	\N	1	\N	\N
856	135	427	\N	2026-02-12 15:23:45.002335+07	\N	2	\N	\N
857	55	143	\N	2026-02-15 13:35:54.944771+07	\N	2	\N	\N
858	56	146	\N	2026-02-15 13:35:59.472498+07	\N	1	\N	\N
859	130	408	\N	2026-02-15 13:37:26.325878+07	\N	3	\N	\N
860	131	411	\N	2026-02-15 13:37:31.310054+07	1	3	\N	\N
861	131	412	\N	2026-02-15 13:37:31.329672+07	2	3	\N	\N
862	131	413	\N	2026-02-15 13:37:31.347262+07	3	3	\N	\N
863	132	415	\N	2026-02-15 13:37:35.005451+07	\N	1	\N	\N
864	130	408	\N	2026-02-15 14:12:10.410191+07	\N	3	\N	\N
865	130	409	\N	2026-02-15 14:12:11.850494+07	\N	4	\N	\N
866	131	411	\N	2026-02-15 14:12:20.244677+07	1	4	\N	\N
867	131	412	\N	2026-02-15 14:12:20.347109+07	2	4	\N	\N
868	131	413	\N	2026-02-15 14:12:20.445868+07	3	4	\N	\N
869	131	412	\N	2026-02-15 14:12:20.86217+07	1	4	\N	\N
870	131	413	\N	2026-02-15 14:12:20.95656+07	2	4	\N	\N
871	131	411	\N	2026-02-15 14:12:21.068063+07	3	4	\N	\N
872	132	415	\N	2026-02-15 14:12:29.96937+07	\N	5	\N	\N
873	132	414	\N	2026-02-15 14:12:30.070543+07	\N	5	\N	\N
874	133	417	\N	2026-02-15 14:31:22.646519+07	\N	2	\N	\N
875	134	422	\N	2026-02-15 14:31:28.175761+07	\N	2	\N	\N
876	135	427	\N	2026-02-15 14:31:33.295867+07	\N	2	\N	\N
877	55	142	\N	2026-02-15 14:33:38.037958+07	\N	2	\N	\N
878	133	417	\N	2026-02-15 15:22:57.275576+07	\N	5	\N	\N
879	133	417	\N	2026-02-15 15:22:59.253015+07	\N	7	\N	\N
880	134	420	\N	2026-02-15 15:23:05.294204+07	\N	3	\N	\N
881	134	421	\N	2026-02-15 15:23:10.107603+07	\N	2	\N	\N
882	135	427	\N	2026-02-15 15:23:18.894193+07	\N	4	\N	\N
883	135	427	\N	2026-02-15 15:23:21.955333+07	\N	9	\N	\N
884	133	417	\N	2026-02-15 15:23:23.285954+07	\N	2	\N	\N
885	134	420	\N	2026-02-15 15:23:30.926598+07	\N	2	\N	\N
886	135	427	\N	2026-02-15 15:26:23.114838+07	\N	1	\N	\N
887	133	417	\N	2026-02-15 15:29:44.542499+07	\N	1	\N	\N
888	134	420	\N	2026-02-15 15:29:49.825707+07	\N	2	\N	\N
889	135	427	\N	2026-02-15 15:29:54.515933+07	\N	1	\N	\N
890	133	417	\N	2026-02-15 15:30:30.046441+07	\N	1	\N	\N
891	134	423	\N	2026-02-15 15:30:34.076861+07	\N	1	\N	\N
892	135	427	\N	2026-02-15 15:30:38.620463+07	\N	1	\N	\N
893	133	417	\N	2026-02-15 15:34:08.586425+07	\N	1	\N	\N
894	133	417	\N	2026-02-15 15:34:59.365871+07	\N	6	\N	\N
895	133	417	\N	2026-02-15 15:35:02.539577+07	\N	9	\N	\N
896	134	420	\N	2026-02-15 15:35:10.77803+07	\N	3	\N	\N
897	135	427	\N	2026-02-15 15:35:18.187422+07	\N	3	\N	\N
898	134	420	\N	2026-02-15 15:35:24.961333+07	\N	3	\N	\N
899	135	427	\N	2026-02-15 15:35:32.337291+07	\N	3	\N	\N
900	133	417	\N	2026-02-15 15:39:59.768234+07	\N	2	\N	\N
901	134	420	\N	2026-02-15 15:40:06.299277+07	\N	2	\N	\N
902	133	417	\N	2026-02-15 15:43:12.79453+07	\N	3	\N	\N
903	134	420	\N	2026-02-15 15:43:19.572955+07	\N	1	\N	\N
904	133	417	\N	2026-02-15 15:49:39.511491+07	\N	3	\N	\N
905	133	417	\N	2026-02-15 15:49:44.528902+07	\N	8	\N	\N
906	134	420	\N	2026-02-15 15:50:05.774954+07	\N	4	\N	\N
907	133	417	\N	2026-02-15 15:51:59.110048+07	\N	1	\N	\N
908	134	420	\N	2026-02-15 15:52:54.082221+07	\N	17	\N	\N
909	135	427	\N	2026-02-15 15:52:58.043311+07	\N	2	\N	\N
910	133	417	\N	2026-02-15 15:54:45.38603+07	\N	2	\N	\N
911	133	417	\N	2026-02-15 15:56:47.62365+07	\N	4	\N	\N
912	133	417	\N	2026-02-15 16:00:09.460476+07	\N	2	\N	\N
913	135	427	\N	2026-02-15 16:04:43.362536+07	\N	4	\N	\N
920	133	417	\N	2026-02-15 16:08:16.449121+07	\N	2	\N	\N
921	133	417	\N	2026-02-15 16:08:41.205687+07	\N	11	\N	\N
922	134	420	\N	2026-02-15 16:09:56.323578+07	\N	15	\N	\N
923	133	417	\N	2026-02-15 16:10:09.42032+07	\N	1	\N	\N
924	134	420	\N	2026-02-15 16:10:19.293685+07	\N	1	\N	\N
925	135	427	\N	2026-02-15 16:10:26.769931+07	\N	2	\N	\N
926	133	417	\N	2026-02-15 16:13:49.857551+07	\N	7	\N	\N
927	133	417	\N	2026-02-15 16:13:50.568362+07	\N	4	\N	\N
928	55	143	\N	2026-02-15 16:13:53.877938+07	\N	1	\N	\N
929	56	145	\N	2026-02-15 16:13:56.296165+07	\N	1	\N	\N
930	133	417	\N	2026-02-15 16:14:14.941591+07	\N	2	\N	\N
931	134	420	\N	2026-02-15 16:14:19.48022+07	\N	2	\N	\N
932	134	420	\N	2026-02-15 16:14:20.520591+07	\N	8	\N	\N
933	134	420	\N	2026-02-15 16:14:22.835493+07	\N	25	\N	\N
934	135	427	\N	2026-02-15 16:14:24.156844+07	\N	2	\N	\N
935	135	427	\N	2026-02-15 16:14:38.284376+07	\N	13	\N	\N
936	135	427	\N	2026-02-15 16:14:41.020192+07	\N	14	\N	\N
937	133	417	\N	2026-02-15 16:17:19.356871+07	\N	1	\N	\N
938	133	417	\N	2026-02-15 16:18:20.840684+07	\N	2	\N	\N
939	134	420	\N	2026-02-15 16:18:31.160352+07	\N	2	\N	\N
940	135	427	\N	2026-02-15 16:18:47.101995+07	\N	4	\N	\N
941	133	417	\N	2026-02-15 16:30:49.516676+07	\N	2	\N	\N
942	133	417	\N	2026-02-15 16:33:18.307331+07	\N	1	\N	\N
943	133	417	\N	2026-02-15 16:36:16.813322+07	\N	2	\N	\N
944	133	417	\N	2026-02-15 16:37:58.235774+07	\N	1	\N	\N
945	134	420	\N	2026-02-15 16:38:04.522822+07	\N	2	\N	\N
946	133	417	\N	2026-02-15 16:39:51.71544+07	\N	1	\N	\N
947	134	421	\N	2026-02-15 16:39:57.984165+07	\N	2	\N	\N
948	135	427	\N	2026-02-15 16:40:04.347167+07	\N	2	\N	\N
949	133	417	\N	2026-02-15 16:42:55.775789+07	\N	4	\N	\N
950	134	420	\N	2026-02-15 16:43:04.620091+07	\N	3	\N	\N
951	133	417	\N	2026-02-15 16:43:34.585608+07	\N	2	\N	\N
952	134	420	\N	2026-02-15 16:43:39.278602+07	\N	2	\N	\N
953	135	427	\N	2026-02-15 16:43:43.473094+07	\N	1	\N	\N
954	133	417	\N	2026-02-15 16:44:07.745506+07	\N	3	\N	\N
955	133	417	t	2026-02-15 16:45:48.893287+07	0	4	\N	\N
956	134	420	t	2026-02-15 16:46:37.358703+07	0	4	\N	\N
957	135	427	t	2026-02-15 16:46:51.628686+07	0	3	\N	\N
958	130	408	\N	2026-02-15 16:47:42.90087+07	\N	5	\N	\N
959	131	411	\N	2026-02-15 16:47:51.087647+07	1	4	\N	\N
960	131	412	\N	2026-02-15 16:47:51.102285+07	2	4	\N	\N
961	131	413	\N	2026-02-15 16:47:51.117539+07	3	4	\N	\N
962	130	408	\N	2026-02-15 16:59:39.04858+07	\N	1	\N	\N
963	131	411	\N	2026-02-15 16:59:47.962185+07	1	4	\N	\N
964	131	412	\N	2026-02-15 16:59:47.986163+07	2	4	\N	\N
965	131	413	\N	2026-02-15 16:59:48.004045+07	3	4	\N	\N
966	35	86	\N	2026-02-15 17:00:07.940561+07	\N	3	\N	\N
967	133	417	\N	2026-02-15 17:00:27.041425+07	\N	1	\N	\N
968	134	420	\N	2026-02-15 17:00:32.25167+07	\N	2	\N	\N
969	133	417	\N	2026-02-15 17:00:43.511814+07	\N	2	\N	\N
970	134	420	\N	2026-02-15 17:00:47.431114+07	\N	2	\N	\N
971	130	408	\N	2026-02-15 17:00:57.810619+07	\N	2	\N	\N
972	131	411	\N	2026-02-15 17:01:03.891445+07	1	3	\N	\N
973	131	412	\N	2026-02-15 17:01:03.911227+07	2	3	\N	\N
974	131	413	\N	2026-02-15 17:01:03.933384+07	3	3	\N	\N
975	132	414	\N	2026-02-15 17:01:10.890291+07	\N	2	\N	\N
976	133	417	f	2026-02-15 17:01:57.236535+07	0	4	\N	\N
977	134	420	f	2026-02-15 17:02:06.337822+07	0	4	\N	\N
978	130	408	t	2026-02-15 17:13:46.678771+07	\N	5	\N	\N
979	130	409	f	2026-02-15 17:13:46.678771+07	\N	6	\N	\N
980	130	408	t	2026-02-15 17:13:46.678771+07	\N	4	\N	\N
981	130	410	f	2026-02-15 17:13:46.678771+07	\N	7	\N	\N
982	130	408	t	2026-02-15 17:13:46.678771+07	\N	6	\N	\N
983	131	411	t	2026-02-15 17:15:28.883703+07	1	8	\N	\N
984	131	412	t	2026-02-15 17:15:28.883703+07	2	8	\N	\N
985	131	413	t	2026-02-15 17:15:28.883703+07	3	8	\N	\N
986	131	411	t	2026-02-15 17:15:28.883703+07	1	9	\N	\N
987	131	413	f	2026-02-15 17:15:28.883703+07	2	9	\N	\N
988	131	412	f	2026-02-15 17:15:28.883703+07	3	9	\N	\N
989	131	411	t	2026-02-15 17:15:28.883703+07	1	10	\N	\N
990	131	412	t	2026-02-15 17:15:28.883703+07	3	10	\N	\N
991	131	413	t	2026-02-15 17:15:28.883703+07	2	10	\N	\N
992	131	412	f	2026-02-15 17:15:28.883703+07	1	12	\N	\N
993	131	411	f	2026-02-15 17:15:28.883703+07	2	12	\N	\N
994	131	413	t	2026-02-15 17:15:28.883703+07	3	12	\N	\N
995	131	411	t	2026-02-15 17:15:28.883703+07	1	15	\N	\N
996	131	412	t	2026-02-15 17:15:28.883703+07	2	15	\N	\N
997	131	413	t	2026-02-15 17:15:28.883703+07	3	15	\N	\N
998	133	417	\N	2026-02-18 13:25:58.958212+07	\N	8	\N	\N
999	134	420	\N	2026-02-18 13:26:04.587364+07	\N	2	\N	\N
1000	135	427	\N	2026-02-18 13:26:09.049349+07	\N	2	\N	\N
1001	133	417	\N	2026-02-18 13:35:43.280004+07	\N	3	\N	\N
1002	134	420	\N	2026-02-18 13:35:46.604572+07	\N	1	\N	\N
1003	135	427	\N	2026-02-18 13:35:50.359273+07	\N	2	\N	\N
1004	130	408	\N	2026-02-18 13:36:11.574394+07	\N	2	\N	\N
1005	131	411	\N	2026-02-18 13:36:17.493733+07	1	4	\N	\N
1006	131	412	\N	2026-02-18 13:36:17.510339+07	2	4	\N	\N
1007	131	413	\N	2026-02-18 13:36:17.522841+07	3	4	\N	\N
1008	132	415	\N	2026-02-18 13:36:22.017171+07	\N	2	\N	\N
1009	130	408	\N	2026-02-18 13:40:58.971355+07	\N	2	\N	\N
1010	131	411	\N	2026-02-18 13:41:05.921482+07	1	5	\N	\N
1011	131	412	\N	2026-02-18 13:41:05.944181+07	2	5	\N	\N
1012	131	413	\N	2026-02-18 13:41:05.959289+07	3	5	\N	\N
1013	132	415	\N	2026-02-18 13:41:14.727606+07	\N	7	\N	\N
1014	133	417	\N	2026-02-18 13:43:23.961045+07	\N	4	\N	\N
1015	130	408	\N	2026-02-18 13:43:36.309993+07	\N	2	\N	\N
1016	55	142	\N	2026-02-18 13:49:59.489353+07	\N	2	\N	\N
1017	56	146	\N	2026-02-18 13:50:07.186727+07	\N	6	\N	\N
1018	56	145	\N	2026-02-18 13:50:07.203857+07	\N	6	\N	\N
1019	130	408	\N	2026-02-18 13:50:21.826835+07	\N	6	\N	\N
1020	131	411	\N	2026-02-18 13:50:38.674468+07	1	8	\N	\N
1021	131	412	\N	2026-02-18 13:50:38.708609+07	2	8	\N	\N
1022	131	413	\N	2026-02-18 13:50:38.727468+07	3	8	\N	\N
1023	55	142	\N	2026-02-18 13:50:49.398607+07	\N	1	\N	\N
1024	130	408	\N	2026-02-18 13:57:59.094614+07	\N	2	\N	\N
1025	131	411	\N	2026-02-18 13:58:16.255593+07	1	3	\N	\N
1026	131	412	\N	2026-02-18 13:58:16.282879+07	2	3	\N	\N
1027	131	413	\N	2026-02-18 13:58:16.300116+07	3	3	\N	\N
1028	132	415	\N	2026-02-18 13:58:19.36114+07	\N	1	\N	\N
1029	133	417	\N	2026-02-18 14:09:04.393185+07	\N	2	\N	\N
1030	134	420	\N	2026-02-18 14:09:08.147273+07	\N	2	\N	\N
1031	135	427	\N	2026-02-18 14:09:11.607331+07	\N	2	\N	\N
1032	133	417	\N	2026-02-18 14:10:20.219244+07	\N	3	\N	\N
1033	134	420	\N	2026-02-18 14:10:24.481751+07	\N	2	\N	\N
1034	133	417	\N	2026-02-18 14:10:26.322453+07	\N	9	\N	\N
1035	135	427	\N	2026-02-18 14:10:30.754305+07	\N	2	\N	\N
1036	134	420	\N	2026-02-18 14:10:33.87714+07	\N	6	\N	\N
1037	135	427	\N	2026-02-18 14:10:38.136858+07	\N	3	\N	\N
1038	130	408	\N	2026-02-18 14:11:16.210419+07	\N	3	\N	\N
1040	131	411	\N	2026-02-18 14:15:17.1466+07	1	8	\N	\N
1041	131	412	\N	2026-02-18 14:15:17.19284+07	2	8	\N	\N
1042	131	413	\N	2026-02-18 14:15:17.211994+07	3	8	\N	\N
1043	130	408	\N	2026-02-18 14:15:29.832271+07	\N	2	\N	\N
1044	130	408	\N	2026-02-18 14:15:48.185425+07	\N	2	\N	\N
1045	130	409	\N	2026-02-18 14:15:48.970782+07	\N	3	\N	\N
1046	131	411	\N	2026-02-18 14:16:06.636156+07	1	10	\N	\N
1047	131	412	\N	2026-02-18 14:16:06.664861+07	2	10	\N	\N
1048	131	413	\N	2026-02-18 14:16:06.682252+07	3	10	\N	\N
1049	131	411	\N	2026-02-18 14:16:10.529321+07	1	14	\N	\N
1050	131	412	\N	2026-02-18 14:16:10.545783+07	2	14	\N	\N
1051	131	413	\N	2026-02-18 14:16:10.564971+07	3	14	\N	\N
1052	132	415	\N	2026-02-18 14:16:25.013436+07	\N	1	\N	\N
1053	132	415	\N	2026-02-18 14:16:26.559071+07	\N	3	\N	\N
1054	133	417	\N	2026-02-18 14:17:32.837304+07	\N	1	\N	\N
1055	134	420	\N	2026-02-18 14:17:37.849859+07	\N	2	\N	\N
1056	135	427	\N	2026-02-18 14:17:44.380688+07	\N	1	\N	\N
1057	55	142	\N	2026-02-18 14:18:29.43348+07	\N	2	\N	\N
1058	56	146	\N	2026-02-18 14:18:32.510535+07	\N	1	\N	\N
1059	133	417	t	2026-02-18 14:21:13.838545+07	\N	2	\N	\N
1060	133	417	t	2026-02-18 14:26:30.135132+07	\N	3	\N	\N
1061	133	417	t	2026-02-18 14:26:54.991678+07	\N	2	\N	\N
1062	133	417	t	2026-02-18 14:27:30.679067+07	\N	2	\N	\N
1063	134	420	t	2026-02-18 14:27:42.15841+07	\N	2	\N	\N
1064	135	427	t	2026-02-18 14:27:54.764033+07	\N	2	\N	\N
1065	133	417	\N	2026-02-18 14:34:11.79884+07	\N	1	\N	\N
1066	134	420	\N	2026-02-18 14:34:15.88417+07	\N	2	\N	\N
1067	135	427	\N	2026-02-18 14:34:19.326163+07	\N	2	\N	\N
1068	133	417	\N	2026-02-18 14:35:58.36656+07	\N	1	\N	\N
1069	133	417	\N	2026-02-18 14:36:15.831194+07	\N	1	\N	\N
1070	134	420	\N	2026-02-18 14:36:22.492387+07	\N	2	\N	\N
1071	133	417	\N	2026-02-18 14:37:02.985621+07	\N	1	\N	\N
1072	133	417	\N	2026-02-18 14:38:36.131113+07	\N	1	\N	\N
1073	134	420	\N	2026-02-18 14:38:41.591492+07	\N	1	\N	\N
1074	135	427	\N	2026-02-18 14:38:48.398144+07	\N	1	\N	\N
1078	133	417	\N	2026-02-18 14:39:42.544586+07	\N	5	\N	\N
1079	134	420	\N	2026-02-18 14:39:46.608057+07	\N	2	\N	\N
1080	135	427	\N	2026-02-18 14:39:49.86252+07	\N	2	\N	\N
1081	133	417	\N	2026-02-18 14:40:14.73954+07	\N	1	\N	\N
1082	134	420	\N	2026-02-18 14:40:23.229573+07	\N	6	\N	\N
1083	133	417	\N	2026-02-18 14:44:14.017783+07	\N	3	\N	\N
1084	134	420	\N	2026-02-18 14:44:19.188267+07	\N	2	\N	\N
1085	135	427	\N	2026-02-18 14:44:32.123769+07	\N	4	\N	\N
1086	55	142	\N	2026-02-18 14:48:11.948382+07	\N	3	\N	\N
1087	133	417	\N	2026-02-18 14:48:25.777514+07	\N	1	\N	\N
1088	134	420	\N	2026-02-18 14:48:36.753614+07	\N	4	\N	\N
1089	130	408	\N	2026-02-18 14:48:52.119113+07	\N	2	\N	\N
1090	131	411	\N	2026-02-18 14:48:56.77339+07	1	2	\N	\N
1091	131	412	\N	2026-02-18 14:48:56.787054+07	2	2	\N	\N
1092	131	413	\N	2026-02-18 14:48:56.801491+07	3	2	\N	\N
1093	132	415	\N	2026-02-18 14:49:00.060151+07	\N	1	\N	\N
1094	133	417	\N	2026-02-18 14:49:17.14131+07	\N	1	\N	\N
1095	133	417	\N	2026-02-18 14:51:24.480772+07	\N	3	\N	\N
1096	133	417	\N	2026-02-18 14:54:02.872916+07	\N	1	\N	\N
1097	134	420	\N	2026-02-18 14:54:17.886988+07	\N	5	\N	\N
1099	134	420	t	2026-02-18 14:56:30.144735+07	\N	3	\N	\N
1100	135	427	t	2026-02-18 14:56:44.187009+07	\N	7	\N	\N
1101	133	417	\N	2026-02-18 14:57:36.097103+07	\N	1	\N	\N
1102	133	417	t	2026-02-18 15:05:16.126953+07	\N	2	\N	\N
1103	130	408	t	2026-02-18 15:05:36.825773+07	\N	4	\N	\N
1104	133	417	t	2026-02-18 15:11:52.790111+07	\N	2	\N	\N
1105	134	420	t	2026-02-18 15:11:58.155378+07	\N	2	\N	\N
1106	135	427	t	2026-02-18 15:12:03.176542+07	\N	3	\N	\N
1107	133	417	t	2026-02-18 15:12:43.603047+07	\N	3	\N	\N
1108	134	420	t	2026-02-18 15:12:48.566435+07	\N	2	\N	\N
1109	135	427	t	2026-02-18 15:12:53.407908+07	\N	2	\N	\N
1111	133	417	t	2026-02-18 15:15:51.95894+07	\N	2	\N	\N
1112	133	417	t	2026-02-18 15:16:11.868118+07	\N	3	\N	\N
1113	134	420	t	2026-02-18 15:16:17.32559+07	\N	2	\N	\N
1114	135	427	t	2026-02-18 15:16:27.728464+07	\N	6	\N	\N
1115	133	417	t	2026-02-18 15:18:25.598707+07	\N	3	\N	\N
1116	134	420	t	2026-02-18 15:18:30.971536+07	\N	3	\N	\N
1117	135	427	t	2026-02-18 15:18:37.790432+07	\N	4	\N	\N
1118	133	417	t	2026-02-18 15:21:18.181978+07	\N	2	\N	\N
1119	134	420	t	2026-02-18 15:21:23.648141+07	\N	2	\N	\N
1120	135	427	t	2026-02-18 15:21:28.126309+07	\N	2	\N	\N
1121	131	411	\N	2026-02-18 15:36:12.719279+07	1	4	\N	\N
1122	131	412	\N	2026-02-18 15:36:12.750328+07	2	4	\N	\N
1123	131	413	\N	2026-02-18 15:36:12.769242+07	3	4	\N	\N
1124	133	417	\N	2026-02-18 15:38:17.347302+07	\N	0	\N	\N
1125	134	420	\N	2026-02-18 15:38:22.256771+07	\N	1	\N	\N
1126	133	417	\N	2026-02-18 15:44:36.885415+07	\N	1	\N	\N
1127	133	418	\N	2026-02-18 16:26:38.178351+07	\N	0	\N	\N
1128	134	420	\N	2026-02-18 16:26:43.704358+07	\N	1	\N	\N
1129	133	417	\N	2026-02-18 16:37:42.767434+07	\N	1	\N	\N
1130	133	417	\N	2026-02-18 16:38:36.338137+07	\N	0	\N	\N
1131	133	417	\N	2026-02-18 16:47:15.266173+07	\N	1	\N	\N
1132	133	419	\N	2026-02-18 16:47:17.004256+07	\N	2	\N	\N
1133	134	420	\N	2026-02-18 16:47:27.02182+07	\N	2	\N	\N
1134	134	420	\N	2026-02-18 16:47:27.398665+07	\N	2	\N	\N
1135	135	427	\N	2026-02-18 16:47:35.433487+07	\N	2	\N	\N
1136	135	427	\N	2026-02-18 16:47:35.655391+07	\N	2	\N	\N
1137	133	417	\N	2026-02-19 13:34:05.492823+07	\N	3	\N	\N
1138	134	420	\N	2026-02-19 13:34:10.000769+07	\N	2	\N	\N
1139	135	427	\N	2026-02-19 13:34:13.480902+07	\N	1	\N	\N
1140	133	417	\N	2026-02-19 13:35:21.556451+07	\N	6	\N	\N
1141	134	420	\N	2026-02-19 13:35:24.381059+07	\N	1	\N	\N
1142	133	417	\N	2026-02-19 13:35:52.93639+07	\N	1	\N	\N
1144	134	420	\N	2026-02-19 13:50:03.766264+07	\N	1	\N	\N
1145	135	426	\N	2026-02-19 13:50:12.084998+07	\N	1	\N	\N
1146	133	417	\N	2026-02-19 13:50:59.560199+07	\N	1	\N	\N
1147	133	417	\N	2026-02-19 13:51:12.867253+07	\N	1	\N	\N
1148	134	420	\N	2026-02-19 13:51:18.328412+07	\N	1	\N	\N
1149	135	427	\N	2026-02-19 13:51:22.284538+07	\N	1	\N	\N
1152	133	417	\N	2026-02-19 13:57:36.723574+07	\N	1	\N	\N
1153	134	420	\N	2026-02-19 13:57:43.619503+07	\N	1	\N	\N
1154	135	427	\N	2026-02-19 13:57:47.100676+07	\N	1	\N	\N
1155	133	417	\N	2026-02-19 14:02:57.199165+07	\N	3	\N	\N
1156	133	417	\N	2026-02-19 14:07:09.176147+07	\N	2	\N	\N
1161	133	416	\N	2026-02-19 14:10:12.279747+07	\N	0	\N	\N
1162	133	417	\N	2026-02-19 14:13:49.246166+07	\N	1	\N	\N
1163	133	417	\N	2026-02-19 14:14:06.078109+07	\N	1	\N	\N
1164	134	420	\N	2026-02-19 14:14:21.338463+07	\N	1	\N	\N
1165	135	427	\N	2026-02-19 14:14:30.42767+07	\N	4	\N	\N
1166	133	417	\N	2026-02-19 14:16:51.604179+07	\N	1	\N	\N
1167	134	420	\N	2026-02-19 14:16:59.146964+07	\N	2	\N	\N
1168	135	427	\N	2026-02-19 14:17:03.404681+07	\N	2	\N	\N
1169	133	417	\N	2026-02-19 14:17:53.157608+07	\N	1	\N	\N
1170	133	417	\N	2026-02-19 14:18:18.49904+07	\N	1	\N	\N
1171	133	417	\N	2026-02-19 14:22:35.298853+07	\N	1	\N	\N
1172	133	417	t	2026-02-19 14:53:49.201373+07	\N	91	\N	\N
1173	133	417	t	2026-02-19 14:53:51.642339+07	\N	94	\N	\N
1174	133	419	f	2026-02-19 14:53:53.535524+07	\N	96	\N	\N
1175	134	420	t	2026-02-19 14:54:12.448963+07	\N	3	\N	\N
1176	134	420	t	2026-02-19 14:54:16.717732+07	\N	8	\N	\N
1177	134	423	f	2026-02-19 14:54:17.976987+07	\N	9	\N	\N
1178	135	426	f	2026-02-19 14:54:50.962354+07	\N	6	\N	\N
1179	135	427	t	2026-02-19 14:54:51.235625+07	\N	5	\N	\N
1180	135	427	t	2026-02-19 14:54:53.045188+07	\N	8	\N	\N
1181	133	417	t	2026-02-19 14:56:19.599994+07	\N	5	\N	\N
1182	133	417	t	2026-02-19 14:56:20.189691+07	\N	5	\N	\N
1183	133	417	t	2026-02-19 14:56:21.993607+07	\N	7	\N	\N
1184	134	420	t	2026-02-19 14:56:33.849855+07	\N	1	\N	\N
1185	134	420	t	2026-02-19 14:56:35.091+07	\N	3	\N	\N
1186	134	421	f	2026-02-19 14:56:40.159388+07	\N	8	\N	\N
1187	135	427	t	2026-02-19 14:57:03.156676+07	\N	4	\N	\N
1188	135	427	t	2026-02-19 14:57:03.919491+07	\N	4	\N	\N
1189	135	427	t	2026-02-19 14:57:05.000213+07	\N	6	\N	\N
1190	133	417	\N	2026-02-19 14:59:52.624856+07	\N	1	\N	\N
1191	133	417	\N	2026-02-19 15:07:42.252543+07	\N	18	\N	\N
1192	130	408	\N	2026-02-19 15:07:53.328657+07	\N	1	\N	\N
1193	130	408	\N	2026-02-19 15:08:19.506624+07	\N	27	\N	\N
1194	133	417	\N	2026-02-19 15:08:43.24151+07	\N	79	\N	\N
1195	131	411	\N	2026-02-19 15:10:54.505243+07	1	170	\N	\N
1196	131	412	\N	2026-02-19 15:10:54.535959+07	2	170	\N	\N
1197	131	413	\N	2026-02-19 15:10:54.553887+07	3	170	\N	\N
1198	133	417	t	2026-02-19 15:11:40.270858+07	\N	1	\N	\N
1199	134	420	t	2026-02-19 15:11:45.320348+07	\N	2	\N	\N
1200	135	427	t	2026-02-19 15:11:49.604037+07	\N	2	\N	\N
1201	133	417	\N	2026-02-19 15:14:21.427072+07	\N	417	\N	\N
1202	134	420	\N	2026-02-19 15:14:29.914021+07	\N	342	\N	\N
1203	135	427	\N	2026-02-19 15:14:41.670221+07	\N	3	\N	\N
1204	133	417	\N	2026-02-19 15:20:44.390149+07	\N	800	\N	\N
1205	134	420	\N	2026-02-19 15:20:56.928813+07	\N	729	\N	\N
1206	133	417	\N	2026-02-19 15:21:36.149554+07	\N	852	\N	\N
1207	133	417	\N	2026-02-19 15:25:26.415604+07	\N	1	\N	\N
1208	134	420	\N	2026-02-19 15:25:40.65188+07	\N	0	\N	\N
1209	135	427	\N	2026-02-19 15:25:49.004443+07	\N	1	\N	\N
1210	133	417	\N	2026-02-19 15:26:02.369289+07	\N	1	\N	\N
1211	133	417	\N	2026-02-19 15:26:30.290207+07	\N	1	\N	\N
1212	135	427	\N	2026-02-19 15:26:47.808473+07	\N	4	\N	\N
1213	133	417	\N	2026-02-19 15:27:08.532054+07	\N	1	\N	\N
1214	133	417	\N	2026-02-19 15:30:57.230485+07	\N	1	\N	\N
1215	130	408	\N	2026-02-19 15:36:17.506226+07	\N	1	\N	\N
1216	133	417	\N	2026-02-19 15:36:47.464988+07	\N	1	\N	\N
1217	133	417	\N	2026-02-19 15:37:09.285551+07	\N	0	\N	\N
1218	134	420	\N	2026-02-19 15:37:16.954539+07	\N	1	\N	\N
1219	135	427	\N	2026-02-19 15:37:28.735698+07	\N	1	\N	\N
1220	133	417	\N	2026-02-19 15:37:47.642306+07	\N	1	\N	\N
1221	134	420	\N	2026-02-19 15:37:53.368572+07	\N	1	\N	\N
1222	133	417	\N	2026-02-19 15:44:40.461008+07	\N	5	\N	\N
1226	134	420	\N	2026-02-19 15:50:19.728107+07	\N	3	\N	\N
1229	133	417	\N	2026-02-19 15:56:51.461617+07	\N	2	\N	\N
1230	134	420	\N	2026-02-19 15:57:04.14669+07	\N	11	\N	\N
1232	134	420	\N	2026-02-19 15:57:40.914496+07	\N	8	\N	\N
1233	133	417	\N	2026-02-19 15:57:57.92067+07	\N	5	\N	\N
1234	134	420	\N	2026-02-19 15:58:38.043287+07	\N	3	\N	\N
1236	55	142	f	2026-02-19 16:00:27.501242+07	\N	174	\N	\N
1237	55	143	f	2026-02-19 16:00:29.272399+07	\N	176	\N	\N
1238	133	417	\N	2026-02-19 16:03:25.742914+07	\N	4	\N	\N
1239	133	417	\N	2026-02-19 16:04:17.350474+07	\N	7	\N	\N
1240	133	417	\N	2026-02-19 16:10:17.38216+07	\N	367	\N	\N
1241	134	420	\N	2026-02-19 16:10:27.407669+07	\N	1	\N	\N
1242	135	427	\N	2026-02-19 16:10:31.570665+07	\N	33	\N	\N
1243	133	417	\N	2026-02-19 16:10:48.485993+07	\N	398	\N	\N
1244	133	417	\N	2026-02-19 16:17:38.452426+07	\N	808	\N	\N
1245	133	417	\N	2026-02-19 16:18:20.369674+07	\N	850	\N	\N
1246	133	417	\N	2026-02-19 16:40:10.066571+07	\N	1	\N	\N
1247	135	427	\N	2026-02-19 16:40:32.173893+07	\N	1	\N	\N
1248	133	417	\N	2026-02-19 16:40:47.137059+07	\N	1	\N	\N
1249	134	420	\N	2026-02-19 16:40:50.562333+07	\N	1	\N	\N
1250	135	427	\N	2026-02-19 16:40:53.042827+07	\N	1	\N	\N
1251	133	417	\N	2026-02-19 16:41:10.398242+07	\N	3	\N	\N
1252	134	420	\N	2026-02-19 16:41:25.323878+07	\N	3	\N	\N
1253	135	427	\N	2026-02-19 16:41:37.385448+07	\N	1	\N	\N
1255	55	142	\N	2026-02-19 16:50:33.080017+07	\N	1	\N	\N
1257	133	417	\N	2026-02-19 16:50:47.320461+07	\N	1	\N	\N
1258	134	420	\N	2026-02-19 16:50:54.580394+07	\N	1	\N	\N
1259	135	427	\N	2026-02-19 16:51:01.062993+07	\N	1	\N	\N
1261	133	416	\N	2026-02-19 16:55:48.719348+07	\N	2	\N	\N
1262	133	417	\N	2026-02-19 16:58:36.738791+07	\N	1	\N	\N
1263	134	420	\N	2026-02-19 16:58:44.252466+07	\N	1	\N	\N
1264	135	427	\N	2026-02-19 16:59:00.177597+07	\N	1	\N	\N
1265	133	417	\N	2026-02-19 17:08:47.270461+07	\N	2	\N	\N
1266	134	420	\N	2026-02-19 17:09:00.015835+07	\N	1	\N	\N
1267	135	427	\N	2026-02-19 17:09:11.950263+07	\N	1	\N	\N
1268	133	417	\N	2026-02-19 17:25:04.703429+07	\N	1	\N	\N
1269	134	420	\N	2026-02-19 17:25:12.840783+07	\N	0	\N	\N
1270	135	427	\N	2026-02-19 17:25:17.853289+07	\N	1	\N	\N
1271	133	417	\N	2026-02-19 17:25:32.980038+07	\N	1	\N	\N
1272	133	417	\N	2026-02-19 17:30:28.60795+07	\N	9	\N	\N
1273	134	420	\N	2026-02-19 17:30:36.767394+07	\N	3	\N	\N
1274	135	426	\N	2026-02-19 17:30:44.082531+07	\N	4	\N	\N
1275	133	417	\N	2026-02-19 17:31:02.058328+07	\N	4	\N	\N
1276	134	422	\N	2026-02-19 17:31:07.260541+07	\N	2	\N	\N
1277	133	417	\N	2026-02-19 17:31:21.404861+07	\N	0	\N	\N
1278	133	417	\N	2026-02-19 17:31:35.887667+07	\N	0	\N	\N
1279	134	420	\N	2026-02-19 17:31:40.538523+07	\N	0	\N	\N
1280	133	417	\N	2026-02-19 17:32:33.131729+07	\N	9	\N	\N
1281	133	417	\N	2026-02-19 17:34:14.86675+07	\N	0	\N	\N
1282	134	420	\N	2026-02-19 17:34:17.02683+07	\N	0	\N	\N
1283	135	427	\N	2026-02-19 17:34:19.153904+07	\N	0	\N	\N
1284	133	417	\N	2026-02-22 13:34:34.026704+07	\N	0	\N	\N
1285	134	420	\N	2026-02-22 13:34:46.270746+07	\N	0	\N	\N
1286	135	427	\N	2026-02-22 13:34:52.660803+07	\N	0	\N	\N
1287	133	417	\N	2026-02-22 13:35:15.169602+07	\N	1	\N	\N
1288	134	420	\N	2026-02-22 13:35:22.12524+07	\N	1	\N	\N
1289	135	427	\N	2026-02-22 13:35:30.481966+07	\N	4	\N	\N
1290	133	417	\N	2026-02-22 13:35:59.596582+07	\N	4	\N	\N
1291	134	420	\N	2026-02-22 13:36:05.170481+07	\N	1	\N	\N
1292	135	427	\N	2026-02-22 13:36:08.098009+07	\N	1	\N	\N
1293	133	417	\N	2026-02-22 13:36:33.99723+07	\N	0	\N	\N
1294	133	417	\N	2026-02-22 13:38:16.38587+07	\N	0	\N	\N
1295	134	420	\N	2026-02-22 13:38:21.399111+07	\N	0	\N	\N
1296	133	417	\N	2026-02-22 13:45:25.412717+07	\N	3	\N	\N
1297	133	417	\N	2026-02-22 13:45:37.272121+07	\N	1	\N	\N
1298	134	420	\N	2026-02-22 13:45:42.927418+07	\N	3	\N	\N
1299	133	417	\N	2026-02-22 13:45:58.409355+07	\N	3	\N	\N
1300	134	420	\N	2026-02-22 13:46:11.428624+07	\N	3	\N	\N
1301	133	417	\N	2026-02-22 13:46:25.848117+07	\N	3	\N	\N
1302	134	420	\N	2026-02-22 13:46:31.548862+07	\N	3	\N	\N
1303	133	417	\N	2026-02-22 13:54:57.229667+07	\N	0	\N	\N
1304	133	417	\N	2026-02-22 13:55:39.084056+07	\N	3	\N	\N
1305	133	417	\N	2026-02-22 13:55:56.939818+07	\N	0	\N	\N
1306	133	417	\N	2026-02-22 13:56:43.036362+07	\N	0	\N	\N
1307	133	417	\N	2026-02-22 14:01:35.332519+07	\N	3	\N	\N
1308	134	420	\N	2026-02-22 14:01:48.628647+07	\N	2	\N	\N
1309	133	417	\N	2026-02-22 14:02:10.346785+07	\N	10	\N	\N
1310	133	417	\N	2026-02-22 14:04:29.330608+07	\N	3	\N	\N
1311	133	417	\N	2026-02-22 14:05:45.909393+07	\N	1	\N	\N
1312	134	420	\N	2026-02-22 14:05:54.764273+07	\N	2	\N	\N
1313	133	417	\N	2026-02-22 14:06:08.605791+07	\N	0	\N	\N
1314	134	420	\N	2026-02-22 14:06:17.612762+07	\N	0	\N	\N
1315	133	417	\N	2026-02-22 14:08:43.723995+07	\N	0	\N	\N
1316	133	417	\N	2026-02-22 14:10:29.437276+07	\N	0	\N	\N
1317	133	417	\N	2026-02-22 14:14:31.851275+07	\N	4	\N	\N
1318	134	420	\N	2026-02-22 14:14:37.224538+07	\N	1	\N	\N
1319	133	417	\N	2026-02-22 14:14:50.036281+07	\N	2	\N	\N
1320	133	417	\N	2026-02-22 14:15:05.262773+07	\N	0	\N	\N
1321	134	420	\N	2026-02-22 14:15:17.144218+07	\N	0	\N	\N
1322	133	417	\N	2026-02-22 14:17:42.68551+07	\N	4	\N	\N
1323	134	420	\N	2026-02-22 14:17:47.827017+07	\N	1	\N	\N
1324	135	427	\N	2026-02-22 14:17:53.763017+07	\N	2	\N	\N
1325	133	417	\N	2026-02-22 14:18:17.62921+07	\N	1	\N	\N
1326	134	420	\N	2026-02-22 14:18:21.70144+07	\N	2	\N	\N
1327	133	417	\N	2026-02-22 14:18:34.3375+07	\N	0	\N	\N
1328	134	420	\N	2026-02-22 14:18:48.622804+07	\N	0	\N	\N
1329	133	417	\N	2026-02-22 14:19:20.885951+07	\N	5	\N	\N
1330	133	417	\N	2026-02-22 14:19:36.551483+07	\N	0	\N	\N
1331	133	416	\N	2026-02-22 14:20:27.335623+07	\N	0	\N	\N
1332	134	420	\N	2026-02-22 14:20:40.277231+07	\N	6	\N	\N
1333	133	417	\N	2026-02-22 14:20:54.307894+07	\N	6	\N	\N
1334	133	416	\N	2026-02-22 14:21:21.662665+07	\N	4	\N	\N
1335	134	420	\N	2026-02-22 14:21:25.304342+07	\N	1	\N	\N
1336	133	417	\N	2026-02-22 14:21:39.744113+07	\N	1	\N	\N
1337	133	417	\N	2026-02-22 14:21:52.078858+07	\N	2	\N	\N
1338	134	420	\N	2026-02-22 14:21:59.526406+07	\N	0	\N	\N
1339	133	416	\N	2026-02-22 14:27:33.717568+07	\N	0	\N	\N
1340	134	420	\N	2026-02-22 14:27:42.109775+07	\N	3	\N	\N
1341	135	427	\N	2026-02-22 14:27:50.55909+07	\N	5	\N	\N
1342	133	417	\N	2026-02-22 14:28:07.918357+07	\N	3	\N	\N
1343	134	420	\N	2026-02-22 14:28:13.536016+07	\N	1	\N	\N
1344	133	417	\N	2026-02-22 14:28:25.737788+07	\N	1	\N	\N
1345	134	420	\N	2026-02-22 14:28:30.937207+07	\N	1	\N	\N
1346	135	427	\N	2026-02-22 14:28:36.593133+07	\N	1	\N	\N
1347	133	417	\N	2026-02-22 14:29:28.981787+07	\N	3	\N	\N
1348	134	420	\N	2026-02-22 14:29:34.716985+07	\N	9	\N	\N
1349	135	427	\N	2026-02-22 14:29:43.694286+07	\N	18	\N	\N
1350	133	417	\N	2026-02-22 14:39:30.967497+07	\N	4	\N	\N
1351	134	420	\N	2026-02-22 14:39:37.398166+07	\N	1	\N	\N
1352	133	417	\N	2026-02-22 14:39:48.695674+07	\N	0	\N	\N
1353	134	420	\N	2026-02-22 14:39:52.401451+07	\N	4	\N	\N
1354	135	427	\N	2026-02-22 14:39:57.391723+07	\N	168	\N	\N
1355	133	417	\N	2026-02-22 14:45:14.739901+07	\N	4	\N	\N
1356	134	420	\N	2026-02-22 14:45:22.497534+07	\N	3	\N	\N
1357	135	427	\N	2026-02-22 14:45:28.303371+07	\N	1	\N	\N
1358	133	417	\N	2026-02-22 14:45:39.407233+07	\N	3	\N	\N
1359	134	420	\N	2026-02-22 14:45:42.356944+07	\N	1	\N	\N
1360	133	417	\N	2026-02-22 14:46:04.031698+07	\N	3	\N	\N
1361	134	420	\N	2026-02-22 14:46:11.356225+07	\N	4	\N	\N
1362	135	427	\N	2026-02-22 14:46:17.751341+07	\N	2	\N	\N
1363	133	417	\N	2026-02-22 14:46:52.608053+07	\N	1	\N	\N
1364	134	420	\N	2026-02-22 14:46:56.257259+07	\N	2	\N	\N
1365	135	427	\N	2026-02-22 14:47:02.698524+07	\N	3	\N	\N
1366	133	417	\N	2026-02-22 14:47:19.398891+07	\N	7	\N	\N
1367	134	420	\N	2026-02-22 14:47:21.826316+07	\N	0	\N	\N
1368	135	427	\N	2026-02-22 14:47:26.566258+07	\N	15	\N	\N
1369	133	417	\N	2026-02-22 14:51:15.666726+07	\N	4	\N	\N
1370	134	420	\N	2026-02-22 14:51:22.677008+07	\N	4	\N	\N
1371	133	417	\N	2026-02-22 14:57:04.288477+07	\N	4	\N	\N
1372	134	420	\N	2026-02-22 14:57:08.518381+07	\N	1	\N	\N
1373	135	427	\N	2026-02-22 14:57:13.739393+07	\N	2	\N	\N
1374	133	416	\N	2026-02-22 14:57:21.513228+07	\N	0	\N	\N
1375	133	417	\N	2026-02-22 14:57:43.068404+07	\N	3	\N	\N
1376	134	420	\N	2026-02-22 14:57:47.767096+07	\N	22	\N	\N
1377	135	427	\N	2026-02-22 14:57:55.917168+07	\N	6	\N	\N
1378	133	417	\N	2026-02-22 15:00:31.529558+07	\N	28	\N	\N
1379	133	417	\N	2026-02-22 15:10:42.023303+07	\N	13	\N	\N
1380	133	417	\N	2026-02-22 15:10:55.12857+07	\N	1	\N	\N
1381	134	420	\N	2026-02-22 15:11:00.153928+07	\N	626	\N	\N
1382	133	416	\N	2026-02-22 15:13:36.783938+07	\N	33	\N	\N
1383	133	417	\N	2026-02-22 15:13:48.687196+07	\N	4	\N	\N
1384	134	420	\N	2026-02-22 15:13:55.835036+07	\N	4	\N	\N
1385	133	417	\N	2026-02-22 15:14:09.788447+07	\N	2	\N	\N
1386	134	420	\N	2026-02-22 15:14:16.101247+07	\N	3	\N	\N
1387	133	417	t	2026-02-22 15:17:28.04672+07	\N	5	\N	\N
1388	133	417	t	2026-02-22 15:17:33.124152+07	\N	10	\N	\N
1389	133	417	t	2026-02-22 15:17:38.991429+07	\N	16	\N	\N
1390	133	419	f	2026-02-22 15:17:42.382445+07	\N	20	\N	\N
1391	134	420	t	2026-02-22 15:17:56.690384+07	\N	3	\N	\N
1392	134	420	t	2026-02-22 15:18:03.571383+07	\N	10	\N	\N
1393	134	423	f	2026-02-22 15:18:09.476322+07	\N	16	\N	\N
1394	134	421	f	2026-02-22 15:18:15.679631+07	\N	22	\N	\N
1396	134	420	\N	2026-02-22 15:18:58.560897+07	\N	2	\N	\N
1397	135	427	\N	2026-02-22 15:19:01.183722+07	\N	1258	\N	\N
1398	133	417	\N	2026-02-22 15:25:40.083102+07	\N	4	\N	\N
1399	134	420	\N	2026-02-22 15:25:44.800229+07	\N	1	\N	\N
1400	133	417	\N	2026-02-22 15:25:56.924309+07	\N	3	\N	\N
1401	134	420	\N	2026-02-22 15:26:02.95747+07	\N	9	\N	\N
1402	135	427	\N	2026-02-22 15:26:09.283134+07	\N	15	\N	\N
1403	133	417	\N	2026-02-22 15:26:25.6459+07	\N	11	\N	\N
1404	134	420	\N	2026-02-22 15:26:30.239536+07	\N	2	\N	\N
1405	135	427	\N	2026-02-22 15:26:35.050025+07	\N	3	\N	\N
1406	133	417	\N	2026-02-22 15:26:57.620686+07	\N	6	\N	\N
1407	134	420	\N	2026-02-22 15:27:01.134023+07	\N	1	\N	\N
1408	133	417	\N	2026-02-22 15:30:26.594677+07	\N	0	\N	\N
1409	134	420	\N	2026-02-22 15:30:31.525985+07	\N	1	\N	\N
1410	135	427	\N	2026-02-22 15:30:35.198834+07	\N	2	\N	\N
1411	133	417	\N	2026-02-22 15:31:01.549236+07	\N	0	\N	\N
1412	134	420	\N	2026-02-22 15:31:04.904668+07	\N	1	\N	\N
1413	133	417	\N	2026-02-22 15:31:24.593507+07	\N	0	\N	\N
1414	134	420	\N	2026-02-22 15:31:29.826029+07	\N	4	\N	\N
1415	135	427	\N	2026-02-22 15:31:36.265835+07	\N	5	\N	\N
1416	133	417	\N	2026-02-22 15:31:53.696376+07	\N	5	\N	\N
1417	134	420	\N	2026-02-22 15:32:13.270535+07	\N	12	\N	\N
1418	135	427	\N	2026-02-22 15:32:16.201234+07	\N	2	\N	\N
1419	133	417	\N	2026-02-22 15:32:34.043996+07	\N	13	\N	\N
1420	134	420	\N	2026-02-22 15:32:37.754713+07	\N	1	\N	\N
1421	135	427	\N	2026-02-22 15:32:39.936942+07	\N	1	\N	\N
1422	133	417	\N	2026-02-22 15:32:48.130224+07	\N	1	\N	\N
1423	134	420	\N	2026-02-22 15:32:52.667706+07	\N	2	\N	\N
1424	135	427	\N	2026-02-22 15:32:59.541861+07	\N	13	\N	\N
1425	133	417	\N	2026-02-22 15:33:09.719752+07	\N	1	\N	\N
1426	134	420	\N	2026-02-22 15:33:12.702291+07	\N	1	\N	\N
1427	135	427	\N	2026-02-22 15:33:15.317666+07	\N	7	\N	\N
1428	133	417	\N	2026-02-22 15:33:32.506435+07	\N	4	\N	\N
1429	134	420	\N	2026-02-22 15:33:40.394063+07	\N	7	\N	\N
1430	135	427	\N	2026-02-22 15:33:43.065807+07	\N	2	\N	\N
1431	134	420	\N	2026-02-22 15:34:15.977262+07	\N	2	\N	\N
1432	133	417	\N	2026-02-22 15:34:32.280201+07	\N	4	\N	\N
1433	134	420	\N	2026-02-22 15:34:37.703994+07	\N	2	\N	\N
1434	133	417	\N	2026-02-22 15:34:47.985146+07	\N	2	\N	\N
1435	134	420	\N	2026-02-22 15:34:54.883747+07	\N	4	\N	\N
1436	133	417	\N	2026-02-22 15:35:08.70785+07	\N	1	\N	\N
1437	133	417	\N	2026-02-22 15:39:46.243217+07	\N	0	\N	\N
1438	134	420	\N	2026-02-22 15:39:55.492481+07	\N	3	\N	\N
1439	135	427	\N	2026-02-22 15:40:04.53389+07	\N	4	\N	\N
1440	133	417	\N	2026-02-22 15:40:14.847901+07	\N	2	\N	\N
1441	134	420	\N	2026-02-22 15:40:23.707381+07	\N	6	\N	\N
1442	133	417	\N	2026-02-22 15:40:34.038611+07	\N	2	\N	\N
1443	134	420	\N	2026-02-22 15:40:42.122924+07	\N	5	\N	\N
1444	135	427	\N	2026-02-22 15:40:51.410713+07	\N	7	\N	\N
1445	133	417	\N	2026-02-22 15:41:03.988648+07	\N	2	\N	\N
1446	134	420	\N	2026-02-22 15:41:12.579657+07	\N	4	\N	\N
1447	133	417	\N	2026-02-22 15:41:22.59688+07	\N	1	\N	\N
1448	134	420	\N	2026-02-22 15:41:28.490545+07	\N	3	\N	\N
1449	133	417	\N	2026-02-22 15:41:40.380091+07	\N	0	\N	\N
1450	134	420	\N	2026-02-22 15:41:49.219347+07	\N	5	\N	\N
1451	135	427	\N	2026-02-22 15:41:56.84675+07	\N	6	\N	\N
1452	133	417	\N	2026-02-22 15:42:13.566249+07	\N	4	\N	\N
1453	134	420	\N	2026-02-22 15:42:19.743091+07	\N	3	\N	\N
1454	135	427	\N	2026-02-22 15:42:22.051707+07	\N	1	\N	\N
1455	133	417	\N	2026-02-22 15:42:33.667389+07	\N	2	\N	\N
1456	134	420	\N	2026-02-22 15:42:45.992775+07	\N	0	\N	\N
1457	135	427	\N	2026-02-22 15:42:51.240978+07	\N	3	\N	\N
1458	133	417	\N	2026-02-22 15:46:57.866549+07	\N	0	\N	\N
1459	134	420	\N	2026-02-22 15:47:02.860191+07	\N	0	\N	\N
1460	135	427	\N	2026-02-22 15:47:06.785087+07	\N	0	\N	\N
1461	133	417	\N	2026-02-22 15:47:22.316569+07	\N	3	\N	\N
1462	133	417	\N	2026-02-22 15:47:41.712544+07	\N	3	\N	\N
1463	134	420	\N	2026-02-22 15:47:46.525132+07	\N	0	\N	\N
1464	135	427	\N	2026-02-22 15:47:55.876062+07	\N	0	\N	\N
1465	133	417	\N	2026-02-22 15:51:27.172631+07	\N	2	\N	\N
1466	134	420	\N	2026-02-22 15:51:33.574618+07	\N	4	\N	\N
1467	135	427	\N	2026-02-22 15:51:39.716744+07	\N	48	\N	\N
2438	134	420	\N	2026-03-08 16:56:37.49933+07	\N	0	\N	\N
2449	134	420	\N	2026-03-08 17:09:05.789466+07	\N	1	\N	\N
1470	133	417	\N	2026-02-22 15:59:07.455725+07	\N	0	\N	\N
1471	134	420	\N	2026-02-22 15:59:11.550557+07	\N	2	\N	\N
1472	135	427	\N	2026-02-22 15:59:16.372287+07	\N	3	\N	\N
1473	133	417	\N	2026-02-22 15:59:25.664356+07	\N	2	\N	\N
1474	134	420	\N	2026-02-22 15:59:33.844234+07	\N	4	\N	\N
1475	135	427	\N	2026-02-22 15:59:40.137156+07	\N	4	\N	\N
1476	133	417	\N	2026-02-22 15:59:54.617379+07	\N	6	\N	\N
1477	133	417	\N	2026-02-22 16:00:08.832751+07	\N	1	\N	\N
1478	134	420	\N	2026-02-22 16:00:14.373703+07	\N	3	\N	\N
1479	133	417	\N	2026-02-22 16:00:26.472574+07	\N	3	\N	\N
1480	134	420	\N	2026-02-22 16:00:30.346469+07	\N	2	\N	\N
1481	135	427	\N	2026-02-22 16:00:34.651053+07	\N	2	\N	\N
1482	133	417	t	2026-02-22 16:04:27.019974+07	\N	5	\N	\N
1483	133	417	t	2026-02-22 16:04:29.207494+07	\N	8	\N	\N
1484	133	418	f	2026-02-22 16:04:32.565111+07	\N	11	\N	\N
1485	134	420	t	2026-02-22 16:04:43.458568+07	\N	4	\N	\N
1486	134	420	t	2026-02-22 16:04:47.33784+07	\N	8	\N	\N
1487	134	421	f	2026-02-22 16:04:52.428966+07	\N	13	\N	\N
1488	135	427	t	2026-02-22 16:05:06.089065+07	\N	4	\N	\N
1489	135	426	f	2026-02-22 16:05:09.700283+07	\N	8	\N	\N
1490	135	424	f	2026-02-22 16:05:12.850838+07	\N	11	\N	\N
1491	133	417	t	2026-02-22 16:06:13.655639+07	\N	3	\N	\N
1492	134	420	t	2026-02-22 16:06:22.686903+07	\N	5	\N	\N
1493	135	427	t	2026-02-22 16:06:28.312523+07	\N	2	\N	\N
1494	133	416	f	2026-02-22 16:06:32.278546+07	\N	22	\N	\N
1495	134	420	t	2026-02-22 16:06:38.75459+07	\N	3	\N	\N
1496	135	427	t	2026-02-22 16:06:44.106954+07	\N	2	\N	\N
1497	133	418	f	2026-02-22 16:06:48.040213+07	\N	38	\N	\N
1498	134	420	t	2026-02-22 16:06:53.218416+07	\N	2	\N	\N
1499	135	425	f	2026-02-22 16:06:59.648705+07	\N	4	\N	\N
1500	130	408	\N	2026-02-22 16:32:06.803505+07	\N	4	\N	\N
1501	130	408	\N	2026-02-22 16:32:08.933196+07	\N	6	\N	\N
1502	131	411	\N	2026-02-22 16:32:22.260839+07	1	2	\N	\N
1503	131	412	\N	2026-02-22 16:32:22.286853+07	2	2	\N	\N
1504	131	413	\N	2026-02-22 16:32:22.30857+07	3	2	\N	\N
1505	133	417	\N	2026-02-22 16:34:18.359699+07	\N	3	\N	\N
1506	133	417	\N	2026-02-22 16:34:20.355101+07	\N	5	\N	\N
1507	134	420	\N	2026-02-22 16:34:27.514701+07	\N	4	\N	\N
1508	134	420	\N	2026-02-22 16:34:27.948918+07	\N	4	\N	\N
1509	135	427	\N	2026-02-22 16:34:44.380252+07	\N	3	\N	\N
1510	135	427	\N	2026-02-22 16:34:48.025562+07	\N	7	\N	\N
1511	133	417	\N	2026-02-22 16:35:13.774705+07	\N	1	\N	\N
1512	133	417	\N	2026-02-22 16:35:13.776165+07	\N	1	\N	\N
1513	134	420	\N	2026-02-22 16:35:21.385714+07	\N	1	\N	\N
1514	134	420	\N	2026-02-22 16:35:22.255011+07	\N	2	\N	\N
1515	135	427	\N	2026-02-22 16:35:28.406146+07	\N	2	\N	\N
1516	135	427	\N	2026-02-22 16:35:28.686625+07	\N	2	\N	\N
1517	133	417	\N	2026-02-22 16:35:43.9597+07	\N	0	\N	\N
1518	133	417	\N	2026-02-22 16:35:45.6654+07	\N	2	\N	\N
1519	134	420	\N	2026-02-22 16:35:55.332648+07	\N	1	\N	\N
1520	134	420	\N	2026-02-22 16:35:55.877455+07	\N	1	\N	\N
1521	135	427	\N	2026-02-22 16:36:12.743911+07	\N	1	\N	\N
1522	135	427	\N	2026-02-22 16:36:15.537348+07	\N	4	\N	\N
1523	133	417	\N	2026-02-22 16:36:36.330792+07	\N	1	\N	\N
1524	133	417	\N	2026-02-22 16:36:37.537422+07	\N	2	\N	\N
1525	134	420	\N	2026-02-22 16:36:49.720316+07	\N	1	\N	\N
1526	134	420	\N	2026-02-22 16:36:51.070606+07	\N	3	\N	\N
1527	133	417	\N	2026-02-22 16:37:13.253807+07	\N	1	\N	\N
1528	133	417	\N	2026-02-22 16:37:13.545882+07	\N	1	\N	\N
1529	134	420	\N	2026-02-22 16:37:22.379794+07	\N	2	\N	\N
1530	134	420	\N	2026-02-22 16:37:24.602819+07	\N	4	\N	\N
1531	135	427	\N	2026-02-22 16:37:31.780488+07	\N	1	\N	\N
1532	135	427	\N	2026-02-22 16:37:32.712044+07	\N	2	\N	\N
1533	130	408	\N	2026-02-22 16:42:24.991679+07	\N	4	\N	\N
1534	131	411	\N	2026-02-22 16:42:44.757008+07	1	14	\N	\N
1535	131	412	\N	2026-02-22 16:42:44.77239+07	2	14	\N	\N
1536	131	413	\N	2026-02-22 16:42:44.788588+07	3	14	\N	\N
1537	130	408	\N	2026-02-22 16:46:15.306201+07	\N	3	\N	\N
1538	131	411	\N	2026-02-22 16:46:24.872826+07	1	6	\N	\N
1539	131	412	\N	2026-02-22 16:46:24.893685+07	2	6	\N	\N
1540	131	413	\N	2026-02-22 16:46:24.910491+07	3	6	\N	\N
1541	55	142	\N	2026-02-22 16:46:42.545132+07	\N	1	\N	\N
1542	56	144	\N	2026-02-22 16:46:50.620253+07	\N	4	\N	\N
1543	56	145	\N	2026-02-22 16:46:50.648829+07	\N	4	\N	\N
1544	133	417	\N	2026-02-22 16:53:20.934283+07	\N	2	\N	\N
1545	133	417	\N	2026-02-22 16:53:23.63659+07	\N	4	\N	\N
1546	134	420	\N	2026-02-22 16:53:37.916682+07	\N	1	\N	\N
1547	134	420	\N	2026-02-22 16:53:38.66558+07	\N	2	\N	\N
1548	133	417	\N	2026-02-23 13:40:03.102684+07	\N	3	\N	\N
1549	134	420	\N	2026-02-23 13:40:10.701558+07	\N	3	\N	\N
1550	135	427	\N	2026-02-23 13:40:15.759781+07	\N	1	\N	\N
1551	133	417	\N	2026-02-23 13:40:30.689339+07	\N	3	\N	\N
1552	134	420	\N	2026-02-23 13:40:33.154937+07	\N	1	\N	\N
1553	135	427	\N	2026-02-23 13:40:36.13825+07	\N	8	\N	\N
1554	133	417	\N	2026-02-23 13:40:52.18539+07	\N	3	\N	\N
1555	134	420	\N	2026-02-23 13:40:57.428083+07	\N	3	\N	\N
1556	135	427	\N	2026-02-23 13:41:00.185972+07	\N	11	\N	\N
1557	133	417	\N	2026-02-23 13:41:16.238731+07	\N	2	\N	\N
1558	134	420	\N	2026-02-23 13:41:18.614103+07	\N	0	\N	\N
1559	135	427	\N	2026-02-23 13:41:21.220896+07	\N	7	\N	\N
1560	133	417	\N	2026-02-23 13:41:37.211712+07	\N	1	\N	\N
1561	134	420	\N	2026-02-23 13:41:44.340085+07	\N	2	\N	\N
1562	135	427	\N	2026-02-23 13:41:48.353658+07	\N	2	\N	\N
1563	133	417	\N	2026-02-23 13:42:00.806707+07	\N	3	\N	\N
1564	134	420	\N	2026-02-23 13:42:06.765579+07	\N	4	\N	\N
1565	133	417	\N	2026-02-23 13:42:18.482402+07	\N	2	\N	\N
1566	134	420	\N	2026-02-23 13:42:25.086865+07	\N	5	\N	\N
1567	135	427	\N	2026-02-23 13:42:27.310324+07	\N	1	\N	\N
1568	133	417	\N	2026-02-23 13:42:38.801795+07	\N	2	\N	\N
1569	134	420	\N	2026-02-23 13:42:42.443856+07	\N	2	\N	\N
1570	135	427	\N	2026-02-23 13:42:49.219847+07	\N	12	\N	\N
1571	133	417	\N	2026-02-23 13:43:00.248934+07	\N	2	\N	\N
1572	134	420	\N	2026-02-23 13:43:08.037256+07	\N	6	\N	\N
1573	133	417	\N	2026-02-23 13:45:52.368864+07	\N	3	\N	\N
1574	134	420	\N	2026-02-23 13:45:56.726036+07	\N	1	\N	\N
1575	133	417	\N	2026-02-23 13:46:15.916381+07	\N	4	\N	\N
1576	134	420	\N	2026-02-23 13:46:19.663024+07	\N	2	\N	\N
1577	133	417	\N	2026-02-23 13:46:33.385711+07	\N	2	\N	\N
1578	134	420	\N	2026-02-23 13:46:38.343198+07	\N	3	\N	\N
1579	135	427	\N	2026-02-23 13:46:42.412761+07	\N	2	\N	\N
1580	133	417	\N	2026-02-23 13:46:54.128769+07	\N	3	\N	\N
1581	134	420	\N	2026-02-23 13:46:58.404215+07	\N	1	\N	\N
1582	133	417	\N	2026-02-23 13:47:12.05214+07	\N	1	\N	\N
1583	134	420	\N	2026-02-23 13:47:15.446771+07	\N	2	\N	\N
1584	135	427	\N	2026-02-23 13:47:20.069578+07	\N	3	\N	\N
1585	133	417	\N	2026-02-23 13:47:28.371658+07	\N	0	\N	\N
1586	134	420	\N	2026-02-23 13:47:32.951869+07	\N	2	\N	\N
1587	133	417	\N	2026-02-23 13:51:18.396151+07	\N	2	\N	\N
1588	133	417	\N	2026-02-23 13:52:12.69148+07	\N	1	\N	\N
1589	134	420	\N	2026-02-23 13:52:18.116659+07	\N	1	\N	\N
1590	135	427	\N	2026-02-23 13:52:23.130646+07	\N	1	\N	\N
1591	133	417	\N	2026-02-23 13:52:33.484096+07	\N	1	\N	\N
1592	134	420	\N	2026-02-23 13:52:36.600471+07	\N	1	\N	\N
1593	133	417	\N	2026-02-23 13:52:49.967313+07	\N	1	\N	\N
1594	134	420	\N	2026-02-23 13:52:53.337405+07	\N	1	\N	\N
1595	135	427	\N	2026-02-23 13:52:56.707621+07	\N	2	\N	\N
1596	133	417	\N	2026-02-23 13:53:07.543575+07	\N	1	\N	\N
1597	134	420	\N	2026-02-23 13:53:12.24731+07	\N	1	\N	\N
1598	133	417	\N	2026-02-23 13:53:42.801469+07	\N	3	\N	\N
1599	134	420	\N	2026-02-23 13:53:50.828542+07	\N	3	\N	\N
1600	133	417	\N	2026-02-23 13:54:06.226124+07	\N	1	\N	\N
1601	134	420	\N	2026-02-23 13:54:09.20036+07	\N	1	\N	\N
1602	135	427	\N	2026-02-23 13:54:12.070854+07	\N	1	\N	\N
1603	133	417	\N	2026-02-23 13:54:21.443952+07	\N	0	\N	\N
1604	134	420	\N	2026-02-23 13:54:23.616453+07	\N	0	\N	\N
1605	135	427	\N	2026-02-23 13:54:27.555293+07	\N	2	\N	\N
1606	133	417	\N	2026-02-23 13:57:50.256892+07	\N	1	\N	\N
1607	134	420	\N	2026-02-23 13:57:54.056565+07	\N	1	\N	\N
1608	133	417	\N	2026-02-23 14:00:17.753704+07	\N	0	\N	\N
1609	134	420	\N	2026-02-23 14:00:22.803682+07	\N	1	\N	\N
1610	133	417	\N	2026-02-23 14:01:11.453972+07	\N	1	\N	\N
1611	134	420	\N	2026-02-23 14:01:13.587757+07	\N	1	\N	\N
1612	133	417	\N	2026-02-23 14:03:40.676989+07	\N	0	\N	\N
1613	134	420	\N	2026-02-23 14:03:46.896447+07	\N	2	\N	\N
1614	135	427	\N	2026-02-23 14:03:52.60892+07	\N	2	\N	\N
1615	133	417	\N	2026-02-23 14:04:01.319242+07	\N	0	\N	\N
1616	134	420	\N	2026-02-23 14:04:04.531719+07	\N	0	\N	\N
1617	133	417	\N	2026-02-23 14:04:23.338843+07	\N	0	\N	\N
1618	134	420	\N	2026-02-23 14:04:25.617917+07	\N	1	\N	\N
1619	133	417	\N	2026-02-23 14:09:20.857002+07	\N	1	\N	\N
1620	134	420	\N	2026-02-23 14:09:27.173936+07	\N	2	\N	\N
1621	135	427	\N	2026-02-23 14:09:30.814844+07	\N	1	\N	\N
1622	133	417	\N	2026-02-23 14:09:41.219818+07	\N	0	\N	\N
1623	134	420	\N	2026-02-23 14:09:44.119549+07	\N	0	\N	\N
1624	135	427	\N	2026-02-23 14:09:47.751642+07	\N	1	\N	\N
1625	133	417	\N	2026-02-23 14:09:57.271817+07	\N	1	\N	\N
1626	134	420	\N	2026-02-23 14:09:59.606504+07	\N	1	\N	\N
1627	135	427	\N	2026-02-23 14:10:01.670524+07	\N	1	\N	\N
1628	133	417	\N	2026-02-23 14:10:11.607186+07	\N	0	\N	\N
1629	134	420	\N	2026-02-23 14:10:22.688035+07	\N	0	\N	\N
1630	135	427	\N	2026-02-23 14:10:27.980335+07	\N	0	\N	\N
1631	133	417	\N	2026-02-23 14:10:47.891168+07	\N	0	\N	\N
1632	133	417	\N	2026-02-23 14:14:27.789519+07	\N	0	\N	\N
1633	134	420	\N	2026-02-23 14:14:33.57198+07	\N	0	\N	\N
1635	133	417	\N	2026-02-23 14:17:42.214236+07	\N	0	\N	\N
1636	134	420	\N	2026-02-23 14:17:45.50346+07	\N	0	\N	\N
1637	135	427	\N	2026-02-23 14:17:48.482218+07	\N	1	\N	\N
1638	133	417	\N	2026-02-23 14:18:35.085162+07	\N	1	\N	\N
1639	134	420	\N	2026-02-23 14:18:40.771441+07	\N	1	\N	\N
1640	135	427	\N	2026-02-23 14:18:45.441344+07	\N	1	\N	\N
1641	133	417	\N	2026-02-23 14:18:55.002683+07	\N	1	\N	\N
1642	134	420	\N	2026-02-23 14:18:58.061302+07	\N	0	\N	\N
1643	133	417	\N	2026-02-23 14:19:15.298849+07	\N	0	\N	\N
1644	134	420	\N	2026-02-23 14:19:20.229519+07	\N	0	\N	\N
1645	135	427	\N	2026-02-23 14:19:25.460282+07	\N	0	\N	\N
1646	133	417	\N	2026-02-23 14:19:51.407856+07	\N	1	\N	\N
1647	134	420	\N	2026-02-23 14:19:55.395981+07	\N	1	\N	\N
1648	133	417	\N	2026-02-23 14:20:08.460291+07	\N	0	\N	\N
1649	134	420	\N	2026-02-23 14:20:13.315063+07	\N	0	\N	\N
1650	133	417	\N	2026-02-23 14:20:43.965803+07	\N	1	\N	\N
1651	134	420	\N	2026-02-23 14:20:48.337016+07	\N	1	\N	\N
1652	133	417	\N	2026-02-23 14:21:05.617808+07	\N	1	\N	\N
1653	134	420	\N	2026-02-23 14:21:07.780114+07	\N	0	\N	\N
1654	135	427	\N	2026-02-23 14:21:11.46541+07	\N	2	\N	\N
1655	133	417	\N	2026-02-23 14:21:23.151153+07	\N	3	\N	\N
1656	134	420	\N	2026-02-23 14:21:26.479017+07	\N	1	\N	\N
1657	133	417	\N	2026-02-23 14:21:37.191802+07	\N	2	\N	\N
1658	134	420	\N	2026-02-23 14:21:42.065294+07	\N	1	\N	\N
1659	135	427	\N	2026-02-23 14:21:46.729591+07	\N	2	\N	\N
1660	133	417	\N	2026-02-23 14:21:56.161941+07	\N	2	\N	\N
1661	134	420	\N	2026-02-23 14:22:01.006927+07	\N	2	\N	\N
1662	135	427	\N	2026-02-23 14:22:06.047025+07	\N	2	\N	\N
1663	133	417	\N	2026-02-23 14:22:13.814364+07	\N	1	\N	\N
1664	134	420	\N	2026-02-23 14:22:16.419712+07	\N	1	\N	\N
1665	135	427	\N	2026-02-23 14:22:18.946534+07	\N	1	\N	\N
1666	133	417	\N	2026-02-23 14:22:38.468175+07	\N	1	\N	\N
1667	134	420	\N	2026-02-23 14:22:42.585205+07	\N	0	\N	\N
1668	133	417	\N	2026-02-23 14:22:54.370478+07	\N	1	\N	\N
1669	134	420	\N	2026-02-23 14:22:56.640018+07	\N	1	\N	\N
1670	133	417	\N	2026-02-23 14:23:13.334638+07	\N	1	\N	\N
1671	134	420	\N	2026-02-23 14:23:16.413885+07	\N	1	\N	\N
1672	133	417	\N	2026-02-23 14:25:38.29064+07	\N	2	\N	\N
1673	134	420	\N	2026-02-23 14:25:43.672983+07	\N	2	\N	\N
1674	133	417	\N	2026-02-23 14:26:07.23986+07	\N	1	\N	\N
1675	134	420	\N	2026-02-23 14:26:10.560262+07	\N	0	\N	\N
1676	135	427	\N	2026-02-23 14:26:16.929823+07	\N	2	\N	\N
1677	133	417	\N	2026-02-23 14:26:28.417818+07	\N	1	\N	\N
1678	134	420	\N	2026-02-23 14:26:33.356783+07	\N	1	\N	\N
1679	135	427	\N	2026-02-23 14:26:38.327739+07	\N	1	\N	\N
1680	133	417	\N	2026-02-23 14:26:47.994319+07	\N	1	\N	\N
1681	134	420	\N	2026-02-23 14:26:50.854134+07	\N	1	\N	\N
1682	135	427	\N	2026-02-23 14:26:53.952668+07	\N	1	\N	\N
1683	133	417	\N	2026-02-23 14:27:04.041149+07	\N	0	\N	\N
1684	134	420	\N	2026-02-23 14:27:05.986705+07	\N	0	\N	\N
1685	135	427	\N	2026-02-23 14:27:08.345655+07	\N	1	\N	\N
1686	133	417	\N	2026-02-23 14:27:17.37721+07	\N	1	\N	\N
1687	134	420	\N	2026-02-23 14:27:19.872903+07	\N	1	\N	\N
1688	135	427	\N	2026-02-23 14:27:22.45998+07	\N	1	\N	\N
1689	133	417	\N	2026-02-23 14:27:34.699885+07	\N	0	\N	\N
1690	134	420	\N	2026-02-23 14:27:36.945133+07	\N	1	\N	\N
1691	135	427	\N	2026-02-23 14:27:39.15067+07	\N	1	\N	\N
1692	133	417	\N	2026-02-23 14:27:48.678602+07	\N	1	\N	\N
1693	134	420	\N	2026-02-23 14:27:50.553831+07	\N	0	\N	\N
1694	135	427	\N	2026-02-23 14:27:52.51096+07	\N	1	\N	\N
1695	133	417	\N	2026-02-23 14:28:00.100879+07	\N	0	\N	\N
1696	134	420	\N	2026-02-23 14:28:03.734937+07	\N	1	\N	\N
1697	135	427	\N	2026-02-23 14:28:07.552285+07	\N	1	\N	\N
1698	133	417	\N	2026-02-23 14:28:14.648268+07	\N	0	\N	\N
1699	134	420	\N	2026-02-23 14:28:18.468695+07	\N	2	\N	\N
1700	135	427	\N	2026-02-23 14:28:23.277535+07	\N	3	\N	\N
1701	133	417	\N	2026-02-23 14:28:36.265476+07	\N	2	\N	\N
1702	134	420	\N	2026-02-23 14:28:41.618976+07	\N	3	\N	\N
1703	133	417	\N	2026-02-23 15:13:32.077889+07	\N	1	\N	\N
1704	133	417	\N	2026-02-23 15:14:32.849753+07	\N	2	\N	\N
1705	133	417	\N	2026-02-23 15:17:51.634159+07	\N	1	\N	\N
1706	133	417	\N	2026-02-23 15:22:48.754915+07	\N	0	\N	\N
1707	133	417	\N	2026-02-23 15:26:27.893911+07	\N	1	\N	\N
1708	133	417	\N	2026-02-23 15:33:02.247528+07	\N	1	\N	\N
1709	134	420	\N	2026-02-23 15:33:07.177865+07	\N	1	\N	\N
1710	133	417	\N	2026-02-23 15:34:00.352748+07	\N	2	\N	\N
1711	133	417	\N	2026-02-23 15:34:01.602671+07	\N	3	\N	\N
1712	134	420	\N	2026-02-23 15:34:10.80205+07	\N	1	\N	\N
1713	134	420	\N	2026-02-23 15:34:11.533453+07	\N	1	\N	\N
1714	135	427	\N	2026-02-23 15:34:24.163371+07	\N	6	\N	\N
1715	133	417	\N	2026-02-23 15:34:42.600088+07	\N	1	\N	\N
1716	133	417	\N	2026-02-23 15:34:44.220756+07	\N	3	\N	\N
1717	134	420	\N	2026-02-23 15:34:51.130682+07	\N	1	\N	\N
1718	134	420	\N	2026-02-23 15:34:54.106621+07	\N	4	\N	\N
1719	135	427	\N	2026-02-23 15:35:04.233122+07	\N	2	\N	\N
1720	135	427	\N	2026-02-23 15:35:05.225492+07	\N	3	\N	\N
1721	133	417	\N	2026-02-23 15:41:50.399959+07	\N	1	\N	\N
1722	133	417	\N	2026-02-23 15:41:51.474771+07	\N	2	\N	\N
1723	133	417	\N	2026-02-23 15:52:22.503009+07	\N	1	\N	\N
1724	133	417	\N	2026-02-23 15:52:23.5649+07	\N	2	\N	\N
1725	133	417	\N	2026-02-23 16:02:35.424673+07	\N	2	\N	\N
1726	133	417	\N	2026-02-23 16:02:35.706222+07	\N	2	\N	\N
1727	134	420	\N	2026-02-23 16:02:43.229758+07	\N	2	\N	\N
1728	134	420	\N	2026-02-23 16:02:43.728483+07	\N	2	\N	\N
1729	135	427	\N	2026-02-23 16:02:55.040918+07	\N	2	\N	\N
1730	135	427	\N	2026-02-23 16:02:57.06816+07	\N	4	\N	\N
1731	133	417	\N	2026-02-23 16:03:18.861064+07	\N	2	\N	\N
1732	133	417	\N	2026-02-23 16:03:18.87795+07	\N	2	\N	\N
1733	133	417	\N	2026-02-23 16:06:30.80982+07	\N	1	\N	\N
1734	133	417	\N	2026-02-23 16:06:32.019797+07	\N	2	\N	\N
1735	134	420	\N	2026-02-23 16:06:38.379935+07	\N	1	\N	\N
1736	134	420	\N	2026-02-23 16:06:38.456719+07	\N	1	\N	\N
1737	135	427	\N	2026-02-23 16:06:45.328293+07	\N	1	\N	\N
1738	135	427	\N	2026-02-23 16:06:45.559977+07	\N	2	\N	\N
1739	133	417	\N	2026-02-23 16:09:37.022082+07	\N	1	\N	\N
1740	133	417	\N	2026-02-23 16:09:37.037631+07	\N	1	\N	\N
1741	134	420	\N	2026-02-23 16:09:46.827169+07	\N	2	\N	\N
1742	134	420	\N	2026-02-23 16:09:46.941496+07	\N	2	\N	\N
1743	135	427	\N	2026-02-23 16:09:53.878572+07	\N	2	\N	\N
1744	135	427	\N	2026-02-23 16:09:53.946669+07	\N	2	\N	\N
1745	133	417	\N	2026-02-23 16:11:20.67111+07	\N	1	\N	\N
1746	133	417	\N	2026-02-23 16:11:20.687486+07	\N	1	\N	\N
1747	133	417	\N	2026-02-23 16:13:20.027373+07	\N	1	\N	\N
1748	133	417	\N	2026-02-23 16:13:20.053068+07	\N	1	\N	\N
1749	133	417	\N	2026-02-23 16:14:01.840481+07	\N	1	\N	\N
1750	133	417	\N	2026-02-23 16:14:01.871371+07	\N	1	\N	\N
1751	133	417	\N	2026-02-23 16:16:33.307536+07	\N	1	\N	\N
1752	133	417	\N	2026-02-23 16:16:33.316272+07	\N	1	\N	\N
1753	134	420	\N	2026-02-23 16:16:45.741506+07	\N	3	\N	\N
1754	134	420	\N	2026-02-23 16:16:46.00153+07	\N	3	\N	\N
1755	133	417	\N	2026-02-23 16:18:13.302574+07	\N	1	\N	\N
1756	133	417	\N	2026-02-23 16:18:13.344378+07	\N	1	\N	\N
1757	133	417	\N	2026-02-23 16:20:25.756036+07	\N	2	\N	\N
1758	133	417	\N	2026-02-23 16:20:25.818995+07	\N	2	\N	\N
1759	134	420	\N	2026-02-23 16:22:51.591465+07	\N	2	\N	\N
1760	134	420	\N	2026-02-23 16:22:51.644787+07	\N	2	\N	\N
1761	135	427	\N	2026-02-23 16:22:58.078637+07	\N	2	\N	\N
1762	135	427	\N	2026-02-23 16:22:58.108338+07	\N	2	\N	\N
1763	133	417	\N	2026-02-23 16:28:36.400572+07	\N	1	\N	\N
1764	133	417	\N	2026-02-23 16:28:46.989556+07	\N	1	\N	\N
1765	134	420	\N	2026-02-23 16:28:52.373438+07	\N	14	\N	\N
1766	135	427	\N	2026-02-23 16:28:56.345296+07	\N	1	\N	\N
1767	133	417	\N	2026-02-23 16:30:33.186901+07	\N	1	\N	\N
1768	133	417	\N	2026-02-23 16:30:33.256206+07	\N	1	\N	\N
1769	134	420	\N	2026-02-23 16:30:37.747302+07	\N	1	\N	\N
1770	134	420	\N	2026-02-23 16:30:39.002827+07	\N	2	\N	\N
1771	135	427	\N	2026-02-23 16:30:44.210091+07	\N	1	\N	\N
1772	135	427	\N	2026-02-23 16:30:45.01884+07	\N	2	\N	\N
1773	133	417	\N	2026-02-23 16:59:46.078894+07	\N	1	\N	\N
1774	133	417	\N	2026-02-23 16:59:46.160926+07	\N	8	\N	\N
1775	134	420	\N	2026-02-23 16:59:51.360955+07	\N	1	\N	\N
1776	134	420	\N	2026-02-23 16:59:51.854962+07	\N	2	\N	\N
1777	135	427	\N	2026-02-23 16:59:56.054461+07	\N	1	\N	\N
1778	135	427	\N	2026-02-23 16:59:56.131021+07	\N	1	\N	\N
1779	133	417	\N	2026-02-23 17:06:49.539601+07	\N	2	\N	\N
1780	133	417	\N	2026-02-23 17:06:49.965035+07	\N	17	\N	\N
1781	134	420	\N	2026-02-23 17:06:54.875947+07	\N	1	\N	\N
1782	134	420	\N	2026-02-23 17:06:56.533455+07	\N	3	\N	\N
1783	135	427	\N	2026-02-23 17:06:59.653913+07	\N	1	\N	\N
1784	135	427	\N	2026-02-23 17:07:00.029593+07	\N	1	\N	\N
1785	133	417	\N	2026-02-23 17:11:16.692174+07	\N	1	\N	\N
1786	134	420	\N	2026-02-23 17:11:22.57426+07	\N	1	\N	\N
1787	135	427	\N	2026-02-23 17:11:26.42344+07	\N	1	\N	\N
1788	133	417	\N	2026-02-23 17:20:26.463849+07	\N	1	\N	\N
1789	133	417	\N	2026-02-23 17:20:26.622139+07	\N	1	\N	\N
1790	134	420	\N	2026-02-23 17:20:31.039074+07	\N	1	\N	\N
1791	134	420	\N	2026-02-23 17:20:31.440152+07	\N	1	\N	\N
1792	135	427	\N	2026-02-23 17:20:34.345627+07	\N	1	\N	\N
1793	135	427	\N	2026-02-23 17:20:34.59667+07	\N	1	\N	\N
1794	133	417	\N	2026-02-23 17:20:53.472856+07	\N	1	\N	\N
1795	133	417	\N	2026-02-23 17:20:53.806531+07	\N	1	\N	\N
1796	134	420	\N	2026-02-23 17:20:57.871213+07	\N	1	\N	\N
1797	134	421	\N	2026-02-23 17:20:59.167502+07	\N	2	\N	\N
1798	135	427	\N	2026-02-23 17:21:03.857833+07	\N	3	\N	\N
1799	135	427	\N	2026-02-23 17:21:05.205428+07	\N	2	\N	\N
1800	133	417	\N	2026-02-23 17:21:28.404871+07	\N	0	\N	\N
1801	134	420	\N	2026-02-23 17:21:30.23107+07	\N	0	\N	\N
1802	135	427	\N	2026-02-23 17:21:32.604447+07	\N	1	\N	\N
1803	133	417	\N	2026-02-23 17:21:53.798271+07	\N	1	\N	\N
1804	133	417	\N	2026-02-23 17:21:54.018238+07	\N	0	\N	\N
1805	133	417	\N	2026-02-25 14:52:43.695955+07	\N	1	\N	\N
1806	134	420	\N	2026-02-25 14:52:46.167986+07	\N	1	\N	\N
1807	135	427	\N	2026-02-25 14:52:48.766426+07	\N	1	\N	\N
1808	133	417	\N	2026-02-25 15:18:37.835136+07	\N	2	\N	\N
1809	133	417	\N	2026-02-25 15:26:13.348583+07	\N	2	\N	\N
1810	133	417	t	2026-02-25 16:11:13.530179+07	\N	75	\N	\N
1811	133	417	t	2026-02-25 16:11:15.64025+07	\N	78	\N	\N
1812	133	417	t	2026-02-25 16:11:19.642305+07	\N	82	\N	\N
1813	133	417	t	2026-02-25 16:11:22.85503+07	\N	85	\N	\N
1814	133	417	t	2026-03-02 14:27:36.454551+07	\N	7	\N	\N
1815	133	417	t	2026-03-02 14:28:15.703424+07	\N	1	\N	\N
1816	133	417	t	2026-03-02 14:40:49.254468+07	\N	1	\N	\N
1819	133	417	\N	2026-03-02 15:31:29.19394+07	\N	0	\N	\N
1820	134	420	\N	2026-03-02 15:31:39.66463+07	\N	4	\N	\N
1821	135	427	\N	2026-03-02 15:31:45.931823+07	\N	1	\N	\N
1822	133	417	\N	2026-03-02 15:37:19.277936+07	\N	0	\N	\N
1823	134	420	\N	2026-03-02 15:37:25.597254+07	\N	3	\N	\N
1824	135	427	\N	2026-03-02 15:37:33.178582+07	\N	4	\N	\N
1825	133	417	\N	2026-03-02 15:37:48.381571+07	\N	1	\N	\N
1827	131	411	\N	2026-03-02 15:38:11.760651+07	1	5	\N	\N
1828	131	412	\N	2026-03-02 15:38:11.760651+07	2	5	\N	\N
1829	131	413	\N	2026-03-02 15:38:11.760651+07	3	5	\N	\N
1830	132	415	\N	2026-03-02 15:38:15.566728+07	\N	1	\N	\N
1831	130	408	\N	2026-03-02 15:38:33.755344+07	\N	0	\N	\N
1832	131	411	\N	2026-03-02 15:38:38.555733+07	1	3	\N	\N
1833	131	412	\N	2026-03-02 15:38:38.555733+07	2	3	\N	\N
1834	131	413	\N	2026-03-02 15:38:38.555733+07	3	3	\N	\N
1835	132	415	\N	2026-03-02 15:38:40.304024+07	\N	0	\N	\N
1836	133	417	\N	2026-03-02 15:38:58.136906+07	\N	0	\N	\N
1837	134	420	\N	2026-03-02 15:39:05.110651+07	\N	1	\N	\N
1838	135	427	\N	2026-03-02 15:39:09.185079+07	\N	1	\N	\N
1839	133	417	\N	2026-03-02 15:39:30.103873+07	\N	1	\N	\N
1840	134	420	\N	2026-03-02 15:39:33.247753+07	\N	0	\N	\N
1841	135	427	\N	2026-03-02 15:39:37.21397+07	\N	1	\N	\N
1842	133	417	\N	2026-03-02 15:42:56.981011+07	\N	0	\N	\N
1843	135	427	\N	2026-03-02 15:43:03.853888+07	\N	1	\N	\N
1844	133	417	\N	2026-03-02 15:46:52.647703+07	\N	0	\N	\N
1845	134	420	\N	2026-03-02 15:46:55.952264+07	\N	0	\N	\N
1846	135	427	\N	2026-03-02 15:46:58.785964+07	\N	0	\N	\N
1847	133	417	\N	2026-03-02 16:18:29.192494+07	\N	6	\N	\N
1848	133	417	\N	2026-03-02 16:18:30.105963+07	\N	7	\N	\N
1849	48	116	\N	2026-03-02 16:49:48.993916+07	\N	12	\N	\N
1850	48	117	\N	2026-03-02 16:49:50.34114+07	\N	14	\N	\N
1851	133	417	\N	2026-03-04 13:24:38.118889+07	\N	2	\N	\N
1852	134	420	\N	2026-03-04 13:24:42.884849+07	\N	1	\N	\N
1853	135	427	\N	2026-03-04 13:24:46.800067+07	\N	1	\N	\N
1854	133	417	\N	2026-03-04 13:38:45.947432+07	\N	1	\N	\N
1855	134	420	\N	2026-03-04 13:38:50.591803+07	\N	1	\N	\N
1856	135	427	\N	2026-03-04 13:38:55.274358+07	\N	2	\N	\N
1857	133	418	\N	2026-03-04 13:50:18.063314+07	\N	5	\N	\N
1858	133	417	\N	2026-03-04 13:50:19.608732+07	\N	7	\N	\N
1859	134	420	\N	2026-03-04 13:57:11.171168+07	\N	2	\N	\N
1860	134	420	\N	2026-03-04 13:57:19.837182+07	\N	11	\N	\N
1861	135	427	\N	2026-03-04 14:00:32.517057+07	\N	3	\N	\N
1862	135	426	\N	2026-03-04 14:00:35.168877+07	\N	5	\N	\N
1863	133	417	\N	2026-03-04 14:04:45.548475+07	\N	4	\N	\N
1864	133	417	\N	2026-03-04 14:04:49.835066+07	\N	9	\N	\N
1865	134	420	\N	2026-03-04 14:05:05.148143+07	\N	4	\N	\N
1866	134	423	\N	2026-03-04 14:05:06.037476+07	\N	5	\N	\N
1867	135	427	\N	2026-03-04 14:05:37.30907+07	\N	4	\N	\N
1868	135	427	\N	2026-03-04 14:05:39.657003+07	\N	7	\N	\N
1870	136	428	\N	2026-03-04 14:07:54.509461+07	\N	2	\N	\N
1871	133	416	\N	2026-03-04 14:08:27.311192+07	\N	2	\N	\N
1872	133	416	\N	2026-03-04 14:10:04.766796+07	\N	6	\N	\N
1873	133	417	\N	2026-03-04 14:10:10.343131+07	\N	12	\N	\N
1874	134	420	\N	2026-03-04 14:10:14.740285+07	\N	2	\N	\N
1875	135	427	\N	2026-03-04 14:10:19.305504+07	\N	1	\N	\N
1876	134	420	\N	2026-03-04 14:10:26.036782+07	\N	18	\N	\N
1877	135	427	\N	2026-03-04 14:10:30.873763+07	\N	2	\N	\N
1878	133	417	\N	2026-03-04 14:17:00.4092+07	\N	3	\N	\N
1879	133	417	\N	2026-03-04 14:17:04.07009+07	\N	7	\N	\N
1880	134	420	\N	2026-03-04 14:17:19.851474+07	\N	4	\N	\N
1881	134	423	\N	2026-03-04 14:17:21.783399+07	\N	6	\N	\N
1882	135	426	\N	2026-03-04 14:17:34.455785+07	\N	5	\N	\N
1883	135	427	\N	2026-03-04 14:17:35.906553+07	\N	6	\N	\N
1884	133	417	\N	2026-03-04 14:27:49.164009+07	\N	1	\N	\N
1885	133	417	\N	2026-03-04 14:27:54.731602+07	\N	6	\N	\N
1886	134	420	\N	2026-03-04 14:28:09.78932+07	\N	3	\N	\N
1887	134	423	\N	2026-03-04 14:28:10.53999+07	\N	4	\N	\N
1888	135	427	\N	2026-03-04 14:28:24.662556+07	\N	3	\N	\N
1889	135	427	\N	2026-03-04 14:28:26.369819+07	\N	4	\N	\N
1890	133	417	\N	2026-03-04 14:33:10.240112+07	\N	3	\N	\N
1891	133	417	\N	2026-03-04 14:33:11.733459+07	\N	2	\N	\N
1892	133	417	\N	2026-03-04 14:33:14.062465+07	\N	5	\N	\N
1893	134	420	\N	2026-03-04 14:34:13.550969+07	\N	3	\N	\N
1894	134	420	\N	2026-03-04 14:34:14.78439+07	\N	5	\N	\N
1895	134	423	\N	2026-03-04 14:34:18.338203+07	\N	8	\N	\N
1896	135	427	\N	2026-03-04 14:34:39.429674+07	\N	3	\N	\N
1897	135	427	\N	2026-03-04 14:34:40.765372+07	\N	4	\N	\N
1898	135	425	\N	2026-03-04 14:34:45.516394+07	\N	9	\N	\N
1899	133	417	\N	2026-03-04 14:41:18.299387+07	\N	3	\N	\N
1900	134	420	\N	2026-03-04 14:41:34.115585+07	\N	6	\N	\N
1901	134	420	\N	2026-03-04 14:41:34.164477+07	\N	6	\N	\N
1902	134	420	\N	2026-03-04 14:41:35.975692+07	\N	8	\N	\N
1903	135	427	\N	2026-03-04 14:41:43.035163+07	\N	2	\N	\N
1904	135	427	\N	2026-03-04 14:41:45.537335+07	\N	5	\N	\N
1905	135	427	\N	2026-03-04 14:41:47.24123+07	\N	6	\N	\N
1906	133	417	\N	2026-03-04 14:42:28.817721+07	\N	1	\N	\N
1907	133	417	\N	2026-03-04 14:42:29.043413+07	\N	1	\N	\N
1909	133	417	\N	2026-03-04 14:45:09.792619+07	\N	10	\N	\N
1910	133	417	\N	2026-03-04 14:45:11.164276+07	\N	11	\N	\N
1911	133	417	\N	2026-03-04 14:45:16.852452+07	\N	2	\N	\N
1912	133	417	\N	2026-03-04 14:45:17.913564+07	\N	3	\N	\N
1913	134	420	\N	2026-03-04 14:46:40.398891+07	\N	3	\N	\N
1914	134	420	\N	2026-03-04 14:46:43.51932+07	\N	6	\N	\N
1915	133	417	\N	2026-03-04 14:46:54.288084+07	\N	2	\N	\N
1916	135	427	\N	2026-03-04 14:47:18.734168+07	\N	5	\N	\N
1917	135	427	\N	2026-03-04 14:47:20.051278+07	\N	6	\N	\N
1918	135	427	\N	2026-03-04 14:47:22.682062+07	\N	8	\N	\N
1919	133	417	\N	2026-03-04 14:55:27.356043+07	\N	4	\N	\N
1920	133	417	\N	2026-03-04 14:55:30.293454+07	\N	7	\N	\N
1921	133	417	\N	2026-03-04 14:55:32.359029+07	\N	8	\N	\N
1922	134	420	\N	2026-03-04 14:55:48.149243+07	\N	3	\N	\N
1923	135	427	\N	2026-03-04 14:55:57.129143+07	\N	4	\N	\N
1924	135	427	\N	2026-03-04 14:55:58.301648+07	\N	5	\N	\N
1925	135	427	\N	2026-03-04 14:56:01.965696+07	\N	8	\N	\N
1926	133	417	\N	2026-03-04 15:03:49.278821+07	\N	3	\N	\N
1927	133	417	\N	2026-03-04 15:03:51.933998+07	\N	6	\N	\N
1928	133	418	\N	2026-03-04 15:03:55.573993+07	\N	9	\N	\N
1931	134	420	\N	2026-03-04 15:04:19.257957+07	\N	7	\N	\N
1933	135	427	\N	2026-03-04 15:04:46.93599+07	\N	4	\N	\N
1935	133	417	\N	2026-03-04 15:28:47.857477+07	\N	1	\N	\N
1936	133	417	\N	2026-03-04 15:28:49.01807+07	\N	2	\N	\N
1937	133	417	\N	2026-03-04 15:45:08.778579+07	\N	1	\N	\N
1938	133	417	\N	2026-03-04 15:45:09.511836+07	\N	2	\N	\N
1939	134	420	\N	2026-03-04 15:45:28.908666+07	\N	3	\N	\N
1940	134	420	\N	2026-03-04 15:45:31.19378+07	\N	6	\N	\N
1941	133	417	\N	2026-03-04 15:48:02.775311+07	\N	1	\N	\N
1942	133	417	\N	2026-03-04 15:48:07.151968+07	\N	5	\N	\N
1943	133	417	\N	2026-03-04 15:49:53.393571+07	\N	2	\N	\N
1944	133	417	\N	2026-03-04 15:49:55.787602+07	\N	4	\N	\N
1945	134	420	\N	2026-03-04 15:50:03.824397+07	\N	3	\N	\N
1946	134	420	\N	2026-03-04 15:50:05.037202+07	\N	4	\N	\N
1947	133	417	\N	2026-03-04 15:59:31.317519+07	\N	2	\N	\N
1948	133	417	\N	2026-03-04 15:59:34.371542+07	\N	5	\N	\N
1949	134	420	\N	2026-03-04 15:59:51.931918+07	\N	2	\N	\N
1950	134	420	\N	2026-03-04 16:00:02.710985+07	\N	13	\N	\N
1951	133	417	\N	2026-03-04 16:10:06.010867+07	\N	1	\N	\N
1952	133	417	\N	2026-03-04 16:10:08.573844+07	\N	3	\N	\N
1953	134	420	\N	2026-03-04 16:10:19.044223+07	\N	3	\N	\N
1954	134	420	\N	2026-03-04 16:10:19.922899+07	\N	4	\N	\N
1955	135	427	\N	2026-03-04 16:11:06.314189+07	\N	1	\N	\N
1956	135	427	\N	2026-03-04 16:11:08.082285+07	\N	3	\N	\N
1957	133	417	\N	2026-03-04 16:22:01.40593+07	\N	1	\N	\N
1958	133	417	\N	2026-03-04 16:22:06.307356+07	\N	6	\N	\N
1959	133	417	\N	2026-03-04 16:25:24.784201+07	\N	5	\N	\N
1960	133	417	\N	2026-03-04 16:25:28.698605+07	\N	9	\N	\N
1961	133	417	\N	2026-03-04 16:32:09.223774+07	\N	1	\N	\N
1962	133	417	\N	2026-03-04 16:32:11.76162+07	\N	4	\N	\N
1963	133	417	\N	2026-03-04 16:46:19.653204+07	\N	6	\N	\N
1964	133	417	\N	2026-03-04 16:46:21.208218+07	\N	7	\N	\N
1965	133	417	\N	2026-03-04 16:54:48.120676+07	\N	3	\N	\N
1966	133	417	\N	2026-03-04 16:54:49.39571+07	\N	4	\N	\N
1967	133	417	\N	2026-03-04 16:57:01.370894+07	\N	2	\N	\N
1968	133	417	\N	2026-03-04 16:57:02.640051+07	\N	3	\N	\N
1969	133	417	\N	2026-03-04 16:59:05.407716+07	\N	1	\N	\N
1970	133	417	\N	2026-03-04 16:59:07.527437+07	\N	20	\N	\N
1971	134	420	\N	2026-03-04 16:59:17.086426+07	\N	3	\N	\N
1972	134	420	\N	2026-03-04 16:59:18.768321+07	\N	5	\N	\N
1973	135	427	\N	2026-03-04 16:59:27.311541+07	\N	2	\N	\N
1974	135	427	\N	2026-03-04 16:59:28.476939+07	\N	3	\N	\N
1975	133	417	\N	2026-03-04 17:02:40.346833+07	\N	1	\N	\N
1976	133	417	\N	2026-03-04 17:02:41.779038+07	\N	2	\N	\N
1977	133	417	\N	2026-03-04 17:03:44.861668+07	\N	1	\N	\N
1978	133	417	\N	2026-03-04 17:03:46.506944+07	\N	2	\N	\N
1995	133	417	\N	2026-03-04 17:17:58.508092+07	\N	28	\N	\N
1996	133	417	\N	2026-03-04 17:18:03.000483+07	\N	33	\N	\N
1997	134	420	\N	2026-03-04 17:18:12.796221+07	\N	2	\N	\N
1999	134	420	\N	2026-03-04 17:18:17.352961+07	\N	7	\N	\N
2001	135	426	\N	2026-03-04 17:18:28.913664+07	\N	6	\N	\N
2002	135	427	\N	2026-03-04 17:18:31.205632+07	\N	8	\N	\N
2003	133	417	\N	2026-03-04 17:36:02.485084+07	\N	3	\N	\N
2004	133	417	\N	2026-03-04 17:44:07.869894+07	\N	1	\N	\N
2005	133	417	\N	2026-03-04 17:44:08.992469+07	\N	2	\N	\N
2006	133	417	\N	2026-03-05 14:00:57.420398+07	\N	1	\N	\N
2007	133	417	\N	2026-03-05 14:00:59.764196+07	\N	3	\N	\N
2008	134	420	\N	2026-03-05 14:01:07.755524+07	\N	1	\N	\N
2009	134	420	\N	2026-03-05 14:01:09.058166+07	\N	3	\N	\N
2010	135	427	\N	2026-03-05 14:01:21.221846+07	\N	2	\N	\N
2011	135	427	\N	2026-03-05 14:01:22.493893+07	\N	3	\N	\N
2012	133	417	\N	2026-03-05 14:01:59.027016+07	\N	2	\N	\N
2013	133	417	\N	2026-03-05 14:01:59.237721+07	\N	2	\N	\N
2014	134	420	\N	2026-03-05 14:02:11.12563+07	\N	2	\N	\N
2015	134	420	\N	2026-03-05 14:02:12.92095+07	\N	3	\N	\N
2016	135	427	\N	2026-03-05 14:02:30.433976+07	\N	1	\N	\N
2017	135	427	\N	2026-03-05 14:02:33.110718+07	\N	4	\N	\N
2018	130	408	\N	2026-03-05 14:06:22.199628+07	\N	1	\N	\N
2019	130	408	\N	2026-03-05 14:06:23.467815+07	\N	2	\N	\N
2020	131	411	\N	2026-03-05 14:06:31.852579+07	1	3	\N	\N
2021	131	412	\N	2026-03-05 14:06:31.852579+07	2	3	\N	\N
2022	131	413	\N	2026-03-05 14:06:31.852579+07	3	3	\N	\N
2023	131	411	\N	2026-03-05 14:06:36.873442+07	1	8	\N	\N
2024	131	412	\N	2026-03-05 14:06:36.873442+07	2	8	\N	\N
2025	131	413	\N	2026-03-05 14:06:36.873442+07	3	8	\N	\N
2026	132	415	\N	2026-03-05 14:06:42.76132+07	\N	1	\N	\N
2027	132	415	\N	2026-03-05 14:06:43.798296+07	\N	2	\N	\N
2028	133	417	\N	2026-03-05 14:07:03.680447+07	\N	1	\N	\N
2029	133	417	\N	2026-03-05 14:07:04.328951+07	\N	1	\N	\N
2030	134	420	\N	2026-03-05 14:07:09.564034+07	\N	1	\N	\N
2031	134	420	\N	2026-03-05 14:07:10.081436+07	\N	2	\N	\N
2032	135	427	\N	2026-03-05 14:07:14.637875+07	\N	1	\N	\N
2033	135	427	\N	2026-03-05 14:07:15.218855+07	\N	2	\N	\N
2034	133	417	\N	2026-03-05 14:09:35.251482+07	\N	1	\N	\N
2035	133	417	\N	2026-03-05 14:09:35.774197+07	\N	2	\N	\N
2036	134	420	\N	2026-03-05 14:09:40.224901+07	\N	1	\N	\N
2037	134	420	\N	2026-03-05 14:09:40.59231+07	\N	1	\N	\N
2038	135	427	\N	2026-03-05 14:09:47.481184+07	\N	1	\N	\N
2039	135	427	\N	2026-03-05 14:09:48.157774+07	\N	2	\N	\N
2040	133	417	\N	2026-03-05 14:10:52.044582+07	\N	1	\N	\N
2041	133	417	\N	2026-03-05 14:10:53.615141+07	\N	2	\N	\N
2042	134	420	\N	2026-03-05 14:10:58.934348+07	\N	2	\N	\N
2043	134	420	\N	2026-03-05 14:10:59.602236+07	\N	1	\N	\N
2044	135	427	\N	2026-03-05 14:11:03.486662+07	\N	1	\N	\N
2045	135	427	\N	2026-03-05 14:11:05.026745+07	\N	4	\N	\N
2046	133	417	\N	2026-03-05 14:11:35.769894+07	\N	1	\N	\N
2047	133	417	\N	2026-03-05 14:11:36.757462+07	\N	2	\N	\N
2048	134	420	\N	2026-03-05 14:11:42.733391+07	\N	2	\N	\N
2049	134	420	\N	2026-03-05 14:11:43.471476+07	\N	2	\N	\N
2050	135	427	\N	2026-03-05 14:11:47.165485+07	\N	1	\N	\N
2051	135	427	\N	2026-03-05 14:11:48.748144+07	\N	3	\N	\N
2052	133	417	\N	2026-03-05 14:22:19.996257+07	\N	1	\N	\N
2053	133	417	\N	2026-03-05 14:22:20.927571+07	\N	2	\N	\N
2054	134	420	\N	2026-03-05 14:22:26.485231+07	\N	1	\N	\N
2055	134	420	\N	2026-03-05 14:22:27.110137+07	\N	2	\N	\N
2056	133	417	\N	2026-03-05 14:32:23.191242+07	\N	1	\N	\N
2057	133	417	\N	2026-03-05 14:32:23.966357+07	\N	1	\N	\N
2058	133	417	\N	2026-03-05 15:00:54.592056+07	\N	1	\N	\N
2059	133	417	\N	2026-03-05 15:00:55.024901+07	\N	2	\N	\N
2060	134	420	\N	2026-03-05 15:01:09.678696+07	\N	1	\N	\N
2061	134	420	\N	2026-03-05 15:01:11.648374+07	\N	4	\N	\N
2062	135	427	\N	2026-03-05 15:01:18.467074+07	\N	1	\N	\N
2063	135	427	\N	2026-03-05 15:01:19.228877+07	\N	2	\N	\N
2064	133	417	\N	2026-03-05 15:01:36.571981+07	\N	0	\N	\N
2065	133	417	\N	2026-03-05 15:01:37.424309+07	\N	1	\N	\N
2066	134	420	\N	2026-03-05 15:01:41.329566+07	\N	1	\N	\N
2067	134	420	\N	2026-03-05 15:01:41.924664+07	\N	1	\N	\N
2068	135	427	\N	2026-03-05 15:01:44.759412+07	\N	1	\N	\N
2069	135	427	\N	2026-03-05 15:01:45.614341+07	\N	1	\N	\N
2070	133	417	\N	2026-03-05 15:02:17.111037+07	\N	1	\N	\N
2071	133	417	\N	2026-03-05 15:02:18.005745+07	\N	2	\N	\N
2072	134	420	\N	2026-03-05 15:02:29.744827+07	\N	1	\N	\N
2073	134	420	\N	2026-03-05 15:02:31.155841+07	\N	2	\N	\N
2074	135	427	\N	2026-03-05 15:02:36.306342+07	\N	1	\N	\N
2075	135	427	\N	2026-03-05 15:02:36.753126+07	\N	1	\N	\N
2076	133	417	\N	2026-03-05 15:03:01.781209+07	\N	1	\N	\N
2077	133	417	\N	2026-03-05 15:03:02.184379+07	\N	1	\N	\N
2078	134	420	\N	2026-03-05 15:03:08.70835+07	\N	1	\N	\N
2079	134	420	\N	2026-03-05 15:03:10.950667+07	\N	3	\N	\N
2080	135	427	\N	2026-03-05 15:03:19.444676+07	\N	2	\N	\N
2081	135	427	\N	2026-03-05 15:03:21.812881+07	\N	4	\N	\N
2082	133	417	\N	2026-03-05 15:03:55.608289+07	\N	1	\N	\N
2083	133	417	\N	2026-03-05 15:03:57.039912+07	\N	2	\N	\N
2084	134	420	\N	2026-03-05 15:04:03.217991+07	\N	2	\N	\N
2086	135	427	\N	2026-03-05 15:04:08.403117+07	\N	1	\N	\N
2440	133	417	\N	2026-03-08 16:56:54.145942+07	\N	1	\N	\N
2442	135	427	\N	2026-03-08 16:56:58.119179+07	\N	0	\N	\N
2451	133	417	\N	2026-03-08 17:09:24.984823+07	\N	0	\N	\N
2453	135	427	\N	2026-03-08 17:09:28.864109+07	\N	0	\N	\N
2461	134	420	\N	2026-03-08 17:10:37.857625+07	\N	0	\N	\N
2469	133	417	\N	2026-03-08 17:28:35.879918+07	\N	0	\N	\N
2471	135	427	\N	2026-03-08 17:28:39.330407+07	\N	0	\N	\N
2478	133	417	\N	2026-03-08 17:29:47.136655+07	\N	1	\N	\N
2480	135	427	\N	2026-03-08 17:29:51.301988+07	\N	0	\N	\N
2481	133	417	\N	2026-03-08 17:30:07.931727+07	\N	0	\N	\N
2483	135	427	\N	2026-03-08 17:30:11.730811+07	\N	0	\N	\N
2488	134	420	\N	2026-03-08 17:30:55.88037+07	\N	0	\N	\N
2497	134	420	\N	2026-03-08 17:32:12.550503+07	\N	0	\N	\N
2505	134	420	\N	2026-03-08 17:36:32.594732+07	\N	0	\N	\N
2516	133	417	\N	2026-03-08 17:38:21.822109+07	\N	0	\N	\N
2518	135	427	\N	2026-03-08 17:38:25.51625+07	\N	0	\N	\N
2525	133	417	\N	2026-03-08 17:40:48.540473+07	\N	0	\N	\N
2527	135	427	\N	2026-03-08 17:40:52.893573+07	\N	1	\N	\N
2534	133	417	\N	2026-03-08 18:03:09.304536+07	\N	0	\N	\N
2542	134	420	\N	2026-03-08 18:08:40.854227+07	\N	0	\N	\N
2550	134	420	\N	2026-03-08 18:31:12.764183+07	\N	0	\N	\N
2559	134	420	\N	2026-03-08 18:47:57.858983+07	\N	0	\N	\N
2560	135	427	\N	2026-03-08 18:47:59.649899+07	\N	0	\N	\N
2569	133	417	\N	2026-03-08 18:53:57.325086+07	\N	1	\N	\N
2571	135	427	\N	2026-03-08 18:54:03.857909+07	\N	1	\N	\N
2578	133	417	\N	2026-03-08 18:59:26.332799+07	\N	0	\N	\N
2580	135	427	\N	2026-03-08 18:59:30.10045+07	\N	1	\N	\N
2587	133	417	\N	2026-03-08 19:01:08.999706+07	\N	0	\N	\N
2589	135	427	\N	2026-03-08 19:01:12.643469+07	\N	0	\N	\N
2593	134	420	\N	2026-03-08 19:02:03.442154+07	\N	0	\N	\N
2602	134	420	\N	2026-03-08 19:03:45.831942+07	\N	0	\N	\N
2609	134	420	\N	2026-03-08 19:14:40.83077+07	\N	0	\N	\N
2619	135	427	\N	2026-03-08 19:20:25.199737+07	\N	1	\N	\N
2626	133	417	\N	2026-03-08 19:23:47.505433+07	\N	0	\N	\N
2628	135	427	\N	2026-03-08 19:23:50.775681+07	\N	0	\N	\N
2634	133	417	\N	2026-03-08 19:32:21.345081+07	\N	0	\N	\N
2641	133	417	\N	2026-03-08 19:36:14.7703+07	\N	0	\N	\N
2643	135	427	\N	2026-03-08 19:36:21.872912+07	\N	0	\N	\N
2647	134	420	\N	2026-03-08 19:39:02.110632+07	\N	0	\N	\N
2655	134	420	\N	2026-03-08 19:52:28.559154+07	\N	0	\N	\N
2663	133	417	\N	2026-03-08 19:56:14.604197+07	\N	0	\N	\N
2665	135	427	\N	2026-03-08 19:56:18.996005+07	\N	1	\N	\N
2674	133	417	\N	2026-03-09 14:38:42.017624+07	\N	13	\N	\N
2681	159	492	\N	2026-03-09 16:00:00.992108+07	\N	1	\N	\N
2682	160	499	\N	2026-03-09 16:00:09.730422+07	\N	3	\N	\N
2688	158	489	\N	2026-03-09 16:09:26.549632+07	\N	1	\N	\N
2695	158	489	\N	2026-03-09 16:19:20.503741+07	\N	1	\N	\N
2697	160	499	\N	2026-03-09 16:19:24.922907+07	\N	0	\N	\N
2702	159	492	\N	2026-03-09 16:20:32.449621+07	\N	0	\N	\N
2710	158	489	\N	2026-03-09 16:26:00.035795+07	\N	1	\N	\N
2712	160	499	\N	2026-03-09 16:26:03.586186+07	\N	0	\N	\N
2719	158	489	\N	2026-03-09 16:30:02.530685+07	\N	0	\N	\N
2721	160	499	\N	2026-03-09 16:30:09.647048+07	\N	1	\N	\N
2726	159	492	\N	2026-03-09 16:48:31.491963+07	\N	0	\N	\N
2734	158	489	\N	2026-03-09 17:39:50.408826+07	\N	1	\N	\N
2736	160	499	\N	2026-03-09 17:39:56.224412+07	\N	1	\N	\N
2744	159	492	\N	2026-03-09 17:41:09.074453+07	\N	1	\N	\N
2747	159	492	\N	2026-03-09 17:41:33.024429+07	\N	0	\N	\N
2753	159	492	\N	2026-03-09 18:19:26.725317+07	\N	0	\N	\N
2760	168	518	\N	2026-03-09 19:04:38.690793+07	\N	5	\N	\N
2761	168	520	\N	2026-03-09 19:04:38.690793+07	\N	5	\N	\N
2762	168	521	\N	2026-03-09 19:04:38.690793+07	\N	5	\N	\N
2772	168	518	\N	2026-03-09 19:08:06.242434+07	\N	6	\N	\N
2773	168	520	\N	2026-03-09 19:08:06.242434+07	\N	6	\N	\N
2774	168	521	\N	2026-03-09 19:08:06.242434+07	\N	6	\N	\N
2783	167	516	\N	2026-03-09 19:24:44.372162+07	\N	5	\N	\N
2796	168	520	\N	2026-03-09 19:41:18.724181+07	\N	1	\N	\N
2806	167	516	\N	2026-03-09 19:51:17.850982+07	\N	2	\N	\N
2809	168	518	\N	2026-03-09 19:51:43.9193+07	\N	2	\N	\N
2813	168	518	\N	2026-03-09 19:52:03.792804+07	\N	2	\N	\N
2818	167	516	\N	2026-03-09 19:53:46.549487+07	\N	1	\N	\N
2820	169	524	\N	2026-03-09 19:53:55.011217+07	1	3	\N	\N
2821	169	523	\N	2026-03-09 19:53:55.011217+07	2	3	\N	\N
2830	167	516	\N	2026-03-11 12:46:01.725983+07	\N	2	\N	\N
2835	169	523	\N	2026-03-11 12:46:20.468557+07	1	3	\N	\N
2836	169	524	\N	2026-03-11 12:46:20.468557+07	2	3	\N	\N
2850	167	516	\N	2026-03-11 16:45:24.441932+07	\N	0	\N	\N
2860	167	516	\N	2026-03-11 17:02:31.133956+07	\N	0	\N	\N
2870	169	523	\N	2026-03-11 17:03:28.150994+07	1	1	\N	\N
2871	169	524	\N	2026-03-11 17:03:28.150994+07	2	1	\N	\N
2885	159	492	\N	2026-03-12 10:07:37.808364+07	\N	1	\N	\N
2896	47	114	\N	2026-03-12 10:21:59.449614+07	\N	7	\N	\N
2897	47	113	\N	2026-03-12 10:21:59.449614+07	\N	7	\N	\N
2902	48	117	\N	2026-03-12 10:22:19.334116+07	\N	2	\N	\N
2904	48	117	\N	2026-03-12 10:22:23.368231+07	\N	6	\N	\N
2930	159	492	\N	2026-03-12 11:57:55.871351+07	\N	2	\N	\N
2936	158	489	\N	2026-03-12 12:03:49.966084+07	\N	0	\N	\N
2938	160	499	\N	2026-03-12 12:03:54.210283+07	\N	1	\N	\N
2942	158	490	\N	2026-03-12 12:15:34.029064+07	\N	2	\N	\N
2944	158	490	\N	2026-03-12 12:15:37.208456+07	\N	6	\N	\N
2949	160	498	\N	2026-03-12 12:15:55.36461+07	\N	2	\N	\N
2952	162	506	\N	2026-03-12 12:16:33.435362+07	\N	4	\N	\N
2957	166	514	\N	2026-03-12 12:17:31.008097+07	\N	2	\N	\N
2959	166	515	\N	2026-03-12 12:17:34.535066+07	\N	6	\N	\N
2961	159	492	\N	2026-03-12 12:24:29.236054+07	\N	0	\N	\N
2963	158	489	\N	2026-03-12 12:26:26.757437+07	\N	0	\N	\N
2965	160	499	\N	2026-03-12 12:26:31.47884+07	\N	0	\N	\N
2966	158	489	\N	2026-03-12 12:33:19.81655+07	\N	1	\N	\N
2968	160	499	\N	2026-03-12 12:33:23.899261+07	\N	1	\N	\N
2969	158	489	\N	2026-03-12 12:37:13.260813+07	\N	1	\N	\N
2971	160	499	\N	2026-03-12 12:37:21.254036+07	\N	1	\N	\N
2972	167	516	\N	2026-03-12 12:55:28.002192+07	\N	2	\N	\N
2974	169	523	\N	2026-03-12 12:55:34.496588+07	1	1	\N	\N
2975	169	524	\N	2026-03-12 12:55:34.496588+07	2	1	\N	\N
2976	158	489	\N	2026-03-12 12:55:51.657593+07	\N	1	\N	\N
2085	134	420	\N	2026-03-05 15:04:04.61017+07	\N	2	\N	\N
2087	135	427	\N	2026-03-05 15:04:08.786664+07	\N	2	\N	\N
2088	133	417	\N	2026-03-05 15:20:58.375297+07	\N	0	\N	\N
2089	133	417	\N	2026-03-05 15:20:58.733772+07	\N	1	\N	\N
2090	134	420	\N	2026-03-05 15:21:02.823376+07	\N	1	\N	\N
2091	134	420	\N	2026-03-05 15:21:03.096101+07	\N	2	\N	\N
2092	135	427	\N	2026-03-05 15:21:06.327573+07	\N	1	\N	\N
2093	135	427	\N	2026-03-05 15:21:07.277287+07	\N	1	\N	\N
2094	133	417	\N	2026-03-05 15:21:51.331326+07	\N	1	\N	\N
2095	133	417	\N	2026-03-05 15:21:51.901858+07	\N	1	\N	\N
2096	134	420	\N	2026-03-05 15:21:55.634379+07	\N	2	\N	\N
2097	134	420	\N	2026-03-05 15:21:56.82963+07	\N	2	\N	\N
2098	135	427	\N	2026-03-05 15:22:01.349037+07	\N	1	\N	\N
2099	135	427	\N	2026-03-05 15:22:02.536225+07	\N	3	\N	\N
2100	133	417	\N	2026-03-05 15:25:18.487882+07	\N	1	\N	\N
2101	133	417	\N	2026-03-05 15:25:19.326244+07	\N	1	\N	\N
2102	134	420	\N	2026-03-05 15:25:24.857602+07	\N	2	\N	\N
2103	134	420	\N	2026-03-05 15:25:27.081767+07	\N	4	\N	\N
2104	135	427	\N	2026-03-05 15:25:32.865696+07	\N	1	\N	\N
2105	135	427	\N	2026-03-05 15:25:33.942715+07	\N	2	\N	\N
2106	133	417	\N	2026-03-05 15:25:55.07148+07	\N	1	\N	\N
2107	133	417	\N	2026-03-05 15:25:55.827972+07	\N	1	\N	\N
2108	133	417	\N	2026-03-05 15:26:15.993289+07	\N	1	\N	\N
2109	133	417	\N	2026-03-05 15:26:16.535934+07	\N	1	\N	\N
2110	134	420	\N	2026-03-05 15:26:19.225147+07	\N	1	\N	\N
2111	135	427	\N	2026-03-05 15:26:21.321517+07	\N	0	\N	\N
2112	134	420	\N	2026-03-05 15:26:22.265872+07	\N	4	\N	\N
2113	135	427	\N	2026-03-05 15:26:26.182886+07	\N	2	\N	\N
2114	133	417	\N	2026-03-05 15:27:09.146199+07	\N	1	\N	\N
2115	133	417	\N	2026-03-05 15:27:10.066843+07	\N	2	\N	\N
2116	134	420	\N	2026-03-05 15:27:13.920916+07	\N	1	\N	\N
2117	134	420	\N	2026-03-05 15:27:14.583926+07	\N	2	\N	\N
2118	135	427	\N	2026-03-05 15:27:16.297312+07	\N	0	\N	\N
2119	135	427	\N	2026-03-05 15:27:20.692524+07	\N	1	\N	\N
2120	133	417	\N	2026-03-05 15:41:59.360506+07	\N	15	\N	\N
2121	133	417	\N	2026-03-05 15:42:00.030789+07	\N	13	\N	\N
2122	134	420	\N	2026-03-05 15:42:03.169468+07	\N	1	\N	\N
2123	134	420	\N	2026-03-05 15:42:04.321607+07	\N	2	\N	\N
2124	133	417	\N	2026-03-05 15:42:26.464247+07	\N	1	\N	\N
2125	133	417	\N	2026-03-05 15:42:27.483392+07	\N	2	\N	\N
2126	134	420	\N	2026-03-05 15:42:29.864215+07	\N	0	\N	\N
2127	135	427	\N	2026-03-05 15:42:31.566832+07	\N	0	\N	\N
2128	134	420	\N	2026-03-05 15:42:35.104699+07	\N	1	\N	\N
2129	135	427	\N	2026-03-05 15:42:37.782401+07	\N	1	\N	\N
2130	133	417	\N	2026-03-05 15:46:38.78237+07	\N	14	\N	\N
2131	133	417	\N	2026-03-05 15:46:39.391959+07	\N	2	\N	\N
2132	134	420	\N	2026-03-05 15:46:41.608957+07	\N	0	\N	\N
2133	135	427	\N	2026-03-05 15:46:44.157229+07	\N	1	\N	\N
2134	134	420	\N	2026-03-05 15:46:47.963307+07	\N	1	\N	\N
2135	135	427	\N	2026-03-05 15:46:51.256629+07	\N	1	\N	\N
2136	133	417	\N	2026-03-05 15:47:17.182503+07	\N	1	\N	\N
2137	134	420	\N	2026-03-05 15:47:19.236202+07	\N	0	\N	\N
2138	135	427	\N	2026-03-05 15:47:21.639732+07	\N	1	\N	\N
2139	133	417	\N	2026-03-05 15:55:05.771207+07	\N	20	\N	\N
2140	134	420	\N	2026-03-05 15:55:08.137396+07	\N	0	\N	\N
2141	135	427	\N	2026-03-05 15:55:10.174867+07	\N	1	\N	\N
2142	133	417	\N	2026-03-05 15:56:59.899541+07	\N	0	\N	\N
2143	134	420	\N	2026-03-05 15:57:03.947674+07	\N	0	\N	\N
2144	135	427	\N	2026-03-05 15:57:06.35842+07	\N	1	\N	\N
2145	133	417	\N	2026-03-05 16:01:45.603846+07	\N	0	\N	\N
2146	134	420	\N	2026-03-05 16:01:48.13674+07	\N	1	\N	\N
2147	135	427	\N	2026-03-05 16:01:50.384746+07	\N	1	\N	\N
2148	133	417	\N	2026-03-05 16:02:42.901967+07	\N	0	\N	\N
2149	134	420	\N	2026-03-05 16:02:45.65305+07	\N	0	\N	\N
2150	133	417	\N	2026-03-05 16:03:07.243045+07	\N	0	\N	\N
2151	134	420	\N	2026-03-05 16:03:08.860235+07	\N	0	\N	\N
2152	135	427	\N	2026-03-05 16:03:11.582279+07	\N	1	\N	\N
2153	133	417	\N	2026-03-05 16:03:29.726778+07	\N	1	\N	\N
2154	134	420	\N	2026-03-05 16:03:31.645658+07	\N	0	\N	\N
2155	133	417	\N	2026-03-05 16:11:00.123957+07	\N	1	\N	\N
2156	134	420	\N	2026-03-05 16:11:02.259827+07	\N	0	\N	\N
2157	135	427	\N	2026-03-05 16:11:04.174705+07	\N	1	\N	\N
2158	133	417	\N	2026-03-05 16:11:21.122377+07	\N	1	\N	\N
2159	134	420	\N	2026-03-05 16:11:22.965071+07	\N	1	\N	\N
2160	135	427	\N	2026-03-05 16:11:24.995555+07	\N	1	\N	\N
2161	133	417	\N	2026-03-05 16:11:53.181898+07	\N	0	\N	\N
2162	134	420	\N	2026-03-05 16:11:55.367805+07	\N	0	\N	\N
2163	135	427	\N	2026-03-05 16:11:57.202268+07	\N	0	\N	\N
2164	133	417	\N	2026-03-05 16:12:11.231584+07	\N	0	\N	\N
2165	134	420	\N	2026-03-05 16:12:12.913361+07	\N	0	\N	\N
2166	135	427	\N	2026-03-05 16:12:14.792575+07	\N	0	\N	\N
2167	133	417	\N	2026-03-05 16:12:36.580587+07	\N	1	\N	\N
2168	133	417	\N	2026-03-05 16:12:58.012769+07	\N	1	\N	\N
2169	134	420	\N	2026-03-05 16:13:00.257507+07	\N	0	\N	\N
2170	135	427	\N	2026-03-05 16:13:02.052521+07	\N	0	\N	\N
2171	133	417	\N	2026-03-05 16:13:21.043197+07	\N	0	\N	\N
2172	134	420	\N	2026-03-05 16:13:24.083124+07	\N	0	\N	\N
2173	135	427	\N	2026-03-05 16:13:26.172345+07	\N	1	\N	\N
2174	133	417	\N	2026-03-05 16:13:48.861204+07	\N	1	\N	\N
2175	133	417	\N	2026-03-05 16:14:10.312672+07	\N	0	\N	\N
2176	133	417	\N	2026-03-05 16:14:23.330664+07	\N	0	\N	\N
2177	133	417	\N	2026-03-05 16:14:23.756075+07	\N	0	\N	\N
2178	133	417	\N	2026-03-05 16:14:40.944673+07	\N	0	\N	\N
2179	158	490	\N	2026-03-05 16:50:22.014482+07	\N	4	\N	\N
2180	158	490	\N	2026-03-05 16:50:25.63114+07	\N	8	\N	\N
2181	160	499	\N	2026-03-05 16:50:45.191837+07	\N	3	\N	\N
2182	160	498	\N	2026-03-05 16:50:46.646769+07	\N	5	\N	\N
2183	162	506	\N	2026-03-05 16:51:43.576748+07	\N	3	\N	\N
2184	162	506	\N	2026-03-05 16:51:45.693651+07	\N	5	\N	\N
2185	158	490	\N	2026-03-05 16:52:19.3111+07	\N	3	\N	\N
2186	158	490	\N	2026-03-05 16:52:22.951155+07	\N	7	\N	\N
2187	159	492	\N	2026-03-05 16:52:34.194595+07	\N	4	\N	\N
2188	159	492	\N	2026-03-05 16:52:36.495403+07	\N	6	\N	\N
2189	160	499	\N	2026-03-05 16:52:48.326688+07	\N	3	\N	\N
2190	160	499	\N	2026-03-05 16:52:50.178602+07	\N	5	\N	\N
2191	158	489	\N	2026-03-05 17:01:56.421839+07	\N	3	\N	\N
2192	158	490	\N	2026-03-05 17:01:59.128117+07	\N	5	\N	\N
2193	158	489	\N	2026-03-05 17:02:01.571491+07	\N	8	\N	\N
2195	159	492	\N	2026-03-05 17:02:12.823865+07	\N	2	\N	\N
2197	159	492	\N	2026-03-05 17:02:19.319927+07	\N	8	\N	\N
2199	160	499	\N	2026-03-05 17:02:35.950217+07	\N	1	\N	\N
2201	160	498	\N	2026-03-05 17:02:41.633199+07	\N	6	\N	\N
2441	134	420	\N	2026-03-08 16:56:56.329049+07	\N	0	\N	\N
2452	134	420	\N	2026-03-08 17:09:26.87389+07	\N	0	\N	\N
2462	135	427	\N	2026-03-08 17:10:39.68296+07	\N	0	\N	\N
2470	134	420	\N	2026-03-08 17:28:37.608469+07	\N	0	\N	\N
2479	134	420	\N	2026-03-08 17:29:49.659351+07	\N	1	\N	\N
2490	133	417	\N	2026-03-08 17:31:21.851435+07	\N	0	\N	\N
2492	135	427	\N	2026-03-08 17:31:25.119052+07	\N	0	\N	\N
2498	135	427	\N	2026-03-08 17:32:17.405265+07	\N	1	\N	\N
2508	134	420	\N	2026-03-08 17:36:46.276899+07	\N	0	\N	\N
2517	134	420	\N	2026-03-08 17:38:23.731786+07	\N	0	\N	\N
2526	134	420	\N	2026-03-08 17:40:50.665338+07	\N	1	\N	\N
2535	133	417	\N	2026-03-08 18:03:40.612642+07	\N	0	\N	\N
2537	135	427	\N	2026-03-08 18:03:43.501131+07	\N	0	\N	\N
2543	133	417	\N	2026-03-08 18:09:25.837389+07	\N	0	\N	\N
2552	133	417	\N	2026-03-08 18:39:50.515995+07	\N	0	\N	\N
2554	135	427	\N	2026-03-08 18:39:54.085575+07	\N	0	\N	\N
2561	130	408	\N	2026-03-08 18:48:19.802585+07	\N	2	\N	\N
2562	132	415	\N	2026-03-08 18:48:30.575627+07	\N	1	\N	\N
2570	134	420	\N	2026-03-08 18:54:00.439483+07	\N	0	\N	\N
2579	134	420	\N	2026-03-08 18:59:28.001958+07	\N	0	\N	\N
2582	134	420	\N	2026-03-08 18:59:44.852707+07	\N	0	\N	\N
2588	134	420	\N	2026-03-08 19:01:10.758167+07	\N	0	\N	\N
2595	133	417	\N	2026-03-08 19:02:53.619198+07	\N	0	\N	\N
2596	134	420	\N	2026-03-08 19:02:58.304304+07	\N	0	\N	\N
2597	135	427	\N	2026-03-08 19:03:03.04198+07	\N	0	\N	\N
2604	133	417	\N	2026-03-08 19:04:16.785279+07	\N	1	\N	\N
2606	135	427	\N	2026-03-08 19:04:21.432548+07	\N	0	\N	\N
2611	133	417	\N	2026-03-08 19:17:16.617658+07	\N	0	\N	\N
2613	135	427	\N	2026-03-08 19:17:20.57272+07	\N	0	\N	\N
2620	133	417	\N	2026-03-08 19:20:39.13563+07	\N	0	\N	\N
2622	135	427	\N	2026-03-08 19:20:42.26816+07	\N	0	\N	\N
2629	133	417	\N	2026-03-08 19:28:33.802147+07	\N	0	\N	\N
2631	135	427	\N	2026-03-08 19:28:38.489234+07	\N	1	\N	\N
2635	133	417	\N	2026-03-08 19:34:13.525169+07	\N	2	\N	\N
2642	134	420	\N	2026-03-08 19:36:20.135833+07	\N	0	\N	\N
2649	133	417	\N	2026-03-08 19:40:12.677619+07	\N	1	\N	\N
2651	135	427	\N	2026-03-08 19:40:17.458095+07	\N	0	\N	\N
2657	133	417	\N	2026-03-08 19:55:16.026442+07	\N	1	\N	\N
2666	133	417	\N	2026-03-08 20:00:20.146897+07	\N	0	\N	\N
2668	135	425	\N	2026-03-08 20:00:28.826217+07	\N	1	\N	\N
2675	134	420	\N	2026-03-09 14:57:08.474547+07	\N	2	\N	\N
2683	158	489	\N	2026-03-09 16:05:15.069371+07	\N	1	\N	\N
2689	158	489	\N	2026-03-09 16:15:56.44781+07	\N	1	\N	\N
2691	160	499	\N	2026-03-09 16:16:08.482271+07	\N	1	\N	\N
2696	159	492	\N	2026-03-09 16:19:22.820094+07	\N	1	\N	\N
2704	158	490	\N	2026-03-09 16:23:41.580694+07	\N	1	\N	\N
2711	159	492	\N	2026-03-09 16:26:01.879619+07	\N	0	\N	\N
2720	159	492	\N	2026-03-09 16:30:05.117182+07	\N	0	\N	\N
2728	158	490	\N	2026-03-09 16:51:33.005121+07	\N	0	\N	\N
2730	160	499	\N	2026-03-09 16:51:37.950197+07	\N	0	\N	\N
2735	159	492	\N	2026-03-09 17:39:53.265235+07	\N	0	\N	\N
2738	159	492	\N	2026-03-09 17:40:16.10224+07	\N	0	\N	\N
2746	158	489	\N	2026-03-09 17:41:31.349345+07	\N	1	\N	\N
2748	160	499	\N	2026-03-09 17:41:34.735693+07	\N	0	\N	\N
2755	162	504	\N	2026-03-09 18:30:15.004751+07	\N	1	\N	\N
2763	169	524	\N	2026-03-09 19:05:01.114611+07	1	20	\N	\N
2764	169	523	\N	2026-03-09 19:05:01.114611+07	2	20	\N	\N
2775	169	523	\N	2026-03-09 19:10:58.002617+07	1	170	\N	\N
2776	169	524	\N	2026-03-09 19:10:58.002617+07	2	170	\N	\N
2784	167	516	\N	2026-03-09 19:35:00.887972+07	\N	2	\N	\N
2799	167	516	\N	2026-03-09 19:42:25.489899+07	\N	1	\N	\N
2800	168	520	\N	2026-03-09 19:42:35.256277+07	\N	8	\N	\N
2807	168	518	\N	2026-03-09 19:51:21.905408+07	\N	2	\N	\N
2819	168	520	\N	2026-03-09 19:53:49.587933+07	\N	1	\N	\N
2831	168	518	\N	2026-03-11 12:46:13.094346+07	\N	5	\N	\N
2832	168	519	\N	2026-03-11 12:46:13.094346+07	\N	5	\N	\N
2833	168	521	\N	2026-03-11 12:46:13.094346+07	\N	5	\N	\N
2834	168	522	\N	2026-03-11 12:46:13.094346+07	\N	5	\N	\N
2841	167	516	\N	2026-03-11 15:49:01.630587+07	\N	0	\N	\N
2851	167	516	\N	2026-03-11 16:45:43.147388+07	\N	2	\N	\N
2861	168	518	\N	2026-03-11 17:02:33.990879+07	\N	1	\N	\N
2863	168	518	\N	2026-03-11 17:02:55.525906+07	\N	2	\N	\N
2864	168	519	\N	2026-03-11 17:02:55.525906+07	\N	2	\N	\N
2872	167	516	\N	2026-03-11 17:08:25.977916+07	\N	1	\N	\N
2876	169	523	\N	2026-03-11 17:08:36.174864+07	1	2	\N	\N
2877	169	524	\N	2026-03-11 17:08:36.174864+07	2	2	\N	\N
2887	158	490	\N	2026-03-12 10:18:59.797818+07	\N	1	\N	\N
2889	158	490	\N	2026-03-12 10:19:02.962747+07	\N	4	\N	\N
2898	47	114	\N	2026-03-12 10:22:02.359483+07	\N	10	\N	\N
2899	47	115	\N	2026-03-12 10:22:02.359483+07	\N	10	\N	\N
2903	48	116	\N	2026-03-12 10:22:21.652097+07	\N	4	\N	\N
2920	158	490	\N	2026-03-12 11:19:48.07247+07	\N	2	\N	\N
2922	158	490	\N	2026-03-12 11:19:49.377356+07	\N	4	\N	\N
2923	159	492	\N	2026-03-12 11:19:58.688991+07	\N	1	\N	\N
2925	159	493	\N	2026-03-12 11:20:01.778277+07	\N	4	\N	\N
2927	160	499	\N	2026-03-12 11:20:08.424357+07	\N	2	\N	\N
2931	160	499	\N	2026-03-12 11:58:00.195795+07	\N	2	\N	\N
2937	159	492	\N	2026-03-12 12:03:51.999384+07	\N	1	\N	\N
2943	158	490	\N	2026-03-12 12:15:34.99623+07	\N	3	\N	\N
2946	159	492	\N	2026-03-12 12:15:47.176453+07	\N	4	\N	\N
2950	160	496	\N	2026-03-12 12:15:57.696057+07	\N	4	\N	\N
2954	165	513	\N	2026-03-12 12:17:13.144516+07	\N	1	\N	\N
2956	165	513	\N	2026-03-12 12:17:16.415482+07	\N	4	\N	\N
2958	166	515	\N	2026-03-12 12:17:32.145224+07	\N	3	\N	\N
2962	160	499	\N	2026-03-12 12:24:31.099213+07	\N	1	\N	\N
2964	159	492	\N	2026-03-12 12:26:29.30073+07	\N	0	\N	\N
2967	159	492	\N	2026-03-12 12:33:21.569369+07	\N	0	\N	\N
2970	159	492	\N	2026-03-12 12:37:17.186627+07	\N	1	\N	\N
2973	168	519	\N	2026-03-12 12:55:31.546611+07	\N	2	\N	\N
2977	159	492	\N	2026-03-12 12:55:54.189432+07	\N	1	\N	\N
2194	158	490	\N	2026-03-05 17:02:02.866421+07	\N	9	\N	\N
2196	159	492	\N	2026-03-05 17:02:15.995233+07	\N	5	\N	\N
2198	159	493	\N	2026-03-05 17:02:23.732825+07	\N	13	\N	\N
2200	160	496	\N	2026-03-05 17:02:39.395617+07	\N	4	\N	\N
2202	160	499	\N	2026-03-05 17:02:44.397724+07	\N	9	\N	\N
2203	133	417	\N	2026-03-08 13:15:59.080259+07	\N	2	\N	\N
2204	133	417	\N	2026-03-08 13:15:59.157507+07	\N	2	\N	\N
2205	134	420	\N	2026-03-08 13:16:07.749098+07	\N	1	\N	\N
2206	134	420	\N	2026-03-08 13:16:09.53192+07	\N	3	\N	\N
2207	135	427	\N	2026-03-08 13:16:14.480085+07	\N	1	\N	\N
2208	135	427	\N	2026-03-08 13:16:15.814656+07	\N	2	\N	\N
2209	133	417	\N	2026-03-08 13:18:34.248931+07	\N	1	\N	\N
2210	133	417	\N	2026-03-08 13:18:36.961031+07	\N	3	\N	\N
2211	134	420	\N	2026-03-08 13:18:42.723728+07	\N	1	\N	\N
2212	134	420	\N	2026-03-08 13:18:43.084495+07	\N	2	\N	\N
2213	135	427	\N	2026-03-08 13:18:46.843288+07	\N	1	\N	\N
2214	135	427	\N	2026-03-08 13:18:48.070057+07	\N	2	\N	\N
2215	133	417	\N	2026-03-08 13:19:28.767034+07	\N	1	\N	\N
2216	133	417	\N	2026-03-08 13:19:29.326506+07	\N	1	\N	\N
2217	134	420	\N	2026-03-08 13:19:32.563418+07	\N	1	\N	\N
2218	134	420	\N	2026-03-08 13:19:33.177438+07	\N	1	\N	\N
2219	135	427	\N	2026-03-08 13:19:36.709726+07	\N	1	\N	\N
2220	135	427	\N	2026-03-08 13:19:37.559951+07	\N	1	\N	\N
2221	133	417	\N	2026-03-08 13:21:25.917624+07	\N	0	\N	\N
2222	133	417	\N	2026-03-08 13:21:28.578576+07	\N	3	\N	\N
2223	134	420	\N	2026-03-08 13:21:32.90512+07	\N	1	\N	\N
2224	135	427	\N	2026-03-08 13:21:58.696905+07	\N	2	\N	\N
2225	133	417	\N	2026-03-08 13:24:10.316308+07	\N	1	\N	\N
2226	134	420	\N	2026-03-08 13:24:20.439295+07	\N	1	\N	\N
2227	135	427	\N	2026-03-08 13:24:26.351672+07	\N	1	\N	\N
2228	133	417	\N	2026-03-08 13:42:16.175396+07	\N	1	\N	\N
2229	134	420	\N	2026-03-08 13:42:21.571745+07	\N	1	\N	\N
2230	134	420	\N	2026-03-08 13:42:21.922894+07	\N	2	\N	\N
2231	135	427	\N	2026-03-08 13:42:26.337062+07	\N	1	\N	\N
2232	135	427	\N	2026-03-08 13:42:27.489242+07	\N	2	\N	\N
2233	133	417	\N	2026-03-08 13:44:15.557602+07	\N	1	\N	\N
2234	133	417	\N	2026-03-08 13:44:17.602353+07	\N	3	\N	\N
2235	134	420	\N	2026-03-08 13:44:21.082138+07	\N	0	\N	\N
2236	134	420	\N	2026-03-08 13:44:22.367215+07	\N	1	\N	\N
2237	135	427	\N	2026-03-08 13:44:26.388625+07	\N	1	\N	\N
2238	135	427	\N	2026-03-08 13:44:26.969425+07	\N	1	\N	\N
2239	133	417	\N	2026-03-08 13:45:05.838047+07	\N	1	\N	\N
2240	134	420	\N	2026-03-08 13:45:08.103322+07	\N	1	\N	\N
2241	135	427	\N	2026-03-08 13:45:10.041346+07	\N	1	\N	\N
2242	133	417	\N	2026-03-08 13:46:47.71615+07	\N	1	\N	\N
2243	134	420	\N	2026-03-08 13:46:50.153967+07	\N	0	\N	\N
2244	135	427	\N	2026-03-08 13:46:52.265517+07	\N	1	\N	\N
2245	133	417	\N	2026-03-08 13:48:28.121393+07	\N	1	\N	\N
2246	133	417	\N	2026-03-08 13:50:48.500784+07	\N	1	\N	\N
2247	134	420	\N	2026-03-08 13:50:53.107462+07	\N	1	\N	\N
2248	134	420	\N	2026-03-08 13:50:53.514351+07	\N	1	\N	\N
2249	135	427	\N	2026-03-08 13:50:57.125317+07	\N	1	\N	\N
2250	133	417	\N	2026-03-08 13:51:26.351873+07	\N	2	\N	\N
2251	134	420	\N	2026-03-08 13:51:29.545252+07	\N	0	\N	\N
2252	135	427	\N	2026-03-08 13:51:38.137349+07	\N	2	\N	\N
2253	133	417	\N	2026-03-08 13:51:57.221597+07	\N	2	\N	\N
2254	134	420	\N	2026-03-08 13:52:02.108269+07	\N	1	\N	\N
2255	135	427	\N	2026-03-08 13:52:04.552672+07	\N	1	\N	\N
2256	133	417	\N	2026-03-08 13:55:45.337792+07	\N	1	\N	\N
2257	134	420	\N	2026-03-08 13:55:48.838786+07	\N	1	\N	\N
2258	133	417	\N	2026-03-08 13:56:06.186159+07	\N	0	\N	\N
2259	133	417	\N	2026-03-08 14:03:51.776689+07	\N	0	\N	\N
2260	133	417	\N	2026-03-08 14:04:09.215992+07	\N	1	\N	\N
2261	130	408	\N	2026-03-08 14:04:24.201975+07	\N	0	\N	\N
2262	131	412	\N	2026-03-08 14:04:27.739506+07	1	2	\N	\N
2263	131	411	\N	2026-03-08 14:04:27.739506+07	2	2	\N	\N
2264	131	413	\N	2026-03-08 14:04:27.739506+07	3	2	\N	\N
2265	132	415	\N	2026-03-08 14:04:30.73546+07	\N	1	\N	\N
2266	133	417	\N	2026-03-08 14:04:42.682926+07	\N	0	\N	\N
2267	134	420	\N	2026-03-08 14:04:44.912095+07	\N	1	\N	\N
2268	135	427	\N	2026-03-08 14:04:47.729993+07	\N	1	\N	\N
2269	133	417	\N	2026-03-08 14:05:17.297492+07	\N	2	\N	\N
2270	134	420	\N	2026-03-08 14:05:24.28283+07	\N	1	\N	\N
2271	135	427	\N	2026-03-08 14:05:30.477803+07	\N	1	\N	\N
2272	133	417	\N	2026-03-08 14:05:58.230196+07	\N	1	\N	\N
2273	134	420	\N	2026-03-08 14:06:02.116671+07	\N	0	\N	\N
2274	135	427	\N	2026-03-08 14:06:05.388485+07	\N	1	\N	\N
2275	133	417	\N	2026-03-08 14:06:50.357209+07	\N	1	\N	\N
2276	134	420	\N	2026-03-08 14:06:52.756429+07	\N	1	\N	\N
2277	133	417	\N	2026-03-08 14:07:16.744387+07	\N	0	\N	\N
2278	134	420	\N	2026-03-08 14:07:24.279521+07	\N	1	\N	\N
2279	135	427	\N	2026-03-08 14:07:29.081239+07	\N	1	\N	\N
2280	133	417	\N	2026-03-08 14:07:51.341045+07	\N	1	\N	\N
2281	134	420	\N	2026-03-08 14:07:55.009332+07	\N	1	\N	\N
2282	133	417	\N	2026-03-08 14:26:50.819131+07	\N	1	\N	\N
2283	134	420	\N	2026-03-08 14:27:04.665004+07	\N	1	\N	\N
2284	133	417	\N	2026-03-08 14:27:44.471774+07	\N	1	\N	\N
2285	134	420	\N	2026-03-08 14:27:47.993064+07	\N	0	\N	\N
2286	133	417	\N	2026-03-08 14:28:20.905001+07	\N	2	\N	\N
2287	134	420	\N	2026-03-08 14:28:25.174021+07	\N	1	\N	\N
2288	133	417	\N	2026-03-08 14:29:01.583413+07	\N	1	\N	\N
2289	134	420	\N	2026-03-08 14:29:03.759274+07	\N	0	\N	\N
2290	135	427	\N	2026-03-08 14:29:06.173701+07	\N	1	\N	\N
2291	133	417	\N	2026-03-08 14:44:24.064762+07	\N	2	\N	\N
2292	134	420	\N	2026-03-08 14:44:44.942926+07	\N	3	\N	\N
2293	135	427	\N	2026-03-08 14:44:49.687649+07	\N	1	\N	\N
2294	133	417	\N	2026-03-08 14:45:08.430258+07	\N	1	\N	\N
2295	134	420	\N	2026-03-08 14:45:11.761037+07	\N	0	\N	\N
2296	135	427	\N	2026-03-08 14:45:14.15138+07	\N	1	\N	\N
2297	133	417	\N	2026-03-08 14:45:34.681262+07	\N	0	\N	\N
2298	134	420	\N	2026-03-08 14:45:37.374507+07	\N	0	\N	\N
2299	135	427	\N	2026-03-08 14:45:41.796093+07	\N	2	\N	\N
2300	133	417	\N	2026-03-08 14:46:00.172866+07	\N	0	\N	\N
2301	133	417	\N	2026-03-08 14:46:33.539039+07	\N	0	\N	\N
2302	134	420	\N	2026-03-08 14:46:36.207118+07	\N	1	\N	\N
2303	135	427	\N	2026-03-08 14:46:41.825954+07	\N	1	\N	\N
2304	133	417	\N	2026-03-08 14:47:10.719595+07	\N	1	\N	\N
2305	134	420	\N	2026-03-08 14:47:12.847314+07	\N	0	\N	\N
2443	133	417	\N	2026-03-08 16:57:24.941335+07	\N	0	\N	\N
2454	133	417	\N	2026-03-08 17:09:52.588438+07	\N	0	\N	\N
2456	135	427	\N	2026-03-08 17:09:56.803721+07	\N	1	\N	\N
2463	133	417	\N	2026-03-08 17:11:01.443991+07	\N	0	\N	\N
2465	135	427	\N	2026-03-08 17:11:05.647818+07	\N	0	\N	\N
2472	133	417	\N	2026-03-08 17:29:00.319292+07	\N	0	\N	\N
2474	135	427	\N	2026-03-08 17:29:03.686118+07	\N	0	\N	\N
2482	134	420	\N	2026-03-08 17:30:09.94015+07	\N	0	\N	\N
2491	134	420	\N	2026-03-08 17:31:23.237172+07	\N	0	\N	\N
2499	133	417	\N	2026-03-08 17:35:40.099046+07	\N	0	\N	\N
2500	134	420	\N	2026-03-08 17:35:43.823719+07	\N	1	\N	\N
2510	133	417	\N	2026-03-08 17:37:13.729598+07	\N	1	\N	\N
2511	134	420	\N	2026-03-08 17:37:23.396649+07	\N	1	\N	\N
2519	133	417	\N	2026-03-08 17:38:51.927503+07	\N	0	\N	\N
2521	135	427	\N	2026-03-08 17:38:55.640505+07	\N	0	\N	\N
2528	133	417	\N	2026-03-08 17:41:27.105065+07	\N	0	\N	\N
2530	135	427	\N	2026-03-08 17:41:31.472697+07	\N	1	\N	\N
2536	134	420	\N	2026-03-08 18:03:42.068501+07	\N	0	\N	\N
2544	134	420	\N	2026-03-08 18:09:28.058681+07	\N	1	\N	\N
2545	135	427	\N	2026-03-08 18:09:29.747673+07	\N	0	\N	\N
2553	134	420	\N	2026-03-08 18:39:52.260372+07	\N	0	\N	\N
2563	133	417	\N	2026-03-08 18:49:27.65413+07	\N	0	\N	\N
2572	133	417	\N	2026-03-08 18:58:45.043441+07	\N	1	\N	\N
2573	134	420	\N	2026-03-08 18:58:48.537799+07	\N	0	\N	\N
2581	133	417	\N	2026-03-08 18:59:42.636403+07	\N	0	\N	\N
2583	135	427	\N	2026-03-08 18:59:47.402794+07	\N	1	\N	\N
2590	133	417	\N	2026-03-08 19:01:41.818463+07	\N	1	\N	\N
2598	133	417	\N	2026-03-08 19:03:21.065983+07	\N	0	\N	\N
2600	135	427	\N	2026-03-08 19:03:25.532508+07	\N	0	\N	\N
2605	134	420	\N	2026-03-08 19:04:19.11855+07	\N	0	\N	\N
2612	134	420	\N	2026-03-08 19:17:18.711606+07	\N	0	\N	\N
2621	134	420	\N	2026-03-08 19:20:40.67147+07	\N	0	\N	\N
2630	134	420	\N	2026-03-08 19:28:36.199089+07	\N	0	\N	\N
2636	134	420	\N	2026-03-08 19:34:22.731059+07	\N	1	\N	\N
2644	133	417	\N	2026-03-08 19:37:52.532254+07	\N	1	\N	\N
2650	134	421	\N	2026-03-08 19:40:14.712796+07	\N	0	\N	\N
2652	133	417	\N	2026-03-08 19:40:42.531486+07	\N	1	\N	\N
2658	134	420	\N	2026-03-08 19:55:18.319047+07	\N	0	\N	\N
2659	135	427	\N	2026-03-08 19:55:20.652449+07	\N	0	\N	\N
2667	134	420	\N	2026-03-08 20:00:24.969394+07	\N	3	\N	\N
2676	135	427	\N	2026-03-09 14:57:14.405629+07	\N	3	\N	\N
2684	159	492	\N	2026-03-09 16:05:26.330078+07	\N	0	\N	\N
2690	159	492	\N	2026-03-09 16:16:02.68782+07	\N	1	\N	\N
2698	158	489	\N	2026-03-09 16:19:47.816229+07	\N	0	\N	\N
2700	160	499	\N	2026-03-09 16:19:52.366267+07	\N	1	\N	\N
2705	159	492	\N	2026-03-09 16:23:44.965005+07	\N	1	\N	\N
2706	160	499	\N	2026-03-09 16:23:47.641088+07	\N	1	\N	\N
2713	158	489	\N	2026-03-09 16:26:31.442891+07	\N	0	\N	\N
2715	160	499	\N	2026-03-09 16:26:35.134904+07	\N	0	\N	\N
2717	159	492	\N	2026-03-09 16:27:06.401337+07	\N	1	\N	\N
2718	160	499	\N	2026-03-09 16:27:12.170169+07	\N	1	\N	\N
2722	158	489	\N	2026-03-09 16:31:43.213467+07	\N	3	\N	\N
2724	160	499	\N	2026-03-09 16:31:52.807961+07	\N	1	\N	\N
2729	159	492	\N	2026-03-09 16:51:35.823869+07	\N	0	\N	\N
2737	158	489	\N	2026-03-09 17:40:13.719696+07	\N	1	\N	\N
2739	160	499	\N	2026-03-09 17:40:18.180804+07	\N	1	\N	\N
2749	158	489	\N	2026-03-09 18:17:42.773397+07	\N	1	\N	\N
2751	160	499	\N	2026-03-09 18:17:57.214353+07	\N	1	\N	\N
2756	158	489	\N	2026-03-09 18:40:46.790511+07	\N	5	\N	\N
2765	167	516	\N	2026-03-09 19:05:12.944949+07	\N	0	\N	\N
2777	167	516	\N	2026-03-09 19:17:45.93423+07	\N	0	\N	\N
2780	169	524	\N	2026-03-09 19:17:57.069748+07	1	1	\N	\N
2781	169	523	\N	2026-03-09 19:17:57.069748+07	2	1	\N	\N
2785	168	518	\N	2026-03-09 19:35:11.436376+07	\N	5	\N	\N
2786	168	519	\N	2026-03-09 19:35:11.436376+07	\N	5	\N	\N
2787	169	523	\N	2026-03-09 19:35:17.252695+07	1	2	\N	\N
2788	169	524	\N	2026-03-09 19:35:17.252695+07	2	2	\N	\N
2801	169	523	\N	2026-03-09 19:42:43.091573+07	1	5	\N	\N
2802	169	524	\N	2026-03-09 19:42:43.091573+07	2	5	\N	\N
2808	167	516	\N	2026-03-09 19:51:38.186923+07	\N	1	\N	\N
2810	169	523	\N	2026-03-09 19:51:48.823072+07	1	2	\N	\N
2811	169	524	\N	2026-03-09 19:51:48.823072+07	2	2	\N	\N
2822	167	516	\N	2026-03-09 19:54:08.876359+07	\N	0	\N	\N
2823	168	519	\N	2026-03-09 19:54:13.106015+07	\N	2	\N	\N
2824	168	518	\N	2026-03-09 19:54:13.106015+07	\N	2	\N	\N
2825	169	523	\N	2026-03-09 19:54:16.056533+07	1	1	\N	\N
2826	169	524	\N	2026-03-09 19:54:16.056533+07	2	1	\N	\N
2837	167	516	\N	2026-03-11 13:06:36.544172+07	\N	0	\N	\N
2842	167	516	\N	2026-03-11 15:49:06.814886+07	\N	0	\N	\N
2852	167	516	\N	2026-03-11 16:46:14.064385+07	\N	10	\N	\N
2855	169	523	\N	2026-03-11 16:46:20.075942+07	1	30	\N	\N
2856	169	524	\N	2026-03-11 16:46:20.075942+07	2	30	\N	\N
2862	167	516	\N	2026-03-11 17:02:51.751084+07	\N	1	\N	\N
2865	169	523	\N	2026-03-11 17:02:59.258135+07	1	2	\N	\N
2866	169	524	\N	2026-03-11 17:02:59.258135+07	2	2	\N	\N
2873	168	518	\N	2026-03-11 17:08:31.424499+07	\N	2	\N	\N
2874	168	519	\N	2026-03-11 17:08:31.424499+07	\N	2	\N	\N
2875	168	522	\N	2026-03-11 17:08:31.424499+07	\N	2	\N	\N
2888	158	490	\N	2026-03-12 10:19:02.141756+07	\N	4	\N	\N
2905	162	506	\N	2026-03-12 10:46:17.248301+07	\N	2	\N	\N
2907	162	506	\N	2026-03-12 10:46:20.419641+07	\N	6	\N	\N
2921	158	490	\N	2026-03-12 11:19:48.668889+07	\N	3	\N	\N
2924	159	494	\N	2026-03-12 11:19:59.613905+07	\N	2	\N	\N
2932	167	516	\N	2026-03-12 12:00:30.012677+07	\N	0	\N	\N
2934	169	523	\N	2026-03-12 12:00:36.9549+07	1	1	\N	\N
2935	169	524	\N	2026-03-12 12:00:36.9549+07	2	1	\N	\N
2939	158	489	\N	2026-03-12 12:07:57.587741+07	\N	4	\N	\N
2941	160	499	\N	2026-03-12 12:08:02.263111+07	\N	1	\N	\N
2945	159	492	\N	2026-03-12 12:15:45.246272+07	\N	2	\N	\N
2947	159	493	\N	2026-03-12 12:15:49.308896+07	\N	6	\N	\N
2951	162	506	\N	2026-03-12 12:16:31.979992+07	\N	3	\N	\N
2953	162	506	\N	2026-03-12 12:16:34.243312+07	\N	5	\N	\N
2955	165	513	\N	2026-03-12 12:17:15.022179+07	\N	3	\N	\N
2960	158	489	\N	2026-03-12 12:24:26.431635+07	\N	0	\N	\N
2306	135	427	\N	2026-03-08 14:47:15.04477+07	\N	1	\N	\N
2307	133	417	\N	2026-03-08 14:47:28.401847+07	\N	0	\N	\N
2308	134	420	\N	2026-03-08 14:47:30.464853+07	\N	0	\N	\N
2309	135	427	\N	2026-03-08 14:47:32.512104+07	\N	1	\N	\N
2310	133	417	\N	2026-03-08 14:47:44.635522+07	\N	0	\N	\N
2311	133	417	\N	2026-03-08 14:47:55.523644+07	\N	0	\N	\N
2312	134	420	\N	2026-03-08 14:47:58.180087+07	\N	1	\N	\N
2313	135	427	\N	2026-03-08 14:48:00.578434+07	\N	1	\N	\N
2314	133	417	\N	2026-03-08 14:48:27.523605+07	\N	3	\N	\N
2315	134	420	\N	2026-03-08 14:48:32.122411+07	\N	1	\N	\N
2316	135	427	\N	2026-03-08 14:48:36.971061+07	\N	1	\N	\N
2317	133	417	\N	2026-03-08 14:49:15.083714+07	\N	0	\N	\N
2318	134	420	\N	2026-03-08 14:49:18.572051+07	\N	1	\N	\N
2319	135	427	\N	2026-03-08 14:49:22.633017+07	\N	2	\N	\N
2320	133	417	\N	2026-03-08 14:55:14.10983+07	\N	6	\N	\N
2321	134	420	\N	2026-03-08 14:55:19.875174+07	\N	1	\N	\N
2322	135	427	\N	2026-03-08 14:55:26.119999+07	\N	1	\N	\N
2323	133	417	\N	2026-03-08 14:55:50.310015+07	\N	2	\N	\N
2324	134	420	\N	2026-03-08 14:55:53.885905+07	\N	1	\N	\N
2325	135	427	\N	2026-03-08 14:55:56.766071+07	\N	1	\N	\N
2326	133	417	\N	2026-03-08 14:56:22.416584+07	\N	0	\N	\N
2327	134	420	\N	2026-03-08 14:56:27.600973+07	\N	3	\N	\N
2328	135	427	\N	2026-03-08 14:56:30.341573+07	\N	1	\N	\N
2329	133	417	\N	2026-03-08 14:57:11.716746+07	\N	0	\N	\N
2330	134	420	\N	2026-03-08 14:57:13.842358+07	\N	0	\N	\N
2331	135	427	\N	2026-03-08 14:57:16.130359+07	\N	1	\N	\N
2332	133	417	\N	2026-03-08 14:57:41.191554+07	\N	0	\N	\N
2333	134	420	\N	2026-03-08 14:57:47.037904+07	\N	3	\N	\N
2334	135	427	\N	2026-03-08 14:57:50.988529+07	\N	2	\N	\N
2335	133	417	\N	2026-03-08 14:58:19.392552+07	\N	1	\N	\N
2336	134	420	\N	2026-03-08 14:58:22.146083+07	\N	1	\N	\N
2337	135	427	\N	2026-03-08 14:58:23.990479+07	\N	0	\N	\N
2338	133	417	\N	2026-03-08 14:58:50.956587+07	\N	0	\N	\N
2339	134	420	\N	2026-03-08 14:58:52.969992+07	\N	0	\N	\N
2340	135	427	\N	2026-03-08 14:58:55.38644+07	\N	1	\N	\N
2341	133	417	\N	2026-03-08 15:00:17.774169+07	\N	1	\N	\N
2342	134	420	\N	2026-03-08 15:00:25.41722+07	\N	1	\N	\N
2343	135	427	\N	2026-03-08 15:00:28.835055+07	\N	1	\N	\N
2344	133	417	\N	2026-03-08 15:01:04.78728+07	\N	1	\N	\N
2345	134	420	\N	2026-03-08 15:01:07.833663+07	\N	0	\N	\N
2346	135	427	\N	2026-03-08 15:01:10.457295+07	\N	1	\N	\N
2347	133	417	\N	2026-03-08 15:01:32.753363+07	\N	1	\N	\N
2348	134	420	\N	2026-03-08 15:01:35.532374+07	\N	0	\N	\N
2349	135	427	\N	2026-03-08 15:01:37.381826+07	\N	0	\N	\N
2350	133	417	\N	2026-03-08 15:02:09.233761+07	\N	1	\N	\N
2351	134	420	\N	2026-03-08 15:02:11.313256+07	\N	0	\N	\N
2352	135	427	\N	2026-03-08 15:02:13.848487+07	\N	1	\N	\N
2353	133	417	\N	2026-03-08 15:02:44.222976+07	\N	4	\N	\N
2354	134	420	\N	2026-03-08 15:02:48.257122+07	\N	1	\N	\N
2355	135	427	\N	2026-03-08 15:02:53.525834+07	\N	1	\N	\N
2356	133	417	\N	2026-03-08 15:04:59.721336+07	\N	1	\N	\N
2357	134	420	\N	2026-03-08 15:05:01.719838+07	\N	0	\N	\N
2358	135	427	\N	2026-03-08 15:05:03.88829+07	\N	1	\N	\N
2359	133	417	\N	2026-03-08 15:05:19.002622+07	\N	0	\N	\N
2360	134	420	\N	2026-03-08 15:05:21.520426+07	\N	0	\N	\N
2361	135	427	\N	2026-03-08 15:05:23.631695+07	\N	1	\N	\N
2362	133	417	\N	2026-03-08 15:05:51.293388+07	\N	1	\N	\N
2363	134	420	\N	2026-03-08 15:05:53.466615+07	\N	1	\N	\N
2364	135	427	\N	2026-03-08 15:05:55.600798+07	\N	1	\N	\N
2365	133	417	\N	2026-03-08 15:06:28.467087+07	\N	1	\N	\N
2366	134	420	\N	2026-03-08 15:06:37.833975+07	\N	1	\N	\N
2367	135	427	\N	2026-03-08 15:06:44.302151+07	\N	1	\N	\N
2368	133	417	\N	2026-03-08 15:07:23.541195+07	\N	1	\N	\N
2369	134	420	\N	2026-03-08 15:07:26.398146+07	\N	0	\N	\N
2370	135	427	\N	2026-03-08 15:07:28.597053+07	\N	1	\N	\N
2371	133	417	\N	2026-03-08 15:20:04.601665+07	\N	0	\N	\N
2372	134	420	\N	2026-03-08 15:20:06.231089+07	\N	0	\N	\N
2373	135	427	\N	2026-03-08 15:20:08.375775+07	\N	1	\N	\N
2374	133	417	\N	2026-03-08 15:24:22.004867+07	\N	1	\N	\N
2375	134	420	\N	2026-03-08 15:24:24.428118+07	\N	0	\N	\N
2376	133	417	\N	2026-03-08 15:24:59.379313+07	\N	1	\N	\N
2377	134	420	\N	2026-03-08 15:25:01.251532+07	\N	0	\N	\N
2378	133	417	\N	2026-03-08 15:25:44.465857+07	\N	2	\N	\N
2379	133	417	\N	2026-03-08 15:26:32.572565+07	\N	1	\N	\N
2380	134	420	\N	2026-03-08 15:26:34.590125+07	\N	0	\N	\N
2381	135	427	\N	2026-03-08 15:26:38.476712+07	\N	2	\N	\N
2382	133	417	\N	2026-03-08 15:27:14.156023+07	\N	1	\N	\N
2383	134	420	\N	2026-03-08 15:27:16.444107+07	\N	0	\N	\N
2384	135	427	\N	2026-03-08 15:27:19.763336+07	\N	2	\N	\N
2385	133	417	\N	2026-03-08 15:27:41.513465+07	\N	0	\N	\N
2386	134	420	\N	2026-03-08 15:27:43.255915+07	\N	0	\N	\N
2387	135	427	\N	2026-03-08 15:27:45.608351+07	\N	1	\N	\N
2388	133	417	\N	2026-03-08 15:29:03.92467+07	\N	1	\N	\N
2389	134	420	\N	2026-03-08 15:29:05.902027+07	\N	0	\N	\N
2390	135	427	\N	2026-03-08 15:29:08.038338+07	\N	1	\N	\N
2391	133	417	\N	2026-03-08 15:29:39.329219+07	\N	1	\N	\N
2392	134	420	\N	2026-03-08 15:29:41.687735+07	\N	0	\N	\N
2393	135	427	\N	2026-03-08 15:29:44.006987+07	\N	1	\N	\N
2394	133	417	\N	2026-03-08 15:30:16.438774+07	\N	1	\N	\N
2395	134	420	\N	2026-03-08 15:30:18.1188+07	\N	0	\N	\N
2396	135	427	\N	2026-03-08 15:30:20.437582+07	\N	0	\N	\N
2397	133	417	\N	2026-03-08 15:30:36.491251+07	\N	1	\N	\N
2398	134	420	\N	2026-03-08 15:30:38.453607+07	\N	0	\N	\N
2399	135	427	\N	2026-03-08 15:30:40.60627+07	\N	1	\N	\N
2400	133	417	\N	2026-03-08 15:31:15.04403+07	\N	0	\N	\N
2401	134	420	\N	2026-03-08 15:31:17.064098+07	\N	0	\N	\N
2402	135	427	\N	2026-03-08 15:31:19.244793+07	\N	1	\N	\N
2403	133	417	\N	2026-03-08 15:31:39.335356+07	\N	1	\N	\N
2404	134	420	\N	2026-03-08 15:31:41.358321+07	\N	0	\N	\N
2405	135	427	\N	2026-03-08 15:31:43.419654+07	\N	1	\N	\N
2406	133	417	\N	2026-03-08 16:27:17.42217+07	\N	1	\N	\N
2407	134	420	\N	2026-03-08 16:27:19.501445+07	\N	0	\N	\N
2408	135	427	\N	2026-03-08 16:27:21.491786+07	\N	0	\N	\N
2409	133	417	\N	2026-03-08 16:27:47.908258+07	\N	0	\N	\N
2410	134	420	\N	2026-03-08 16:27:50.632761+07	\N	0	\N	\N
2411	135	427	\N	2026-03-08 16:27:53.294837+07	\N	1	\N	\N
2412	133	417	\N	2026-03-08 16:28:13.167217+07	\N	0	\N	\N
2413	134	420	\N	2026-03-08 16:28:14.856566+07	\N	0	\N	\N
2444	134	420	\N	2026-03-08 16:57:26.779942+07	\N	0	\N	\N
2455	134	420	\N	2026-03-08 17:09:54.473495+07	\N	0	\N	\N
2464	134	420	\N	2026-03-08 17:11:03.375104+07	\N	0	\N	\N
2473	134	420	\N	2026-03-08 17:29:01.921388+07	\N	0	\N	\N
2484	133	417	\N	2026-03-08 17:30:33.056475+07	\N	0	\N	\N
2486	135	427	\N	2026-03-08 17:30:36.486467+07	\N	0	\N	\N
2493	133	417	\N	2026-03-08 17:31:43.303687+07	\N	0	\N	\N
2495	135	427	\N	2026-03-08 17:31:46.869518+07	\N	0	\N	\N
2501	133	417	\N	2026-03-08 17:36:08.149098+07	\N	1	\N	\N
2503	135	427	\N	2026-03-08 17:36:11.89341+07	\N	0	\N	\N
2512	135	427	\N	2026-03-08 17:37:27.831916+07	\N	0	\N	\N
2520	134	420	\N	2026-03-08 17:38:53.800989+07	\N	0	\N	\N
2529	134	420	\N	2026-03-08 17:41:28.840816+07	\N	0	\N	\N
2538	133	417	\N	2026-03-08 18:04:39.917496+07	\N	0	\N	\N
2540	135	427	\N	2026-03-08 18:04:43.71541+07	\N	1	\N	\N
2546	133	417	\N	2026-03-08 18:19:32.263839+07	\N	0	\N	\N
2548	135	427	\N	2026-03-08 18:19:35.775506+07	\N	0	\N	\N
2555	133	417	\N	2026-03-08 18:43:32.361597+07	\N	0	\N	\N
2557	135	427	\N	2026-03-08 18:43:35.837268+07	\N	0	\N	\N
2564	134	420	\N	2026-03-08 18:49:29.239522+07	\N	0	\N	\N
2565	135	427	\N	2026-03-08 18:49:30.902799+07	\N	0	\N	\N
2574	135	427	\N	2026-03-08 18:58:51.714259+07	\N	1	\N	\N
2576	134	420	\N	2026-03-08 18:59:09.625751+07	\N	0	\N	\N
2584	133	417	\N	2026-03-08 19:00:26.002304+07	\N	0	\N	\N
2591	134	420	\N	2026-03-08 19:01:43.577891+07	\N	0	\N	\N
2599	134	420	\N	2026-03-08 19:03:23.927214+07	\N	0	\N	\N
2607	133	417	\N	2026-03-08 19:04:44.70523+07	\N	1	\N	\N
2614	133	417	\N	2026-03-08 19:18:36.393319+07	\N	1	\N	\N
2615	134	420	\N	2026-03-08 19:18:46.328792+07	\N	2	\N	\N
2616	135	427	\N	2026-03-08 19:18:49.558215+07	\N	1	\N	\N
2623	133	417	\N	2026-03-08 19:23:24.979496+07	\N	0	\N	\N
2625	135	427	\N	2026-03-08 19:23:28.355394+07	\N	0	\N	\N
2632	133	417	\N	2026-03-08 19:31:02.379294+07	\N	0	\N	\N
2637	133	417	\N	2026-03-08 19:35:01.304876+07	\N	1	\N	\N
2639	134	420	\N	2026-03-08 19:35:07.4304+07	\N	1	\N	\N
2640	135	427	\N	2026-03-08 19:35:14.506559+07	\N	1	\N	\N
2645	134	420	\N	2026-03-08 19:38:06.766281+07	\N	1	\N	\N
2653	134	420	\N	2026-03-08 19:40:44.569644+07	\N	0	\N	\N
2660	133	417	\N	2026-03-08 19:55:52.542974+07	\N	0	\N	\N
2662	135	427	\N	2026-03-08 19:55:57.916943+07	\N	1	\N	\N
2664	134	420	\N	2026-03-08 19:56:16.726283+07	\N	0	\N	\N
2669	130	408	\N	2026-03-09 14:12:30.807596+07	\N	1	\N	\N
2673	132	415	\N	2026-03-09 14:12:37.503258+07	\N	1	\N	\N
2677	158	489	\N	2026-03-09 15:58:47.227536+07	\N	1	\N	\N
2678	159	492	\N	2026-03-09 15:58:51.328455+07	\N	0	\N	\N
2679	160	499	\N	2026-03-09 15:58:59.200943+07	\N	1	\N	\N
2685	158	489	\N	2026-03-09 16:05:54.381061+07	\N	1	\N	\N
2686	159	492	\N	2026-03-09 16:06:08.170455+07	\N	5	\N	\N
2692	158	489	\N	2026-03-09 16:18:21.138102+07	\N	1	\N	\N
2694	160	499	\N	2026-03-09 16:18:27.365191+07	\N	1	\N	\N
2699	159	492	\N	2026-03-09 16:19:50.273848+07	\N	0	\N	\N
2707	158	489	\N	2026-03-09 16:25:08.731026+07	\N	0	\N	\N
2708	159	492	\N	2026-03-09 16:25:13.488848+07	\N	1	\N	\N
2714	159	492	\N	2026-03-09 16:26:33.200243+07	\N	0	\N	\N
2723	159	492	\N	2026-03-09 16:31:47.499465+07	\N	1	\N	\N
2731	158	489	\N	2026-03-09 16:52:05.100443+07	\N	1	\N	\N
2733	160	499	\N	2026-03-09 16:52:09.566897+07	\N	1	\N	\N
2740	158	489	\N	2026-03-09 17:40:40.761677+07	\N	0	\N	\N
2741	159	492	\N	2026-03-09 17:40:45.088698+07	\N	0	\N	\N
2742	160	499	\N	2026-03-09 17:40:48.506126+07	\N	1	\N	\N
2750	159	492	\N	2026-03-09 18:17:52.39583+07	\N	1	\N	\N
2757	159	492	\N	2026-03-09 18:40:53.812314+07	\N	4	\N	\N
2758	160	499	\N	2026-03-09 18:40:58.017175+07	\N	1	\N	\N
2766	168	518	\N	2026-03-09 19:05:34.834697+07	\N	20	\N	\N
2767	168	520	\N	2026-03-09 19:05:34.834697+07	\N	20	\N	\N
2768	168	521	\N	2026-03-09 19:05:34.834697+07	\N	20	\N	\N
2769	169	524	\N	2026-03-09 19:05:36.962552+07	1	1	\N	\N
2770	169	523	\N	2026-03-09 19:05:36.962552+07	2	1	\N	\N
2778	168	518	\N	2026-03-09 19:17:53.44596+07	\N	4	\N	\N
2779	168	520	\N	2026-03-09 19:17:53.44596+07	\N	4	\N	\N
2789	167	516	\N	2026-03-09 19:39:10.825416+07	\N	5	\N	\N
2790	168	518	\N	2026-03-09 19:39:19.07954+07	\N	4	\N	\N
2791	168	519	\N	2026-03-09 19:39:19.07954+07	\N	4	\N	\N
2792	168	521	\N	2026-03-09 19:39:19.07954+07	\N	4	\N	\N
2793	169	524	\N	2026-03-09 19:39:29.071093+07	1	7	\N	\N
2794	169	523	\N	2026-03-09 19:39:29.071093+07	2	7	\N	\N
2803	167	516	\N	2026-03-09 19:46:39.049561+07	\N	1	\N	\N
2812	167	516	\N	2026-03-09 19:52:00.543035+07	\N	1	\N	\N
2814	169	523	\N	2026-03-09 19:52:07.365461+07	1	2	\N	\N
2815	169	524	\N	2026-03-09 19:52:07.365461+07	2	2	\N	\N
2827	167	516	\N	2026-03-09 20:00:55.882334+07	\N	3	\N	\N
2829	167	517	\N	2026-03-09 20:00:58.757021+07	\N	6	\N	\N
2838	167	516	\N	2026-03-11 13:07:02.358032+07	\N	0	\N	\N
2843	168	519	\N	2026-03-11 16:05:31.691751+07	\N	3	\N	\N
2844	168	518	\N	2026-03-11 16:05:31.691751+07	\N	3	\N	\N
2845	168	521	\N	2026-03-11 16:05:31.691751+07	\N	3	\N	\N
2853	168	518	\N	2026-03-11 16:46:17.283548+07	\N	1	\N	\N
2854	168	519	\N	2026-03-11 16:46:17.283548+07	\N	1	\N	\N
2867	167	516	\N	2026-03-11 17:03:22.296834+07	\N	1	\N	\N
2878	167	516	\N	2026-03-11 17:09:06.352664+07	\N	0	\N	\N
2879	168	518	\N	2026-03-11 17:09:14.112059+07	\N	4	\N	\N
2880	168	521	\N	2026-03-11 17:09:14.112059+07	\N	4	\N	\N
2881	168	520	\N	2026-03-11 17:09:14.112059+07	\N	4	\N	\N
2882	169	523	\N	2026-03-11 17:09:17.891265+07	1	1	\N	\N
2883	169	524	\N	2026-03-11 17:09:17.891265+07	2	1	\N	\N
2890	159	492	\N	2026-03-12 10:20:13.111479+07	\N	3	\N	\N
2892	159	492	\N	2026-03-12 10:20:17.269419+07	\N	7	\N	\N
2894	160	499	\N	2026-03-12 10:20:32.050774+07	\N	5	\N	\N
2906	162	506	\N	2026-03-12 10:46:18.210803+07	\N	3	\N	\N
2926	160	499	\N	2026-03-12 11:20:07.346105+07	\N	1	\N	\N
2928	160	498	\N	2026-03-12 11:20:11.714307+07	\N	6	\N	\N
2933	168	522	\N	2026-03-12 12:00:33.696411+07	\N	1	\N	\N
2940	159	492	\N	2026-03-12 12:08:00.22386+07	\N	1	\N	\N
2948	160	499	\N	2026-03-12 12:15:54.483165+07	\N	1	\N	\N
2414	135	427	\N	2026-03-08 16:28:16.917178+07	\N	0	\N	\N
2415	133	417	\N	2026-03-08 16:29:31.925686+07	\N	1	\N	\N
2416	134	420	\N	2026-03-08 16:29:34.796548+07	\N	0	\N	\N
2417	135	427	\N	2026-03-08 16:29:36.807139+07	\N	1	\N	\N
2418	133	417	\N	2026-03-08 16:30:50.031559+07	\N	1	\N	\N
2419	134	420	\N	2026-03-08 16:30:52.481189+07	\N	1	\N	\N
2420	135	427	\N	2026-03-08 16:30:54.672158+07	\N	1	\N	\N
2421	133	417	\N	2026-03-08 16:33:10.186095+07	\N	0	\N	\N
2422	134	420	\N	2026-03-08 16:33:11.986254+07	\N	0	\N	\N
2423	133	417	\N	2026-03-08 16:33:28.708748+07	\N	1	\N	\N
2424	134	420	\N	2026-03-08 16:33:30.981684+07	\N	0	\N	\N
2425	135	427	\N	2026-03-08 16:33:33.006583+07	\N	0	\N	\N
2426	133	417	\N	2026-03-08 16:38:02.603049+07	\N	1	\N	\N
2427	134	420	\N	2026-03-08 16:38:04.586369+07	\N	0	\N	\N
2428	135	427	\N	2026-03-08 16:38:06.88055+07	\N	1	\N	\N
2429	133	417	\N	2026-03-08 16:38:22.672767+07	\N	0	\N	\N
2430	134	420	\N	2026-03-08 16:38:24.760919+07	\N	0	\N	\N
2431	135	427	\N	2026-03-08 16:38:26.828418+07	\N	0	\N	\N
2432	133	417	\N	2026-03-08 16:38:42.897885+07	\N	0	\N	\N
2433	134	420	\N	2026-03-08 16:38:45.256489+07	\N	0	\N	\N
2434	135	427	\N	2026-03-08 16:38:47.327245+07	\N	1	\N	\N
2445	133	417	\N	2026-03-08 16:58:09.449305+07	\N	1	\N	\N
2457	133	417	\N	2026-03-08 17:10:11.574865+07	\N	1	\N	\N
2466	133	417	\N	2026-03-08 17:28:15.147759+07	\N	0	\N	\N
2468	135	427	\N	2026-03-08 17:28:18.548935+07	\N	0	\N	\N
2475	133	417	\N	2026-03-08 17:29:23.079168+07	\N	1	\N	\N
2477	135	427	\N	2026-03-08 17:29:27.245443+07	\N	0	\N	\N
2485	134	420	\N	2026-03-08 17:30:34.784629+07	\N	0	\N	\N
2494	134	420	\N	2026-03-08 17:31:45.276402+07	\N	0	\N	\N
2502	134	420	\N	2026-03-08 17:36:09.892229+07	\N	0	\N	\N
2513	133	417	\N	2026-03-08 17:37:51.633684+07	\N	1	\N	\N
2515	135	427	\N	2026-03-08 17:37:54.902656+07	\N	0	\N	\N
2522	133	417	\N	2026-03-08 17:39:35.493925+07	\N	0	\N	\N
2524	135	427	\N	2026-03-08 17:39:39.046829+07	\N	0	\N	\N
2531	133	417	\N	2026-03-08 18:00:05.030951+07	\N	0	\N	\N
2533	135	427	\N	2026-03-08 18:00:09.52314+07	\N	1	\N	\N
2539	134	420	\N	2026-03-08 18:04:41.858902+07	\N	0	\N	\N
2547	134	420	\N	2026-03-08 18:19:34.033719+07	\N	0	\N	\N
2556	134	420	\N	2026-03-08 18:43:34.03192+07	\N	0	\N	\N
2566	133	417	\N	2026-03-08 18:53:32.502577+07	\N	2	\N	\N
2567	134	420	\N	2026-03-08 18:53:37.268847+07	\N	0	\N	\N
2568	135	427	\N	2026-03-08 18:53:40.168105+07	\N	0	\N	\N
2575	133	417	\N	2026-03-08 18:59:08.009337+07	\N	1	\N	\N
2577	135	427	\N	2026-03-08 18:59:12.076433+07	\N	1	\N	\N
2585	134	420	\N	2026-03-08 19:00:31.704803+07	\N	0	\N	\N
2586	135	427	\N	2026-03-08 19:00:35.375477+07	\N	1	\N	\N
2592	133	417	\N	2026-03-08 19:02:01.553705+07	\N	0	\N	\N
2594	135	427	\N	2026-03-08 19:02:05.256257+07	\N	1	\N	\N
2601	133	417	\N	2026-03-08 19:03:44.327741+07	\N	0	\N	\N
2603	135	427	\N	2026-03-08 19:03:47.461662+07	\N	0	\N	\N
2608	133	417	\N	2026-03-08 19:14:39.11958+07	\N	1	\N	\N
2610	135	427	\N	2026-03-08 19:14:42.433766+07	\N	0	\N	\N
2617	133	417	\N	2026-03-08 19:20:21.648163+07	\N	0	\N	\N
2618	134	420	\N	2026-03-08 19:20:22.943513+07	\N	0	\N	\N
2624	134	420	\N	2026-03-08 19:23:26.579452+07	\N	0	\N	\N
2627	134	420	\N	2026-03-08 19:23:49.024826+07	\N	0	\N	\N
2633	133	417	\N	2026-03-08 19:31:38.184165+07	\N	1	\N	\N
2638	133	417	\N	2026-03-08 19:35:04.187025+07	\N	4	\N	\N
2646	133	417	\N	2026-03-08 19:39:00.112553+07	\N	1	\N	\N
2648	135	427	\N	2026-03-08 19:39:03.910204+07	\N	0	\N	\N
2654	133	417	\N	2026-03-08 19:52:27.029534+07	\N	1	\N	\N
2656	135	427	\N	2026-03-08 19:52:30.107799+07	\N	4	\N	\N
2661	134	420	\N	2026-03-08 19:55:55.761379+07	\N	0	\N	\N
2670	131	411	\N	2026-03-09 14:12:35.154857+07	1	3	\N	\N
2671	131	412	\N	2026-03-09 14:12:35.154857+07	2	3	\N	\N
2672	131	413	\N	2026-03-09 14:12:35.154857+07	3	3	\N	\N
2680	158	489	\N	2026-03-09 15:59:29.395451+07	\N	2	\N	\N
2687	160	499	\N	2026-03-09 16:06:17.564397+07	\N	1	\N	\N
2693	159	492	\N	2026-03-09 16:18:24.249206+07	\N	0	\N	\N
2701	158	489	\N	2026-03-09 16:20:29.180808+07	\N	1	\N	\N
2703	160	499	\N	2026-03-09 16:20:35.423319+07	\N	1	\N	\N
2709	160	499	\N	2026-03-09 16:25:16.854295+07	\N	1	\N	\N
2716	158	489	\N	2026-03-09 16:27:01.740034+07	\N	1	\N	\N
2725	158	489	\N	2026-03-09 16:48:28.433138+07	\N	1	\N	\N
2727	160	499	\N	2026-03-09 16:48:34.959047+07	\N	1	\N	\N
2732	159	492	\N	2026-03-09 16:52:07.073422+07	\N	0	\N	\N
2743	158	489	\N	2026-03-09 17:41:06.713164+07	\N	1	\N	\N
2745	160	499	\N	2026-03-09 17:41:11.001337+07	\N	0	\N	\N
2752	158	489	\N	2026-03-09 18:19:22.188849+07	\N	3	\N	\N
2754	160	499	\N	2026-03-09 18:19:30.260753+07	\N	1	\N	\N
2759	167	516	\N	2026-03-09 19:04:30.251398+07	\N	0	\N	\N
2771	167	516	\N	2026-03-09 19:07:58.965524+07	\N	0	\N	\N
2782	158	489	\N	2026-03-09 19:19:15.196361+07	\N	1	\N	\N
2795	167	516	\N	2026-03-09 19:41:15.686887+07	\N	6	\N	\N
2797	169	523	\N	2026-03-09 19:41:21.967083+07	1	2	\N	\N
2798	169	524	\N	2026-03-09 19:41:21.967083+07	2	2	\N	\N
2804	167	516	\N	2026-03-09 19:48:23.642763+07	\N	3	\N	\N
2805	167	516	\N	2026-03-09 19:48:47.259915+07	\N	2	\N	\N
2816	167	516	\N	2026-03-09 19:52:22.075061+07	\N	0	\N	\N
2817	168	520	\N	2026-03-09 19:52:24.550437+07	\N	1	\N	\N
2828	167	517	\N	2026-03-09 20:00:57.652784+07	\N	4	\N	\N
2839	167	516	\N	2026-03-11 13:53:13.965463+07	\N	8	\N	\N
2846	167	516	\N	2026-03-11 16:05:56.818546+07	\N	1	\N	\N
2857	167	516	\N	2026-03-11 16:55:33.813556+07	\N	1	\N	\N
2858	168	518	\N	2026-03-11 16:55:40.610478+07	\N	2	\N	\N
2859	168	519	\N	2026-03-11 16:55:40.610478+07	\N	2	\N	\N
2868	168	518	\N	2026-03-11 17:03:25.51936+07	\N	1	\N	\N
2869	168	519	\N	2026-03-11 17:03:25.51936+07	\N	1	\N	\N
2884	158	489	\N	2026-03-12 10:07:33.682237+07	\N	1	\N	\N
2886	160	499	\N	2026-03-12 10:07:41.375447+07	\N	1	\N	\N
2891	159	492	\N	2026-03-12 10:20:14.901+07	\N	5	\N	\N
2893	160	498	\N	2026-03-12 10:20:30.230898+07	\N	3	\N	\N
2895	160	496	\N	2026-03-12 10:20:33.566913+07	\N	7	\N	\N
2929	158	489	\N	2026-03-12 11:57:50.556528+07	\N	0	\N	\N
2978	160	499	\N	2026-03-12 12:55:56.788359+07	\N	1	\N	\N
2979	167	516	\N	2026-03-12 13:05:09.836105+07	\N	0	\N	\N
2980	158	489	\N	2026-03-12 14:48:55.901124+07	\N	1	\N	\N
2981	159	492	\N	2026-03-12 14:48:58.926896+07	\N	0	\N	\N
2982	160	499	\N	2026-03-12 14:49:01.49319+07	\N	0	\N	\N
2983	158	489	\N	2026-03-12 14:54:55.691826+07	\N	2	\N	\N
2984	159	492	\N	2026-03-12 14:54:57.500186+07	\N	0	\N	\N
2985	160	499	\N	2026-03-12 14:54:59.611104+07	\N	1	\N	\N
2986	158	489	\N	2026-03-12 14:56:29.159737+07	\N	1	\N	\N
2987	159	492	\N	2026-03-12 14:56:41.828457+07	\N	1	\N	\N
2988	160	499	\N	2026-03-12 14:56:45.204775+07	\N	1	\N	\N
2989	158	489	\N	2026-03-12 14:57:07.147217+07	\N	1	\N	\N
2990	158	488	\N	2026-03-12 14:57:08.715462+07	\N	2	\N	\N
2991	158	489	\N	2026-03-12 14:57:25.282376+07	\N	1	\N	\N
2992	158	488	\N	2026-03-12 14:57:26.588896+07	\N	2	\N	\N
2993	159	492	\N	2026-03-12 14:57:30.133856+07	\N	0	\N	\N
2994	159	494	\N	2026-03-12 14:57:34.0735+07	\N	0	\N	\N
2995	160	499	\N	2026-03-12 14:57:37.294916+07	\N	1	\N	\N
2996	160	498	\N	2026-03-12 14:57:38.982611+07	\N	0	\N	\N
2997	167	516	\N	2026-03-12 14:58:13.281826+07	\N	0	\N	\N
2998	168	519	\N	2026-03-12 14:58:19.791517+07	\N	3	\N	\N
2999	168	518	\N	2026-03-12 14:58:19.791517+07	\N	3	\N	\N
3000	167	516	\N	2026-03-12 14:58:22.103268+07	\N	0	\N	\N
3001	169	523	\N	2026-03-12 14:58:28.1205+07	1	2	\N	\N
3002	169	524	\N	2026-03-12 14:58:28.1205+07	2	2	\N	\N
3003	168	521	\N	2026-03-12 14:58:30.388298+07	\N	4	\N	\N
3004	169	523	\N	2026-03-12 14:58:36.020757+07	1	3	\N	\N
3005	169	524	\N	2026-03-12 14:58:36.020757+07	2	3	\N	\N
3006	158	489	\N	2026-03-12 15:04:59.063545+07	\N	0	\N	\N
3007	159	492	\N	2026-03-12 15:05:00.752056+07	\N	0	\N	\N
3008	160	499	\N	2026-03-12 15:05:02.718951+07	\N	1	\N	\N
3009	158	489	\N	2026-03-12 15:11:48.092891+07	\N	1	\N	\N
3010	159	492	\N	2026-03-12 15:11:51.004414+07	\N	0	\N	\N
3011	160	499	\N	2026-03-12 15:11:54.474774+07	\N	1	\N	\N
3012	167	516	\N	2026-03-12 15:13:02.628862+07	\N	0	\N	\N
3013	168	520	\N	2026-03-12 15:13:07.933112+07	\N	2	\N	\N
3014	169	523	\N	2026-03-12 15:13:13.791196+07	1	1	\N	\N
3015	169	524	\N	2026-03-12 15:13:13.791196+07	2	1	\N	\N
3016	158	489	\N	2026-03-12 15:13:40.758191+07	\N	1	\N	\N
3017	159	492	\N	2026-03-12 15:13:45.380808+07	\N	2	\N	\N
3018	160	497	\N	2026-03-12 15:13:47.366431+07	\N	0	\N	\N
3019	167	516	\N	2026-03-12 15:14:23.886071+07	\N	2	\N	\N
3020	168	519	\N	2026-03-12 15:14:27.948381+07	\N	2	\N	\N
3021	167	516	\N	2026-03-12 15:14:54.936589+07	\N	4	\N	\N
3022	168	519	\N	2026-03-12 15:15:01.044187+07	\N	2	\N	\N
3023	168	518	\N	2026-03-12 15:15:01.044187+07	\N	2	\N	\N
3024	169	523	\N	2026-03-12 15:15:07.070081+07	1	3	\N	\N
3025	169	524	\N	2026-03-12 15:15:07.070081+07	2	3	\N	\N
3026	167	516	\N	2026-03-12 15:15:29.401833+07	\N	1	\N	\N
3027	168	518	\N	2026-03-12 15:15:33.309943+07	\N	2	\N	\N
3028	168	519	\N	2026-03-12 15:15:33.309943+07	\N	2	\N	\N
3029	169	523	\N	2026-03-12 15:15:36.331954+07	1	1	\N	\N
3030	169	524	\N	2026-03-12 15:15:36.331954+07	2	1	\N	\N
3031	158	489	\N	2026-03-12 15:15:58.570634+07	\N	0	\N	\N
3032	159	492	\N	2026-03-12 15:16:00.523397+07	\N	0	\N	\N
3033	158	489	\N	2026-03-12 15:16:13.852125+07	\N	0	\N	\N
3034	159	492	\N	2026-03-12 15:16:15.561906+07	\N	0	\N	\N
3035	160	499	\N	2026-03-12 15:16:17.007209+07	\N	0	\N	\N
3036	167	517	\N	2026-03-12 15:16:35.574702+07	\N	0	\N	\N
3037	168	518	\N	2026-03-12 15:16:39.076402+07	\N	2	\N	\N
3038	168	519	\N	2026-03-12 15:16:39.076402+07	\N	2	\N	\N
3039	169	523	\N	2026-03-12 15:16:42.375885+07	1	1	\N	\N
3040	169	524	\N	2026-03-12 15:16:42.375885+07	2	1	\N	\N
3041	158	489	\N	2026-03-14 16:59:12.459897+07	\N	1	\N	\N
3042	159	493	\N	2026-03-14 16:59:15.096625+07	\N	0	\N	\N
3043	160	496	\N	2026-03-14 16:59:16.206865+07	\N	0	\N	\N
3044	159	492	\N	2026-03-14 17:18:32.799759+07	\N	2	\N	\N
3045	158	489	\N	2026-03-14 17:18:51.645921+07	\N	3	\N	\N
3046	158	489	\N	2026-03-14 17:22:02.079148+07	\N	2	\N	\N
3047	159	492	\N	2026-03-14 17:22:05.578138+07	\N	1	\N	\N
3048	160	499	\N	2026-03-14 17:22:08.45308+07	\N	1	\N	\N
3049	158	489	\N	2026-03-14 17:22:24.205294+07	\N	1	\N	\N
3050	159	492	\N	2026-03-14 17:22:27.339802+07	\N	1	\N	\N
3051	160	499	\N	2026-03-14 17:22:29.311452+07	\N	1	\N	\N
3052	158	489	\N	2026-03-14 17:27:49.832656+07	\N	1	\N	\N
3053	158	489	\N	2026-03-14 17:28:05.831581+07	\N	1	\N	\N
3054	159	493	\N	2026-03-14 17:28:07.666332+07	\N	0	\N	\N
3055	160	499	\N	2026-03-14 17:28:09.316194+07	\N	0	\N	\N
3056	158	489	\N	2026-03-14 17:28:24.209987+07	\N	0	\N	\N
3057	159	492	\N	2026-03-14 17:28:26.749701+07	\N	0	\N	\N
3058	160	499	\N	2026-03-14 17:28:31.080044+07	\N	3	\N	\N
3059	158	489	\N	2026-03-14 17:29:16.27855+07	\N	2	\N	\N
3060	158	489	\N	2026-03-14 17:29:18.736197+07	\N	5	\N	\N
3061	159	495	\N	2026-03-14 17:29:20.184037+07	\N	0	\N	\N
3062	160	499	\N	2026-03-14 17:29:21.800604+07	\N	1	\N	\N
3063	159	492	\N	2026-03-14 17:29:25.739816+07	\N	1	\N	\N
3064	160	499	\N	2026-03-14 17:29:27.861965+07	\N	1	\N	\N
3065	158	489	\N	2026-03-14 17:41:04.044107+07	\N	3	\N	\N
3066	158	489	\N	2026-03-14 17:43:49.710634+07	\N	2	\N	\N
3067	158	490	\N	2026-03-14 17:43:52.704924+07	\N	5	\N	\N
3068	159	492	\N	2026-03-14 17:44:07.554315+07	\N	2	\N	\N
3069	159	492	\N	2026-03-14 17:44:09.088077+07	\N	3	\N	\N
3070	160	499	\N	2026-03-14 17:44:26.043695+07	\N	2	\N	\N
3071	160	499	\N	2026-03-14 17:44:27.365706+07	\N	3	\N	\N
3072	158	489	\N	2026-03-14 18:02:29.273937+07	\N	2	\N	\N
3073	159	492	\N	2026-03-14 18:02:31.860911+07	\N	0	\N	\N
3074	160	499	\N	2026-03-14 18:02:33.767682+07	\N	1	\N	\N
3075	158	489	\N	2026-03-15 13:21:53.457891+07	\N	2	\N	\N
3076	159	492	\N	2026-03-15 13:22:04.098261+07	\N	1	\N	\N
3077	160	499	\N	2026-03-15 13:22:13.608019+07	\N	3	\N	\N
3078	158	489	\N	2026-03-15 13:22:54.398483+07	\N	1	\N	\N
3079	158	489	\N	2026-03-15 13:23:36.477297+07	\N	1	\N	\N
3080	159	492	\N	2026-03-15 13:23:41.974273+07	\N	1	\N	\N
3081	160	499	\N	2026-03-15 13:23:46.295691+07	\N	1	\N	\N
3082	158	489	\N	2026-03-15 13:24:27.274718+07	\N	1	\N	\N
3083	159	492	\N	2026-03-15 13:24:29.509503+07	\N	0	\N	\N
3084	160	499	\N	2026-03-15 13:24:32.183911+07	\N	1	\N	\N
3085	158	489	\N	2026-03-15 15:38:00.446927+07	\N	0	\N	\N
3086	159	492	\N	2026-03-15 15:38:03.112565+07	\N	0	\N	\N
3087	160	499	\N	2026-03-15 15:38:06.027547+07	\N	0	\N	\N
3088	141	439	\N	2026-03-15 15:38:26.40681+07	\N	1	\N	\N
3089	158	489	\N	2026-03-15 16:45:39.038617+07	\N	1	\N	\N
3090	159	492	\N	2026-03-15 16:45:43.385599+07	\N	1	\N	\N
3091	160	499	\N	2026-03-15 16:45:46.771395+07	\N	1	\N	\N
3092	158	489	\N	2026-03-15 16:46:06.66329+07	\N	1	\N	\N
3093	159	492	\N	2026-03-15 16:46:09.974671+07	\N	1	\N	\N
3094	160	499	\N	2026-03-15 16:46:12.346341+07	\N	1	\N	\N
3095	158	489	\N	2026-03-15 16:46:27.883968+07	\N	0	\N	\N
3096	159	492	\N	2026-03-15 16:46:30.140216+07	\N	0	\N	\N
3097	160	499	\N	2026-03-15 16:46:32.241131+07	\N	0	\N	\N
3098	158	489	\N	2026-03-15 16:46:44.938874+07	\N	0	\N	\N
3099	159	492	\N	2026-03-15 16:46:46.523948+07	\N	0	\N	\N
3100	160	499	\N	2026-03-15 16:46:48.18991+07	\N	0	\N	\N
3101	158	489	\N	2026-03-15 16:47:18.365039+07	\N	1	\N	\N
3102	159	492	\N	2026-03-15 16:47:21.823404+07	\N	1	\N	\N
3103	160	499	\N	2026-03-15 16:47:24.659929+07	\N	0	\N	\N
3104	158	489	\N	2026-03-15 16:47:42.083933+07	\N	0	\N	\N
3105	159	492	\N	2026-03-15 16:47:45.900346+07	\N	1	\N	\N
3106	160	499	\N	2026-03-15 16:47:48.467705+07	\N	0	\N	\N
3107	158	489	\N	2026-03-15 16:49:18.082776+07	\N	0	\N	\N
3108	159	492	\N	2026-03-15 16:49:20.877807+07	\N	0	\N	\N
3109	160	499	\N	2026-03-15 16:49:22.798147+07	\N	1	\N	\N
3110	158	489	\N	2026-03-15 16:52:33.625814+07	\N	1	\N	\N
3111	158	489	\N	2026-03-15 16:52:51.546849+07	\N	0	\N	\N
3112	159	492	\N	2026-03-15 16:52:53.410823+07	\N	0	\N	\N
3113	160	499	\N	2026-03-15 16:52:55.711109+07	\N	0	\N	\N
3114	158	489	\N	2026-03-15 16:54:00.17693+07	\N	0	\N	\N
3115	159	492	\N	2026-03-15 16:54:01.608597+07	\N	0	\N	\N
3116	160	499	\N	2026-03-15 16:54:03.879659+07	\N	0	\N	\N
3122	158	490	\N	2026-03-16 19:32:19.378413+07	\N	2	1614	8148
3123	158	490	\N	2026-03-16 19:46:52.155836+07	\N	1	1615	8150
3124	159	492	\N	2026-03-16 19:47:06.620836+07	\N	1	1615	8150
3125	160	499	\N	2026-03-16 19:47:11.778746+07	\N	1	1615	8150
3126	158	490	\N	2026-03-16 19:49:23.200443+07	\N	1	1617	8157
3127	159	492	\N	2026-03-16 19:49:25.419868+07	\N	1	1617	8157
3128	160	499	\N	2026-03-16 19:49:27.124733+07	\N	1	1617	8157
3129	158	489	\N	2026-03-16 19:49:28.950603+07	\N	6	1617	8159
3130	159	492	\N	2026-03-16 19:49:32.320144+07	\N	2	1617	8159
3131	160	499	\N	2026-03-16 19:49:35.299663+07	\N	2	1617	8159
3132	158	490	\N	2026-03-16 19:50:45.81351+07	\N	0	1618	8161
3133	158	489	\N	2026-03-16 19:50:49.011331+07	\N	0	1618	8162
3134	159	492	\N	2026-03-16 19:50:53.958311+07	\N	4	1618	8162
3135	159	492	\N	2026-03-16 19:50:54.844025+07	\N	3	1618	8161
3136	160	499	\N	2026-03-16 19:50:58.235556+07	\N	0	1618	8161
3137	160	499	\N	2026-03-16 19:50:59.200811+07	\N	3	1618	8162
3138	158	490	\N	2026-03-16 19:51:26.607918+07	\N	0	1619	8165
3139	158	489	\N	2026-03-16 19:51:27.442359+07	\N	0	1619	8166
3140	443	1101	\N	2026-03-16 19:58:45.808166+07	\N	2	1620	8177
3141	443	1101	\N	2026-03-16 19:59:10.742127+07	\N	1	1621	8180
3142	443	1101	\N	2026-03-16 19:59:24.895194+07	\N	0	1622	8183
3143	443	1101	\N	2026-03-16 19:59:37.12748+07	\N	0	1623	8186
3144	158	490	\N	2026-03-18 13:07:16.970841+07	\N	15	1629	8220
3145	158	490	\N	2026-03-18 13:07:54.011144+07	\N	1	1630	8230
3146	158	490	\N	2026-03-18 13:07:55.399446+07	\N	2	1630	8229
3147	159	492	\N	2026-03-18 13:08:05.97544+07	\N	1	1630	8230
3148	159	492	\N	2026-03-18 13:08:07.391159+07	\N	3	1630	8229
3149	160	499	\N	2026-03-18 13:08:12.543679+07	\N	1	1630	8230
3150	160	499	\N	2026-03-18 13:08:14.147409+07	\N	3	1630	8229
3151	158	490	\N	2026-03-18 13:11:05.63673+07	\N	1	1631	8237
3152	158	490	\N	2026-03-18 13:11:06.773217+07	\N	2	1631	8239
3153	159	492	\N	2026-03-18 13:11:13.716144+07	\N	1	1631	8239
3154	159	492	\N	2026-03-18 13:11:14.770901+07	\N	2	1631	8237
3155	160	498	\N	2026-03-18 13:11:19.989645+07	\N	2	1631	8239
3156	160	499	\N	2026-03-18 13:11:21.744326+07	\N	4	1631	8237
3157	158	489	\N	2026-03-18 13:18:09.636793+07	\N	1	1632	8245
3158	158	490	\N	2026-03-18 13:18:11.141455+07	\N	2	1632	8246
3159	159	492	\N	2026-03-18 13:18:19.754144+07	\N	1	1632	8245
3160	159	492	\N	2026-03-18 13:18:21.154724+07	\N	2	1632	8246
3161	160	499	\N	2026-03-18 13:18:25.139223+07	\N	1	1632	8245
3162	160	499	\N	2026-03-18 13:18:26.376752+07	\N	2	1632	8246
3163	158	490	\N	2026-03-18 13:32:24.637378+07	\N	2	1633	8255
3164	158	488	\N	2026-03-18 13:32:25.823177+07	\N	3	1633	8256
3165	159	492	\N	2026-03-18 13:32:34.649074+07	\N	1	1633	8255
3166	159	492	\N	2026-03-18 13:32:37.38906+07	\N	4	1633	8256
3167	160	499	\N	2026-03-18 13:32:42.561814+07	\N	2	1633	8256
3168	160	498	\N	2026-03-18 13:32:44.495051+07	\N	4	1633	8255
3169	158	490	\N	2026-03-18 13:37:19.662713+07	\N	1	1634	8264
3170	158	490	\N	2026-03-18 13:37:21.860004+07	\N	3	1634	8265
3171	159	492	\N	2026-03-18 13:37:29.833213+07	\N	2	1634	8264
3172	159	494	\N	2026-03-18 13:37:30.563126+07	\N	2	1634	8265
3173	160	498	\N	2026-03-18 13:37:34.228985+07	\N	0	1634	8265
3174	160	498	\N	2026-03-18 13:37:34.293285+07	\N	0	1634	8264
3175	158	490	\N	2026-03-18 13:45:11.413922+07	\N	2	1635	8274
3176	158	490	\N	2026-03-18 13:45:12.897809+07	\N	3	1635	8273
3177	159	492	\N	2026-03-18 13:45:22.323479+07	\N	1	1635	8274
3178	159	494	\N	2026-03-18 13:45:24.225585+07	\N	3	1635	8273
3179	160	499	\N	2026-03-18 13:45:29.446744+07	\N	1	1635	8274
3180	160	496	\N	2026-03-18 13:45:30.354282+07	\N	1	1635	8273
3181	158	490	\N	2026-03-18 13:47:43.073186+07	\N	0	1636	8281
3182	158	490	\N	2026-03-18 13:47:43.895491+07	\N	1	1636	8282
3183	159	492	\N	2026-03-18 13:47:54.252741+07	\N	1	1636	8281
3184	159	492	\N	2026-03-18 13:47:55.323362+07	\N	2	1636	8282
3185	160	499	\N	2026-03-18 13:47:59.495859+07	\N	1	1636	8281
3186	160	499	\N	2026-03-18 13:48:00.770368+07	\N	2	1636	8282
3187	443	1101	\N	2026-03-18 13:51:08.384395+07	\N	1	1637	8288
3188	158	490	\N	2026-03-18 14:10:41.520896+07	\N	2	1638	8301
3189	158	490	\N	2026-03-18 14:10:41.964087+07	\N	2	1638	8302
3190	159	492	\N	2026-03-18 14:11:19.860063+07	\N	1	1638	8302
3191	159	494	\N	2026-03-18 14:11:22.051334+07	\N	4	1638	8301
3192	160	499	\N	2026-03-18 14:11:27.016049+07	\N	1	1638	8301
3193	160	499	\N	2026-03-18 14:11:29.226097+07	\N	3	1638	8302
3194	158	490	\N	2026-03-18 14:16:06.287541+07	\N	1	1639	8312
3195	158	489	\N	2026-03-18 14:16:07.574686+07	\N	2	1639	8311
3196	160	499	\N	2026-03-18 14:22:35.553725+07	\N	2	1639	8312
3197	160	499	\N	2026-03-18 14:22:37.289333+07	\N	4	1639	8311
3198	158	490	\N	2026-03-18 14:24:00.653306+07	\N	1	1640	8321
3199	158	489	\N	2026-03-18 14:24:00.996008+07	\N	2	1640	8322
3200	159	492	\N	2026-03-18 14:24:07.749054+07	\N	1	1640	8322
3201	159	492	\N	2026-03-18 14:24:09.491538+07	\N	2	1640	8321
3202	160	499	\N	2026-03-18 14:24:14.695545+07	\N	2	1640	8322
3203	160	497	\N	2026-03-18 14:24:16.511405+07	\N	4	1640	8321
3204	454	1137	\N	2026-03-18 14:57:21.40084+07	\N	5	1643	8341
3205	455	1140	\N	2026-03-18 14:57:24.204267+07	\N	1	1643	8341
3206	454	1137	\N	2026-03-18 14:57:26.372645+07	\N	10	1643	8342
3207	454	1137	\N	2026-03-18 14:57:28.93679+07	\N	13	1643	8345
3208	455	1140	\N	2026-03-18 14:57:31.047187+07	\N	1	1643	8342
3209	456	1142	\N	2026-03-18 14:57:34.803672+07	\N	9	1643	8341
3210	457	1149	\N	2026-03-18 14:57:38.264675+07	\N	2	1643	8341
3211	455	1140	\N	2026-03-18 14:57:40.133414+07	\N	7	1643	8345
3212	456	1142	\N	2026-03-18 14:57:42.617611+07	\N	1	1643	8342
3213	456	1142	\N	2026-03-18 14:57:44.386396+07	\N	0	1643	8345
3214	458	1151	\N	2026-03-18 14:57:46.798868+07	\N	1	1643	8341
3215	457	1147	\N	2026-03-18 14:57:50.191085+07	\N	1	1643	8345
3216	458	1151	\N	2026-03-18 14:57:52.656003+07	\N	1	1643	8345
3217	459	1152	\N	2026-03-18 14:57:55.217312+07	\N	1	1643	8345
3218	459	1153	\N	2026-03-18 14:57:58.862332+07	\N	10	1643	8341
3219	457	1149	\N	2026-03-18 14:58:01.317203+07	\N	1	1643	8342
3220	458	1150	\N	2026-03-18 14:58:03.267178+07	\N	0	1643	8342
3221	459	1153	\N	2026-03-18 14:58:06.401928+07	\N	2	1643	8342
3222	460	1155	\N	2026-03-18 14:58:09.136679+07	\N	12	1643	8345
3223	460	1155	\N	2026-03-18 14:58:15.638966+07	\N	1	1643	8341
3224	460	1155	\N	2026-03-18 14:58:18.241093+07	\N	10	1643	8342
3225	158	490	\N	2026-03-18 15:00:42.9143+07	\N	1	1644	8353
3226	158	489	\N	2026-03-18 15:00:43.505106+07	\N	1	1644	8352
3227	159	492	\N	2026-03-18 15:00:47.568746+07	\N	1	1644	8353
3228	159	494	\N	2026-03-18 15:00:48.522844+07	\N	2	1644	8352
3229	160	499	\N	2026-03-18 15:00:51.595954+07	\N	0	1644	8352
3230	160	499	\N	2026-03-18 15:00:52.378347+07	\N	1	1644	8353
3231	454	1135	\N	2026-03-18 16:15:20.550106+07	\N	7	1645	8358
3232	455	1140	\N	2026-03-18 16:15:33.302094+07	\N	3	1645	8358
3233	455	1140	\N	2026-03-18 16:15:34.390306+07	\N	4	1645	8357
3234	456	1142	\N	2026-03-18 16:15:42.080473+07	\N	1	1645	8358
3235	456	1142	\N	2026-03-18 16:15:42.924599+07	\N	2	1645	8357
3236	457	1149	\N	2026-03-18 16:15:49.160033+07	\N	2	1645	8357
3237	457	1149	\N	2026-03-18 16:15:51.309631+07	\N	4	1645	8358
3238	458	1150	\N	2026-03-18 16:15:59.066235+07	\N	1	1645	8357
3239	458	1151	\N	2026-03-18 16:16:00.544602+07	\N	2	1645	8358
3240	459	1153	\N	2026-03-18 16:16:06.690565+07	\N	1	1645	8358
3241	459	1152	\N	2026-03-18 16:16:07.425384+07	\N	2	1645	8357
3242	460	1155	\N	2026-03-18 16:16:13.823144+07	\N	2	1645	8357
3243	460	1155	\N	2026-03-18 16:16:14.857338+07	\N	4	1645	8358
3244	454	1137	\N	2026-03-18 17:24:50.520412+07	\N	5	1647	8365
3245	454	1135	\N	2026-03-18 17:24:54.821087+07	\N	9	1647	8366
3246	456	1142	\N	2026-03-18 17:25:17.209907+07	\N	2	1647	8365
3247	456	1142	\N	2026-03-18 17:25:19.038428+07	\N	3	1647	8366
3248	457	1149	\N	2026-03-18 17:25:38.267446+07	\N	2	1647	8365
3249	457	1149	\N	2026-03-18 17:25:39.65137+07	\N	4	1647	8366
3250	458	1151	\N	2026-03-18 17:25:44.879175+07	\N	2	1647	8365
3251	458	1150	\N	2026-03-18 17:25:46.093322+07	\N	4	1647	8366
3252	459	1153	\N	2026-03-18 17:25:52.636537+07	\N	2	1647	8365
3253	459	1153	\N	2026-03-18 17:25:53.786485+07	\N	3	1647	8366
3254	460	1155	\N	2026-03-18 17:25:58.811035+07	\N	2	1647	8365
3255	460	1155	\N	2026-03-18 17:25:59.901952+07	\N	3	1647	8366
3256	454	1135	\N	2026-03-18 17:54:36.293218+07	\N	3	1649	8375
3257	455	1138	\N	2026-03-18 17:54:39.416456+07	\N	0	1649	8375
3258	456	1142	\N	2026-03-18 17:54:41.80856+07	\N	1	1649	8375
3259	457	1149	\N	2026-03-18 17:54:44.477134+07	\N	1	1649	8375
3260	454	1137	\N	2026-03-18 17:54:50.344956+07	\N	17	1649	8374
3261	455	1138	\N	2026-03-18 17:54:52.232568+07	\N	0	1649	8374
3262	456	1142	\N	2026-03-18 17:54:54.919415+07	\N	1	1649	8374
3263	457	1149	\N	2026-03-18 17:54:59.284391+07	\N	2	1649	8374
3264	458	1151	\N	2026-03-18 17:55:01.476245+07	\N	1	1649	8374
3265	459	1153	\N	2026-03-18 17:55:19.276574+07	\N	1	1649	8374
3266	460	1155	\N	2026-03-18 17:55:21.778137+07	\N	1	1649	8374
3267	454	1137	\N	2026-03-18 17:55:48.984886+07	\N	0	1650	8381
3268	455	1140	\N	2026-03-18 17:55:52.047919+07	\N	1	1650	8381
3269	454	1137	\N	2026-03-18 17:55:57.998107+07	\N	0	1650	8380
3270	454	1137	\N	2026-03-18 17:56:12.605796+07	\N	0	1651	8388
3271	455	1140	\N	2026-03-18 17:56:15.203975+07	\N	1	1651	8388
3272	454	1135	\N	2026-03-18 17:56:20.880617+07	\N	0	1651	8386
3273	455	1140	\N	2026-03-18 17:56:23.240247+07	\N	1	1651	8386
3274	456	1142	\N	2026-03-18 17:56:25.56148+07	\N	1	1651	8388
3275	457	1149	\N	2026-03-18 17:56:27.208202+07	\N	0	1651	8388
3276	443	1101	\N	2026-03-18 18:47:31.816579+07	\N	1	1652	8409
3277	443	1101	\N	2026-03-18 18:49:06.823877+07	\N	1	1653	8417
3278	454	1137	\N	2026-03-18 19:39:09.935448+07	\N	4	1656	8488
3279	455	1140	\N	2026-03-18 19:39:22.432196+07	\N	2	1656	8488
3280	456	1142	\N	2026-03-18 19:39:25.768244+07	\N	1	1656	8488
3281	457	1149	\N	2026-03-18 19:39:29.297653+07	\N	1	1656	8488
3282	458	1150	\N	2026-03-18 19:39:36.928364+07	\N	5	1656	8488
3283	459	1153	\N	2026-03-18 19:39:44.504529+07	\N	1	1656	8488
3284	460	1155	\N	2026-03-18 19:39:47.923077+07	\N	1	1656	8488
3285	454	1135	\N	2026-03-18 19:41:08.882436+07	\N	7	1657	8491
3286	455	1140	\N	2026-03-18 19:41:17.889235+07	\N	7	1657	8491
3287	456	1142	\N	2026-03-18 19:41:21.219631+07	\N	2	1657	8491
3288	457	1149	\N	2026-03-18 19:41:24.264964+07	\N	1	1657	8491
3289	458	1151	\N	2026-03-18 19:41:28.134528+07	\N	2	1657	8491
3290	459	1152	\N	2026-03-18 19:41:32.371592+07	\N	3	1657	8491
3291	460	1155	\N	2026-03-18 19:41:34.462141+07	\N	1	1657	8491
3292	443	1101	\N	2026-03-18 19:43:20.901832+07	\N	1	1658	8496
3293	443	1101	\N	2026-03-18 19:43:20.978638+07	\N	1	1658	8497
3294	454	1137	\N	2026-03-18 19:43:36.835099+07	\N	2	1659	8502
3295	454	1136	\N	2026-03-18 19:43:37.455433+07	\N	3	1659	8503
3296	454	1137	\N	2026-03-18 19:44:02.272875+07	\N	1	1660	8508
3297	454	1137	\N	2026-03-18 19:44:02.998245+07	\N	2	1660	8510
3298	455	1140	\N	2026-03-18 19:44:05.522786+07	\N	1	1660	8508
3299	455	1140	\N	2026-03-18 19:44:07.32364+07	\N	1	1660	8510
3300	456	1142	\N	2026-03-18 19:44:09.721199+07	\N	1	1660	8508
3301	456	1144	\N	2026-03-18 19:44:11.142331+07	\N	0	1660	8510
3302	457	1146	\N	2026-03-18 19:44:15.215433+07	\N	2	1660	8508
3303	457	1146	\N	2026-03-18 19:44:16.608999+07	\N	2	1660	8510
3304	458	1151	\N	2026-03-18 19:44:20.306892+07	\N	2	1660	8508
3305	458	1150	\N	2026-03-18 19:44:21.248405+07	\N	2	1660	8510
3306	459	1153	\N	2026-03-18 19:44:23.370457+07	\N	1	1660	8510
3307	459	1153	\N	2026-03-18 19:44:25.162237+07	\N	0	1660	8508
3308	460	1155	\N	2026-03-18 19:44:28.368631+07	\N	1	1660	8508
3309	460	1155	\N	2026-03-18 19:44:29.365432+07	\N	2	1660	8510
3310	454	1137	\N	2026-03-18 19:45:25.295758+07	\N	0	1661	8514
3311	455	1140	\N	2026-03-18 19:45:33.100803+07	\N	2	1661	8514
3312	456	1143	\N	2026-03-18 19:45:43.559224+07	\N	1	1661	8514
3313	457	1146	\N	2026-03-18 19:45:49.025595+07	\N	1	1661	8514
3314	454	1136	\N	2026-03-18 19:45:51.057036+07	\N	0	1661	8516
3315	455	1140	\N	2026-03-18 19:45:54.962262+07	\N	1	1661	8516
3316	458	1151	\N	2026-03-18 19:45:57.438638+07	\N	1	1661	8514
3317	459	1153	\N	2026-03-18 19:45:59.676592+07	\N	1	1661	8514
3318	460	1155	\N	2026-03-18 19:46:02.20938+07	\N	1	1661	8514
3319	454	1137	\N	2026-03-18 19:46:30.576065+07	\N	0	1662	8520
3320	455	1140	\N	2026-03-18 19:46:35.952555+07	\N	3	1662	8520
3321	456	1142	\N	2026-03-18 19:46:42.543289+07	\N	1	1662	8520
3322	457	1149	\N	2026-03-18 19:46:44.140593+07	\N	0	1662	8520
3323	458	1151	\N	2026-03-18 19:46:45.843345+07	\N	1	1662	8520
3324	459	1152	\N	2026-03-18 19:46:47.533602+07	\N	0	1662	8520
3325	460	1156	\N	2026-03-18 19:46:49.04507+07	\N	0	1662	8520
3326	454	1135	\N	2026-03-18 19:47:19.622218+07	\N	1	1663	8526
3327	455	1140	\N	2026-03-18 19:47:29.913419+07	\N	1	1663	8526
3328	456	1142	\N	2026-03-18 19:47:35.815073+07	\N	1	1663	8527
3329	456	1142	\N	2026-03-18 19:47:37.516384+07	\N	3	1663	8526
3330	457	1149	\N	2026-03-18 19:47:41.071525+07	\N	1	1663	8526
3331	457	1149	\N	2026-03-18 19:47:41.669405+07	\N	1	1663	8527
3332	458	1151	\N	2026-03-18 19:47:45.62998+07	\N	1	1663	8526
3333	458	1151	\N	2026-03-18 19:47:47.001249+07	\N	3	1663	8527
3334	459	1153	\N	2026-03-18 19:47:53.277898+07	\N	1	1663	8526
3335	459	1153	\N	2026-03-18 19:47:54.581593+07	\N	2	1663	8527
3336	460	1155	\N	2026-03-18 19:47:58.436093+07	\N	2	1663	8526
3337	454	1135	\N	2026-03-18 19:48:46.772466+07	\N	1	1664	8534
3338	455	1140	\N	2026-03-18 19:48:49.661534+07	\N	1	1664	8534
3339	456	1145	\N	2026-03-18 19:48:51.718179+07	\N	1	1664	8534
3340	457	1148	\N	2026-03-18 19:48:53.224668+07	\N	0	1664	8534
3341	454	1135	\N	2026-03-18 19:49:39.187591+07	\N	1	1665	8542
3342	455	1140	\N	2026-03-18 19:49:41.948698+07	\N	1	1665	8542
3343	454	1137	\N	2026-03-18 19:49:44.424155+07	\N	7	1665	8544
3344	455	1139	\N	2026-03-18 19:49:47.943082+07	\N	0	1665	8544
3345	456	1142	\N	2026-03-18 19:49:52.224029+07	\N	9	1665	8542
3346	457	1149	\N	2026-03-18 19:49:54.135467+07	\N	1	1665	8542
3347	458	1151	\N	2026-03-18 19:49:55.845251+07	\N	0	1665	8542
3348	459	1153	\N	2026-03-18 19:49:57.939861+07	\N	1	1665	8542
3349	460	1155	\N	2026-03-18 19:49:59.831034+07	\N	1	1665	8542
3350	454	1137	\N	2026-03-18 19:50:33.268225+07	\N	0	1666	8548
3351	455	1140	\N	2026-03-18 19:50:36.325766+07	\N	1	1666	8548
3352	456	1145	\N	2026-03-18 19:50:38.498936+07	\N	1	1666	8548
3353	457	1149	\N	2026-03-18 19:50:40.778418+07	\N	1	1666	8548
3354	458	1151	\N	2026-03-18 19:50:42.798426+07	\N	1	1666	8548
3355	459	1153	\N	2026-03-18 19:50:44.851988+07	\N	1	1666	8548
3356	460	1155	\N	2026-03-18 19:50:47.375504+07	\N	1	1666	8548
3357	454	1135	\N	2026-03-18 19:52:33.88906+07	\N	3	1667	8558
3358	455	1140	\N	2026-03-18 19:52:36.18764+07	\N	1	1667	8558
3359	456	1142	\N	2026-03-18 19:52:38.017391+07	\N	0	1667	8558
3360	457	1149	\N	2026-03-18 19:52:40.241733+07	\N	1	1667	8558
3361	458	1151	\N	2026-03-18 19:52:42.182723+07	\N	0	1667	8558
3362	459	1152	\N	2026-03-18 19:52:43.833465+07	\N	0	1667	8558
3363	460	1155	\N	2026-03-18 19:52:46.278469+07	\N	1	1667	8558
3364	455	1140	\N	2026-03-18 19:52:52.856678+07	\N	1	1667	8559
3365	456	1142	\N	2026-03-18 19:52:55.164237+07	\N	1	1667	8559
3366	457	1149	\N	2026-03-18 19:52:56.277889+07	\N	0	1667	8559
3367	458	1151	\N	2026-03-18 19:52:57.539963+07	\N	0	1667	8559
3368	459	1153	\N	2026-03-18 19:52:58.90233+07	\N	0	1667	8559
3369	460	1154	\N	2026-03-18 19:53:00.372241+07	\N	0	1667	8559
3370	158	490	\N	2026-03-18 19:53:31.119405+07	\N	1	1668	8568
3371	158	489	\N	2026-03-18 19:53:31.674152+07	\N	1	1668	8567
3372	159	492	\N	2026-03-18 19:53:36.270328+07	\N	2	1668	8568
3373	159	492	\N	2026-03-18 19:53:37.624073+07	\N	2	1668	8567
3374	160	499	\N	2026-03-18 19:53:40.732878+07	\N	1	1668	8568
3375	160	497	\N	2026-03-18 19:53:43.09877+07	\N	0	1668	8567
3376	162	506	\N	2026-03-18 19:58:51.806857+07	\N	2	1669	8579
3377	162	506	\N	2026-03-18 19:58:52.495015+07	\N	3	1669	8580
3378	158	490	\N	2026-03-18 20:02:48.452681+07	\N	0	1670	8590
3379	158	489	\N	2026-03-18 20:02:48.84248+07	\N	0	1670	8591
3380	159	494	\N	2026-03-18 20:02:51.726634+07	\N	1	1670	8590
3381	160	499	\N	2026-03-18 20:02:54.168034+07	\N	1	1670	8590
3382	159	492	\N	2026-03-18 20:02:58.422874+07	\N	1	1670	8591
3383	160	499	\N	2026-03-18 20:03:01.356976+07	\N	1	1670	8591
3384	461	1160	\N	2026-03-19 12:32:56.236557+07	\N	13	1671	8598
3385	462	1162	\N	2026-03-19 12:33:09.268943+07	\N	3	1671	8598
3386	462	1161	\N	2026-03-19 12:33:09.268943+07	\N	3	1671	8598
3387	463	1166	\N	2026-03-19 12:33:31.506232+07	1	15	1671	8598
3388	463	1167	\N	2026-03-19 12:33:31.506232+07	2	15	1671	8598
3389	463	1168	\N	2026-03-19 12:33:31.506232+07	3	15	1671	8598
3390	463	1169	\N	2026-03-19 12:33:31.506232+07	4	15	1671	8598
3391	461	1160	\N	2026-03-19 12:34:28.974856+07	\N	4	1672	8601
3392	461	1160	\N	2026-03-19 12:36:53.395325+07	\N	1	1673	8604
3393	462	1162	\N	2026-03-19 12:37:00.456194+07	\N	4	1673	8604
3394	462	1164	\N	2026-03-19 12:37:00.456194+07	\N	4	1673	8604
3395	462	1165	\N	2026-03-19 12:37:00.456194+07	\N	4	1673	8604
3396	461	1160	\N	2026-03-19 12:37:14.094264+07	\N	1	1674	8607
3397	462	1162	\N	2026-03-19 12:37:21.846907+07	\N	3	1674	8607
3398	462	1164	\N	2026-03-19 12:37:21.846907+07	\N	3	1674	8607
3399	462	1165	\N	2026-03-19 12:37:21.846907+07	\N	3	1674	8607
3400	463	1166	\N	2026-03-19 12:37:33.754912+07	1	9	1674	8607
3401	463	1167	\N	2026-03-19 12:37:33.754912+07	2	9	1674	8607
3402	463	1168	\N	2026-03-19 12:37:33.754912+07	3	9	1674	8607
3403	463	1169	\N	2026-03-19 12:37:33.754912+07	4	9	1674	8607
3404	464	1173	\N	2026-03-19 12:56:59.254869+07	\N	1	1675	8610
3405	465	1175	\N	2026-03-19 12:57:07.811146+07	\N	5	1675	8610
3406	465	1177	\N	2026-03-19 12:57:07.811146+07	\N	5	1675	8610
3407	465	1178	\N	2026-03-19 12:57:07.811146+07	\N	5	1675	8610
3408	466	1179	\N	2026-03-19 12:57:11.918407+07	1	2	1675	8610
3409	466	1180	\N	2026-03-19 12:57:11.918407+07	2	2	1675	8610
3410	466	1182	\N	2026-03-19 12:57:11.918407+07	3	2	1675	8610
3411	466	1181	\N	2026-03-19 12:57:11.918407+07	4	2	1675	8610
3412	454	1137	\N	2026-03-19 12:59:05.471795+07	\N	0	1676	8613
3413	464	1172	\N	2026-03-19 13:00:47.288232+07	\N	0	1677	8616
3414	454	1137	\N	2026-03-19 13:08:07.505987+07	\N	4	1678	8619
3415	464	1173	\N	2026-03-19 13:16:46.263362+07	\N	1	1679	8622
3416	465	1177	\N	2026-03-19 13:16:51.253576+07	\N	3	1679	8622
3417	466	1181	\N	2026-03-19 13:16:54.19278+07	1	1	1679	8622
3418	466	1180	\N	2026-03-19 13:16:54.19278+07	2	1	1679	8622
3419	466	1179	\N	2026-03-19 13:16:54.19278+07	3	1	1679	8622
3420	466	1182	\N	2026-03-19 13:16:54.19278+07	4	1	1679	8622
3421	467	1183	\N	2026-03-19 13:16:56.907182+07	\N	1	1679	8622
3422	464	1173	\N	2026-03-19 13:17:52.444096+07	\N	1	1680	8625
3423	464	1171	\N	2026-03-19 13:23:40.291985+07	\N	1	1681	8629
3424	465	1175	\N	2026-03-19 13:23:44.11209+07	\N	2	1681	8629
3425	465	1177	\N	2026-03-19 13:23:44.11209+07	\N	2	1681	8629
3426	465	1178	\N	2026-03-19 13:23:44.11209+07	\N	2	1681	8629
3427	467	1184	\N	2026-03-19 13:23:48.070201+07	\N	1	1681	8629
3428	464	1173	\N	2026-03-19 13:24:03.818934+07	\N	1	1682	8632
3429	465	1174	\N	2026-03-19 13:24:07.032206+07	\N	2	1682	8632
3430	465	1175	\N	2026-03-19 13:24:07.032206+07	\N	2	1682	8632
3431	466	1181	\N	2026-03-19 13:24:09.36696+07	1	1	1682	8632
3432	466	1182	\N	2026-03-19 13:24:09.36696+07	2	1	1682	8632
3433	466	1180	\N	2026-03-19 13:24:09.36696+07	3	1	1682	8632
3434	466	1179	\N	2026-03-19 13:24:09.36696+07	4	1	1682	8632
3435	467	1184	\N	2026-03-19 13:24:11.5299+07	\N	1	1682	8632
3436	464	1173	\N	2026-03-19 13:24:26.110234+07	\N	1	1683	8636
3437	465	1174	\N	2026-03-19 13:24:29.336362+07	\N	2	1683	8636
3438	466	1182	\N	2026-03-19 13:24:31.558066+07	1	1	1683	8636
3439	466	1181	\N	2026-03-19 13:24:31.558066+07	2	1	1683	8636
3440	466	1180	\N	2026-03-19 13:24:31.558066+07	3	1	1683	8636
3441	466	1179	\N	2026-03-19 13:24:31.558066+07	4	1	1683	8636
3442	467	1184	\N	2026-03-19 13:24:33.915688+07	\N	1	1683	8636
3443	454	1137	\N	2026-03-19 13:25:02.85481+07	\N	0	1684	8639
3444	455	1140	\N	2026-03-19 13:25:05.223241+07	\N	1	1684	8639
3445	456	1145	\N	2026-03-19 13:25:07.531013+07	\N	1	1684	8639
3446	457	1149	\N	2026-03-19 13:25:09.126354+07	\N	0	1684	8639
3447	458	1151	\N	2026-03-19 13:25:11.762971+07	\N	1	1684	8639
3448	459	1153	\N	2026-03-19 13:25:14.021058+07	\N	1	1684	8639
3449	460	1155	\N	2026-03-19 13:25:16.75803+07	\N	1	1684	8639
3450	464	1173	\N	2026-03-19 13:27:21.620301+07	\N	1	1685	8643
3451	465	1174	\N	2026-03-19 13:27:24.071103+07	\N	1	1685	8643
3452	466	1179	\N	2026-03-19 13:27:33.744306+07	1	8	1685	8643
3453	466	1180	\N	2026-03-19 13:27:33.744306+07	2	8	1685	8643
3454	466	1181	\N	2026-03-19 13:27:33.744306+07	3	8	1685	8643
3455	466	1182	\N	2026-03-19 13:27:33.744306+07	4	8	1685	8643
3456	467	1184	\N	2026-03-19 13:27:35.76097+07	\N	0	1685	8643
3457	464	1173	\N	2026-03-19 13:30:31.759713+07	\N	4	1686	8647
3458	465	1174	\N	2026-03-19 13:30:34.88887+07	\N	1	1686	8647
3459	466	1181	\N	2026-03-19 13:30:37.66815+07	1	1	1686	8647
3460	466	1182	\N	2026-03-19 13:30:37.66815+07	2	1	1686	8647
3461	466	1180	\N	2026-03-19 13:30:37.66815+07	3	1	1686	8647
3462	466	1179	\N	2026-03-19 13:30:37.66815+07	4	1	1686	8647
3463	467	1184	\N	2026-03-19 13:30:39.770765+07	\N	1	1686	8647
3464	464	1173	\N	2026-03-19 13:31:44.943445+07	\N	3	1687	8650
3465	465	1176	\N	2026-03-19 13:31:47.631658+07	\N	1	1687	8650
3466	466	1180	\N	2026-03-19 13:31:50.095274+07	1	1	1687	8650
3467	466	1179	\N	2026-03-19 13:31:50.095274+07	2	1	1687	8650
3468	466	1181	\N	2026-03-19 13:31:50.095274+07	3	1	1687	8650
3469	466	1182	\N	2026-03-19 13:31:50.095274+07	4	1	1687	8650
3470	467	1184	\N	2026-03-19 13:31:51.723134+07	\N	0	1687	8650
3471	443	1101	\N	2026-03-19 13:44:26.961327+07	\N	1	1688	8654
3472	443	1101	\N	2026-03-19 13:44:50.07011+07	\N	1	1689	8657
3473	158	490	\N	2026-03-20 10:48:23.519499+07	\N	2	1692	8688
3474	158	489	\N	2026-03-20 10:48:31.856777+07	\N	10	1692	8687
3475	158	490	\N	2026-03-20 10:48:34.255652+07	\N	13	1692	8691
3476	159	492	\N	2026-03-20 10:49:08.913118+07	\N	1	1692	8688
3477	159	492	\N	2026-03-20 10:49:10.443455+07	\N	3	1692	8691
3478	159	492	\N	2026-03-20 10:49:10.51164+07	\N	3	1692	8687
3479	160	499	\N	2026-03-20 10:49:18.431385+07	\N	1	1692	8688
3480	160	498	\N	2026-03-20 10:49:20.019582+07	\N	3	1692	8691
3481	158	489	\N	2026-03-20 10:55:43.528052+07	\N	0	1693	8698
3482	158	489	\N	2026-03-20 10:55:44.286086+07	\N	10	1693	8699
3483	158	489	\N	2026-03-20 10:55:46.095492+07	\N	0	1693	8697
3484	158	490	\N	2026-03-20 10:55:46.831398+07	\N	0	1693	8696
3485	159	492	\N	2026-03-20 10:55:48.525481+07	\N	1	1693	8698
3486	159	492	\N	2026-03-20 10:55:48.983351+07	\N	1	1693	8696
3487	160	499	\N	2026-03-20 10:55:50.904018+07	\N	1	1693	8696
3488	159	494	\N	2026-03-20 10:55:51.285463+07	\N	1	1693	8697
3489	160	499	\N	2026-03-20 10:55:55.680394+07	\N	1	1693	8698
3490	159	492	\N	2026-03-20 10:55:56.221613+07	\N	0	1693	8699
3491	160	499	\N	2026-03-20 10:55:56.488615+07	\N	2	1693	8697
3492	160	499	\N	2026-03-20 10:56:03.866607+07	\N	1	1693	8699
3493	158	490	\N	2026-03-20 10:56:59.369202+07	\N	1	1694	8712
3494	158	489	\N	2026-03-20 10:57:00.037922+07	\N	2	1694	8715
3495	158	489	\N	2026-03-20 10:57:00.282564+07	\N	2	1694	8713
3496	158	488	\N	2026-03-20 10:57:04.279797+07	\N	6	1694	8714
3497	159	492	\N	2026-03-20 10:57:28.682289+07	\N	2	1694	8715
3498	159	492	\N	2026-03-20 10:57:31.082463+07	\N	4	1694	8714
3499	159	492	\N	2026-03-20 10:57:33.64851+07	\N	6	1694	8713
3500	159	495	\N	2026-03-20 10:57:35.171538+07	\N	8	1694	8712
3501	160	499	\N	2026-03-20 10:57:40.30143+07	\N	2	1694	8712
\.


--
-- TOC entry 5301 (class 0 OID 17378)
-- Dependencies: 261
-- Data for Name: QuizProgress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuizProgress" ("Current_Question", "Total_Questions", "Updated_At", "AssignedQuiz_ID", "ActivityParticipant_ID") FROM stdin;
4	4	2026-03-19 13:16:56.907182	1679	8622
1	1	2026-03-19 13:44:50.07011	1689	8657
3	3	2026-03-20 10:49:18.431385	1692	8688
3	3	2026-03-20 10:49:20.019582	1692	8691
4	4	2026-03-19 13:18:06.597694	1680	8625
4	4	2026-03-19 14:00:52.116441	1691	8669
3	3	2026-03-20 10:49:20.861028	1692	8687
4	4	2026-03-19 13:23:48.070201	1681	8629
4	4	2026-03-19 14:00:52.171218	1691	8670
3	3	2026-03-20 10:55:55.680394	1693	8698
3	3	2026-03-20 10:55:56.488615	1693	8697
4	4	2026-03-19 13:24:11.5299	1682	8632
3	3	2026-03-20 10:55:50.904018	1693	8696
3	3	2026-03-20 10:56:03.866607	1693	8699
4	4	2026-03-19 13:24:33.915688	1683	8636
3	3	2026-03-20 10:57:40.30143	1694	8712
3	3	2026-03-20 10:57:43.04923	1694	8713
7	7	2026-03-19 13:25:16.75803	1684	8639
3	3	2026-03-20 10:57:42.922512	1694	8714
3	3	2026-03-20 10:57:43.018234	1694	8715
4	4	2026-03-19 13:27:35.76097	1685	8643
4	4	2026-03-19 13:30:39.770765	1686	8647
4	4	2026-03-19 13:31:51.723134	1687	8650
1	1	2026-03-19 13:44:26.961327	1688	8654
3	3	2026-03-18 14:22:37.289333	1639	8311
1	1	2026-03-18 18:47:31.816579	1652	8409
1	3	2026-03-16 19:32:19.378413	1614	8148
7	7	2026-03-18 16:16:13.823144	1645	8357
3	3	2026-03-16 19:47:11.778746	1615	8150
3	3	2026-03-18 14:24:14.695545	1640	8322
3	3	2026-03-16 19:49:27.124733	1617	8157
3	3	2026-03-18 14:24:16.511405	1640	8321
3	3	2026-03-16 19:49:35.299663	1617	8159
7	7	2026-03-18 16:16:14.857338	1645	8358
3	3	2026-03-16 19:50:58.235556	1618	8161
3	3	2026-03-16 19:50:59.200811	1618	8162
1	3	2026-03-16 19:51:26.607918	1619	8165
1	3	2026-03-16 19:51:27.442359	1619	8166
1	1	2026-03-16 19:58:45.808166	1620	8177
1	1	2026-03-16 19:59:10.742127	1621	8180
1	1	2026-03-16 19:59:24.895194	1622	8183
1	1	2026-03-16 19:59:37.12748	1623	8186
1	3	2026-03-16 21:46:57.64128	1625	8203
1	3	2026-03-16 21:46:57.634003	1625	8202
1	3	2026-03-16 22:42:43.848324	1626	8207
1	3	2026-03-16 22:43:56.861973	1626	8209
1	3	2026-03-16 22:58:59.672317	1627	8213
1	3	2026-03-16 23:04:55.526594	1627	8212
1	3	2026-03-18 13:07:16.970841	1629	8220
3	3	2026-03-18 13:08:12.543679	1630	8230
3	3	2026-03-18 13:08:14.147409	1630	8229
7	7	2026-03-18 16:16:18.045291	1645	8356
3	3	2026-03-18 13:11:19.989645	1631	8239
3	3	2026-03-18 13:11:21.744326	1631	8237
1	1	2026-03-18 18:47:33.88554	1652	8410
3	3	2026-03-18 13:18:25.139223	1632	8245
3	3	2026-03-18 13:18:26.376752	1632	8246
1	1	2026-03-18 18:49:06.823877	1653	8417
1	7	2026-03-18 19:09:54.720972	1655	8465
3	3	2026-03-18 13:32:42.561814	1633	8256
3	3	2026-03-18 13:32:44.495051	1633	8255
1	7	2026-03-18 19:09:54.724074	1655	8464
1	7	2026-03-18 19:09:54.906889	1655	8466
3	3	2026-03-18 13:37:34.228985	1634	8265
3	3	2026-03-18 13:37:34.293285	1634	8264
7	7	2026-03-18 19:44:28.368631	1660	8508
3	3	2026-03-18 13:45:29.446744	1635	8274
3	3	2026-03-18 13:45:30.354282	1635	8273
7	7	2026-03-18 19:44:29.365432	1660	8510
3	3	2026-03-18 13:47:59.495859	1636	8281
3	3	2026-03-18 13:48:00.770368	1636	8282
1	1	2026-03-18 13:51:08.384395	1637	8288
4	7	2026-03-18 19:48:53.224668	1664	8534
7	7	2026-03-18 17:25:58.811035	1647	8365
3	3	2026-03-18 14:11:27.016049	1638	8301
3	3	2026-03-18 14:11:29.226097	1638	8302
3	3	2026-03-18 14:22:35.553725	1639	8312
7	7	2026-03-18 14:58:09.136679	1643	8345
7	7	2026-03-18 14:58:15.638966	1643	8341
7	7	2026-03-18 14:58:18.241093	1643	8342
7	7	2026-03-18 17:25:59.901952	1647	8366
1	7	2026-03-18 17:52:02.18526	1648	8371
3	3	2026-03-18 15:00:51.595954	1644	8352
3	3	2026-03-18 15:00:52.378347	1644	8353
7	7	2026-03-18 19:43:52.113669	1659	8502
7	7	2026-03-18 19:39:47.923077	1656	8488
4	7	2026-03-18 17:54:44.477134	1649	8375
1	7	2026-03-18 19:41:11.825166	1657	8492
7	7	2026-03-18 19:43:52.164463	1659	8503
7	7	2026-03-18 17:55:21.778137	1649	8374
1	7	2026-03-18 19:48:54.200481	1664	8535
7	7	2026-03-18 19:46:49.04507	1662	8520
7	7	2026-03-18 19:41:34.462141	1657	8491
1	1	2026-03-18 19:43:20.901832	1658	8496
1	7	2026-03-18 17:55:57.998107	1650	8380
3	7	2026-03-18 17:56:03.352033	1650	8381
1	1	2026-03-18 19:43:20.978638	1658	8497
2	7	2026-03-18 17:56:23.240247	1651	8386
4	7	2026-03-18 17:56:27.208202	1651	8388
2	7	2026-03-18 19:45:54.962262	1661	8516
1	7	2026-03-18 19:46:53.417099	1662	8522
7	7	2026-03-18 19:46:02.20938	1661	8514
7	7	2026-03-18 19:47:58.436093	1663	8526
7	7	2026-03-18 19:47:59.305154	1663	8527
7	7	2026-03-18 19:50:47.375504	1666	8548
1	7	2026-03-18 19:50:57.619869	1666	8549
7	7	2026-03-18 19:49:59.831034	1665	8542
7	7	2026-03-18 19:52:46.278469	1667	8558
3	7	2026-03-18 19:50:03.599072	1665	8544
7	7	2026-03-18 19:53:00.372241	1667	8559
3	3	2026-03-18 19:53:43.09877	1668	8567
1	1	2026-03-18 19:58:51.806857	1669	8579
3	3	2026-03-18 19:53:40.732878	1668	8568
1	1	2026-03-18 19:58:52.495015	1669	8580
3	3	2026-03-18 20:02:54.168034	1670	8590
3	3	2026-03-18 20:03:01.356976	1670	8591
3	3	2026-03-19 12:33:31.506232	1671	8598
3	3	2026-03-19 12:34:42.135172	1672	8601
3	3	2026-03-19 12:37:02.798612	1673	8604
3	3	2026-03-19 12:37:33.754912	1674	8607
4	4	2026-03-19 12:57:27.636756	1675	8610
1	7	2026-03-19 12:59:05.471795	1676	8613
1	4	2026-03-19 13:00:47.288232	1677	8616
1	7	2026-03-19 13:08:07.505987	1678	8619
\.


--
-- TOC entry 5268 (class 0 OID 16576)
-- Dependencies: 228
-- Data for Name: QuizResults; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuizResults" ("Result_ID", "Total_Score", "Total_Question", "Total_Correct", "Total_Incorrct", "Time_ Submission", "Total_Time_Taken", "AssignedQuiz_ID", "ActivityParticipant_ID") FROM stdin;
1121	226	0	0	0	\N	17	\N	\N
1148	0	0	0	0	\N	1	\N	\N
1124	354	0	0	0	\N	18	\N	\N
1127	226	0	0	0	\N	17	\N	\N
1129	100	0	0	0	\N	15	\N	\N
1131	100	0	0	0	\N	15	\N	\N
464	7638	0	0	0	\N	323	\N	\N
465	627	0	0	0	\N	399	\N	\N
466	6365	0	0	0	\N	361	\N	\N
467	627	0	0	0	\N	494	\N	\N
468	7524	0	0	0	\N	513	\N	\N
4	2272	0	0	0	\N	115	\N	\N
5	231	0	0	0	\N	141	\N	\N
6	1805	0	0	0	\N	128	\N	\N
7	231	0	0	0	\N	175	\N	\N
8	2234	0	0	0	\N	183	\N	\N
359	2814	0	0	0	\N	119	\N	\N
360	231	0	0	0	\N	147	\N	\N
361	2345	0	0	0	\N	133	\N	\N
362	231	0	0	0	\N	182	\N	\N
363	2772	0	0	0	\N	189	\N	\N
1037	402	0	0	0	\N	22	\N	\N
1038	100	0	0	0	\N	27	\N	\N
1039	404	0	0	0	\N	23	\N	\N
1040	100	0	0	0	\N	33	\N	\N
969	906	0	0	0	\N	51	\N	\N
104	8194	0	0	0	\N	289	\N	\N
105	561	0	0	0	\N	357	\N	\N
106	7055	0	0	0	\N	323	\N	\N
107	561	0	0	0	\N	442	\N	\N
108	8092	0	0	0	\N	459	\N	\N
970	300	0	0	0	\N	63	\N	\N
971	906	0	0	0	\N	57	\N	\N
972	300	0	0	0	\N	78	\N	\N
973	900	0	0	0	\N	81	\N	\N
1041	400	0	0	0	\N	33	\N	\N
754	0	0	0	0	\N	40	\N	\N
755	816	0	0	0	\N	32	\N	\N
756	0	0	0	0	\N	48	\N	\N
757	800	0	0	0	\N	40	\N	\N
758	0	0	0	0	\N	56	\N	\N
1042	202	0	0	0	\N	20	\N	\N
1043	304	0	0	0	\N	22	\N	\N
1044	200	0	0	0	\N	28	\N	\N
1045	300	0	0	0	\N	28	\N	\N
909	1208	0	0	0	\N	68	\N	\N
749	2416	0	0	0	\N	136	\N	\N
750	599	0	0	0	\N	168	\N	\N
751	2215	0	0	0	\N	152	\N	\N
752	599	0	0	0	\N	208	\N	\N
753	2400	0	0	0	\N	216	\N	\N
910	400	0	0	0	\N	84	\N	\N
911	1208	0	0	0	\N	76	\N	\N
912	400	0	0	0	\N	104	\N	\N
913	1200	0	0	0	\N	108	\N	\N
1014	302	0	0	0	\N	17	\N	\N
1015	100	0	0	0	\N	21	\N	\N
1016	302	0	0	0	\N	19	\N	\N
1017	100	0	0	0	\N	26	\N	\N
1018	300	0	0	0	\N	27	\N	\N
1036	0	0	0	0	\N	2	\N	\N
1046	200	0	0	0	\N	28	\N	\N
1133	248	0	0	0	\N	26	\N	\N
1077	596	0	0	0	\N	22	\N	\N
1078	142	0	0	0	\N	27	\N	\N
1079	594	0	0	0	\N	23	\N	\N
1080	136	0	0	0	\N	33	\N	\N
1081	574	0	0	0	\N	33	\N	\N
1082	300	0	0	0	\N	20	\N	\N
1083	446	0	0	0	\N	22	\N	\N
1084	288	0	0	0	\N	28	\N	\N
1135	246	0	0	0	\N	27	\N	\N
1137	290	0	0	0	\N	5	\N	\N
1139	196	0	0	0	\N	2	\N	\N
1149	202	0	0	0	\N	1	\N	\N
1140	424	0	0	0	\N	6	\N	\N
1085	438	0	0	0	\N	28	\N	\N
1086	292	0	0	0	\N	28	\N	\N
1117	0	0	0	0	\N	1	\N	\N
1118	412	0	0	0	\N	34	\N	\N
1150	148	0	0	0	\N	1	\N	\N
1143	148	0	0	0	\N	2	\N	\N
1151	202	0	0	0	\N	1	\N	\N
1145	294	0	0	0	\N	4	\N	\N
1152	0	0	0	0	\N	1	\N	\N
1153	0	0	0	0	\N	2	\N	\N
1154	148	0	0	0	\N	1	\N	\N
1155	0	0	0	0	\N	2	\N	\N
1161	290	0	0	0	\N	5	\N	\N
1157	434	0	0	0	\N	8	\N	\N
1160	146	0	0	0	\N	2	\N	\N
1163	238	0	0	0	\N	11	\N	\N
1166	0	0	0	0	\N	4	\N	\N
1171	0	0	0	0	\N	3	\N	\N
1168	292	0	0	0	\N	7	\N	\N
1172	120	0	0	0	\N	11	\N	\N
1176	372	0	0	0	\N	6	\N	\N
1175	372	0	0	0	\N	6	\N	\N
1181	0	0	0	0	\N	3	\N	\N
1183	292	0	0	0	\N	6	\N	\N
1186	440	0	0	0	\N	5	\N	\N
1189	442	0	0	0	\N	4	\N	\N
1192	296	0	0	0	\N	3	\N	\N
1195	148	0	0	0	\N	1	\N	\N
1196	292	0	0	0	\N	4	\N	\N
1198	142	0	0	0	\N	2	\N	\N
1199	122	0	0	0	\N	11	\N	\N
1287	0	0	0	0	\N	2	\N	\N
1200	442	0	0	0	\N	4	\N	\N
1203	404	0	0	0	\N	8	\N	\N
1206	242	0	0	0	\N	3	\N	\N
1289	0	0	0	0	\N	2	\N	\N
1208	250	0	0	0	\N	5	\N	\N
1211	242	0	0	0	\N	7	\N	\N
1213	398	0	0	0	\N	5	\N	\N
1216	144	0	0	0	\N	4	\N	\N
1338	466	3	3	0	\N	7	\N	\N
1218	282	0	0	0	\N	10	\N	\N
1221	238	0	0	0	\N	5	\N	\N
1223	0	0	0	0	\N	3	\N	\N
1224	254	0	0	0	\N	3	\N	\N
1226	200	0	0	0	\N	4	\N	\N
1291	0	0	0	0	\N	5	\N	\N
1228	200	0	0	0	\N	7	\N	\N
1294	0	0	0	0	\N	1	\N	\N
1231	360	0	0	0	\N	12	\N	\N
1234	372	0	0	0	\N	6	\N	\N
1295	0	0	0	0	\N	3	\N	\N
1237	300	0	0	0	\N	8	\N	\N
1240	356	0	0	0	\N	14	\N	\N
1243	120	0	0	0	\N	4	\N	\N
1244	124	0	0	0	\N	2	\N	\N
1245	0	0	0	0	\N	8	\N	\N
1247	232	0	0	0	\N	14	\N	\N
1249	100	0	0	0	\N	1	\N	\N
1251	300	0	0	0	\N	6	\N	\N
1297	384	0	0	0	\N	3	\N	\N
1254	360	0	0	0	\N	6	\N	\N
1257	502	0	0	0	\N	7	\N	\N
1341	200	2	2	0	\N	4	\N	\N
1259	480	0	0	0	\N	18	\N	\N
1263	234	0	0	0	\N	11	\N	\N
1264	124	0	0	0	\N	14	\N	\N
1368	128	0	0	0	\N	0	\N	\N
1268	238	0	0	0	\N	14	\N	\N
1267	352	0	0	0	\N	19	\N	\N
1343	300	3	3	0	\N	11	\N	\N
1273	364	0	0	0	\N	4	\N	\N
1276	0	0	0	0	\N	3	\N	\N
1278	126	0	0	0	\N	4	\N	\N
1280	130	0	0	0	\N	1	\N	\N
1282	126	0	0	0	\N	5	\N	\N
1300	754	0	0	0	\N	13	\N	\N
1284	408	3	3	0	\N	6	\N	\N
1306	246	0	0	0	\N	7	\N	\N
1308	300	0	0	0	\N	9	\N	\N
1311	0	0	0	0	\N	3	\N	\N
1312	230	0	0	0	\N	5	\N	\N
1314	362	0	0	0	\N	5	\N	\N
1317	100	0	0	0	\N	1	\N	\N
1318	100	0	0	0	\N	3	\N	\N
1319	244	0	0	0	\N	6	\N	\N
1346	300	3	3	0	\N	10	\N	\N
1324	100	0	0	0	\N	1	\N	\N
1325	0	0	0	0	\N	16	\N	\N
1321	572	4	4	0	\N	14	\N	\N
1328	100	1	1	0	\N	4	\N	\N
1329	0	0	0	0	\N	3	\N	\N
1331	0	0	0	0	\N	6	\N	\N
1332	0	0	0	0	\N	3	\N	\N
1349	348	3	3	0	\N	6	\N	\N
1335	300	3	3	0	\N	7	\N	\N
1381	444	0	0	0	\N	4	\N	\N
1370	252	0	0	0	\N	6	\N	\N
1352	0	0	0	0	\N	4	\N	\N
1356	0	0	0	0	\N	1	\N	\N
1357	0	0	0	0	\N	1	\N	\N
1369	380	0	0	0	\N	5	\N	\N
1358	100	0	0	0	\N	5	\N	\N
1361	254	0	0	0	\N	1	\N	\N
1363	126	0	0	0	\N	1	\N	\N
1364	122	0	0	0	\N	1	\N	\N
1366	126	0	0	0	\N	15	\N	\N
1393	134	0	0	0	\N	3	\N	\N
1375	300	0	0	0	\N	6	\N	\N
1378	200	0	0	0	\N	7	\N	\N
1380	100	0	0	0	\N	1	\N	\N
1385	414	0	0	0	\N	3	\N	\N
1394	104	0	0	0	\N	2	\N	\N
1398	252	0	0	0	\N	2	\N	\N
1395	216	0	0	0	\N	6	\N	\N
1388	500	0	0	0	\N	6	\N	\N
1401	126	0	0	0	\N	1	\N	\N
1402	372	0	0	0	\N	6	\N	\N
1408	126	0	0	0	\N	1	\N	\N
1405	374	0	0	0	\N	5	\N	\N
1409	106	0	0	0	\N	1	\N	\N
1410	118	0	0	0	\N	1	\N	\N
1412	310	3	2	1	\N	108	\N	\N
1413	418	3	2	1	\N	107	\N	\N
1411	304	3	2	1	\N	105	\N	\N
1421	756	3	3	0	\N	12	\N	\N
1422	498	3	2	1	\N	19	\N	\N
1420	756	3	3	0	\N	12	\N	\N
1429	126	0	0	0	\N	1	\N	\N
1430	100	0	0	0	\N	18	\N	\N
1431	126	0	0	0	\N	1	\N	\N
1432	100	0	0	0	\N	27	\N	\N
1433	100	0	0	0	\N	79	\N	\N
1434	100	0	0	0	\N	262	\N	\N
1436	300	3	3	0	\N	5	\N	\N
1523	414	0	0	0	\N	3	\N	\N
1439	322	0	0	0	\N	762	\N	\N
1442	200	0	0	0	\N	1529	\N	\N
1444	100	0	0	0	\N	852	\N	\N
1445	380	0	0	0	\N	2	\N	\N
1448	118	0	0	0	\N	1	\N	\N
1449	246	0	0	0	\N	5	\N	\N
1451	126	0	0	0	\N	1	\N	\N
1452	118	0	0	0	\N	1	\N	\N
1453	126	0	0	0	\N	1	\N	\N
1454	122	0	0	0	\N	1	\N	\N
1577	200	0	0	0	\N	6	\N	\N
1455	380	0	0	0	\N	2	\N	\N
1458	200	0	0	0	\N	2	\N	\N
1526	406	0	0	0	\N	7	\N	\N
1461	118	0	0	0	\N	3969	\N	\N
1464	0	0	0	0	\N	35	\N	\N
1529	0	0	0	0	\N	2187	\N	\N
1530	0	0	0	0	\N	2	\N	\N
1465	230	0	0	0	\N	299	\N	\N
1579	200	0	0	0	\N	6	\N	\N
1532	504	0	0	0	\N	4	\N	\N
1536	138	0	0	0	\N	3	\N	\N
1471	348	0	0	0	\N	86	\N	\N
1581	100	0	0	0	\N	0	\N	\N
1478	122	0	0	0	\N	407	\N	\N
1538	366	0	0	0	\N	3	\N	\N
1482	230	0	0	0	\N	40	\N	\N
1582	134	0	0	0	\N	3	\N	\N
1541	412	0	0	0	\N	4	\N	\N
1485	238	0	0	0	\N	97	\N	\N
1583	100	0	0	0	\N	0	\N	\N
1491	114	0	0	0	\N	46	\N	\N
1544	380	0	0	0	\N	2	\N	\N
1547	138	0	0	0	\N	19	\N	\N
1494	226	0	0	0	\N	88	\N	\N
1549	0	0	0	0	\N	5073	\N	\N
1502	0	1	0	1	\N	174	\N	\N
1503	0	1	0	1	\N	176	\N	\N
1584	100	0	0	0	\N	0	\N	\N
1499	0	0	0	0	\N	110	\N	\N
1460	0	0	0	0	\N	2284	\N	\N
1507	120	0	0	0	\N	31	\N	\N
1509	0	0	0	0	\N	21	\N	\N
1550	256	0	0	0	\N	16	\N	\N
1510	114	0	0	0	\N	181	\N	\N
1553	112	0	0	0	\N	6	\N	\N
1514	326	0	0	0	\N	401	\N	\N
1517	100	0	0	0	\N	398	\N	\N
1518	100	0	0	0	\N	808	\N	\N
1519	100	0	0	0	\N	850	\N	\N
1520	0	0	0	0	\N	1329	\N	\N
1521	252	0	0	0	\N	2	\N	\N
1555	100	0	0	0	\N	0	\N	\N
1556	200	0	0	0	\N	0	\N	\N
1558	106	0	0	0	\N	9	\N	\N
1585	0	0	0	0	\N	0	\N	\N
1559	300	0	0	0	\N	0	\N	\N
1562	300	0	0	0	\N	0	\N	\N
1586	246	0	0	0	\N	5	\N	\N
1565	372	0	0	0	\N	6	\N	\N
1588	108	0	0	0	\N	10	\N	\N
1568	360	0	0	0	\N	6	\N	\N
1571	100	0	0	0	\N	0	\N	\N
1572	200	0	0	0	\N	0	\N	\N
1574	122	0	0	0	\N	3	\N	\N
1575	232	0	0	0	\N	4	\N	\N
1589	122	0	0	0	\N	3	\N	\N
1590	246	0	0	0	\N	3	\N	\N
1592	200	0	0	0	\N	0	\N	\N
1594	100	0	0	0	\N	0	\N	\N
1595	100	0	0	0	\N	0	\N	\N
1596	200	0	0	0	\N	5	\N	\N
1598	100	0	0	0	\N	2	\N	\N
1599	256	0	0	0	\N	0	\N	\N
1601	370	0	0	0	\N	7	\N	\N
1604	250	0	0	0	\N	3	\N	\N
1606	200	0	0	0	\N	0	\N	\N
1608	100	0	0	0	\N	5	\N	\N
1609	100	0	0	0	\N	0	\N	\N
1610	116	0	0	0	\N	6	\N	\N
1612	116	0	0	0	\N	6	\N	\N
1613	126	0	0	0	\N	5	\N	\N
1615	100	0	0	0	\N	1	\N	\N
1616	200	0	0	0	\N	2	\N	\N
1618	240	0	0	0	\N	8	\N	\N
1621	248	0	0	0	\N	4	\N	\N
1623	300	0	0	0	\N	3	\N	\N
1626	300	0	0	0	\N	30	\N	\N
1629	270	0	0	0	\N	5	\N	\N
1631	372	0	0	0	\N	172	\N	\N
1634	368	0	0	0	\N	8	\N	\N
1637	248	0	0	0	\N	4	\N	\N
1639	300	0	0	0	\N	9	\N	\N
1642	300	0	0	0	\N	6	\N	\N
1645	300	0	0	0	\N	22	\N	\N
1648	0	0	0	0	\N	1	\N	\N
1649	200	0	0	0	\N	45	\N	\N
1652	0	0	0	0	\N	0	\N	\N
1742	300	0	0	0	\N	11	\N	\N
1653	370	0	0	0	\N	7	\N	\N
1656	0	0	0	0	\N	0	\N	\N
1657	484	0	0	0	\N	31	\N	\N
1660	0	0	0	0	\N	1	\N	\N
1661	0	0	0	0	\N	0	\N	\N
1662	100	0	0	0	\N	28	\N	\N
1663	0	0	0	0	\N	0	\N	\N
1664	100	0	0	0	\N	13	\N	\N
1665	200	0	0	0	\N	627	\N	\N
1667	0	0	0	0	\N	33	\N	\N
1668	236	0	0	0	\N	8	\N	\N
1670	270	0	0	0	\N	5	\N	\N
3927	326	3	3	0	\N	2	1636	8281
1677	214	1	1	0	\N	3	\N	\N
1792	200	3	2	1	\N	27	\N	\N
1672	0	0	0	0	\N	0	\N	\N
1680	200	1	1	0	\N	10	\N	\N
1681	0	1	0	1	\N	16	\N	\N
1682	0	1	0	1	\N	22	\N	\N
1745	300	0	0	0	\N	8	\N	\N
1748	300	0	0	0	\N	5	\N	\N
1689	270	0	0	0	\N	5	\N	\N
1691	300	0	0	0	\N	27	\N	\N
1795	100	3	1	2	\N	44	\N	\N
1694	300	0	0	0	\N	16	\N	\N
1697	200	0	0	0	\N	7	\N	\N
1751	300	0	0	0	\N	0	\N	\N
1699	300	0	0	0	\N	3	\N	\N
1702	0	0	0	0	\N	1	\N	\N
1703	200	0	0	0	\N	1	\N	\N
1754	100	0	0	0	\N	3	\N	\N
1705	300	0	0	0	\N	9	\N	\N
1708	300	0	0	0	\N	19	\N	\N
1711	300	0	0	0	\N	15	\N	\N
1755	300	0	0	0	\N	3	\N	\N
1714	300	0	0	0	\N	16	\N	\N
1717	300	0	0	0	\N	9	\N	\N
1720	300	0	0	0	\N	13	\N	\N
1723	136	0	0	0	\N	22	\N	\N
1725	244	0	0	0	\N	6	\N	\N
1727	348	0	0	0	\N	6	\N	\N
1729	118	0	0	0	\N	1	\N	\N
1758	300	0	0	0	\N	54	\N	\N
1730	300	0	0	0	\N	7	\N	\N
1733	200	0	0	0	\N	8	\N	\N
1735	300	0	0	0	\N	14	\N	\N
1738	244	0	0	0	\N	6	\N	\N
1740	232	0	0	0	\N	4	\N	\N
1761	100	0	0	0	\N	54	\N	\N
1683	300	0	0	0	\N	1491	\N	\N
1799	108	0	0	0	\N	16	\N	\N
1765	100	0	0	0	\N	1771750612	\N	\N
1798	228	0	0	0	\N	16	\N	\N
1768	300	0	0	0	\N	5	\N	\N
1771	300	0	0	0	\N	10	\N	\N
1774	170	0	0	0	\N	6	\N	\N
1775	272	0	0	0	\N	4	\N	\N
1777	300	0	0	0	\N	7	\N	\N
1844	396	0	0	0	\N	12	\N	\N
1826	408	0	0	0	\N	6	\N	\N
1803	400	0	0	0	\N	10	\N	\N
1780	634	3	3	0	\N	13	\N	\N
1781	408	3	2	1	\N	24	\N	\N
1782	0	3	0	3	\N	35	\N	\N
1804	388	0	0	0	\N	16	\N	\N
1789	300	3	3	0	\N	10	\N	\N
1825	410	0	0	0	\N	5	\N	\N
1810	394	0	0	0	\N	4	\N	\N
1809	392	0	0	0	\N	5	\N	\N
1831	244	0	0	0	\N	18	\N	\N
1816	400	0	0	0	\N	4	\N	\N
1815	398	0	0	0	\N	5	\N	\N
1822	386	0	0	0	\N	3	\N	\N
1821	384	0	0	0	\N	4	\N	\N
1833	262	0	0	0	\N	9	\N	\N
1835	0	0	0	0	\N	5	\N	\N
1838	590	0	0	0	\N	5	\N	\N
1837	592	0	0	0	\N	4	\N	\N
1841	370	0	0	0	\N	7	\N	\N
1856	200	0	0	0	\N	7	\N	\N
1847	386	0	0	0	\N	17	\N	\N
1850	402	0	0	0	\N	9	\N	\N
1861	388	0	0	0	\N	16	\N	\N
1853	300	0	0	0	\N	5	\N	\N
1858	300	0	0	0	\N	8	\N	\N
1867	272	0	0	0	\N	4	\N	\N
1864	264	0	0	0	\N	28	\N	\N
1869	264	0	0	0	\N	6	\N	\N
1871	406	0	0	0	\N	7	\N	\N
1874	272	0	0	0	\N	4	\N	\N
1876	408	0	0	0	\N	6	\N	\N
1879	276	0	0	0	\N	2	\N	\N
1881	0	0	0	0	\N	17	\N	\N
1882	136	0	0	0	\N	2	\N	\N
1883	414	0	0	0	\N	3	\N	\N
1886	276	0	0	0	\N	2	\N	\N
1888	412	0	0	0	\N	4	\N	\N
1891	236	0	0	0	\N	12	\N	\N
1894	268	0	0	0	\N	6	\N	\N
1987	414	0	0	0	\N	3	\N	\N
1896	300	0	0	0	\N	3	\N	\N
1899	300	0	0	0	\N	2	\N	\N
1902	276	0	0	0	\N	2	\N	\N
2084	412	0	0	0	\N	4	\N	\N
1904	278	0	0	0	\N	21	\N	\N
1990	386	0	0	0	\N	2	\N	\N
1907	276	0	0	0	\N	22	\N	\N
1910	412	0	0	0	\N	4	\N	\N
1913	280	0	0	0	\N	0	\N	\N
2072	414	0	0	0	\N	3	\N	\N
1915	278	0	0	0	\N	21	\N	\N
1993	386	0	0	0	\N	2	\N	\N
1918	604	0	0	0	\N	4	\N	\N
1921	418	0	0	0	\N	1	\N	\N
2045	410	0	0	0	\N	5	\N	\N
1924	414	0	0	0	\N	3	\N	\N
1996	416	0	0	0	\N	2	\N	\N
1927	300	0	0	0	\N	0	\N	\N
1930	100	0	0	0	\N	0	\N	\N
1931	280	0	0	0	\N	0	\N	\N
1933	100	0	0	0	\N	0	\N	\N
1935	418	0	0	0	\N	1	\N	\N
2044	410	0	0	0	\N	5	\N	\N
1938	414	0	0	0	\N	3	\N	\N
1941	278	0	0	0	\N	1	\N	\N
1999	300	0	0	0	\N	5	\N	\N
1943	300	0	0	0	\N	0	\N	\N
1946	276	0	0	0	\N	2	\N	\N
1948	200	0	0	0	\N	0	\N	\N
1950	276	0	0	0	\N	2	\N	\N
1952	300	0	0	0	\N	3	\N	\N
1955	200	0	0	0	\N	4	\N	\N
2002	200	0	0	0	\N	5	\N	\N
1957	350	0	0	0	\N	5	\N	\N
2004	138	0	0	0	\N	1	\N	\N
1960	576	0	0	0	\N	6	\N	\N
2005	136	0	0	0	\N	2	\N	\N
1963	414	0	0	0	\N	3	\N	\N
1966	238	0	0	0	\N	1	\N	\N
1968	272	0	0	0	\N	2	\N	\N
1970	276	0	0	0	\N	2	\N	\N
2006	138	0	0	0	\N	1	\N	\N
1972	268	0	0	0	\N	23	\N	\N
2007	140	0	0	0	\N	0	\N	\N
1975	300	0	0	0	\N	3	\N	\N
2008	138	0	0	0	\N	1	\N	\N
1978	414	0	0	0	\N	3	\N	\N
1981	414	0	0	0	\N	3	\N	\N
2009	272	0	0	0	\N	2	\N	\N
1984	418	0	0	0	\N	1	\N	\N
2050	138	0	0	0	\N	1	\N	\N
2051	138	0	0	0	\N	1	\N	\N
2052	138	0	0	0	\N	1	\N	\N
2011	274	0	0	0	\N	23	\N	\N
2012	400	0	0	0	\N	10	\N	\N
2053	138	0	0	0	\N	1	\N	\N
2054	138	0	0	0	\N	1	\N	\N
2017	406	0	0	0	\N	7	\N	\N
2018	406	0	0	0	\N	7	\N	\N
2023	138	0	0	0	\N	1	\N	\N
2024	136	0	0	0	\N	2	\N	\N
2025	138	0	0	0	\N	21	\N	\N
2055	138	0	0	0	\N	1	\N	\N
2026	136	0	0	0	\N	44	\N	\N
2030	408	0	0	0	\N	6	\N	\N
2031	404	0	0	0	\N	8	\N	\N
2036	136	0	0	0	\N	2	\N	\N
2037	136	0	0	0	\N	2	\N	\N
2057	268	0	0	0	\N	4	\N	\N
2056	268	0	0	0	\N	4	\N	\N
2039	412	0	0	0	\N	4	\N	\N
2038	412	0	0	0	\N	4	\N	\N
2060	136	0	0	0	\N	1	\N	\N
2061	136	0	0	0	\N	1	\N	\N
2073	410	0	0	0	\N	5	\N	\N
2062	408	0	0	0	\N	6	\N	\N
2063	408	0	0	0	\N	6	\N	\N
2068	138	0	0	0	\N	1	\N	\N
2069	388	0	0	0	\N	16	\N	\N
2085	378	0	0	0	\N	21	\N	\N
2093	348	0	0	0	\N	3	\N	\N
2079	398	0	0	0	\N	11	\N	\N
2078	414	0	0	0	\N	3	\N	\N
2094	348	0	0	0	\N	3	\N	\N
2090	402	0	0	0	\N	3	\N	\N
2100	216	0	0	0	\N	6	\N	\N
2099	328	0	0	0	\N	4	\N	\N
2108	100	0	0	0	\N	1	\N	\N
2105	300	0	0	0	\N	1	\N	\N
2109	100	0	0	0	\N	0	\N	\N
2110	0	0	0	0	\N	10	\N	\N
2111	0	0	0	0	\N	20	\N	\N
2112	414	0	0	0	\N	3	\N	\N
2116	0	0	0	0	\N	6	\N	\N
2115	0	0	0	0	\N	4	\N	\N
2121	136	0	0	0	\N	2	\N	\N
2127	110	1	1	0	\N	75	\N	\N
2124	118	0	0	0	\N	2	\N	\N
2128	104	1	1	0	\N	78	\N	\N
2129	100	1	1	0	\N	82	\N	\N
2130	100	1	1	0	\N	85	\N	\N
2131	106	0	0	0	\N	7	\N	\N
2132	138	0	0	0	\N	1	\N	\N
2133	118	0	0	0	\N	1	\N	\N
3928	320	3	3	0	\N	5	1636	8282
2136	350	0	0	0	\N	5	\N	\N
2224	292	0	0	0	\N	8	\N	\N
2139	346	0	0	0	\N	7	\N	\N
2142	118	0	0	0	\N	2	\N	\N
2225	424	0	0	0	\N	13	\N	\N
2147	300	0	0	0	\N	3	\N	\N
2150	416	0	0	0	\N	2	\N	\N
2153	356	0	0	0	\N	2	\N	\N
2144	300	0	0	0	\N	6	\N	\N
2299	350	0	0	0	\N	5	\N	\N
2157	238	0	0	0	\N	2	\N	\N
2272	218	0	0	0	\N	20	\N	\N
2160	360	0	0	0	\N	0	\N	\N
2163	108	0	0	0	\N	6	\N	\N
2164	106	0	0	0	\N	7	\N	\N
2165	0	0	0	0	\N	10	\N	\N
2166	0	0	0	0	\N	10	\N	\N
2167	0	0	0	0	\N	21	\N	\N
2168	0	0	0	0	\N	20	\N	\N
2169	0	0	0	0	\N	5	\N	\N
2170	0	0	0	0	\N	8	\N	\N
2171	0	0	0	0	\N	8	\N	\N
2172	0	0	0	0	\N	10	\N	\N
2173	0	0	0	0	\N	10	\N	\N
2230	268	0	0	0	\N	14	\N	\N
2231	402	0	0	0	\N	9	\N	\N
2178	0	0	0	0	\N	10	\N	\N
2179	0	0	0	0	\N	10	\N	\N
2174	0	0	0	0	\N	12	\N	\N
2232	260	0	0	0	\N	19	\N	\N
2175	272	0	0	0	\N	14	\N	\N
2184	0	0	0	0	\N	10	\N	\N
2183	0	0	0	0	\N	10	\N	\N
2185	0	0	0	0	\N	10	\N	\N
2186	0	0	0	0	\N	10	\N	\N
2187	352	0	0	0	\N	4	\N	\N
2190	352	0	0	0	\N	4	\N	\N
2300	340	0	0	0	\N	10	\N	\N
2194	876	0	0	0	\N	12	\N	\N
2193	278	0	0	0	\N	21	\N	\N
2305	118	0	0	0	\N	1	\N	\N
2306	108	0	0	0	\N	6	\N	\N
2200	566	0	0	0	\N	17	\N	\N
2199	378	0	0	0	\N	16	\N	\N
2205	234	0	0	0	\N	3	\N	\N
2241	398	0	0	0	\N	11	\N	\N
2207	0	0	0	0	\N	4	\N	\N
2210	0	0	0	0	\N	3	\N	\N
2211	0	0	0	0	\N	3	\N	\N
2240	258	0	0	0	\N	14	\N	\N
2213	300	0	0	0	\N	15	\N	\N
2239	252	0	0	0	\N	17	\N	\N
2212	200	0	0	0	\N	26	\N	\N
2248	118	0	0	0	\N	1	\N	\N
2249	118	0	0	0	\N	1	\N	\N
2219	378	0	0	0	\N	16	\N	\N
2218	382	0	0	0	\N	15	\N	\N
2271	220	0	0	0	\N	18	\N	\N
2253	116	0	0	0	\N	2	\N	\N
2254	114	0	0	0	\N	3	\N	\N
2270	344	0	0	0	\N	11	\N	\N
2283	118	0	0	0	\N	1	\N	\N
2284	116	0	0	0	\N	2	\N	\N
2251	384	0	0	0	\N	18	\N	\N
2250	386	0	0	0	\N	17	\N	\N
2252	370	0	0	0	\N	25	\N	\N
2285	264	0	0	0	\N	4	\N	\N
2262	392	0	0	0	\N	14	\N	\N
2261	262	0	0	0	\N	12	\N	\N
2263	248	0	0	0	\N	18	\N	\N
2307	110	0	0	0	\N	5	\N	\N
2286	256	0	0	0	\N	8	\N	\N
2289	136	0	0	0	\N	1	\N	\N
2290	128	0	0	0	\N	5	\N	\N
2291	230	0	0	0	\N	5	\N	\N
2292	224	0	0	0	\N	8	\N	\N
2296	266	0	0	0	\N	7	\N	\N
2295	250	0	0	0	\N	15	\N	\N
2308	102	0	0	0	\N	9	\N	\N
2309	118	0	0	0	\N	1	\N	\N
2310	112	0	0	0	\N	4	\N	\N
2311	288	0	0	0	\N	6	\N	\N
2312	286	0	0	0	\N	7	\N	\N
2313	294	0	0	0	\N	3	\N	\N
2314	292	0	0	0	\N	4	\N	\N
2315	116	0	0	0	\N	2	\N	\N
2316	114	0	0	0	\N	3	\N	\N
2318	364	0	0	0	\N	28	\N	\N
2323	118	0	0	0	\N	1	\N	\N
2317	408	0	0	0	\N	6	\N	\N
2324	116	0	0	0	\N	2	\N	\N
2325	118	0	0	0	\N	1	\N	\N
2326	116	0	0	0	\N	2	\N	\N
2327	0	0	0	0	\N	49	\N	\N
2330	444	0	0	0	\N	48	\N	\N
2329	300	0	0	0	\N	36	\N	\N
2338	0	0	0	0	\N	10	\N	\N
2336	0	0	0	0	\N	91	\N	\N
2339	0	0	0	0	\N	10	\N	\N
2341	0	0	0	0	\N	20	\N	\N
2342	0	0	0	0	\N	20	\N	\N
2328	470	0	0	0	\N	40	\N	\N
2345	138	0	0	0	\N	1	\N	\N
2346	136	0	0	0	\N	2	\N	\N
2347	0	0	0	0	\N	40	\N	\N
2348	0	0	0	0	\N	52	\N	\N
2351	0	0	0	0	\N	20	\N	\N
2352	0	0	0	0	\N	20	\N	\N
2353	0	0	0	0	\N	20	\N	\N
2354	0	0	0	0	\N	20	\N	\N
2355	0	0	0	0	\N	20	\N	\N
2356	0	0	0	0	\N	20	\N	\N
2489	378	0	0	0	\N	21	\N	\N
2435	344	0	0	0	\N	2	\N	\N
2357	412	0	0	0	\N	4	\N	\N
2358	402	0	0	0	\N	9	\N	\N
2436	340	0	0	0	\N	4	\N	\N
2363	410	0	0	0	\N	5	\N	\N
2364	402	0	0	0	\N	9	\N	\N
2492	0	0	0	0	\N	20	\N	\N
2369	410	0	0	0	\N	5	\N	\N
2370	396	0	0	0	\N	12	\N	\N
2442	412	0	0	0	\N	4	\N	\N
2375	414	0	0	0	\N	3	\N	\N
2376	410	0	0	0	\N	5	\N	\N
2441	408	0	0	0	\N	6	\N	\N
2381	414	0	0	0	\N	3	\N	\N
2382	410	0	0	0	\N	5	\N	\N
2534	0	0	0	0	\N	6	\N	\N
2387	412	0	0	0	\N	4	\N	\N
2388	406	0	0	0	\N	7	\N	\N
2493	300	0	0	0	\N	1	\N	\N
2447	412	0	0	0	\N	4	\N	\N
2393	412	0	0	0	\N	4	\N	\N
2394	406	0	0	0	\N	7	\N	\N
2399	236	0	0	0	\N	2	\N	\N
2400	232	0	0	0	\N	4	\N	\N
2403	132	0	0	0	\N	1	\N	\N
2404	132	0	0	0	\N	1	\N	\N
2448	406	0	0	0	\N	7	\N	\N
2453	138	0	0	0	\N	1	\N	\N
2405	408	0	0	0	\N	6	\N	\N
2406	410	0	0	0	\N	5	\N	\N
2454	138	0	0	0	\N	1	\N	\N
2411	410	0	0	0	\N	2	\N	\N
2412	408	0	0	0	\N	3	\N	\N
2496	0	0	0	0	\N	0	\N	\N
2417	408	0	0	0	\N	3	\N	\N
2418	404	0	0	0	\N	5	\N	\N
2455	416	0	0	0	\N	2	\N	\N
2423	388	0	0	0	\N	4	\N	\N
2424	380	0	0	0	\N	8	\N	\N
2456	406	0	0	0	\N	7	\N	\N
2429	412	0	0	0	\N	4	\N	\N
2430	408	0	0	0	\N	6	\N	\N
2521	300	0	0	0	\N	0	\N	\N
2497	416	0	0	0	\N	2	\N	\N
2461	416	0	0	0	\N	2	\N	\N
2462	410	0	0	0	\N	5	\N	\N
2467	248	0	0	0	\N	16	\N	\N
2468	250	0	0	0	\N	15	\N	\N
2500	0	0	0	0	\N	6	\N	\N
2471	418	0	0	0	\N	1	\N	\N
2501	0	0	0	0	\N	0	\N	\N
2472	412	0	0	0	\N	4	\N	\N
2502	0	0	0	0	\N	0	\N	\N
2477	390	0	0	0	\N	15	\N	\N
2478	412	0	0	0	\N	4	\N	\N
2503	200	0	0	0	\N	0	\N	\N
2483	416	0	0	0	\N	2	\N	\N
2486	0	0	0	0	\N	8	\N	\N
2487	0	0	0	0	\N	1	\N	\N
2488	0	0	0	0	\N	1	\N	\N
2505	0	0	0	0	\N	0	\N	\N
2524	0	0	0	0	\N	0	\N	\N
2506	418	0	0	0	\N	1	\N	\N
2509	0	0	0	0	\N	6	\N	\N
2510	278	0	0	0	\N	1	\N	\N
2512	0	0	0	0	\N	4	\N	\N
2513	416	0	0	0	\N	2	\N	\N
2516	0	0	0	0	\N	6	\N	\N
2517	414	0	0	0	\N	3	\N	\N
2520	0	0	0	0	\N	8	\N	\N
2525	300	0	0	0	\N	0	\N	\N
2528	0	0	0	0	\N	0	\N	\N
2529	138	0	0	0	\N	1	\N	\N
2530	0	0	0	0	\N	2	\N	\N
2539	138	0	0	0	\N	1	\N	\N
2531	418	0	0	0	\N	1	\N	\N
2540	0	0	0	0	\N	4	\N	\N
2535	300	0	0	0	\N	1	\N	\N
2538	0	0	0	0	\N	0	\N	\N
2541	140	0	0	0	\N	0	\N	\N
2542	0	0	0	0	\N	2	\N	\N
2543	100	0	0	0	\N	0	\N	\N
2544	100	0	0	0	\N	0	\N	\N
2545	100	0	0	0	\N	0	\N	\N
2546	0	0	0	0	\N	0	\N	\N
2547	192	0	0	0	\N	12	\N	\N
2553	134	0	0	0	\N	3	\N	\N
2548	378	0	0	0	\N	14	\N	\N
2554	130	0	0	0	\N	5	\N	\N
3933	138	1	1	0	\N	1	1637	8288
2650	0	0	0	0	\N	1	\N	\N
2556	392	0	0	0	\N	14	\N	\N
2555	392	0	0	0	\N	14	\N	\N
2654	118	0	0	0	\N	1	\N	\N
2655	0	0	0	0	\N	3	\N	\N
2706	0	0	0	0	\N	5	\N	\N
2564	396	0	0	0	\N	12	\N	\N
2563	130	0	0	0	\N	17	\N	\N
2562	254	0	0	0	\N	19	\N	\N
2561	122	0	0	0	\N	25	\N	\N
2656	200	0	0	0	\N	3	\N	\N
2659	0	0	0	0	\N	0	\N	\N
2573	328	0	0	0	\N	4	\N	\N
2574	322	0	0	0	\N	7	\N	\N
2579	352	0	0	0	\N	4	\N	\N
2580	348	0	0	0	\N	6	\N	\N
2660	300	0	0	0	\N	2	\N	\N
2663	0	0	0	0	\N	0	\N	\N
2585	414	0	0	0	\N	3	\N	\N
2586	414	0	0	0	\N	3	\N	\N
2591	354	0	0	0	\N	3	\N	\N
2592	114	0	0	0	\N	6	\N	\N
2738	0	0	0	0	\N	6	\N	\N
2711	356	0	0	0	\N	2	\N	\N
2597	354	0	0	0	\N	3	\N	\N
2598	0	0	0	0	\N	7	\N	\N
2664	412	0	0	0	\N	4	\N	\N
2665	0	0	0	0	\N	8	\N	\N
2603	394	0	0	0	\N	4	\N	\N
2604	262	0	0	0	\N	5	\N	\N
2714	0	0	0	0	\N	7	\N	\N
2609	356	0	0	0	\N	2	\N	\N
2610	350	0	0	0	\N	5	\N	\N
2670	362	0	0	0	\N	2	\N	\N
2615	414	0	0	0	\N	3	\N	\N
2618	0	0	0	0	\N	10	\N	\N
2673	0	0	0	0	\N	9	\N	\N
2619	416	0	0	0	\N	2	\N	\N
2622	0	0	0	0	\N	7	\N	\N
2623	118	0	0	0	\N	1	\N	\N
2624	0	0	0	0	\N	3	\N	\N
2674	236	0	0	0	\N	2	\N	\N
2625	354	0	0	0	\N	3	\N	\N
2626	118	0	0	0	\N	7	\N	\N
2676	0	0	0	0	\N	5	\N	\N
2631	352	0	0	0	\N	4	\N	\N
2632	0	0	0	0	\N	5	\N	\N
2637	352	0	0	0	\N	4	\N	\N
2640	0	0	0	0	\N	10	\N	\N
2641	236	0	0	0	\N	2	\N	\N
2642	0	0	0	0	\N	4	\N	\N
2647	120	0	0	0	\N	0	\N	\N
2648	0	0	0	0	\N	2	\N	\N
2649	120	0	0	0	\N	0	\N	\N
2677	356	0	0	0	\N	2	\N	\N
2678	0	0	0	0	\N	6	\N	\N
2683	236	0	0	0	\N	2	\N	\N
2685	0	0	0	0	\N	5	\N	\N
2686	0	0	0	0	\N	1	\N	\N
2687	0	0	0	0	\N	2	\N	\N
2690	0	0	0	0	\N	2	\N	\N
2691	0	0	0	0	\N	2	\N	\N
2694	0	0	0	0	\N	1	\N	\N
2695	0	0	0	0	\N	1	\N	\N
2749	350	0	0	0	\N	5	\N	\N
2715	348	0	0	0	\N	6	\N	\N
2696	236	0	0	0	\N	7	\N	\N
2697	0	0	0	0	\N	10	\N	\N
2702	238	0	0	0	\N	1	\N	\N
2704	0	0	0	0	\N	6	\N	\N
2739	300	0	0	0	\N	1	\N	\N
2742	0	0	0	0	\N	0	\N	\N
2705	234	0	0	0	\N	4	\N	\N
2716	0	0	0	0	\N	8	\N	\N
2743	100	0	0	0	\N	0	\N	\N
2721	356	0	0	0	\N	2	\N	\N
2724	0	0	0	0	\N	9	\N	\N
2744	0	0	0	0	\N	0	\N	\N
2725	300	0	0	0	\N	2	\N	\N
2728	0	0	0	0	\N	0	\N	\N
2729	100	0	0	0	\N	0	\N	\N
2730	0	0	0	0	\N	0	\N	\N
2731	300	0	0	0	\N	2	\N	\N
2734	0	0	0	0	\N	0	\N	\N
2735	356	0	0	0	\N	2	\N	\N
2758	0	0	0	0	\N	10	\N	\N
2745	300	0	0	0	\N	2	\N	\N
2748	0	0	0	0	\N	0	\N	\N
2751	0	0	0	0	\N	10	\N	\N
2753	300	0	0	0	\N	3	\N	\N
2756	0	0	0	0	\N	0	\N	\N
2757	0	0	0	0	\N	10	\N	\N
2760	0	0	0	0	\N	13	\N	\N
2759	344	0	0	0	\N	8	\N	\N
2765	352	0	0	0	\N	4	\N	\N
2768	0	0	0	0	\N	10	\N	\N
2772	0	0	0	0	\N	0	\N	\N
2769	300	0	0	0	\N	4	\N	\N
2776	0	0	0	0	\N	0	\N	\N
2773	300	0	0	0	\N	1	\N	\N
2780	0	0	0	0	\N	0	\N	\N
2777	300	0	0	0	\N	5	\N	\N
3941	132	2	1	1	\N	6	1639	8311
3934	314	3	2	1	\N	7	1638	8301
2781	356	0	0	0	\N	2	\N	\N
2784	0	0	0	0	\N	6	\N	\N
2878	300	0	0	0	\N	2	\N	\N
2785	300	0	0	0	\N	1	\N	\N
2788	0	0	0	0	\N	0	\N	\N
2881	0	0	0	0	\N	0	\N	\N
2882	0	0	0	0	\N	0	\N	\N
2789	354	0	0	0	\N	3	\N	\N
2790	0	0	0	0	\N	5	\N	\N
2791	0	0	0	0	\N	6	\N	\N
2933	200	0	0	0	\N	0	\N	\N
2798	356	0	0	0	\N	2	\N	\N
2801	0	0	0	0	\N	10	\N	\N
2802	0	0	0	0	\N	10	\N	\N
2883	356	0	0	0	\N	2	\N	\N
2803	418	0	0	0	\N	1	\N	\N
2806	0	0	0	0	\N	7	\N	\N
2807	0	0	0	0	\N	7	\N	\N
2886	0	0	0	0	\N	6	\N	\N
2808	416	0	0	0	\N	2	\N	\N
2811	0	0	0	0	\N	10	\N	\N
2812	0	0	0	0	\N	10	\N	\N
2887	0	0	0	0	\N	6	\N	\N
2815	0	0	0	0	\N	10	\N	\N
2816	0	0	0	0	\N	10	\N	\N
2813	348	0	0	0	\N	6	\N	\N
2818	416	0	0	0	\N	2	\N	\N
2821	0	0	0	0	\N	6	\N	\N
2822	0	0	0	0	\N	7	\N	\N
2918	300	0	0	0	\N	0	\N	\N
2823	300	0	0	0	\N	1	\N	\N
2826	0	0	0	0	\N	0	\N	\N
2827	0	0	0	0	\N	0	\N	\N
2888	300	0	0	0	\N	1	\N	\N
2828	414	0	0	0	\N	3	\N	\N
2831	0	0	0	0	\N	8	\N	\N
2832	0	0	0	0	\N	8	\N	\N
2891	0	0	0	0	\N	0	\N	\N
2892	0	0	0	0	\N	0	\N	\N
2833	354	0	0	0	\N	3	\N	\N
2835	0	0	0	0	\N	5	\N	\N
2834	0	0	0	0	\N	4	\N	\N
2921	0	0	0	0	\N	0	\N	\N
2842	416	0	0	0	\N	2	\N	\N
2845	0	0	0	0	\N	10	\N	\N
2846	0	0	0	0	\N	11	\N	\N
2893	300	0	0	0	\N	2	\N	\N
2847	418	0	0	0	\N	1	\N	\N
2850	0	0	0	0	\N	5	\N	\N
2851	0	0	0	0	\N	5	\N	\N
2852	278	0	0	0	\N	1	\N	\N
2854	0	0	0	0	\N	4	\N	\N
2855	0	0	0	0	\N	4	\N	\N
2856	274	0	0	0	\N	1	\N	\N
2858	0	0	0	0	\N	3	\N	\N
2859	0	0	0	0	\N	3	\N	\N
2860	136	0	0	0	\N	2	\N	\N
2861	0	0	0	0	\N	4	\N	\N
2862	0	0	0	0	\N	4	\N	\N
2896	0	0	0	0	\N	0	\N	\N
2863	414	0	0	0	\N	3	\N	\N
2866	0	0	0	0	\N	9	\N	\N
2867	0	0	0	0	\N	9	\N	\N
2897	0	0	0	0	\N	0	\N	\N
2868	414	0	0	0	\N	3	\N	\N
2871	0	0	0	0	\N	10	\N	\N
2872	0	0	0	0	\N	10	\N	\N
2873	300	0	0	0	\N	1	\N	\N
2876	0	0	0	0	\N	0	\N	\N
2877	0	0	0	0	\N	0	\N	\N
2922	0	0	0	0	\N	0	\N	\N
2898	300	0	0	0	\N	1	\N	\N
2901	0	0	0	0	\N	0	\N	\N
2902	0	0	0	0	\N	0	\N	\N
2936	0	0	0	0	\N	0	\N	\N
2903	300	0	0	0	\N	2	\N	\N
2906	0	0	0	0	\N	0	\N	\N
2907	0	0	0	0	\N	0	\N	\N
2923	416	0	0	0	\N	2	\N	\N
2908	418	0	0	0	\N	1	\N	\N
2911	0	0	0	0	\N	8	\N	\N
2912	0	0	0	0	\N	8	\N	\N
2926	0	0	0	0	\N	7	\N	\N
2913	300	0	0	0	\N	1	\N	\N
2916	0	0	0	0	\N	0	\N	\N
2917	0	0	0	0	\N	0	\N	\N
2927	0	0	0	0	\N	7	\N	\N
2937	0	0	0	0	\N	0	\N	\N
2928	300	0	0	0	\N	3	\N	\N
2931	0	0	0	0	\N	0	\N	\N
2932	0	0	0	0	\N	0	\N	\N
2938	300	0	0	0	\N	1	\N	\N
2941	0	0	0	0	\N	0	\N	\N
2942	0	0	0	0	\N	0	\N	\N
2947	0	0	0	0	\N	7	\N	\N
2943	416	0	0	0	\N	2	\N	\N
2946	0	0	0	0	\N	7	\N	\N
2951	0	0	0	0	\N	0	\N	\N
2948	300	0	0	0	\N	0	\N	\N
2952	0	0	0	0	\N	0	\N	\N
2956	0	0	0	0	\N	0	\N	\N
2953	300	0	0	0	\N	1	\N	\N
2957	0	0	0	0	\N	0	\N	\N
2958	1602	0	0	0	\N	4	\N	\N
2960	778	0	0	0	\N	1	\N	\N
2963	0	0	0	0	\N	6	\N	\N
2964	0	0	0	0	\N	5	\N	\N
2965	300	0	0	0	\N	1	\N	\N
2968	0	0	0	0	\N	0	\N	\N
2969	0	0	0	0	\N	0	\N	\N
2970	200	0	0	0	\N	0	\N	\N
2972	0	0	0	0	\N	0	\N	\N
2973	0	0	0	0	\N	0	\N	\N
2974	138	0	0	0	\N	1	\N	\N
2975	0	0	0	0	\N	2	\N	\N
2976	0	0	0	0	\N	2	\N	\N
2977	100	0	0	0	\N	0	\N	\N
2978	0	0	0	0	\N	0	\N	\N
2979	0	0	0	0	\N	0	\N	\N
2980	100	0	0	0	\N	0	\N	\N
2981	0	0	0	0	\N	0	\N	\N
2982	0	0	0	0	\N	0	\N	\N
2983	774	0	0	0	\N	3	\N	\N
2986	0	0	0	0	\N	7	\N	\N
2987	0	0	0	0	\N	7	\N	\N
3058	600	0	0	0	\N	0	\N	\N
2988	300	0	0	0	\N	0	\N	\N
2991	0	0	0	0	\N	0	\N	\N
2992	0	0	0	0	\N	0	\N	\N
3061	0	0	0	0	\N	7	\N	\N
2993	300	0	0	0	\N	1	\N	\N
2996	0	0	0	0	\N	0	\N	\N
2997	0	0	0	0	\N	0	\N	\N
3062	0	0	0	0	\N	7	\N	\N
2998	300	0	0	0	\N	2	\N	\N
3001	0	0	0	0	\N	0	\N	\N
3002	0	0	0	0	\N	0	\N	\N
3003	300	0	0	0	\N	0	\N	\N
3006	0	0	0	0	\N	0	\N	\N
3007	0	0	0	0	\N	0	\N	\N
3008	300	0	0	0	\N	0	\N	\N
3011	0	0	0	0	\N	0	\N	\N
3012	0	0	0	0	\N	0	\N	\N
3013	600	0	0	0	\N	0	\N	\N
3016	0	0	0	0	\N	6	\N	\N
3017	0	0	0	0	\N	6	\N	\N
3109	0	0	0	0	\N	5	\N	\N
3018	300	0	0	0	\N	0	\N	\N
3021	0	0	0	0	\N	0	\N	\N
3022	0	0	0	0	\N	0	\N	\N
3091	300	0	0	0	\N	0	\N	\N
3023	300	0	0	0	\N	0	\N	\N
3026	0	0	0	0	\N	0	\N	\N
3027	0	0	0	0	\N	0	\N	\N
3095	0	0	0	0	\N	0	\N	\N
3028	300	0	0	0	\N	1	\N	\N
3031	0	0	0	0	\N	0	\N	\N
3032	0	0	0	0	\N	0	\N	\N
3063	356	0	0	0	\N	2	\N	\N
3033	300	0	0	0	\N	2	\N	\N
3036	0	0	0	0	\N	0	\N	\N
3037	0	0	0	0	\N	0	\N	\N
3065	0	0	0	0	\N	6	\N	\N
3038	300	0	0	0	\N	0	\N	\N
3041	0	0	0	0	\N	0	\N	\N
3042	0	0	0	0	\N	0	\N	\N
3064	0	0	0	0	\N	6	\N	\N
3043	300	0	0	0	\N	0	\N	\N
3046	0	0	0	0	\N	0	\N	\N
3047	0	0	0	0	\N	0	\N	\N
3048	300	0	0	0	\N	1	\N	\N
3051	0	0	0	0	\N	0	\N	\N
3052	0	0	0	0	\N	0	\N	\N
3053	300	0	0	0	\N	0	\N	\N
3056	0	0	0	0	\N	0	\N	\N
3057	0	0	0	0	\N	0	\N	\N
3094	0	0	0	0	\N	0	\N	\N
3072	238	0	0	0	\N	2	\N	\N
3074	0	0	0	0	\N	3	\N	\N
3073	0	0	0	0	\N	3	\N	\N
3081	598	0	0	0	\N	1	\N	\N
3084	0	0	0	0	\N	7	\N	\N
3085	0	0	0	0	\N	7	\N	\N
3086	300	0	0	0	\N	0	\N	\N
3089	0	0	0	0	\N	0	\N	\N
3090	0	0	0	0	\N	0	\N	\N
3110	300	0	0	0	\N	0	\N	\N
3096	416	0	0	0	\N	2	\N	\N
3098	0	0	0	0	\N	5	\N	\N
3097	0	0	0	0	\N	5	\N	\N
3113	0	0	0	0	\N	0	\N	\N
3105	598	0	0	0	\N	1	\N	\N
3108	0	0	0	0	\N	5	\N	\N
3114	0	0	0	0	\N	0	\N	\N
3115	0	0	0	0	\N	2	\N	\N
3116	0	0	0	0	\N	0	\N	\N
3117	0	0	0	0	\N	0	\N	\N
3121	0	0	0	0	\N	0	\N	\N
3118	300	0	0	0	\N	0	\N	\N
3122	0	0	0	0	\N	0	\N	\N
3126	0	0	0	0	\N	0	\N	\N
3123	300	0	0	0	\N	0	\N	\N
3127	0	0	0	0	\N	0	\N	\N
3131	0	0	0	0	\N	0	\N	\N
3128	300	0	0	0	\N	2	\N	\N
3132	0	0	0	0	\N	0	\N	\N
3136	0	0	0	0	\N	0	\N	\N
3133	300	0	0	0	\N	1	\N	\N
3137	0	0	0	0	\N	0	\N	\N
3138	0	0	0	0	\N	0	\N	\N
3139	0	0	0	0	\N	0	\N	\N
3140	0	0	0	0	\N	0	\N	\N
3235	0	0	0	0	\N	7	\N	\N
3141	300	0	0	0	\N	1	\N	\N
3144	0	0	0	0	\N	0	\N	\N
3145	0	0	0	0	\N	0	\N	\N
3146	100	0	0	0	\N	0	\N	\N
3147	0	0	0	0	\N	0	\N	\N
3148	0	0	0	0	\N	0	\N	\N
3149	300	0	0	0	\N	0	\N	\N
3153	0	0	0	0	\N	0	\N	\N
3236	278	0	0	0	\N	1	\N	\N
3154	300	0	0	0	\N	1	\N	\N
3157	0	0	0	0	\N	0	\N	\N
3158	0	0	0	0	\N	0	\N	\N
3159	398	0	0	0	\N	1	\N	\N
3161	0	0	0	0	\N	4	\N	\N
3162	0	0	0	0	\N	4	\N	\N
3238	0	0	0	0	\N	3	\N	\N
3163	300	0	0	0	\N	1	\N	\N
3166	0	0	0	0	\N	0	\N	\N
3167	0	0	0	0	\N	0	\N	\N
3168	600	0	0	0	\N	0	\N	\N
3171	0	0	0	0	\N	6	\N	\N
3172	0	0	0	0	\N	6	\N	\N
3275	592	0	0	0	\N	4	\N	\N
3173	400	0	0	0	\N	1	\N	\N
3176	0	0	0	0	\N	6	\N	\N
3177	0	0	0	0	\N	6	\N	\N
3239	478	0	0	0	\N	1	\N	\N
3178	300	0	0	0	\N	0	\N	\N
3181	0	0	0	0	\N	0	\N	\N
3182	0	0	0	0	\N	0	\N	\N
3242	0	0	0	0	\N	8	\N	\N
3183	300	0	0	0	\N	0	\N	\N
3186	0	0	0	0	\N	0	\N	\N
3187	0	0	0	0	\N	0	\N	\N
3188	418	0	0	0	\N	1	\N	\N
3191	214	0	0	0	\N	8	\N	\N
3276	0	0	0	0	\N	5	\N	\N
3194	300	0	0	0	\N	0	\N	\N
3197	0	0	0	0	\N	0	\N	\N
3243	480	0	0	0	\N	0	\N	\N
3198	356	0	0	0	\N	2	\N	\N
3199	0	0	0	0	\N	6	\N	\N
3244	0	0	0	0	\N	4	\N	\N
3204	536	0	0	0	\N	2	\N	\N
3207	0	0	0	0	\N	40	\N	\N
3301	160	0	0	0	\N	0	\N	\N
3208	416	0	0	0	\N	2	\N	\N
3209	0	0	0	0	\N	4	\N	\N
3249	480	0	0	0	\N	0	\N	\N
3214	416	0	0	0	\N	2	\N	\N
3217	0	0	0	0	\N	9	\N	\N
3252	0	0	0	0	\N	7	\N	\N
3218	300	0	0	0	\N	1	\N	\N
3221	0	0	0	0	\N	0	\N	\N
3222	300	0	0	0	\N	1	\N	\N
3225	0	0	0	0	\N	0	\N	\N
3281	478	0	0	0	\N	1	\N	\N
3253	300	0	0	0	\N	0	\N	\N
3226	478	0	0	0	\N	1	\N	\N
3227	0	0	0	0	\N	4	\N	\N
3284	0	0	0	0	\N	5	\N	\N
3232	660	0	0	0	\N	0	\N	\N
3256	0	0	0	0	\N	0	\N	\N
3257	300	0	0	0	\N	1	\N	\N
3260	0	0	0	0	\N	0	\N	\N
3302	0	0	0	0	\N	1	\N	\N
3285	300	0	0	0	\N	0	\N	\N
3261	158	0	0	0	\N	2	\N	\N
3262	0	0	0	0	\N	2	\N	\N
3288	0	0	0	0	\N	0	\N	\N
3267	418	0	0	0	\N	1	\N	\N
3270	0	0	0	0	\N	15	\N	\N
3271	540	0	0	0	\N	0	\N	\N
3274	0	0	0	0	\N	40	\N	\N
3303	158	0	0	0	\N	1	\N	\N
3305	0	0	0	0	\N	3	\N	\N
3289	300	0	0	0	\N	0	\N	\N
3292	0	0	0	0	\N	0	\N	\N
3306	0	0	0	0	\N	3	\N	\N
3293	480	0	0	0	\N	0	\N	\N
3296	0	0	0	0	\N	7	\N	\N
3307	160	0	0	0	\N	0	\N	\N
3297	478	0	0	0	\N	1	\N	\N
3300	0	0	0	0	\N	8	\N	\N
3308	0	0	0	0	\N	3	\N	\N
3310	0	0	0	0	\N	3	\N	\N
3312	0	0	0	0	\N	7	\N	\N
3321	212	0	0	0	\N	4	\N	\N
3311	314	0	0	0	\N	4	\N	\N
3313	0	0	0	0	\N	8	\N	\N
3324	0	0	0	0	\N	60	\N	\N
3320	654	0	0	0	\N	3	\N	\N
3328	0	0	0	0	\N	0	\N	\N
3325	300	0	0	0	\N	0	\N	\N
3329	0	0	0	0	\N	0	\N	\N
3331	0	0	0	0	\N	6	\N	\N
3342	0	0	0	0	\N	20	\N	\N
3330	316	0	0	0	\N	2	\N	\N
3332	0	0	0	0	\N	7	\N	\N
3339	658	0	0	0	\N	1	\N	\N
3343	0	0	0	0	\N	20	\N	\N
3552	100	0	0	0	\N	8	\N	\N
3344	200	0	0	0	\N	1	\N	\N
3347	0	0	0	0	\N	0	\N	\N
3348	0	0	0	0	\N	0	\N	\N
3439	420	0	0	0	\N	0	\N	\N
3349	200	0	0	0	\N	2	\N	\N
3352	0	0	0	0	\N	0	\N	\N
3353	0	0	0	0	\N	0	\N	\N
3354	470	0	0	0	\N	5	\N	\N
3357	0	0	0	0	\N	7	\N	\N
3494	106	0	0	0	\N	16	\N	\N
3358	598	0	0	0	\N	1	\N	\N
3361	0	0	0	0	\N	17	\N	\N
3442	318	0	0	0	\N	2	\N	\N
3362	300	0	0	0	\N	1	\N	\N
3365	0	0	0	0	\N	0	\N	\N
3366	300	0	0	0	\N	1	\N	\N
3369	0	0	0	0	\N	0	\N	\N
3370	314	0	0	0	\N	4	\N	\N
3445	278	0	0	0	\N	2	\N	\N
3373	410	0	0	0	\N	5	\N	\N
3376	384	0	0	0	\N	18	\N	\N
3529	0	0	0	0	\N	2	\N	\N
3379	318	0	0	0	\N	2	\N	\N
3448	278	0	0	0	\N	2	\N	\N
3382	312	0	0	0	\N	6	\N	\N
3385	158	0	0	0	\N	1	\N	\N
3387	388	0	0	0	\N	7	\N	\N
3497	402	0	0	0	\N	9	\N	\N
3390	0	0	0	0	\N	2	\N	\N
3451	278	0	0	0	\N	1	\N	\N
3393	316	0	0	0	\N	3	\N	\N
3396	318	0	0	0	\N	2	\N	\N
3399	318	0	0	0	\N	2	\N	\N
3454	278	0	0	0	\N	2	\N	\N
3402	200	0	0	0	\N	1	\N	\N
3405	278	0	0	0	\N	2	\N	\N
3408	414	0	0	0	\N	3	\N	\N
3457	200	0	0	0	\N	1	\N	\N
3411	312	0	0	0	\N	2	\N	\N
3412	0	0	0	0	\N	4	\N	\N
3500	332	0	0	0	\N	14	\N	\N
3417	312	0	0	0	\N	1	\N	\N
3420	0	0	0	0	\N	10	\N	\N
3460	276	0	0	0	\N	3	\N	\N
3421	200	0	0	0	\N	0	\N	\N
3424	0	0	0	0	\N	0	\N	\N
3425	276	0	0	0	\N	3	\N	\N
3426	0	0	0	0	\N	3	\N	\N
3430	278	0	0	0	\N	1	\N	\N
3463	218	0	0	0	\N	4	\N	\N
3433	316	0	0	0	\N	5	\N	\N
3466	0	0	0	0	\N	1	\N	\N
3436	278	0	0	0	\N	2	\N	\N
3467	270	0	0	0	\N	10	\N	\N
3503	136	0	0	0	\N	20	\N	\N
3470	200	0	0	0	\N	25	\N	\N
3473	200	0	0	0	\N	21	\N	\N
3476	300	0	0	0	\N	176	\N	\N
3506	114	0	0	0	\N	16	\N	\N
3479	200	0	0	0	\N	5	\N	\N
3482	0	0	0	0	\N	41	\N	\N
3485	130	0	0	0	\N	19	\N	\N
3509	116	0	0	0	\N	4	\N	\N
3488	0	0	0	0	\N	169	\N	\N
3491	272	0	0	0	\N	9	\N	\N
3553	0	0	0	0	\N	111	\N	\N
3512	232	0	0	0	\N	14	\N	\N
3534	0	0	0	0	\N	8	\N	\N
3515	350	0	0	0	\N	5	\N	\N
3532	110	0	0	0	\N	13	\N	\N
3518	350	0	0	0	\N	5	\N	\N
3521	238	0	0	0	\N	1	\N	\N
3533	0	0	0	0	\N	6	\N	\N
3523	236	0	0	0	\N	5	\N	\N
3526	238	0	0	0	\N	3	\N	\N
3555	0	0	0	0	\N	0	\N	\N
3540	226	0	0	0	\N	10	\N	\N
3543	0	0	0	0	\N	17	\N	\N
3544	0	0	0	0	\N	17	\N	\N
3545	100	0	0	0	\N	0	\N	\N
3546	100	0	0	0	\N	0	\N	\N
3547	0	0	0	0	\N	0	\N	\N
3548	0	0	0	0	\N	0	\N	\N
3549	0	0	0	0	\N	0	\N	\N
3550	0	0	0	0	\N	0	\N	\N
3551	0	0	0	0	\N	2	\N	\N
3556	0	0	0	0	\N	8	\N	\N
3557	0	0	0	0	\N	2	\N	\N
3558	0	0	0	0	\N	0	\N	\N
3559	0	0	0	0	\N	0	\N	\N
3560	0	0	0	0	\N	0	\N	\N
3561	200	0	0	0	\N	0	\N	\N
3562	100	0	0	0	\N	3	\N	\N
3565	100	0	0	0	\N	1	\N	\N
3566	0	0	0	0	\N	0	\N	\N
3567	0	0	0	0	\N	0	\N	\N
3568	0	0	0	0	\N	0	\N	\N
3569	0	0	0	0	\N	0	\N	\N
3570	100	0	0	0	\N	0	\N	\N
3935	468	3	3	0	\N	6	1638	8302
3945	314	3	2	1	\N	5	1640	8322
3571	116	0	0	0	\N	3	\N	\N
3572	0	0	0	0	\N	4	\N	\N
3577	240	0	0	0	\N	41	\N	\N
3764	236	3	2	1	\N	4	\N	\N
3580	0	0	0	0	\N	14	\N	\N
3670	200	0	0	0	\N	1	\N	\N
3583	118	0	0	0	\N	3	\N	\N
3586	238	0	0	0	\N	11	\N	\N
3720	354	3	2	1	\N	3	\N	\N
3589	234	0	0	0	\N	5	\N	\N
3673	200	0	0	0	\N	0	\N	\N
3592	276	0	0	0	\N	3	\N	\N
3595	234	0	0	0	\N	5	\N	\N
3598	350	0	0	0	\N	5	\N	\N
3676	200	0	0	0	\N	2	\N	\N
3601	236	0	0	0	\N	3	\N	\N
3604	0	0	0	0	\N	0	\N	\N
3605	0	0	0	0	\N	0	\N	\N
3606	0	0	0	0	\N	0	\N	\N
3607	0	0	0	0	\N	0	\N	\N
3608	0	0	0	0	\N	0	\N	\N
3609	0	0	0	0	\N	0	\N	\N
3750	236	3	2	1	\N	4	\N	\N
3679	236	0	0	0	\N	3	\N	\N
3610	312	0	0	0	\N	7	\N	\N
3612	452	0	0	0	\N	14	\N	\N
3611	298	0	0	0	\N	18	\N	\N
3619	196	0	0	0	\N	9	\N	\N
3620	180	0	0	0	\N	14	\N	\N
3621	362	0	0	0	\N	32	\N	\N
3626	156	0	0	0	\N	2	\N	\N
3627	154	0	0	0	\N	3	\N	\N
3628	148	0	0	0	\N	6	\N	\N
3629	0	0	0	0	\N	0	\N	\N
3723	116	3	1	2	\N	3	\N	\N
3682	234	0	0	0	\N	5	\N	\N
3632	408	3	3	0	\N	6	\N	\N
3631	270	3	2	1	\N	7	\N	\N
3630	136	3	1	2	\N	12	\N	\N
3639	0	0	0	0	\N	0	\N	\N
3640	232	0	0	0	\N	4	\N	\N
3685	200	0	0	0	\N	3	\N	\N
3643	200	0	0	0	\N	2	\N	\N
3688	0	0	0	0	\N	119	\N	\N
3646	200	0	0	0	\N	2	\N	\N
3689	100	0	0	0	\N	0	\N	\N
3649	236	0	0	0	\N	6	\N	\N
3690	0	0	0	0	\N	0	\N	\N
3726	136	2	1	1	\N	4	\N	\N
3653	404	3	3	0	\N	8	\N	\N
3652	272	3	2	1	\N	6	\N	\N
3654	128	3	1	2	\N	16	\N	\N
3661	194	1	1	0	\N	3	\N	\N
3662	192	1	1	0	\N	4	\N	\N
3663	190	1	1	0	\N	5	\N	\N
3665	114	2	1	1	\N	5	\N	\N
3666	226	2	2	0	\N	7	\N	\N
3664	226	2	2	0	\N	7	\N	\N
3691	240	3	2	1	\N	1	\N	\N
3694	238	3	2	1	\N	3	\N	\N
3697	236	3	2	1	\N	3	\N	\N
3700	0	1	0	1	\N	1	\N	\N
3701	0	1	0	1	\N	2	\N	\N
3728	266	3	2	1	\N	9	\N	\N
3702	238	3	2	1	\N	2	\N	\N
3703	0	3	0	3	\N	2	\N	\N
3708	200	3	2	1	\N	5	\N	\N
3731	276	3	2	1	\N	4	\N	\N
3710	300	3	2	1	\N	7	\N	\N
3714	200	3	2	1	\N	1	\N	\N
3753	236	3	2	1	\N	3	\N	\N
3717	238	3	2	1	\N	2	\N	\N
3734	100	3	1	2	\N	0	\N	\N
3737	200	3	2	1	\N	0	\N	\N
3756	0	2	0	2	\N	2	\N	\N
3740	100	3	1	2	\N	3	\N	\N
3743	0	3	0	3	\N	1	\N	\N
3746	116	3	1	2	\N	4	\N	\N
3749	0	1	0	1	\N	3	\N	\N
3758	120	3	1	2	\N	1	\N	\N
3761	200	3	2	1	\N	3	\N	\N
3765	118	3	1	2	\N	6	\N	\N
3770	0	3	0	3	\N	5	\N	\N
3771	0	3	0	3	\N	5	\N	\N
3776	0	1	0	1	\N	1	\N	\N
3777	0	1	0	1	\N	1	\N	\N
3778	0	1	0	1	\N	3	\N	\N
3779	232	3	2	1	\N	6	\N	\N
3780	338	3	3	0	\N	11	\N	\N
3785	0	1	0	1	\N	10	\N	\N
3786	278	3	2	1	\N	3	\N	\N
3789	0	1	0	1	\N	20	\N	\N
3791	0	3	0	3	\N	15	\N	\N
3790	240	3	2	1	\N	6	\N	\N
3797	0	3	0	3	\N	3	\N	\N
3796	0	3	0	3	\N	1	\N	\N
3803	0	3	0	3	\N	12	\N	\N
3802	236	3	2	1	\N	3	\N	\N
3811	0	1	0	1	\N	10	\N	\N
3808	238	3	2	1	\N	2	\N	\N
3813	0	3	0	3	\N	3	\N	\N
3818	100	1	1	0	\N	1	\N	\N
3812	240	3	2	1	\N	0	\N	\N
3819	0	1	0	1	\N	2	\N	\N
3820	0	1	0	1	\N	10	\N	\N
3821	0	3	0	3	\N	11	\N	\N
3824	0	1	0	1	\N	3	\N	\N
3825	0	1	0	1	\N	3	\N	\N
3826	236	3	2	1	\N	3	\N	\N
3940	274	2	2	0	\N	3	1639	8312
3829	236	3	2	1	\N	3	\N	\N
3921	592	3	3	0	\N	4	1635	8274
3832	200	3	2	1	\N	0	\N	\N
3922	194	3	1	2	\N	7	1635	8273
3835	200	3	2	1	\N	0	\N	\N
3838	238	3	2	1	\N	2	\N	\N
3944	314	3	2	1	\N	7	1640	8321
3841	238	3	2	1	\N	1	\N	\N
3844	238	3	2	1	\N	1	\N	\N
3847	0	1	0	1	\N	10	\N	\N
3848	0	3	0	3	\N	1	\N	\N
3849	0	3	0	3	\N	2	\N	\N
3854	240	3	2	1	\N	0	\N	\N
3857	0	1	0	1	\N	10	\N	\N
4040	820	7	6	1	\N	15	1656	8488
3858	240	3	2	1	\N	0	\N	\N
3861	0	1	0	1	\N	8	\N	\N
3862	196	1	1	0	\N	2	1614	8148
3863	3306	3	3	0	\N	3	1615	8150
4048	0	1	0	1	\N	10	1657	8492
3866	594	3	3	0	\N	3	1617	8157
4120	0	1	0	1	\N	8	1664	8535
3869	392	3	2	1	\N	10	1617	8159
4085	500	7	5	2	\N	7	1661	8514
3998	1770	7	6	1	\N	19	1647	8365
3872	300	3	3	0	\N	3	1618	8161
3873	200	3	2	1	\N	7	1618	8162
3878	100	1	1	0	\N	0	1619	8165
3879	0	1	0	1	\N	0	1619	8166
3880	116	1	1	0	\N	2	1620	8177
3881	118	1	1	0	\N	1	1621	8180
3882	100	1	1	0	\N	0	1622	8183
3883	100	1	1	0	\N	0	1623	8186
3884	0	1	0	1	\N	50	1625	8202
3885	0	1	0	1	\N	50	1625	8203
3886	0	1	0	1	\N	50	1626	8207
3887	0	1	0	1	\N	122	1626	8209
3888	0	1	0	1	\N	50	1627	8213
3889	0	1	0	1	\N	405	1627	8212
3890	190	1	1	0	\N	15	1629	8220
3999	1174	7	4	3	\N	30	1647	8366
4012	0	1	0	1	\N	7	1648	8371
3891	774	3	3	0	\N	3	1630	8230
3892	764	3	3	0	\N	8	1630	8229
3898	394	3	2	1	\N	5	1631	8239
3897	586	3	3	0	\N	7	1631	8237
3953	634	7	5	2	\N	35	1643	8345
3903	396	3	2	1	\N	3	1632	8245
3904	588	3	3	0	\N	6	1632	8246
3950	922	7	7	0	\N	29	1643	8341
3952	790	7	6	1	\N	25	1643	8342
3910	388	3	2	1	\N	9	1633	8256
3909	394	3	2	1	\N	7	1633	8255
3916	194	3	1	2	\N	5	1634	8265
3915	394	3	2	1	\N	3	1634	8264
4013	276	4	2	2	\N	5	1649	8375
3972	200	3	1	2	\N	3	1644	8352
3971	594	3	3	0	\N	3	1644	8353
4047	574	7	5	2	\N	23	1657	8491
4055	138	1	1	0	\N	1	1658	8496
4056	138	1	1	0	\N	1	1658	8497
4017	794	7	6	1	\N	23	1649	8374
4026	100	1	1	0	\N	0	1650	8380
4024	200	3	2	1	\N	9	1650	8381
4030	100	2	1	1	\N	1	1651	8386
3978	460	7	4	3	\N	23	1645	8357
3977	690	7	6	1	\N	22	1645	8358
3979	0	7	0	7	\N	41	1645	8356
4028	400	4	4	0	\N	2	1651	8388
4139	594	7	5	2	\N	6	1667	8558
4094	500	7	5	2	\N	5	1662	8520
4101	0	1	0	1	\N	0	1662	8522
4034	118	1	1	0	\N	1	1652	8409
4035	0	1	0	1	\N	3	1652	8410
4036	118	1	1	0	\N	1	1653	8417
4037	0	1	0	1	\N	0	1655	8465
4038	0	1	0	1	\N	0	1655	8464
4039	0	1	0	1	\N	0	1655	8466
4071	828	7	6	1	\N	8	1660	8508
4072	548	7	4	3	\N	10	1660	8510
4102	702	7	6	1	\N	10	1663	8526
4057	136	7	1	6	\N	3	1659	8502
4058	0	7	0	7	\N	4	1659	8503
4089	100	2	1	1	\N	1	1661	8516
4103	466	7	4	3	\N	15	1663	8527
4159	100	1	1	0	\N	2	1669	8579
4121	814	7	6	1	\N	14	1665	8542
4160	100	1	1	0	\N	3	1669	8580
4116	138	4	1	3	\N	3	1664	8534
4123	126	3	1	2	\N	20	1665	8544
4131	600	7	6	1	\N	6	1666	8548
4138	0	1	0	1	\N	0	1666	8549
4143	596	7	5	2	\N	12	1667	8559
4153	592	3	3	0	\N	4	1668	8568
4154	196	3	1	2	\N	3	1668	8567
4161	200	3	2	1	\N	2	1670	8590
4162	200	3	2	1	\N	2	1670	8591
4167	264	3	2	1	\N	31	1671	8598
4170	152	3	1	2	\N	12	1672	8601
4173	310	3	2	1	\N	35	1673	8604
4176	454	3	3	0	\N	13	1674	8607
4179	308	4	2	2	\N	19	1675	8610
4183	100	1	1	0	\N	0	1676	8613
4184	0	1	0	1	\N	0	1677	8616
4185	152	1	1	0	\N	4	1678	8619
4186	272	4	1	3	\N	6	1679	8622
4190	158	4	1	3	\N	2	1680	8625
4194	314	4	2	2	\N	34	1681	8629
4198	316	4	2	2	\N	5	1682	8632
4202	200	4	2	2	\N	5	1683	8636
4206	600	7	6	1	\N	5	1684	8639
4213	462	4	3	1	\N	10	1685	8643
4217	310	4	2	2	\N	7	1686	8647
4221	314	4	2	2	\N	5	1687	8650
4225	138	1	1	0	\N	1	1688	8654
4226	138	1	1	0	\N	1	1689	8657
4227	0	4	0	4	\N	1	1691	8669
4228	0	4	0	4	\N	2	1691	8670
4235	412	3	3	0	\N	4	1692	8688
4237	248	3	2	1	\N	19	1692	8691
4236	134	3	1	2	\N	16	1692	8687
4247	300	3	3	0	\N	2	1693	8696
4244	200	3	2	1	\N	2	1693	8698
4246	100	3	1	2	\N	3	1693	8697
4245	200	3	2	1	\N	11	1693	8699
4256	394	3	2	1	\N	11	1694	8712
4259	192	3	1	2	\N	14	1694	8714
4257	196	3	1	2	\N	8	1694	8715
4258	188	3	1	2	\N	12	1694	8713
\.


--
-- TOC entry 5269 (class 0 OID 16629)
-- Dependencies: 229
-- Data for Name: Students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Students" ("Student_ID", "Student_Name", "Student_Number", "Avatar_ID", "Class_ID") FROM stdin;
2	25255	25255	2	2
3	1234	1234	1	2
179	8655	8655	225	4
171	Margentar	456643677	204	4
180	6584515	6584515	233	4
4	123	123	7	2
1	123	123	8	6
5	1234	1234	9	6
176	85050608	85050608	219	4
168	ghgh	65050324	190	5
6	65050084	65050084	6	2
19	dd	23	19	4
21	67	67	20	4
23	14	14	21	4
24	67	67	22	4
27	3	3	24	4
28	3	3	25	4
30	25	25	26	4
31	25	25	27	4
32	25	25	28	4
34	256	256	29	4
35	23	23	30	4
39	236	236	32	4
40	11	11	33	4
44	89	89	35	4
46	14	14	36	2
47	14	14	37	4
49	45	45	38	4
51	78	78	39	4
59	141414	141414	40	4
61	5555	5555	41	4
63	123	123	42	4
101	Alice	1	1	1
102	Bob	2	2	1
103	Charlie	3	3	1
104	Dana	4	4	1
105	Eve	5	5	1
133	12	12	108	5
134	12	12	109	5
135	12	12	110	5
140	14	14	112	5
141	14	14	113	5
155	151515	151515	\N	5
156	5641	5641	\N	5
157	5459857	5459857	\N	5
158	05255	5255	\N	5
159	254	254	\N	5
160	1411	1411	\N	5
161	14444	14444	\N	5
162	141111	141111	\N	5
72	1	1	829	5
164	12	11111	143	5
170	65050327	65050327	672	4
37	11	11	639	4
166	11	11	147	5
7	ดด	65050084	673	4
130	3	3	719	5
167	65050084	65050084	174	5
165	123	123	151	5
128	2	2	828	5
127	2	2	696	5
76	1	1	191	5
169	65050327	65050327	192	5
73	1	1	180	5
163	1111	1111	158	5
74	1	1	181	5
75	minus	1	182	5
77	1	1	194	5
79	Many	2	195	5
82	Minis	1	196	5
83	minus	1	197	5
87	1	1	220	5
116	huuuuuuuuuuuuuu	1	311	5
88	1	1	221	5
86	1	1	211	5
71	1	1	674	5
173	546868	546868	212	4
174	456789123	456789123	213	1
175	4895216	4895216	214	4
80	Hhh	2	222	5
177	84354	84354	223	4
178	46465	46465	224	4
89	1	1	230	5
182	เอ้ะ	23466897	235	4
183	471901	471901	238	4
90	1	1	236	5
181	undefined	632790	237	4
184	48261910	48261910	239	4
185	356899	356899	240	4
186	7418526	7418526	241	4
188	14680	14680	247	4
187	345678	345678	248	4
91	1	1	249	5
92	u	1	250	5
126	2	2	582	5
189	36104827	36104827	260	4
8	65050084	65050084	253	4
94	po	1	254	5
95	oi	1	255	5
9	65050084	65050084	574	4
96	9u	1	267	5
191	1	1	266	4
26	3	3	263	4
192	4	4	264	4
42	2	2	265	4
97	=[-	1	268	5
98	1	1	269	5
99	yh	1	270	5
106	-0	1	271	5
109	1	1	272	5
112	tr	1	273	5
193	Ummmmm	754635413	277	4
194	Ark	765465456	276	4
113	1	1	279	5
121	หพกเะ้ั	1	340	5
197	741852960	741852960	326	4
195	741852962	741852962	341	4
93	2	2	343	5
81	2	2	314	5
119	0o	1	319	5
117	1	1	318	5
107	2	2	350	5
85	Sgsh	2	330	5
84	Sghs	2	323	5
100	Sbsj	2	344	5
196	741852961	741852961	349	4
108	2	2	351	5
111	2	2	356	5
110	Eg	2	353	5
114	Eg	2	357	5
122	1	1	358	5
123	1	1	359	5
124	1	1	360	5
131	1	1	364	5
115	2	2	362	5
66	1	1	371	5
118	Gy5	2	365	5
65	jokp	1	366	5
125	1	1	370	5
67	1	1	394	5
68	sef	1	410	5
69	1	1	522	5
190	65050066	65050066	572	4
70	1	1	640	5
120	2	2	367	5
198	1	1	388	12
199	2	2	389	12
200	3	3	390	12
201	7	7	391	12
203	555	555	\N	4
204	555	555	\N	4
205	555	555	\N	4
206	555	555	\N	4
207	555	555	\N	4
208	555	555	\N	4
209	555	555	\N	4
210	555	555	\N	4
211	555	555	\N	4
212	555	555	\N	4
213	555	555	\N	4
214	555	555	\N	4
215	555	555	\N	4
216	555	555	\N	4
217	555	555	\N	4
218	555	555	\N	4
219	555	555	\N	4
220	555	555	\N	4
221	555	555	\N	4
222	555	555	\N	4
223	555	555	\N	4
224	555	555	\N	4
225	555	555	\N	4
226	555	555	\N	4
227	555	555	\N	4
228	555	555	\N	4
229	555	555	\N	4
230	555	555	\N	4
202	555	555	422	4
232	789456	789456	\N	4
233	789456	789456	\N	4
234	789456	789456	\N	4
235	789456	789456	\N	4
236	789456	789456	\N	4
237	789456	789456	\N	4
238	789456	789456	\N	4
239	789456	789456	\N	4
240	789456	789456	\N	4
241	789456	789456	\N	4
242	789456	789456	\N	4
243	789456	789456	\N	4
288	1	1	903	60
244	บรู้ว	207691	434	4
245	843164	843164	444	4
295	57422	57422	\N	17
246	78623	78623	446	4
231	789456	789456	458	4
248	7542168	7542168	462	4
247	6281010	6281010	463	4
250	5476336	5476336	464	4
277	65050000	65050000	770	13
296	1	1	945	14
297	minnie	2	947	14
275	65050084	65050084	783	13
274	65050327	65050327	784	13
251	6437548	6437548	483	4
276	65050066	65050066	785	13
278	Bttttt	65050327	787	14
279	Ddear	65050084	788	14
249	undefined	52810138	514	4
280	ot	65050066	789	14
252	25346457	25346457	520	4
253	639191	639191	521	4
172	741852963	741852963	573	4
254	5	5	597	4
255	78965452	78965452	603	4
256	987654	987654	608	4
257	6505037	6505037	615	4
258	784512965	784512965	619	4
259	5643	5643	620	4
260	74185296	74185296	621	4
261	74455	74455	624	4
262	65205752	65205752	625	4
263	6841	6841	632	4
264	98	98	635	4
265	8	8	636	4
266	9	9	637	4
267	7	7	638	4
268	68654	68654	643	4
269	4664	4664	644	4
270	65464	65464	646	4
271	684354	684354	647	4
281	65656	65656	830	55
272	24799	24799	664	4
273	552	552	\N	5
289	357	357	870	55
299	650	650	949	14
298	4	4	950	14
282	45678	45678	836	55
283	546346	546346	837	55
284	3457	3457	840	55
285	281901	281901	843	55
294	3	3	929	17
287	2	2	934	55
286	1	1	935	55
291	2	2	900	60
290	3	3	901	60
293	2	2	943	17
292	1	1	944	17
\.


--
-- TOC entry 5259 (class 0 OID 16388)
-- Dependencies: 219
-- Data for Name: Teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Teachers" ("Teacher_ID", "Teacher_Name", "Teacher_Email", "Teacher_Password", "Reset_Token", "Reset_Token_Expire") FROM stdin;
2	nongdear	65050084@kmitl.ac.th	asdfghjk	\N	\N
3	Admin	admin@test.com	Admintest	\N	\N
4	dear	dreammy@dear.com	dear	\N	\N
5	Kullanit	dear	dear	\N	\N
6	baitongtongmai@	65050327@kmitl.ac.th	asdfghjk	\N	\N
7	baitongtongmai@gmail.com	admin2@test.com	asdfghjkl	\N	\N
1	dongji	baitongtongmai@gmail.com	asdfghjk	a4f5abcc4dcf349f9d0ebb3b2a8b57e0404fde78165136b43cdfdda201a2ab8b	1772710583483
8	dkjupiter	admin22@test.com	$2b$10$A8RdwSXe9SxX/MiUNk4KKeBx9V8rih9h3KNt//JA.XoIYItFoQ.3q	\N	\N
9	dkjupiter	baitongtongmai22@gmail.com	$2b$10$XUpvqbzhz6ofmztU921azOaiadibyYZxkd//qcupYO5lQZoBsbC5y	\N	\N
10	dkjupiter	6505032@kmitl.ac.th	$2b$10$2uV/5r0pKb5Y5F/k/hBlq.SHaR2skyUSvYijgKyWBdYNMJz3P5OIK	\N	\N
11	dkjupiter	650@kmitl.ac.th	$2b$10$rd1NcKQzAyNYNy9t8v1RIOOLwxm/m29JCxhi7HsllfSX7RXB9TdKa	\N	\N
12	wertyu	baitongtongmai666@gmail.com	$2b$10$3ApA75W9DUYaUsHSUgCseeqeBff0Lg8yU.eSMQP.D3s9LD8M60FiK	\N	\N
13	dkjupiter	650527@kmitl.ac.th	$2b$10$ikwjKuFcKPAS9r2GXQlT2uWcj3QjV5NPIIjyAbS30E1d1pQwrEJ8G	\N	\N
14	dkjupiter	baitongtongmai66@gmail.com	$2b$10$/OpYlhu02osWVoFg0kwdDOXrEkAyP.K9rzffLPuGkJjab6v9vul9y	\N	\N
15	dkjupiter	5464546874@kmitl.ac.th	$2b$10$EMOClj1SG9XRdDG.Ji8l.OHwkv2TR.1oVIqT.QKjNmq5BcEAnY29q	\N	\N
16	dkjupiter	846518@test.com	$2b$10$0.r0pq2/Sb272RExI5bIQ.513orl3VlrdlG8jP48Exbl.UZoHPz7K	\N	\N
17	baitongtongmai@gmail.com	baitongtongmai55555@gmail.com	$2b$10$fCu5.thzFRRBTQEGOBAdpuFR2WqlEWuiq14K2n6dUcjb8IvABuwcO	\N	\N
18	Dk	Testmail@gmail.com	$2b$10$jQ9vnGILjZPZs.DObsoFJuy5FgiQcLKTcLqBx06ouUKwEAjzhxfwG	\N	\N
19	test_account	test@test.com	$2b$10$ka/cuPyA3.zn5ylVFBaegO4.FzQXMRxQDPtxJoCW7Dy0jsb1iU4R.	\N	\N
20	baitongtongmai@gmail.com	89465321@kmitl.ac.th	$2b$10$02by3Gb2Knq0GW00MT98NOCJv6tsx.KmPbSThAV8aIhP6TSnviAlK	\N	\N
21	Dear	dear@kullanit.com	$2b$10$l4yNzwCH1PO1ufZfp/NrueL4JVoVVbi72pJDkDa/4NvmBn5QziDiy	\N	\N
22	dear	kullanit@gmail.com	$2b$10$rFPCLwlCgTvh2SaK6Fgio./aOjbelZ.d1LtvySJqqtIB78ohuVM6G	\N	\N
23	k1	k1@gmail.com	$2b$10$nwXtkoVDrDzx1jJv0iRktueXZwCpBzP8x9Bi7Dj5qQnWFZEiEkO6i	\N	\N
24	k2	k2@gmail.com	$2b$10$ddvCHp2GMj/yaaktBukapeTxq4XoCHSbPs8Bp80SYahXGjmk9n0EG	\N	\N
25	ForTest	admintest@test.com	$2b$10$VH6SXyPFw8ymgPcf4TiTCe5PPWkjv6lYPVF/N3TCVg8BdrZwxqtmy	\N	\N
\.


--
-- TOC entry 5303 (class 0 OID 25563)
-- Dependencies: 263
-- Data for Name: TeamAssignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TeamAssignments" ("Team_ID", "Team_Name", "Created_At", "AssignedQuiz_ID") FROM stdin;
1	Team 1	2026-03-05 14:00:45.488598	\N
2	Team 2	2026-03-05 14:00:45.521223	\N
3	Team 1	2026-03-05 14:01:54.783243	\N
4	Team 1	2026-03-05 14:06:19.23187	\N
5	Team 2	2026-03-05 14:06:19.266558	\N
6	Team 1	2026-03-05 14:07:01.506356	\N
7	Team 1	2026-03-05 14:09:31.586619	\N
8	Team 1	2026-03-05 14:11:32.969988	\N
9	Team 1	2026-03-05 14:22:17.579016	\N
10	Team 1	2026-03-05 14:32:20.460002	\N
11	Team 1	2026-03-05 15:02:14.726336	\N
12	Team 1	2026-03-05 15:02:58.8315	\N
13	Team 2	2026-03-05 15:02:58.862338	\N
14	Team 1	2026-03-05 15:03:53.322421	\N
15	Team 1	2026-03-05 15:21:47.526431	\N
16	Team 2	2026-03-05 15:21:47.5635	\N
17	Team 1	2026-03-05 15:25:16.029824	\N
18	Team 2	2026-03-05 15:25:16.072794	\N
19	Team 1	2026-03-05 15:25:52.254926	\N
20	Team 2	2026-03-05 15:25:52.287922	\N
21	Team 1	2026-03-05 15:26:13.650993	\N
22	Team 2	2026-03-05 15:26:13.674783	\N
23	Team 1	2026-03-05 15:27:07.077574	\N
24	Team 1	2026-03-05 15:42:23.550303	\N
25	Team 2	2026-03-05 15:42:23.584716	\N
26	Team 1	2026-03-05 15:46:35.760432	\N
27	Team 2	2026-03-05 15:46:35.789007	\N
28	Team 1	2026-03-05 15:47:15.347339	\N
29	Team 1	2026-03-05 15:47:56.136146	\N
30	Team 1	2026-03-05 15:55:02.865657	\N
31	Team 1	2026-03-05 15:56:57.537871	\N
32	Team 1	2026-03-05 16:01:43.75505	\N
33	Team 1	2026-03-05 16:02:41.135142	\N
34	Team 1	2026-03-05 16:03:27.951651	\N
35	Team 1	2026-03-05 16:10:57.811004	\N
36	Team 1	2026-03-05 16:11:51.475805	\N
37	Team 1	2026-03-05 16:12:55.342599	\N
38	Team 1	2026-03-05 16:13:19.406747	\N
39	Team 1	2026-03-05 16:13:47.062605	\N
40	Team 1	2026-03-05 16:14:08.995468	\N
41	Team 1	2026-03-05 16:14:39.160435	\N
42	Team 1	2026-03-08 13:15:52.357496	\N
43	Team 2	2026-03-08 13:15:52.396122	\N
44	Team 1	2026-03-08 13:18:31.525362	\N
45	Team 2	2026-03-08 13:18:31.556769	\N
46	Team 1	2026-03-08 13:19:26.163917	\N
47	Team 2	2026-03-08 13:19:26.206761	\N
48	Team 1	2026-03-08 13:21:24.034958	\N
49	Team 1	2026-03-08 13:24:07.837288	\N
50	Team 2	2026-03-08 13:24:07.866325	\N
51	Team 1	2026-03-08 13:42:13.010499	\N
52	Team 2	2026-03-08 13:42:13.045353	\N
53	Team 1	2026-03-08 13:45:03.433823	\N
54	Team 1	2026-03-08 14:05:14.086686	\N
55	Team 1	2026-03-08 14:05:54.916253	\N
56	Team 1	2026-03-08 14:06:47.98501	\N
57	Team 1	2026-03-08 14:07:14.493799	\N
58	Team 2	2026-03-08 14:07:14.538333	\N
59	Team 1	2026-03-08 14:07:48.885067	\N
60	Team 2	2026-03-08 14:07:48.924676	\N
61	Team 1	2026-03-08 14:53:54.138212	\N
62	Team 2	2026-03-08 14:53:54.164913	\N
63	Team 1	2026-03-08 14:55:05.782241	\N
64	Team 2	2026-03-08 14:55:05.811157	\N
65	Team 1	2026-03-08 14:55:45.86133	\N
66	Team 2	2026-03-08 14:55:45.892467	\N
67	Team 1	2026-03-08 14:57:09.564362	\N
68	Team 2	2026-03-08 14:57:09.600806	\N
69	Team 1	2026-03-08 14:57:35.296214	\N
70	Team 2	2026-03-08 14:57:35.331649	\N
71	Team 1	2026-03-08 14:58:17.135107	\N
72	Team 2	2026-03-08 14:58:17.172645	\N
73	Team 1	2026-03-08 14:58:48.101591	\N
74	Team 2	2026-03-08 14:58:48.144752	\N
75	Team 1	2026-03-08 15:00:12.860868	\N
76	Team 2	2026-03-08 15:00:12.926937	\N
77	Team 1	2026-03-08 15:00:56.947741	\N
78	Team 2	2026-03-08 15:00:56.986664	\N
79	Team 1	2026-03-08 15:02:05.712194	\N
80	Team 2	2026-03-08 15:02:05.752421	\N
81	Team 1	2026-03-08 15:03:23.874776	\N
82	Team 2	2026-03-08 15:03:23.920214	\N
83	Team 1	2026-03-08 15:04:53.335322	\N
84	Team 2	2026-03-08 15:04:53.374444	\N
85	Team 1	2026-03-08 15:06:25.646082	\N
86	Team 2	2026-03-08 15:06:25.689957	\N
87	Team 1	2026-03-08 15:07:20.38894	\N
88	Team 2	2026-03-08 15:07:20.445365	\N
89	Team 1	2026-03-08 15:24:19.400286	\N
90	Team 2	2026-03-08 15:24:19.454245	\N
91	Team 1	2026-03-08 15:24:56.782959	\N
92	Team 2	2026-03-08 15:24:56.823914	\N
93	Team 1	2026-03-08 15:25:32.65713	\N
94	Team 2	2026-03-08 15:25:32.697921	\N
95	Team 1	2026-03-08 15:26:21.745892	\N
96	Team 2	2026-03-08 15:26:21.789789	\N
97	Team 1	2026-03-08 15:27:08.138322	\N
98	Team 2	2026-03-08 15:27:08.194109	\N
99	Team 1	2026-03-08 15:28:56.882549	\N
100	Team 2	2026-03-08 15:28:56.91998	\N
101	Team 1	2026-03-08 15:29:36.333171	\N
102	Team 2	2026-03-08 15:29:36.375373	\N
103	Team 1	2026-03-08 15:30:07.877875	\N
104	Team 2	2026-03-08 15:30:07.924609	\N
105	Team 1	2026-03-08 15:31:06.74875	\N
106	Team 2	2026-03-08 15:31:06.795601	\N
107	Team 1	2026-03-08 15:31:35.121198	\N
108	Team 2	2026-03-08 15:31:35.155303	\N
109	Team 1	2026-03-08 15:48:14.048539	\N
110	Team 2	2026-03-08 15:48:14.094752	\N
111	Team 1	2026-03-08 15:48:18.597307	\N
112	Team 2	2026-03-08 15:48:18.638386	\N
113	Team 1	2026-03-08 15:51:55.4591	\N
114	Team 2	2026-03-08 15:51:55.500861	\N
115	Team 1	2026-03-08 16:05:12.926865	\N
116	Team 2	2026-03-08 16:05:12.985599	\N
117	Team 1	2026-03-08 16:08:51.469992	\N
118	Team 2	2026-03-08 16:08:51.520479	\N
119	Team 1	2026-03-08 16:18:21.68944	\N
120	Team 2	2026-03-08 16:18:21.743896	\N
121	Team 1	2026-03-08 16:26:10.714807	\N
122	Team 2	2026-03-08 16:26:10.758254	\N
123	Team 1	2026-03-08 16:27:13.062059	\N
124	Team 2	2026-03-08 16:27:13.10482	\N
125	Team 1	2026-03-08 16:28:42.002268	\N
126	Team 1	2026-03-08 16:29:28.663386	\N
127	Team 2	2026-03-08 16:29:28.704817	\N
128	Team 1	2026-03-08 16:33:07.419056	\N
129	Team 2	2026-03-08 16:33:07.461266	\N
130	Team 1	2026-03-08 16:37:58.089359	\N
131	Team 2	2026-03-08 16:37:58.138623	\N
132	Team 1	2026-03-08 16:39:39.703245	\N
133	Team 1	2026-03-08 16:56:32.779248	\N
134	Team 2	2026-03-08 16:56:32.825971	\N
135	Team 1	2026-03-08 16:58:06.707528	\N
136	Team 2	2026-03-08 16:58:06.751721	\N
137	Team 1	2026-03-08 17:09:01.282992	\N
138	Team 2	2026-03-08 17:09:01.330902	\N
139	Team 1	2026-03-08 17:09:48.940849	\N
140	Team 2	2026-03-08 17:09:48.983692	\N
141	Team 1	2026-03-08 17:10:33.924088	\N
142	Team 2	2026-03-08 17:10:33.961517	\N
143	Team 1	2026-03-08 17:10:58.538477	\N
144	Team 2	2026-03-08 17:10:58.591291	\N
145	Team 1	2026-03-08 17:28:12.842561	\N
146	Team 2	2026-03-08 17:28:12.881648	\N
147	Team 1	2026-03-08 17:28:58.257385	\N
148	Team 2	2026-03-08 17:28:58.30156	\N
149	Team 1	2026-03-08 17:29:20.973863	\N
150	Team 2	2026-03-08 17:29:21.008891	\N
151	Team 1	2026-03-08 17:30:05.044532	\N
152	Team 2	2026-03-08 17:30:05.089798	\N
153	Team 1	2026-03-08 17:30:30.609443	\N
154	Team 2	2026-03-08 17:30:30.644326	\N
155	Team 1	2026-03-08 17:31:19.725748	\N
156	Team 2	2026-03-08 17:31:19.76761	\N
157	Team 1	2026-03-08 17:37:11.156118	\N
158	Team 2	2026-03-08 17:37:11.204694	\N
159	Team 1	2026-03-08 17:37:46.931263	\N
160	Team 2	2026-03-08 17:37:47.011723	\N
161	Team 1	2026-03-08 17:38:19.480849	\N
162	Team 2	2026-03-08 17:38:19.544425	\N
163	Team 1	2026-03-08 17:38:49.378861	\N
164	Team 2	2026-03-08 17:38:49.422186	\N
165	Team 1	2026-03-08 17:39:33.215493	\N
166	Team 2	2026-03-08 17:39:33.269551	\N
167	Team 1	2026-03-08 17:41:23.169569	\N
168	Team 2	2026-03-08 17:41:23.22098	\N
169	Team 1	2026-03-08 18:00:02.607831	\N
170	Team 2	2026-03-08 18:00:02.70556	\N
171	Team 1	2026-03-08 18:03:07.265229	\N
172	Team 2	2026-03-08 18:03:07.307279	\N
173	Team 1	2026-03-08 18:03:37.796044	\N
174	Team 2	2026-03-08 18:03:37.831895	\N
175	Team 1	2026-03-08 18:04:37.839168	\N
176	Team 2	2026-03-08 18:04:37.878831	\N
177	Team 1	2026-03-08 18:08:35.536944	\N
178	Team 2	2026-03-08 18:08:35.586336	\N
179	Team 1	2026-03-08 18:09:23.899861	\N
180	Team 2	2026-03-08 18:09:23.941699	\N
181	Team 1	2026-03-08 18:19:30.195465	\N
182	Team 2	2026-03-08 18:19:30.24117	\N
183	Team 1	2026-03-08 18:31:08.526408	\N
184	Team 2	2026-03-08 18:31:08.568552	\N
185	Team 1	2026-03-08 18:39:48.382055	\N
186	Team 2	2026-03-08 18:39:48.428448	\N
187	Team 1	2026-03-08 18:43:29.600486	\N
188	Team 2	2026-03-08 18:43:29.638616	\N
189	Team 1	2026-03-08 18:49:25.061852	\N
190	Team 1	2026-03-08 19:00:23.780771	\N
191	Team 1	2026-03-08 19:01:07.048204	\N
192	Team 1	2026-03-08 19:01:39.686371	\N
193	Team 1	2026-03-08 19:01:59.60336	\N
194	Team 1	2026-03-08 19:02:51.69349	\N
195	Team 1	2026-03-08 19:03:18.306268	\N
196	Team 1	2026-03-08 19:03:42.1204	\N
197	Team 1	2026-03-08 19:04:14.658456	\N
198	Team 1	2026-03-08 19:04:42.91072	\N
199	Team 1	2026-03-08 19:23:45.042964	\N
200	Team 1	2026-03-08 19:28:31.890022	\N
201	Team 1	2026-03-08 19:31:01.021271	\N
202	Team 1	2026-03-08 19:31:34.729498	\N
203	Team 2	2026-03-08 19:31:34.796699	\N
204	Team 1	2026-03-08 19:32:18.61254	\N
205	Team 2	2026-03-08 19:32:18.650939	\N
206	Team 1	2026-03-08 19:37:42.977548	\N
207	Team 2	2026-03-08 19:37:43.016404	\N
208	Team 1	2026-03-08 19:38:56.669841	\N
209	Team 2	2026-03-08 19:38:56.718684	\N
210	Team 1	2026-03-08 19:40:10.15328	\N
211	Team 2	2026-03-08 19:40:10.201463	\N
212	Team 1	2026-03-08 19:40:39.826099	\N
213	Team 2	2026-03-08 19:40:39.866631	\N
214	Team 1	2026-03-09 15:58:44.101483	\N
215	Team 1	2026-03-09 15:59:26.710862	\N
216	Team 1	2026-03-09 16:23:40.10212	\N
217	Team 1	2026-03-09 16:25:07.281284	\N
218	Team 1	2026-03-09 17:40:39.029854	\N
219	Team 1	2026-03-09 17:41:04.31322	\N
220	Team 1	2026-03-09 17:41:29.623352	\N
221	Team 1	2026-03-09 19:32:26.299282	\N
222	Team 1	2026-03-09 19:38:59.712735	\N
223	Team 1	2026-03-09 19:41:06.980676	\N
224	Team 1	2026-03-09 19:58:55.031315	\N
225	Team 1	2026-03-09 20:00:41.364156	\N
226	Team 2	2026-03-09 20:00:41.577614	\N
227	Team 1	2026-03-11 16:47:20.029456	\N
228	Team 1	2026-03-11 16:54:51.59901	\N
229	Team 1	2026-03-11 16:55:31.308499	\N
230	Team 1	2026-03-11 17:03:20.082364	\N
231	Team 1	2026-03-11 17:09:04.201796	\N
232	Team 1	2026-03-12 12:55:24.701331	\N
233	Team 1	2026-03-12 13:08:59.216335	\N
234	Team 1	2026-03-12 14:49:16.959433	\N
235	Team 1	2026-03-12 15:13:00.177054	\N
236	Team 1	2026-03-12 15:14:19.862364	\N
237	Team 1	2026-03-12 15:15:26.163418	\N
238	Team 1	2026-03-12 15:15:56.623646	\N
239	Team 1	2026-03-12 15:16:32.750372	\N
240	Team 1	2026-03-15 13:21:46.575174	\N
241	Team 1	2026-03-15 13:23:34.221625	\N
242	Team 1	2026-03-15 13:24:24.650268	\N
243	Team 1	2026-03-15 15:37:58.761132	\N
244	Team 1	2026-03-15 15:38:23.701213	\N
245	Team 1	2026-03-15 16:47:16.118803	\N
246	Team 1	2026-03-15 16:47:39.942725	\N
247	Team 1	2026-03-15 16:49:16.090196	\N
248	Team 1	2026-03-15 16:53:58.010407	\N
249	Team 1	2026-03-18 13:00:09.280371	\N
250	Team 1	2026-03-18 13:07:47.368223	\N
251	Team 1	2026-03-18 13:18:03.458334	\N
252	Team 1	2026-03-18 13:30:03.957747	\N
253	Team 1	2026-03-18 13:37:08.699832	\N
254	Team 1	2026-03-18 13:44:57.186313	1635
255	Team 1	2026-03-18 14:10:37.710149	1638
256	Team 1	2026-03-18 14:16:00.543065	1639
257	Team 1	2026-03-18 14:23:57.265105	1640
258	Team 1	2026-03-18 14:32:13.667661	1641
259	Team 1	2026-03-18 14:36:22.912285	1642
260	Team 1	2026-03-18 19:01:47.920155	\N
261	Team 2	2026-03-18 19:01:47.972908	\N
262	Team 1	2026-03-18 19:06:01.186671	1654
263	Team 2	2026-03-18 19:06:01.247236	1654
264	Team 1	2026-03-18 19:09:39.396855	1655
265	Team 2	2026-03-18 19:09:39.451698	1655
266	Team 1	2026-03-18 19:47:13.724905	1663
267	Team 1	2026-03-18 19:48:44.027253	1664
268	Team 1	2026-03-18 19:50:28.987251	1666
269	Team 1	2026-03-18 19:52:29.196204	1667
270	Team 1	2026-03-18 19:53:27.924529	1668
271	Team 1	2026-03-18 19:58:48.107002	1669
272	Team 1	2026-03-18 20:02:45.369937	1670
273	Team 1	2026-03-19 13:17:48.719233	1680
274	Team 1	2026-03-19 13:24:01.191519	1682
275	Team 1	2026-03-19 13:25:00.659521	1684
276	Team 1	2026-03-19 13:27:18.443495	1685
277	Team 1	2026-03-19 13:31:40.442127	1687
278	Team 1	2026-03-19 14:00:38.809419	1691
279	Team 1	2026-03-20 10:55:26.929206	1693
280	Team 2	2026-03-20 10:55:26.981124	1693
281	Team 1	2026-03-20 10:56:55.39413	1694
282	Team 2	2026-03-20 10:56:55.409307	1694
\.


--
-- TOC entry 5305 (class 0 OID 25579)
-- Dependencies: 265
-- Data for Name: TeamMembers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TeamMembers" ("TeamMember_ID", "Team_ID", "ActivityParticipant_ID") FROM stdin;
1	1	\N
2	2	\N
3	3	\N
4	3	\N
5	4	\N
6	5	\N
7	6	\N
8	6	\N
9	7	\N
10	7	\N
11	8	\N
12	8	\N
13	9	\N
14	9	\N
15	10	\N
16	10	\N
17	11	\N
18	11	\N
19	12	\N
20	13	\N
21	14	\N
22	14	\N
23	15	\N
24	16	\N
25	17	\N
26	18	\N
27	19	\N
28	20	\N
29	21	\N
30	22	\N
31	23	\N
32	23	\N
33	24	\N
34	25	\N
35	26	\N
36	27	\N
37	28	\N
38	28	\N
39	29	\N
40	29	\N
41	30	\N
42	30	\N
43	31	\N
44	31	\N
45	32	\N
46	32	\N
47	33	\N
48	33	\N
49	34	\N
50	34	\N
51	35	\N
52	35	\N
53	36	\N
54	36	\N
55	37	\N
56	37	\N
57	38	\N
58	38	\N
59	39	\N
60	39	\N
61	40	\N
62	40	\N
63	41	\N
64	41	\N
65	42	\N
66	43	\N
67	44	\N
68	45	\N
69	46	\N
70	47	\N
71	48	\N
72	48	\N
73	49	\N
74	50	\N
75	51	\N
76	52	\N
77	53	\N
78	53	\N
79	54	\N
80	54	\N
81	55	\N
82	55	\N
83	56	\N
84	56	\N
85	57	\N
86	58	\N
87	59	\N
88	60	\N
89	61	\N
90	62	\N
91	63	\N
92	64	\N
93	65	\N
94	66	\N
95	67	\N
96	68	\N
97	69	\N
98	70	\N
99	71	\N
100	72	\N
101	73	\N
102	74	\N
103	75	\N
104	75	\N
105	76	\N
106	77	\N
107	77	\N
108	78	\N
109	79	\N
110	79	\N
111	80	\N
112	81	\N
113	81	\N
114	82	\N
115	83	\N
116	83	\N
117	84	\N
118	85	\N
119	85	\N
120	86	\N
121	87	\N
122	87	\N
123	88	\N
124	89	\N
125	89	\N
126	90	\N
127	91	\N
128	91	\N
129	92	\N
130	93	\N
131	93	\N
132	94	\N
133	95	\N
134	95	\N
135	96	\N
136	97	\N
137	97	\N
138	98	\N
139	99	\N
140	99	\N
141	100	\N
142	101	\N
143	101	\N
144	102	\N
145	103	\N
146	103	\N
147	104	\N
148	105	\N
149	105	\N
150	106	\N
151	107	\N
152	107	\N
153	108	\N
154	109	\N
155	109	\N
156	110	\N
157	111	\N
158	111	\N
159	112	\N
160	113	\N
161	113	\N
162	114	\N
163	115	\N
164	115	\N
165	116	\N
166	117	\N
167	117	\N
168	118	\N
169	119	\N
170	119	\N
171	120	\N
172	121	\N
173	121	\N
174	122	\N
175	123	\N
176	123	\N
177	124	\N
178	125	\N
179	126	\N
180	126	\N
181	127	\N
182	128	\N
183	128	\N
184	129	\N
185	130	\N
186	130	\N
187	131	\N
188	132	\N
189	132	\N
190	133	\N
191	133	\N
192	134	\N
193	135	\N
194	135	\N
195	136	\N
196	137	\N
197	137	\N
198	138	\N
199	139	\N
200	139	\N
201	140	\N
202	141	\N
203	141	\N
204	142	\N
205	143	\N
206	143	\N
207	144	\N
208	145	\N
209	145	\N
210	146	\N
211	147	\N
212	147	\N
213	148	\N
214	149	\N
215	149	\N
216	150	\N
217	151	\N
218	151	\N
219	152	\N
220	153	\N
221	153	\N
222	154	\N
223	155	\N
224	155	\N
225	156	\N
226	157	\N
227	157	\N
228	158	\N
229	159	\N
230	159	\N
231	160	\N
232	161	\N
233	161	\N
234	162	\N
235	163	\N
236	163	\N
237	164	\N
238	165	\N
239	165	\N
240	166	\N
241	167	\N
242	167	\N
243	168	\N
244	169	\N
245	169	\N
246	170	\N
247	171	\N
248	171	\N
249	172	\N
250	173	\N
251	173	\N
252	174	\N
253	175	\N
254	175	\N
255	176	\N
256	177	\N
257	177	\N
258	178	\N
259	179	\N
260	179	\N
261	180	\N
262	181	\N
263	181	\N
264	182	\N
265	183	\N
266	183	\N
267	184	\N
268	185	\N
269	185	\N
270	186	\N
271	187	\N
272	187	\N
273	188	\N
274	189	\N
275	189	\N
276	190	\N
277	190	\N
278	191	\N
279	191	\N
280	192	\N
281	192	\N
282	193	\N
283	193	\N
284	194	\N
285	194	\N
286	195	\N
287	195	\N
288	196	\N
289	196	\N
290	197	\N
291	197	\N
292	198	\N
293	198	\N
294	199	\N
295	199	\N
296	200	\N
297	200	\N
298	201	\N
299	201	\N
300	202	\N
301	202	\N
302	203	\N
303	204	\N
304	204	\N
305	205	\N
306	206	\N
307	206	\N
308	207	\N
309	208	\N
310	208	\N
311	209	\N
312	210	\N
313	210	\N
314	211	\N
315	212	\N
316	212	\N
317	213	\N
318	214	\N
319	215	\N
320	216	\N
321	217	\N
322	217	\N
323	218	\N
324	219	\N
325	220	\N
326	221	\N
327	222	\N
328	223	\N
329	224	\N
330	225	\N
331	225	\N
332	226	\N
333	227	\N
334	228	\N
335	229	\N
336	230	\N
337	231	\N
338	232	\N
339	233	\N
340	234	\N
341	235	\N
342	236	\N
343	237	\N
344	238	\N
345	239	\N
346	240	\N
347	240	\N
348	241	\N
349	241	\N
350	242	\N
351	242	\N
352	243	\N
353	243	\N
354	244	\N
355	244	\N
356	245	\N
357	246	\N
358	247	\N
359	247	\N
360	248	\N
361	248	\N
362	249	8220
363	249	8221
364	250	8230
365	250	8229
366	251	8246
367	251	8245
368	252	8256
369	252	8255
370	253	8265
371	253	8264
372	254	8273
373	254	8274
374	255	8301
375	255	8302
376	256	8311
377	256	8312
378	257	8322
379	257	8321
380	258	8331
381	258	8332
382	259	8337
383	259	8338
384	260	8452
385	260	8450
386	261	8451
387	262	8452
388	262	8450
389	263	8451
390	264	8464
391	264	8466
392	265	8465
393	266	8526
394	266	8527
395	267	8534
396	267	8535
397	268	8549
398	268	8548
399	269	8559
400	269	8558
401	270	8567
402	270	8568
403	271	8580
404	271	8579
405	272	8591
406	272	8590
407	273	8625
408	274	8632
409	275	8639
410	276	8643
411	277	8650
412	278	8669
413	278	8670
414	279	8696
415	279	8698
416	280	8697
417	280	8699
418	281	8713
419	281	8715
420	282	8712
421	282	8714
\.


--
-- TOC entry 5322 (class 0 OID 0)
-- Dependencies: 246
-- Name: ActivityParticipants_ActivityParticipant_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ActivityParticipants_ActivityParticipant_ID_seq"', 8763, true);


--
-- TOC entry 5323 (class 0 OID 0)
-- Dependencies: 242
-- Name: ActivitySessions_ActivitySession_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ActivitySessions_ActivitySession_ID_seq"', 1868, true);


--
-- TOC entry 5324 (class 0 OID 0)
-- Dependencies: 255
-- Name: AssignedInteractiveBoards_AssignedInteractiveBoard_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AssignedInteractiveBoards_AssignedInteractiveBoard_ID_seq"', 37, true);


--
-- TOC entry 5325 (class 0 OID 0)
-- Dependencies: 249
-- Name: AssignedPoll_AssignedPoll_ID_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AssignedPoll_AssignedPoll_ID_seq1"', 133, true);


--
-- TOC entry 5326 (class 0 OID 0)
-- Dependencies: 244
-- Name: AssignedQuiz_AssignedQuiz_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AssignedQuiz_AssignedQuiz_ID_seq"', 1694, true);


--
-- TOC entry 5327 (class 0 OID 0)
-- Dependencies: 234
-- Name: ClassRooms_Class_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ClassRooms_Class_ID_seq"', 60, true);


--
-- TOC entry 5328 (class 0 OID 0)
-- Dependencies: 257
-- Name: InteractiveBoardMessages_InteractiveBoardMessage_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."InteractiveBoardMessages_InteractiveBoardMessage_ID_seq"', 80, true);


--
-- TOC entry 5329 (class 0 OID 0)
-- Dependencies: 253
-- Name: PollAnswers_PollAnswer_ID_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PollAnswers_PollAnswer_ID_seq1"', 113, true);


--
-- TOC entry 5330 (class 0 OID 0)
-- Dependencies: 251
-- Name: PollOptions_PollOption_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PollOptions_PollOption_ID_seq"', 281, true);


--
-- TOC entry 5331 (class 0 OID 0)
-- Dependencies: 237
-- Name: QuestionOptions_Option_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."QuestionOptions_Option_ID_seq"', 1200, true);


--
-- TOC entry 5332 (class 0 OID 0)
-- Dependencies: 235
-- Name: QuestionSets_Set_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."QuestionSets_Set_ID_seq"', 129, true);


--
-- TOC entry 5333 (class 0 OID 0)
-- Dependencies: 236
-- Name: Questions_Question_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Questions_Question_ID_seq"', 472, true);


--
-- TOC entry 5334 (class 0 OID 0)
-- Dependencies: 260
-- Name: QuizResults_Result_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."QuizResults_Result_ID_seq"', 4267, true);


--
-- TOC entry 5335 (class 0 OID 0)
-- Dependencies: 232
-- Name: Teachers_Teacher_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Teachers_Teacher_ID_seq"', 25, true);


--
-- TOC entry 5336 (class 0 OID 0)
-- Dependencies: 262
-- Name: TeamAssignments_Team_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TeamAssignments_Team_ID_seq"', 282, true);


--
-- TOC entry 5337 (class 0 OID 0)
-- Dependencies: 264
-- Name: TeamMembers_TeamMember_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TeamMembers_TeamMember_ID_seq"', 421, true);


--
-- TOC entry 5338 (class 0 OID 0)
-- Dependencies: 241
-- Name: activityplans_plan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activityplans_plan_id_seq', 29, true);


--
-- TOC entry 5339 (class 0 OID 0)
-- Dependencies: 238
-- Name: avatars_avatar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.avatars_avatar_id_seq', 950, true);


--
-- TOC entry 5340 (class 0 OID 0)
-- Dependencies: 233
-- Name: classrooms_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.classrooms_class_id_seq', 1, true);


--
-- TOC entry 5341 (class 0 OID 0)
-- Dependencies: 259
-- Name: quizanswers_quizanswer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quizanswers_quizanswer_id_seq', 3501, true);


--
-- TOC entry 5342 (class 0 OID 0)
-- Dependencies: 239
-- Name: students_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_student_id_seq', 299, true);


--
-- TOC entry 5052 (class 2606 OID 17155)
-- Name: ActivityParticipants ActivityParticipants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityParticipants"
    ADD CONSTRAINT "ActivityParticipants_pkey" PRIMARY KEY ("ActivityParticipant_ID");


--
-- TOC entry 5042 (class 2606 OID 16664)
-- Name: ActivityPlans ActivityPlans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPlans"
    ADD CONSTRAINT "ActivityPlans_pkey" PRIMARY KEY ("Plan_ID");


--
-- TOC entry 5048 (class 2606 OID 17108)
-- Name: ActivitySessions ActivitySessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivitySessions"
    ADD CONSTRAINT "ActivitySessions_pkey" PRIMARY KEY ("ActivitySession_ID");


--
-- TOC entry 5065 (class 2606 OID 17336)
-- Name: AssignedInteractiveBoards AssignedInteractiveBoards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssignedInteractiveBoards"
    ADD CONSTRAINT "AssignedInteractiveBoards_pkey" PRIMARY KEY ("AssignedInteractiveBoard_ID");


--
-- TOC entry 5058 (class 2606 OID 17205)
-- Name: AssignedPoll AssignedPoll_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssignedPoll"
    ADD CONSTRAINT "AssignedPoll_pkey1" PRIMARY KEY ("AssignedPoll_ID");


--
-- TOC entry 5050 (class 2606 OID 17120)
-- Name: AssignedQuiz AssignedQuiz_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssignedQuiz"
    ADD CONSTRAINT "AssignedQuiz_pkey" PRIMARY KEY ("AssignedQuiz_ID");


--
-- TOC entry 5030 (class 2606 OID 16545)
-- Name: AvatarAccessories AvatarAccessories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AvatarAccessories"
    ADD CONSTRAINT "AvatarAccessories_pkey" PRIMARY KEY ("Accessory_ID");


--
-- TOC entry 5032 (class 2606 OID 16554)
-- Name: AvatarBodies AvatarBodies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AvatarBodies"
    ADD CONSTRAINT "AvatarBodies_pkey" PRIMARY KEY ("Body_ID");


--
-- TOC entry 5028 (class 2606 OID 16526)
-- Name: AvatarCostumes AvatarCostumes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AvatarCostumes"
    ADD CONSTRAINT "AvatarCostumes_pkey" PRIMARY KEY ("Costume_ID");


--
-- TOC entry 5026 (class 2606 OID 16500)
-- Name: AvatarMasks AvatarMasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AvatarMasks"
    ADD CONSTRAINT "AvatarMasks_pkey" PRIMARY KEY ("Mask_ID");


--
-- TOC entry 5034 (class 2606 OID 16575)
-- Name: Avatars Avatars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Avatars"
    ADD CONSTRAINT "Avatars_pkey" PRIMARY KEY ("Avatar_ID");


--
-- TOC entry 5044 (class 2606 OID 16677)
-- Name: ClassRooms ClassRooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClassRooms"
    ADD CONSTRAINT "ClassRooms_pkey" PRIMARY KEY ("Class_ID");


--
-- TOC entry 5067 (class 2606 OID 17351)
-- Name: InteractiveBoardMessages InteractiveBoardMessages_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InteractiveBoardMessages"
    ADD CONSTRAINT "InteractiveBoardMessages_pkey1" PRIMARY KEY ("InteractiveBoardMessage_ID");


--
-- TOC entry 5062 (class 2606 OID 17227)
-- Name: PollAnswers PollAnswers_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PollAnswers"
    ADD CONSTRAINT "PollAnswers_pkey1" PRIMARY KEY ("PollAnswer_ID");


--
-- TOC entry 5060 (class 2606 OID 17215)
-- Name: PollOptions PollOptions_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PollOptions"
    ADD CONSTRAINT "PollOptions_pkey1" PRIMARY KEY ("PollOption_ID");


--
-- TOC entry 5024 (class 2606 OID 16450)
-- Name: QuestionOptions QuestionOptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionOptions"
    ADD CONSTRAINT "QuestionOptions_pkey" PRIMARY KEY ("Option_ID");


--
-- TOC entry 5019 (class 2606 OID 16407)
-- Name: QuestionSets QuestionSets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionSets"
    ADD CONSTRAINT "QuestionSets_pkey" PRIMARY KEY ("Set_ID");


--
-- TOC entry 5022 (class 2606 OID 16435)
-- Name: Questions Questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Questions"
    ADD CONSTRAINT "Questions_pkey" PRIMARY KEY ("Question_ID");


--
-- TOC entry 5056 (class 2606 OID 17167)
-- Name: QuizAnswers QuizAnswers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuizAnswers"
    ADD CONSTRAINT "QuizAnswers_pkey" PRIMARY KEY ("QuizAnswer_ID");


--
-- TOC entry 5069 (class 2606 OID 25955)
-- Name: QuizProgress QuizProgress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuizProgress"
    ADD CONSTRAINT "QuizProgress_pkey" PRIMARY KEY ("AssignedQuiz_ID", "ActivityParticipant_ID");


--
-- TOC entry 5036 (class 2606 OID 16592)
-- Name: QuizResults QuizResults_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuizResults"
    ADD CONSTRAINT "QuizResults_pkey" PRIMARY KEY ("Result_ID");


--
-- TOC entry 5040 (class 2606 OID 16640)
-- Name: Students Students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "Students_pkey" PRIMARY KEY ("Student_ID");


--
-- TOC entry 5017 (class 2606 OID 16397)
-- Name: Teachers Teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Teachers"
    ADD CONSTRAINT "Teachers_pkey" PRIMARY KEY ("Teacher_ID");


--
-- TOC entry 5071 (class 2606 OID 25572)
-- Name: TeamAssignments TeamAssignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamAssignments"
    ADD CONSTRAINT "TeamAssignments_pkey" PRIMARY KEY ("Team_ID");


--
-- TOC entry 5073 (class 2606 OID 25587)
-- Name: TeamMembers TeamMembers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamMembers"
    ADD CONSTRAINT "TeamMembers_pkey" PRIMARY KEY ("TeamMember_ID");


--
-- TOC entry 5046 (class 2606 OID 17032)
-- Name: Question_Correct_Options pk_question_correct; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question_Correct_Options"
    ADD CONSTRAINT pk_question_correct PRIMARY KEY ("Question_ID", "Option_ID");


--
-- TOC entry 5038 (class 2606 OID 25932)
-- Name: QuizResults quizresults_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuizResults"
    ADD CONSTRAINT quizresults_unique UNIQUE ("ActivityParticipant_ID", "AssignedQuiz_ID");


--
-- TOC entry 5054 (class 2606 OID 17389)
-- Name: ActivityParticipants unique_activity_student; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityParticipants"
    ADD CONSTRAINT unique_activity_student UNIQUE ("ActivitySession_ID", "Student_ID");


--
-- TOC entry 5020 (class 1259 OID 16413)
-- Name: fki_Teachers_pkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Teachers_pkey" ON public."QuestionSets" USING btree ("Teacher_ID");


--
-- TOC entry 5063 (class 1259 OID 25870)
-- Name: idx_pollanswers_option; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pollanswers_option ON public."PollAnswers" USING btree ("PollOption_ID");


--
-- TOC entry 5111 (class 2620 OID 17080)
-- Name: ActivityPlans trg_activityplans_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_activityplans_updated BEFORE UPDATE ON public."ActivityPlans" FOR EACH ROW EXECUTE FUNCTION public.update_plan_updated_at();


--
-- TOC entry 5093 (class 2606 OID 17304)
-- Name: ActivityParticipants ActivityParticipants_ActivitySession_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityParticipants"
    ADD CONSTRAINT "ActivityParticipants_ActivitySession_ID_fkey" FOREIGN KEY ("ActivitySession_ID") REFERENCES public."ActivitySessions"("ActivitySession_ID");


--
-- TOC entry 5094 (class 2606 OID 17309)
-- Name: ActivityParticipants ActivityParticipants_Student_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityParticipants"
    ADD CONSTRAINT "ActivityParticipants_Student_ID_fkey" FOREIGN KEY ("Student_ID") REFERENCES public."Students"("Student_ID");


--
-- TOC entry 5103 (class 2606 OID 17352)
-- Name: AssignedInteractiveBoards AssignedInteractiveBoards_ActivitySession_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssignedInteractiveBoards"
    ADD CONSTRAINT "AssignedInteractiveBoards_ActivitySession_ID_fkey" FOREIGN KEY ("ActivitySession_ID") REFERENCES public."ActivitySessions"("ActivitySession_ID");


--
-- TOC entry 5099 (class 2606 OID 17274)
-- Name: AssignedPoll AssignedPoll_ActivitySession_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssignedPoll"
    ADD CONSTRAINT "AssignedPoll_ActivitySession_ID_fkey" FOREIGN KEY ("ActivitySession_ID") REFERENCES public."ActivitySessions"("ActivitySession_ID");


--
-- TOC entry 5091 (class 2606 OID 17234)
-- Name: AssignedQuiz AssignedQuiz_ActivitySession_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssignedQuiz"
    ADD CONSTRAINT "AssignedQuiz_ActivitySession_ID_fkey" FOREIGN KEY ("ActivitySession_ID") REFERENCES public."ActivitySessions"("ActivitySession_ID");


--
-- TOC entry 5092 (class 2606 OID 17239)
-- Name: AssignedQuiz AssignedQuiz_Quiz_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AssignedQuiz"
    ADD CONSTRAINT "AssignedQuiz_Quiz_ID_fkey" FOREIGN KEY ("Quiz_ID") REFERENCES public."QuestionSets"("Set_ID");


--
-- TOC entry 5077 (class 2606 OID 16619)
-- Name: Avatars AvatarAccessories_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Avatars"
    ADD CONSTRAINT "AvatarAccessories_fkey" FOREIGN KEY ("Accessory_ID") REFERENCES public."AvatarAccessories"("Accessory_ID") MATCH FULL;


--
-- TOC entry 5078 (class 2606 OID 16624)
-- Name: Avatars AvatarBodies; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Avatars"
    ADD CONSTRAINT "AvatarBodies" FOREIGN KEY ("Body_ID") REFERENCES public."AvatarBodies"("Body_ID") MATCH FULL;


--
-- TOC entry 5079 (class 2606 OID 16609)
-- Name: Avatars AvatarCostumes_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Avatars"
    ADD CONSTRAINT "AvatarCostumes_fkey" FOREIGN KEY ("Costume_ID") REFERENCES public."AvatarCostumes"("Costume_ID") MATCH FULL;


--
-- TOC entry 5080 (class 2606 OID 16614)
-- Name: Avatars AvatarMasks; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Avatars"
    ADD CONSTRAINT "AvatarMasks" FOREIGN KEY ("Mask_ID") REFERENCES public."AvatarMasks"("Mask_ID") MATCH FULL;


--
-- TOC entry 5083 (class 2606 OID 16649)
-- Name: Students Avatars_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "Avatars_fkey" FOREIGN KEY ("Avatar_ID") REFERENCES public."Avatars"("Avatar_ID") MATCH FULL;


--
-- TOC entry 5084 (class 2606 OID 16683)
-- Name: Students ClassRooms_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "ClassRooms_fkey" FOREIGN KEY ("Class_ID") REFERENCES public."ClassRooms"("Class_ID") MATCH FULL;


--
-- TOC entry 5085 (class 2606 OID 16768)
-- Name: ActivityPlans ClassRooms_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPlans"
    ADD CONSTRAINT "ClassRooms_fkey" FOREIGN KEY ("Class_ID") REFERENCES public."ClassRooms"("Class_ID") MATCH FULL;


--
-- TOC entry 5089 (class 2606 OID 17229)
-- Name: ActivitySessions Class_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivitySessions"
    ADD CONSTRAINT "Class_ID" FOREIGN KEY ("Class_ID") REFERENCES public."ClassRooms"("Class_ID");


--
-- TOC entry 5101 (class 2606 OID 17289)
-- Name: PollAnswers PollAnswers_PollOption_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PollAnswers"
    ADD CONSTRAINT "PollAnswers_PollOption_ID_fkey" FOREIGN KEY ("PollOption_ID") REFERENCES public."PollOptions"("PollOption_ID");


--
-- TOC entry 5100 (class 2606 OID 17279)
-- Name: PollOptions PollOptions_AssignedPoll_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PollOptions"
    ADD CONSTRAINT "PollOptions_AssignedPoll_ID_fkey" FOREIGN KEY ("AssignedPoll_ID") REFERENCES public."AssignedPoll"("AssignedPoll_ID");


--
-- TOC entry 5095 (class 2606 OID 17264)
-- Name: QuizAnswers QuizAnswers_Choice_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuizAnswers"
    ADD CONSTRAINT "QuizAnswers_Choice_ID_fkey" FOREIGN KEY ("Choice_ID") REFERENCES public."QuestionOptions"("Option_ID");


--
-- TOC entry 5096 (class 2606 OID 17259)
-- Name: QuizAnswers QuizAnswers_Question_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuizAnswers"
    ADD CONSTRAINT "QuizAnswers_Question_ID_fkey" FOREIGN KEY ("Question_ID") REFERENCES public."Questions"("Question_ID");


--
-- TOC entry 5086 (class 2606 OID 16678)
-- Name: ClassRooms Teachers_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClassRooms"
    ADD CONSTRAINT "Teachers_fkey" FOREIGN KEY ("Teacher_ID") REFERENCES public."Teachers"("Teacher_ID") MATCH FULL;


--
-- TOC entry 5074 (class 2606 OID 16408)
-- Name: QuestionSets Teachers_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionSets"
    ADD CONSTRAINT "Teachers_pkey" FOREIGN KEY ("Teacher_ID") REFERENCES public."Teachers"("Teacher_ID");


--
-- TOC entry 5090 (class 2606 OID 25933)
-- Name: ActivitySessions fk_activitysessions_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivitySessions"
    ADD CONSTRAINT fk_activitysessions_teacher FOREIGN KEY ("Assigned_By") REFERENCES public."Teachers"("Teacher_ID") ON DELETE CASCADE;


--
-- TOC entry 5104 (class 2606 OID 25874)
-- Name: InteractiveBoardMessages fk_board_message; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InteractiveBoardMessages"
    ADD CONSTRAINT fk_board_message FOREIGN KEY ("AssignedInteractiveBoard_ID") REFERENCES public."AssignedInteractiveBoards"("AssignedInteractiveBoard_ID") ON DELETE CASCADE;


--
-- TOC entry 5105 (class 2606 OID 25938)
-- Name: InteractiveBoardMessages fk_ibm_participant; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InteractiveBoardMessages"
    ADD CONSTRAINT fk_ibm_participant FOREIGN KEY ("ActivityParticipant_ID") REFERENCES public."ActivityParticipants"("ActivityParticipant_ID") ON DELETE CASCADE;


--
-- TOC entry 5102 (class 2606 OID 25879)
-- Name: PollAnswers fk_pollanswers_participant; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PollAnswers"
    ADD CONSTRAINT fk_pollanswers_participant FOREIGN KEY ("ActivityParticipant_ID") REFERENCES public."ActivityParticipants"("ActivityParticipant_ID") ON DELETE CASCADE;


--
-- TOC entry 5087 (class 2606 OID 17038)
-- Name: Question_Correct_Options fk_qco_option; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question_Correct_Options"
    ADD CONSTRAINT fk_qco_option FOREIGN KEY ("Option_ID") REFERENCES public."QuestionOptions"("Option_ID") ON DELETE CASCADE;


--
-- TOC entry 5088 (class 2606 OID 17033)
-- Name: Question_Correct_Options fk_qco_question; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question_Correct_Options"
    ADD CONSTRAINT fk_qco_question FOREIGN KEY ("Question_ID") REFERENCES public."Questions"("Question_ID") ON DELETE CASCADE;


--
-- TOC entry 5076 (class 2606 OID 17045)
-- Name: QuestionOptions fk_questionoptions_question; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionOptions"
    ADD CONSTRAINT fk_questionoptions_question FOREIGN KEY ("Question_ID") REFERENCES public."Questions"("Question_ID") ON DELETE CASCADE;


--
-- TOC entry 5075 (class 2606 OID 25943)
-- Name: QuestionSets fk_questionsets_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionSets"
    ADD CONSTRAINT fk_questionsets_parent FOREIGN KEY ("Parent_Set_ID") REFERENCES public."QuestionSets"("Set_ID") ON DELETE SET NULL;


--
-- TOC entry 5097 (class 2606 OID 25884)
-- Name: QuizAnswers fk_quizanswers_assignedquiz; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuizAnswers"
    ADD CONSTRAINT fk_quizanswers_assignedquiz FOREIGN KEY ("AssignedQuiz_ID") REFERENCES public."AssignedQuiz"("AssignedQuiz_ID") ON DELETE CASCADE;


--
-- TOC entry 5098 (class 2606 OID 25889)
-- Name: QuizAnswers fk_quizanswers_participant; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuizAnswers"
    ADD CONSTRAINT fk_quizanswers_participant FOREIGN KEY ("ActivityParticipant_ID") REFERENCES public."ActivityParticipants"("ActivityParticipant_ID") ON DELETE CASCADE;


--
-- TOC entry 5106 (class 2606 OID 25894)
-- Name: QuizProgress fk_quizprogress_assignedquiz; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuizProgress"
    ADD CONSTRAINT fk_quizprogress_assignedquiz FOREIGN KEY ("AssignedQuiz_ID") REFERENCES public."AssignedQuiz"("AssignedQuiz_ID") ON DELETE CASCADE;


--
-- TOC entry 5107 (class 2606 OID 25899)
-- Name: QuizProgress fk_quizprogress_participant; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuizProgress"
    ADD CONSTRAINT fk_quizprogress_participant FOREIGN KEY ("ActivityParticipant_ID") REFERENCES public."ActivityParticipants"("ActivityParticipant_ID") ON DELETE CASCADE;


--
-- TOC entry 5081 (class 2606 OID 25904)
-- Name: QuizResults fk_quizresults_assignedquiz; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuizResults"
    ADD CONSTRAINT fk_quizresults_assignedquiz FOREIGN KEY ("AssignedQuiz_ID") REFERENCES public."AssignedQuiz"("AssignedQuiz_ID") ON DELETE CASCADE;


--
-- TOC entry 5082 (class 2606 OID 25909)
-- Name: QuizResults fk_quizresults_participant; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuizResults"
    ADD CONSTRAINT fk_quizresults_participant FOREIGN KEY ("ActivityParticipant_ID") REFERENCES public."ActivityParticipants"("ActivityParticipant_ID") ON DELETE CASCADE;


--
-- TOC entry 5109 (class 2606 OID 25590)
-- Name: TeamMembers fk_team_member_team; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamMembers"
    ADD CONSTRAINT fk_team_member_team FOREIGN KEY ("Team_ID") REFERENCES public."TeamAssignments"("Team_ID") ON DELETE CASCADE;


--
-- TOC entry 5108 (class 2606 OID 25924)
-- Name: TeamAssignments fk_teamassignment_quiz; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamAssignments"
    ADD CONSTRAINT fk_teamassignment_quiz FOREIGN KEY ("AssignedQuiz_ID") REFERENCES public."AssignedQuiz"("AssignedQuiz_ID") ON DELETE CASCADE;


--
-- TOC entry 5110 (class 2606 OID 25914)
-- Name: TeamMembers fk_teammembers_participant; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamMembers"
    ADD CONSTRAINT fk_teammembers_participant FOREIGN KEY ("ActivityParticipant_ID") REFERENCES public."ActivityParticipants"("ActivityParticipant_ID") ON DELETE CASCADE;


-- Completed on 2026-03-22 16:55:02

--
-- PostgreSQL database dump complete
--

\unrestrict 3uRRFu5i2LlGV9jxU5xz7iOiCNWWTtaVrvK1VUjyaFDFcDAtejljVGi7FAVUCNh

