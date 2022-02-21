/*
 Navicat Premium Data Transfer

 Source Server         : hasura
 Source Server Type    : PostgreSQL
 Source Server Version : 120007
 Source Host           : 103.195.238.188:22032
 Source Catalog        : postgres
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 120007
 File Encoding         : 65001

 Date: 25/09/2021 19:37:47
*/


-- ----------------------------
-- Sequence structure for comment_tag_user_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."comment_tag_user_id_seq";
CREATE SEQUENCE "public"."comment_tag_user_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for comments_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."comments_id_seq";
CREATE SEQUENCE "public"."comments_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for follows_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."follows_id_seq";
CREATE SEQUENCE "public"."follows_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for locations_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."locations_id_seq";
CREATE SEQUENCE "public"."locations_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for media_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."media_id_seq";
CREATE SEQUENCE "public"."media_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for notification_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."notification_id_seq";
CREATE SEQUENCE "public"."notification_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for pet_breeds_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."pet_breeds_id_seq";
CREATE SEQUENCE "public"."pet_breeds_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for pet_owners_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."pet_owners_id_seq";
CREATE SEQUENCE "public"."pet_owners_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for pet_services_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."pet_services_id_seq";
CREATE SEQUENCE "public"."pet_services_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for pet_vaccinateds_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."pet_vaccinateds_id_seq";
CREATE SEQUENCE "public"."pet_vaccinateds_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for pet_weights_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."pet_weights_id_seq";
CREATE SEQUENCE "public"."pet_weights_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for pet_worm_flusheds_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."pet_worm_flusheds_id_seq";
CREATE SEQUENCE "public"."pet_worm_flusheds_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for pets_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."pets_id_seq";
CREATE SEQUENCE "public"."pets_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for post_reacts_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."post_reacts_id_seq";
CREATE SEQUENCE "public"."post_reacts_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for posts_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."posts_id_seq";
CREATE SEQUENCE "public"."posts_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for report_post_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."report_post_id_seq";
CREATE SEQUENCE "public"."report_post_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for request_contact_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."request_contact_id_seq";
CREATE SEQUENCE "public"."request_contact_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for settings_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."settings_id_seq";
CREATE SEQUENCE "public"."settings_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for users_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."users_id_seq";
CREATE SEQUENCE "public"."users_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for comment_react
-- ----------------------------
DROP TABLE IF EXISTS "public"."comment_react";
CREATE TABLE "public"."comment_react" (
  "id" int4 NOT NULL DEFAULT nextval('comments_id_seq'::regclass),
  "comment_id" int4 NOT NULL,
  "reactor_uuid" text COLLATE "pg_catalog"."default",
  "post_id" int4 NOT NULL
)
;

-- ----------------------------
-- Table structure for comment_tag_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."comment_tag_user";
CREATE TABLE "public"."comment_tag_user" (
  "id" int4 NOT NULL DEFAULT nextval('comment_tag_user_id_seq'::regclass),
  "comment_id" int4 NOT NULL,
  "user_id" int4 NOT NULL,
  "post_id" int4 NOT NULL
)
;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS "public"."comments";
CREATE TABLE "public"."comments" (
  "id" int4 NOT NULL DEFAULT nextval('comments_id_seq'::regclass),
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "post_id" int4 NOT NULL,
  "creator_uuid" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) DEFAULT now(),
  "updated_at" timestamptz(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for follows
-- ----------------------------
DROP TABLE IF EXISTS "public"."follows";
CREATE TABLE "public"."follows" (
  "id" int4 NOT NULL DEFAULT nextval('follows_id_seq'::regclass),
  "user_uuid" text COLLATE "pg_catalog"."default" NOT NULL,
  "pet_id" int4 NOT NULL
)
;

-- ----------------------------
-- Table structure for locations
-- ----------------------------
DROP TABLE IF EXISTS "public"."locations";
CREATE TABLE "public"."locations" (
  "id" int4 NOT NULL DEFAULT nextval('locations_id_seq'::regclass),
  "name" text COLLATE "pg_catalog"."default",
  "lat" float8,
  "long" float8,
  "updated_at" timestamptz(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for medias
-- ----------------------------
DROP TABLE IF EXISTS "public"."medias";
CREATE TABLE "public"."medias" (
  "id" int4 NOT NULL DEFAULT nextval('media_id_seq'::regclass),
  "url" text COLLATE "pg_catalog"."default",
  "type" int2 NOT NULL DEFAULT '0'::smallint,
  "post_id" int4
)
;
COMMENT ON COLUMN "public"."medias"."type" IS '0: image, 1:video, 2: gif';

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS "public"."notifications";
CREATE TABLE "public"."notifications" (
  "id" int4 NOT NULL DEFAULT nextval('notification_id_seq'::regclass),
  "type" int4 NOT NULL,
  "post_id" int4,
  "pet_id" int4,
  "is_read" bool DEFAULT false,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "owner_id" int4 NOT NULL,
  "actor_uuid" text COLLATE "pg_catalog"."default",
  "owner_uuid" text COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."notifications"."type" IS '@JsonValue(0)   react,   @JsonValue(1)   follow,   @JsonValue(2)   comment,   @JsonValue(3)   adoption,   @JsonValue(4)   matting,   @JsonValue(5)   lose,@JsonValue(6)   comment_tag_user,@JsonValue(7)   react_comment,@JsonValue(8)   request_message';

-- ----------------------------
-- Table structure for pet_breeds
-- ----------------------------
DROP TABLE IF EXISTS "public"."pet_breeds";
CREATE TABLE "public"."pet_breeds" (
  "id" int4 NOT NULL DEFAULT nextval('pet_breeds_id_seq'::regclass),
  "id_pet_type" int4 NOT NULL,
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "avatar" text COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Table structure for pet_owners
-- ----------------------------
DROP TABLE IF EXISTS "public"."pet_owners";
CREATE TABLE "public"."pet_owners" (
  "id" int4 NOT NULL DEFAULT nextval('pet_owners_id_seq'::regclass),
  "pet_id" int4 NOT NULL,
  "owner_uuid" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "give_time" timestamptz(6)
)
;

-- ----------------------------
-- Table structure for pet_services
-- ----------------------------
DROP TABLE IF EXISTS "public"."pet_services";
CREATE TABLE "public"."pet_services" (
  "id" int4 NOT NULL DEFAULT nextval('pet_services_id_seq'::regclass),
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "location_id" int4 NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "logo" text COLLATE "pg_catalog"."default",
  "phone_number" text COLLATE "pg_catalog"."default",
  "social_contact" text COLLATE "pg_catalog"."default",
  "website" text COLLATE "pg_catalog"."default",
  "google_map_link" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for pet_types
-- ----------------------------
DROP TABLE IF EXISTS "public"."pet_types";
CREATE TABLE "public"."pet_types" (
  "id" int4 NOT NULL DEFAULT nextval('pet_breeds_id_seq'::regclass),
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "descriptions" text COLLATE "pg_catalog"."default",
  "avatar" text COLLATE "pg_catalog"."default",
  "order" int4
)
;

-- ----------------------------
-- Table structure for pet_vaccinateds
-- ----------------------------
DROP TABLE IF EXISTS "public"."pet_vaccinateds";
CREATE TABLE "public"."pet_vaccinateds" (
  "id" int4 NOT NULL DEFAULT nextval('pet_vaccinateds_id_seq'::regclass),
  "pet_id" int4 NOT NULL,
  "vaccine_name" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "created_at" timestamptz(6) DEFAULT now(),
  "date" date NOT NULL,
  "updated_at" timestamptz(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for pet_weights
-- ----------------------------
DROP TABLE IF EXISTS "public"."pet_weights";
CREATE TABLE "public"."pet_weights" (
  "id" int4 NOT NULL DEFAULT nextval('pet_weights_id_seq'::regclass),
  "weight" float8 NOT NULL,
  "created_at" timestamptz(6) DEFAULT now(),
  "pet_id" int4 NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "date" date NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for pet_worm_flusheds
-- ----------------------------
DROP TABLE IF EXISTS "public"."pet_worm_flusheds";
CREATE TABLE "public"."pet_worm_flusheds" (
  "id" int4 NOT NULL DEFAULT nextval('pet_worm_flusheds_id_seq'::regclass),
  "pet_id" int4 NOT NULL,
  "created_at" timestamptz(6) DEFAULT now(),
  "description" text COLLATE "pg_catalog"."default",
  "date" date NOT NULL,
  "updated_at" timestamptz(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for pets
-- ----------------------------
DROP TABLE IF EXISTS "public"."pets";
CREATE TABLE "public"."pets" (
  "id" int4 NOT NULL DEFAULT nextval('pets_id_seq'::regclass),
  "name" text COLLATE "pg_catalog"."default" NOT NULL,
  "pet_type_id" int4,
  "gender" int2 NOT NULL,
  "dob" date,
  "pet_breed_id" int4,
  "bio" text COLLATE "pg_catalog"."default",
  "father_id" int4,
  "mother_id" int4,
  "avatar_id" int4,
  "current_owner_uuid" text COLLATE "pg_catalog"."default",
  "avatar_url" text COLLATE "pg_catalog"."default",
  "uuid" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for post_pet
-- ----------------------------
DROP TABLE IF EXISTS "public"."post_pet";
CREATE TABLE "public"."post_pet" (
  "pet_id" int4 NOT NULL,
  "post_id" int4 NOT NULL
)
;

-- ----------------------------
-- Table structure for post_reacts
-- ----------------------------
DROP TABLE IF EXISTS "public"."post_reacts";
CREATE TABLE "public"."post_reacts" (
  "id" int4 NOT NULL DEFAULT nextval('post_reacts_id_seq'::regclass),
  "post_id" int4 NOT NULL,
  "reactor_uuid" text COLLATE "pg_catalog"."default" NOT NULL,
  "mating_pet_id" int4
)
;

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS "public"."posts";
CREATE TABLE "public"."posts" (
  "id" int4 NOT NULL DEFAULT nextval('posts_id_seq'::regclass),
  "content" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT '""'::text,
  "is_closed" bool DEFAULT false,
  "created_at" timestamptz(6) DEFAULT now(),
  "type" int2 NOT NULL DEFAULT '0'::smallint,
  "location_id" int4,
  "creator_uuid" text COLLATE "pg_catalog"."default" NOT NULL,
  "status" int2,
  "uuid" text COLLATE "pg_catalog"."default",
  "additional_data" text COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."posts"."type" IS '0 - activity, 1 - adop, 2 - mating, 3 - lose';
COMMENT ON COLUMN "public"."posts"."status" IS '"0" is draft - "1" is published';

-- ----------------------------
-- Table structure for report_comment
-- ----------------------------
DROP TABLE IF EXISTS "public"."report_comment";
CREATE TABLE "public"."report_comment" (
  "id" int8 NOT NULL DEFAULT nextval('report_post_id_seq'::regclass),
  "post_id" int4 NOT NULL,
  "creator_uuid" text COLLATE "pg_catalog"."default" NOT NULL,
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "type" int4 NOT NULL DEFAULT 0,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "comment_id" int4 NOT NULL
)
;

-- ----------------------------
-- Table structure for report_post
-- ----------------------------
DROP TABLE IF EXISTS "public"."report_post";
CREATE TABLE "public"."report_post" (
  "id" int8 NOT NULL DEFAULT nextval('report_post_id_seq'::regclass),
  "post_id" int4 NOT NULL,
  "creator_uuid" text COLLATE "pg_catalog"."default" NOT NULL,
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "type" int4 NOT NULL DEFAULT 0,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now()
)
;

-- ----------------------------
-- Table structure for request_contact
-- ----------------------------
DROP TABLE IF EXISTS "public"."request_contact";
CREATE TABLE "public"."request_contact" (
  "id" int8 NOT NULL DEFAULT nextval('request_contact_id_seq'::regclass),
  "from_user_uuid" text COLLATE "pg_catalog"."default" NOT NULL,
  "to_user_uuid" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "status" int4 NOT NULL DEFAULT 0,
  "content" text COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."request_contact"."status" IS '0: waiting,1:accept,2:deny';

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS "public"."settings";
CREATE TABLE "public"."settings" (
  "id" int8 NOT NULL DEFAULT nextval('settings_id_seq'::regclass),
  "setting" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now()
)
;
COMMENT ON TABLE "public"."settings" IS 'setting is  json map';

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
  "uuid" text COLLATE "pg_catalog"."default" NOT NULL,
  "name" text COLLATE "pg_catalog"."default",
  "phone_number" text COLLATE "pg_catalog"."default",
  "email" text COLLATE "pg_catalog"."default" NOT NULL,
  "id" int8 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
  "location_id" int4,
  "bio" text COLLATE "pg_catalog"."default" DEFAULT ''''::text,
  "avatar_id" int4,
  "dob" date,
  "avatar_url" text COLLATE "pg_catalog"."default",
  "setting_id" int4,
  "created_at" timestamptz(6) DEFAULT now(),
  "active" int2 DEFAULT '1'::smallint
)
;

-- ----------------------------
-- Function structure for armor
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."armor"(bytea);
CREATE OR REPLACE FUNCTION "public"."armor"(bytea)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pg_armor'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for armor
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."armor"(bytea, _text, _text);
CREATE OR REPLACE FUNCTION "public"."armor"(bytea, _text, _text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pg_armor'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for calc_distance_user_to_post
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."calc_distance_user_to_post"("post_row" "public"."posts", "hasura_session" json);
CREATE OR REPLACE FUNCTION "public"."calc_distance_user_to_post"("post_row" "public"."posts", "hasura_session" json)
  RETURNS "pg_catalog"."float8" AS $BODY$
DECLARE 
    long_post float;
	lat_post float;
	long_user float;
	lat_user float;
BEGIN
    SELECT  locations.long , locations.lat INTO  long_user ,  lat_user FROM locations JOIN users ON locations.id = users.location_id
	WHERE users.uuid = cast(hasura_session ->> 'x-hasura-user-id' as varchar);
    
	IF long_user ISNULL AND lat_user ISNULL THEN RETURN 0; END IF;
	SELECT  locations.long , locations.lat INTO  long_post , lat_post FROM locations JOIN posts ON locations.id = posts.location_id	
	WHERE posts.id = post_row.id;
	IF long_post ISNULL AND lat_post ISNULL THEN RETURN 0; END IF;
	
    RETURN SQRT(POW(69.1 * (lat_user -  lat_post), 2) + POW(69.1 * (long_post - long_user) * COS(lat_user / 57.3), 2));
	
END
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;

-- ----------------------------
-- Function structure for calculate_distance
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."calculate_distance"("lat1" float8, "lon1" float8, "lat2" float8, "lon2" float8, "units" varchar);
CREATE OR REPLACE FUNCTION "public"."calculate_distance"("lat1" float8, "lon1" float8, "lat2" float8, "lon2" float8, "units" varchar)
  RETURNS "pg_catalog"."float8" AS $BODY$
    DECLARE
        dist float = 0;
        radlat1 float;
        radlat2 float;
        theta float;
        radtheta float;
    BEGIN
        IF lat1 = lat2 OR lon1 = lon2
            THEN RETURN dist;
        ELSE
            radlat1 = pi() * lat1 / 180;
            radlat2 = pi() * lat2 / 180;
            theta = lon1 - lon2;
            radtheta = pi() * theta / 180;
            dist = sin(radlat1) * sin(radlat2) + cos(radlat1) * cos(radlat2) * cos(radtheta);

            IF dist > 1 THEN dist = 1; END IF;

            dist = acos(dist);
            dist = dist * 180 / pi();
            dist = dist * 60 * 1.1515;

            IF units = 'K' THEN dist = dist * 1.609344; END IF;
            IF units = 'N' THEN dist = dist * 0.8684; END IF;

            RETURN dist;
        END IF;
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for count_post_react
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."count_post_react"("post_row" "public"."posts");
CREATE OR REPLACE FUNCTION "public"."count_post_react"("post_row" "public"."posts")
  RETURNS "pg_catalog"."int8" AS $BODY$
SELECT count(*) from post_reacts where post_id = post_row.id ;
$BODY$
  LANGUAGE sql STABLE
  COST 100;

-- ----------------------------
-- Function structure for crypt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."crypt"(text, text);
CREATE OR REPLACE FUNCTION "public"."crypt"(text, text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pg_crypt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for dearmor
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."dearmor"(text);
CREATE OR REPLACE FUNCTION "public"."dearmor"(text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_dearmor'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for decrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."decrypt"(bytea, bytea, text);
CREATE OR REPLACE FUNCTION "public"."decrypt"(bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_decrypt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for decrypt_iv
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."decrypt_iv"(bytea, bytea, bytea, text);
CREATE OR REPLACE FUNCTION "public"."decrypt_iv"(bytea, bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_decrypt_iv'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for digest
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."digest"(text, text);
CREATE OR REPLACE FUNCTION "public"."digest"(text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_digest'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for digest
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."digest"(bytea, text);
CREATE OR REPLACE FUNCTION "public"."digest"(bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_digest'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for encrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."encrypt"(bytea, bytea, text);
CREATE OR REPLACE FUNCTION "public"."encrypt"(bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_encrypt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for encrypt_iv
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."encrypt_iv"(bytea, bytea, bytea, text);
CREATE OR REPLACE FUNCTION "public"."encrypt_iv"(bytea, bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_encrypt_iv'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for gen_random_bytes
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."gen_random_bytes"(int4);
CREATE OR REPLACE FUNCTION "public"."gen_random_bytes"(int4)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_random_bytes'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for gen_random_uuid
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."gen_random_uuid"();
CREATE OR REPLACE FUNCTION "public"."gen_random_uuid"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/pgcrypto', 'pg_random_uuid'
  LANGUAGE c VOLATILE
  COST 1;

-- ----------------------------
-- Function structure for gen_salt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."gen_salt"(text);
CREATE OR REPLACE FUNCTION "public"."gen_salt"(text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pg_gen_salt'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for gen_salt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."gen_salt"(text, int4);
CREATE OR REPLACE FUNCTION "public"."gen_salt"(text, int4)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pg_gen_salt_rounds'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for get_functional_posts_by_location
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_functional_posts_by_location"("lat_user" float8, "long_user" float8, "kilomiters" int4);
CREATE OR REPLACE FUNCTION "public"."get_functional_posts_by_location"("lat_user" float8, "long_user" float8, "kilomiters" int4)
  RETURNS SETOF "public"."posts" AS $BODY$
    SELECT
        P.*
    FROM
        posts P
        JOIN locations L ON P.location_id = L.id
    WHERE
        P.type != 0
        AND
        ((6371 * acos (cos(radians(lat_user)) * cos(radians( L.lat )) 
        * cos(radians(long_user) - radians(L.long)) + sin(radians(lat_user)) 
        * sin(radians(L.lat)))) <= kilomiters)
    GROUP BY
        P.id
$BODY$
  LANGUAGE sql STABLE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for get_posts_by_type
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_posts_by_type"("post_type" int4, "long_user" float8, "lat_user" float8, "mlimit" int4, "moffset" int4);
CREATE OR REPLACE FUNCTION "public"."get_posts_by_type"("post_type" int4, "long_user" float8, "lat_user" float8, "mlimit" int4, "moffset" int4)
  RETURNS SETOF "public"."posts" AS $BODY$
BEGIN
	RETURN QUERY SELECT P.* FROM posts P JOIN locations L ON P.location_id = L.id
	WHERE (L.long BETWEEN long_user-0.03 AND long_user+0.03) AND (L.lat BETWEEN lat_user-0.03 AND lat_user+0.03) AND P.type=post_type GROUP BY P.id LiMIT mlimit OFFSET moffset;
END
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for hmac
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hmac"(bytea, bytea, text);
CREATE OR REPLACE FUNCTION "public"."hmac"(bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_hmac'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for hmac
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."hmac"(text, text, text);
CREATE OR REPLACE FUNCTION "public"."hmac"(text, text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_hmac'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for ilike
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."ilike"("idpost" int4, "iduser" int4);
CREATE OR REPLACE FUNCTION "public"."ilike"("idpost" int4, "iduser" int4)
  RETURNS "pg_catalog"."bool" AS $BODY$
BEGIN
  RETURN EXISTS (
    SELECT *
    FROM post_reacts
    WHERE post_reacts.post_id = idpost 
         AND post_reacts.reactor_id = iduser    -- <<-- this looks nonsensical
        );
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for is_my_post
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."is_my_post"("post_row" "public"."posts", "hasura_session" json);
CREATE OR REPLACE FUNCTION "public"."is_my_post"("post_row" "public"."posts", "hasura_session" json)
  RETURNS "pg_catalog"."bool" AS $BODY$
SELECT post_row.creator_uuid =  cast(hasura_session ->> 'x-hasura-user-id' as varchar)
$BODY$
  LANGUAGE sql STABLE
  COST 100;

-- ----------------------------
-- Function structure for pgp_armor_headers
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_armor_headers"(text, OUT "key" text, OUT "value" text);
CREATE OR REPLACE FUNCTION "public"."pgp_armor_headers"(IN text, OUT "key" text, OUT "value" text)
  RETURNS SETOF "pg_catalog"."record" AS '$libdir/pgcrypto', 'pgp_armor_headers'
  LANGUAGE c IMMUTABLE STRICT
  COST 1
  ROWS 1000;

-- ----------------------------
-- Function structure for pgp_key_id
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_key_id"(bytea);
CREATE OR REPLACE FUNCTION "public"."pgp_key_id"(bytea)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pgp_key_id_w'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_decrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_pub_decrypt"(bytea, bytea, text, text);
CREATE OR REPLACE FUNCTION "public"."pgp_pub_decrypt"(bytea, bytea, text, text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_decrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_pub_decrypt"(bytea, bytea, text);
CREATE OR REPLACE FUNCTION "public"."pgp_pub_decrypt"(bytea, bytea, text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_decrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_pub_decrypt"(bytea, bytea);
CREATE OR REPLACE FUNCTION "public"."pgp_pub_decrypt"(bytea, bytea)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_decrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_pub_decrypt_bytea"(bytea, bytea, text, text);
CREATE OR REPLACE FUNCTION "public"."pgp_pub_decrypt_bytea"(bytea, bytea, text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_decrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_pub_decrypt_bytea"(bytea, bytea, text);
CREATE OR REPLACE FUNCTION "public"."pgp_pub_decrypt_bytea"(bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_decrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_pub_decrypt_bytea"(bytea, bytea);
CREATE OR REPLACE FUNCTION "public"."pgp_pub_decrypt_bytea"(bytea, bytea)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_encrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_pub_encrypt"(text, bytea, text);
CREATE OR REPLACE FUNCTION "public"."pgp_pub_encrypt"(text, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_encrypt_text'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_encrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_pub_encrypt"(text, bytea);
CREATE OR REPLACE FUNCTION "public"."pgp_pub_encrypt"(text, bytea)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_encrypt_text'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_encrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_pub_encrypt_bytea"(bytea, bytea, text);
CREATE OR REPLACE FUNCTION "public"."pgp_pub_encrypt_bytea"(bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_encrypt_bytea'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_encrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_pub_encrypt_bytea"(bytea, bytea);
CREATE OR REPLACE FUNCTION "public"."pgp_pub_encrypt_bytea"(bytea, bytea)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_encrypt_bytea'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_decrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_sym_decrypt"(bytea, text, text);
CREATE OR REPLACE FUNCTION "public"."pgp_sym_decrypt"(bytea, text, text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pgp_sym_decrypt_text'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_decrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_sym_decrypt"(bytea, text);
CREATE OR REPLACE FUNCTION "public"."pgp_sym_decrypt"(bytea, text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pgp_sym_decrypt_text'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_decrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_sym_decrypt_bytea"(bytea, text);
CREATE OR REPLACE FUNCTION "public"."pgp_sym_decrypt_bytea"(bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_sym_decrypt_bytea'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_decrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_sym_decrypt_bytea"(bytea, text, text);
CREATE OR REPLACE FUNCTION "public"."pgp_sym_decrypt_bytea"(bytea, text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_sym_decrypt_bytea'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_encrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_sym_encrypt"(text, text);
CREATE OR REPLACE FUNCTION "public"."pgp_sym_encrypt"(text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_sym_encrypt_text'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_encrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_sym_encrypt"(text, text, text);
CREATE OR REPLACE FUNCTION "public"."pgp_sym_encrypt"(text, text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_sym_encrypt_text'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_encrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_sym_encrypt_bytea"(bytea, text, text);
CREATE OR REPLACE FUNCTION "public"."pgp_sym_encrypt_bytea"(bytea, text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_sym_encrypt_bytea'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_encrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."pgp_sym_encrypt_bytea"(bytea, text);
CREATE OR REPLACE FUNCTION "public"."pgp_sym_encrypt_bytea"(bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_sym_encrypt_bytea'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for post_liked_by_user
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."post_liked_by_user"("post_row" "public"."posts", "hasura_session" json);
CREATE OR REPLACE FUNCTION "public"."post_liked_by_user"("post_row" "public"."posts", "hasura_session" json)
  RETURNS "pg_catalog"."bool" AS $BODY$
SELECT EXISTS (
    SELECT 1
    FROM post_reacts A
    WHERE A.reactor_uuid = cast(hasura_session ->> 'x-hasura-user-id' as varchar) AND A.post_id = post_row.id
);
$BODY$
  LANGUAGE sql STABLE
  COST 100;

-- ----------------------------
-- Function structure for set_current_timestamp_updated_at
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."set_current_timestamp_updated_at"();
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for user_following_pet
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."user_following_pet"("pet_row" "public"."pets", "hasura_session" json);
CREATE OR REPLACE FUNCTION "public"."user_following_pet"("pet_row" "public"."pets", "hasura_session" json)
  RETURNS "pg_catalog"."bool" AS $BODY$
SELECT EXISTS (
    SELECT 1
    FROM follows A
    WHERE A.user_uuid = cast(hasura_session ->> 'x-hasura-user-id' as varchar) AND A.pet_id = pet_row.id
);
$BODY$
  LANGUAGE sql STABLE
  COST 100;

-- ----------------------------
-- Function structure for user_liked_comment
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."user_liked_comment"("comment_row" "public"."comments", "hasura_session" json);
CREATE OR REPLACE FUNCTION "public"."user_liked_comment"("comment_row" "public"."comments", "hasura_session" json)
  RETURNS "pg_catalog"."bool" AS $BODY$
SELECT EXISTS (
    SELECT 1
    FROM comment_react A
    WHERE A.reactor_uuid = cast(hasura_session ->> 'x-hasura-user-id' as varchar) AND A.comment_id = comment_row.id
);
$BODY$
  LANGUAGE sql STABLE
  COST 100;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."comment_tag_user_id_seq"
OWNED BY "public"."comment_tag_user"."id";
SELECT setval('"public"."comment_tag_user_id_seq"', 57, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."comments_id_seq"
OWNED BY "public"."comments"."id";
SELECT setval('"public"."comments_id_seq"', 207, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."follows_id_seq"
OWNED BY "public"."follows"."id";
SELECT setval('"public"."follows_id_seq"', 70, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."locations_id_seq"
OWNED BY "public"."locations"."id";
SELECT setval('"public"."locations_id_seq"', 105, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."media_id_seq"
OWNED BY "public"."medias"."id";
SELECT setval('"public"."media_id_seq"', 328, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."notification_id_seq"
OWNED BY "public"."notifications"."id";
SELECT setval('"public"."notification_id_seq"', 290, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."pet_breeds_id_seq"
OWNED BY "public"."pet_breeds"."id";
SELECT setval('"public"."pet_breeds_id_seq"', 62, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."pet_owners_id_seq"
OWNED BY "public"."pet_owners"."id";
SELECT setval('"public"."pet_owners_id_seq"', 107, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."pet_services_id_seq"
OWNED BY "public"."pet_services"."id";
SELECT setval('"public"."pet_services_id_seq"', 14, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."pet_vaccinateds_id_seq"
OWNED BY "public"."pet_vaccinateds"."id";
SELECT setval('"public"."pet_vaccinateds_id_seq"', 18, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."pet_weights_id_seq"
OWNED BY "public"."pet_weights"."id";
SELECT setval('"public"."pet_weights_id_seq"', 123, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."pet_worm_flusheds_id_seq"
OWNED BY "public"."pet_worm_flusheds"."id";
SELECT setval('"public"."pet_worm_flusheds_id_seq"', 39, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."pets_id_seq"
OWNED BY "public"."pets"."id";
SELECT setval('"public"."pets_id_seq"', 120, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."post_reacts_id_seq"
OWNED BY "public"."post_reacts"."id";
SELECT setval('"public"."post_reacts_id_seq"', 319, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."posts_id_seq"
OWNED BY "public"."posts"."id";
SELECT setval('"public"."posts_id_seq"', 257, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."report_post_id_seq"
OWNED BY "public"."report_post"."id";
SELECT setval('"public"."report_post_id_seq"', 11, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."request_contact_id_seq"
OWNED BY "public"."request_contact"."id";
SELECT setval('"public"."request_contact_id_seq"', 20, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."settings_id_seq"
OWNED BY "public"."settings"."id";
SELECT setval('"public"."settings_id_seq"', 5, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."users_id_seq"
OWNED BY "public"."users"."id";
SELECT setval('"public"."users_id_seq"', 74, true);

-- ----------------------------
-- Triggers structure for table comment_react
-- ----------------------------
CREATE TRIGGER "notify_hasura_notify_like_comment_INSERT" AFTER INSERT ON "public"."comment_react"
FOR EACH ROW
EXECUTE PROCEDURE "hdb_catalog"."notify_hasura_notify_like_comment_INSERT"();

-- ----------------------------
-- Primary Key structure for table comment_react
-- ----------------------------
ALTER TABLE "public"."comment_react" ADD CONSTRAINT "comment_react_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table comment_tag_user
-- ----------------------------
CREATE TRIGGER "notify_hasura_nofity_tag_user_comment_INSERT" AFTER INSERT ON "public"."comment_tag_user"
FOR EACH ROW
EXECUTE PROCEDURE "hdb_catalog"."notify_hasura_nofity_tag_user_comment_INSERT"();

-- ----------------------------
-- Primary Key structure for table comment_tag_user
-- ----------------------------
ALTER TABLE "public"."comment_tag_user" ADD CONSTRAINT "comment_tag_user_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table comments
-- ----------------------------
CREATE INDEX "index_creator_uuid_in_comment" ON "public"."comments" USING hash (
  "creator_uuid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops"
);
CREATE INDEX "index_post_id_in_comment" ON "public"."comments" USING hash (
  "post_id" "pg_catalog"."int4_ops"
);

-- ----------------------------
-- Triggers structure for table comments
-- ----------------------------
CREATE TRIGGER "notify_hasura_notify_comment_post_INSERT" AFTER INSERT ON "public"."comments"
FOR EACH ROW
EXECUTE PROCEDURE "hdb_catalog"."notify_hasura_notify_comment_post_INSERT"();
CREATE TRIGGER "set_public_comments_updated_at" BEFORE UPDATE ON "public"."comments"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_comments_updated_at" ON "public"."comments" IS 'trigger to set value of column "updated_at" to current timestamp on row update';

-- ----------------------------
-- Primary Key structure for table comments
-- ----------------------------
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table follows
-- ----------------------------
CREATE TRIGGER "notify_hasura_follow_pet_INSERT" AFTER INSERT ON "public"."follows"
FOR EACH ROW
EXECUTE PROCEDURE "hdb_catalog"."notify_hasura_follow_pet_INSERT"();
CREATE TRIGGER "notify_hasura_notify_follow_pet_INSERT" AFTER INSERT ON "public"."follows"
FOR EACH ROW
EXECUTE PROCEDURE "hdb_catalog"."notify_hasura_notify_follow_pet_INSERT"();

-- ----------------------------
-- Primary Key structure for table follows
-- ----------------------------
ALTER TABLE "public"."follows" ADD CONSTRAINT "follows_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table locations
-- ----------------------------
CREATE INDEX "index_long_lat" ON "public"."locations" USING btree (
  "long" "pg_catalog"."float8_ops" ASC NULLS LAST,
  "lat" "pg_catalog"."float8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table locations
-- ----------------------------
CREATE TRIGGER "set_public_locations_updated_at" BEFORE UPDATE ON "public"."locations"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_locations_updated_at" ON "public"."locations" IS 'trigger to set value of column "updated_at" to current timestamp on row update';

-- ----------------------------
-- Primary Key structure for table locations
-- ----------------------------
ALTER TABLE "public"."locations" ADD CONSTRAINT "locations_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table medias
-- ----------------------------
CREATE TRIGGER "notify_hasura_on_media_deleted_DELETE" AFTER DELETE ON "public"."medias"
FOR EACH ROW
EXECUTE PROCEDURE "hdb_catalog"."notify_hasura_on_media_deleted_DELETE"();

-- ----------------------------
-- Primary Key structure for table medias
-- ----------------------------
ALTER TABLE "public"."medias" ADD CONSTRAINT "media_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table notifications
-- ----------------------------
CREATE TRIGGER "set_public_notification_updated_at" BEFORE UPDATE ON "public"."notifications"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_notification_updated_at" ON "public"."notifications" IS 'trigger to set value of column "updated_at" to current timestamp on row update';

-- ----------------------------
-- Primary Key structure for table notifications
-- ----------------------------
ALTER TABLE "public"."notifications" ADD CONSTRAINT "notification_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table pet_breeds
-- ----------------------------
ALTER TABLE "public"."pet_breeds" ADD CONSTRAINT "pet_breeds_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table pet_owners
-- ----------------------------
ALTER TABLE "public"."pet_owners" ADD CONSTRAINT "pet_owners_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table pet_services
-- ----------------------------
ALTER TABLE "public"."pet_services" ADD CONSTRAINT "pet_services_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table pet_types
-- ----------------------------
ALTER TABLE "public"."pet_types" ADD CONSTRAINT "pet_types_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table pet_vaccinateds
-- ----------------------------
CREATE TRIGGER "set_public_pet_vaccinateds_updated_at" BEFORE UPDATE ON "public"."pet_vaccinateds"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_pet_vaccinateds_updated_at" ON "public"."pet_vaccinateds" IS 'trigger to set value of column "updated_at" to current timestamp on row update';

-- ----------------------------
-- Primary Key structure for table pet_vaccinateds
-- ----------------------------
ALTER TABLE "public"."pet_vaccinateds" ADD CONSTRAINT "pet_vaccinateds_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table pet_weights
-- ----------------------------
CREATE TRIGGER "set_public_pet_weights_updated_at" BEFORE UPDATE ON "public"."pet_weights"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_pet_weights_updated_at" ON "public"."pet_weights" IS 'trigger to set value of column "updated_at" to current timestamp on row update';

-- ----------------------------
-- Primary Key structure for table pet_weights
-- ----------------------------
ALTER TABLE "public"."pet_weights" ADD CONSTRAINT "pet_weights_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table pet_worm_flusheds
-- ----------------------------
CREATE TRIGGER "set_public_pet_worm_flusheds_updated_at" BEFORE UPDATE ON "public"."pet_worm_flusheds"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_pet_worm_flusheds_updated_at" ON "public"."pet_worm_flusheds" IS 'trigger to set value of column "updated_at" to current timestamp on row update';

-- ----------------------------
-- Primary Key structure for table pet_worm_flusheds
-- ----------------------------
ALTER TABLE "public"."pet_worm_flusheds" ADD CONSTRAINT "pet_worm_flusheds_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table pets
-- ----------------------------
CREATE INDEX "index_name_pet" ON "public"."pets" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table pets
-- ----------------------------
ALTER TABLE "public"."pets" ADD CONSTRAINT "pets_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table post_pet
-- ----------------------------
CREATE INDEX "index_pet" ON "public"."post_pet" USING hash (
  "pet_id" "pg_catalog"."int4_ops"
);
CREATE INDEX "index_post_in_post_pet" ON "public"."post_pet" USING hash (
  "post_id" "pg_catalog"."int4_ops"
);

-- ----------------------------
-- Primary Key structure for table post_pet
-- ----------------------------
ALTER TABLE "public"."post_pet" ADD CONSTRAINT "post_pet_pkey" PRIMARY KEY ("pet_id", "post_id");

-- ----------------------------
-- Triggers structure for table post_reacts
-- ----------------------------
CREATE TRIGGER "notify_hasura_notify_like_post_INSERT" AFTER INSERT ON "public"."post_reacts"
FOR EACH ROW
EXECUTE PROCEDURE "hdb_catalog"."notify_hasura_notify_like_post_INSERT"();

-- ----------------------------
-- Uniques structure for table post_reacts
-- ----------------------------
ALTER TABLE "public"."post_reacts" ADD CONSTRAINT "post_reacts_reactor_uuid_post_id_mating_pet_id_key" UNIQUE ("reactor_uuid", "post_id", "mating_pet_id");

-- ----------------------------
-- Primary Key structure for table post_reacts
-- ----------------------------
ALTER TABLE "public"."post_reacts" ADD CONSTRAINT "post_reacts_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table posts
-- ----------------------------
CREATE INDEX "index_creator_uuid_in_post" ON "public"."posts" USING hash (
  "creator_uuid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops"
);

-- ----------------------------
-- Triggers structure for table posts
-- ----------------------------
CREATE TRIGGER "notify_hasura_notify_lost_pet_INSERT" AFTER INSERT ON "public"."posts"
FOR EACH ROW
EXECUTE PROCEDURE "hdb_catalog"."notify_hasura_notify_lost_pet_INSERT"();

-- ----------------------------
-- Uniques structure for table posts
-- ----------------------------
ALTER TABLE "public"."posts" ADD CONSTRAINT "posts_uuid_key" UNIQUE ("uuid");

-- ----------------------------
-- Primary Key structure for table posts
-- ----------------------------
ALTER TABLE "public"."posts" ADD CONSTRAINT "posts_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table report_comment
-- ----------------------------
CREATE TRIGGER "set_public_report_post_updated_at" BEFORE UPDATE ON "public"."report_comment"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_report_post_updated_at" ON "public"."report_comment" IS 'trigger to set value of column "updated_at" to current timestamp on row update';

-- ----------------------------
-- Primary Key structure for table report_comment
-- ----------------------------
ALTER TABLE "public"."report_comment" ADD CONSTRAINT "report_post_copy1_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table report_post
-- ----------------------------
CREATE TRIGGER "set_public_report_post_updated_at" BEFORE UPDATE ON "public"."report_post"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_report_post_updated_at" ON "public"."report_post" IS 'trigger to set value of column "updated_at" to current timestamp on row update';

-- ----------------------------
-- Primary Key structure for table report_post
-- ----------------------------
ALTER TABLE "public"."report_post" ADD CONSTRAINT "report_post_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table request_contact
-- ----------------------------
CREATE TRIGGER "notify_hasura_notify_new_request_mesage_INSERT" AFTER INSERT ON "public"."request_contact"
FOR EACH ROW
EXECUTE PROCEDURE "hdb_catalog"."notify_hasura_notify_new_request_mesage_INSERT"();
CREATE TRIGGER "set_public_request_contact_updated_at" BEFORE UPDATE ON "public"."request_contact"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_request_contact_updated_at" ON "public"."request_contact" IS 'trigger to set value of column "updated_at" to current timestamp on row update';

-- ----------------------------
-- Primary Key structure for table request_contact
-- ----------------------------
ALTER TABLE "public"."request_contact" ADD CONSTRAINT "request_contact_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table settings
-- ----------------------------
CREATE TRIGGER "set_public_settings_updated_at" BEFORE UPDATE ON "public"."settings"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_settings_updated_at" ON "public"."settings" IS 'trigger to set value of column "updated_at" to current timestamp on row update';

-- ----------------------------
-- Primary Key structure for table settings
-- ----------------------------
ALTER TABLE "public"."settings" ADD CONSTRAINT "settings_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table users
-- ----------------------------
CREATE INDEX "index_uuid_in_user" ON "public"."users" USING hash (
  "uuid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops"
);

-- ----------------------------
-- Uniques structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_uuid_key" UNIQUE ("uuid");

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table comment_react
-- ----------------------------
ALTER TABLE "public"."comment_react" ADD CONSTRAINT "comment_react_comment_id_fkey" FOREIGN KEY ("comment_id") REFERENCES "public"."comments" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."comment_react" ADD CONSTRAINT "comment_react_reactor_uuid_fkey" FOREIGN KEY ("reactor_uuid") REFERENCES "public"."users" ("uuid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table comment_tag_user
-- ----------------------------
ALTER TABLE "public"."comment_tag_user" ADD CONSTRAINT "comment_tag_user_comment_id_fkey" FOREIGN KEY ("comment_id") REFERENCES "public"."comments" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE "public"."comment_tag_user" ADD CONSTRAINT "comment_tag_user_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table comments
-- ----------------------------
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_creator_uuid_fkey" FOREIGN KEY ("creator_uuid") REFERENCES "public"."users" ("uuid") ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table follows
-- ----------------------------
ALTER TABLE "public"."follows" ADD CONSTRAINT "follows_pet_id_fkey" FOREIGN KEY ("pet_id") REFERENCES "public"."pets" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE "public"."follows" ADD CONSTRAINT "follows_user_uuid_fkey" FOREIGN KEY ("user_uuid") REFERENCES "public"."users" ("uuid") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table medias
-- ----------------------------
ALTER TABLE "public"."medias" ADD CONSTRAINT "medias_id_post_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table notifications
-- ----------------------------
ALTER TABLE "public"."notifications" ADD CONSTRAINT "notification_pet_id_fkey" FOREIGN KEY ("pet_id") REFERENCES "public"."pets" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE "public"."notifications" ADD CONSTRAINT "notification_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE "public"."notifications" ADD CONSTRAINT "notifications_actor_uuid_fkey" FOREIGN KEY ("actor_uuid") REFERENCES "public"."users" ("uuid") ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE "public"."notifications" ADD CONSTRAINT "notifications_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table pet_breeds
-- ----------------------------
ALTER TABLE "public"."pet_breeds" ADD CONSTRAINT "pet_breeds_id_pet_type_fkey" FOREIGN KEY ("id_pet_type") REFERENCES "public"."pet_types" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table pet_owners
-- ----------------------------
ALTER TABLE "public"."pet_owners" ADD CONSTRAINT "pet_owners_owner_uuid_fkey" FOREIGN KEY ("owner_uuid") REFERENCES "public"."users" ("uuid") ON DELETE NO ACTION ON UPDATE RESTRICT;
ALTER TABLE "public"."pet_owners" ADD CONSTRAINT "pet_owners_pet_id_fkey" FOREIGN KEY ("pet_id") REFERENCES "public"."pets" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table pet_services
-- ----------------------------
ALTER TABLE "public"."pet_services" ADD CONSTRAINT "pet_services_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "public"."locations" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table pet_vaccinateds
-- ----------------------------
ALTER TABLE "public"."pet_vaccinateds" ADD CONSTRAINT "pet_vaccinateds_pet_id_fkey" FOREIGN KEY ("pet_id") REFERENCES "public"."pets" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table pet_weights
-- ----------------------------
ALTER TABLE "public"."pet_weights" ADD CONSTRAINT "pet_weights_pet_id_fkey" FOREIGN KEY ("pet_id") REFERENCES "public"."pets" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table pet_worm_flusheds
-- ----------------------------
ALTER TABLE "public"."pet_worm_flusheds" ADD CONSTRAINT "pet_worm_flusheds_pet_id_fkey" FOREIGN KEY ("pet_id") REFERENCES "public"."pets" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table pets
-- ----------------------------
ALTER TABLE "public"."pets" ADD CONSTRAINT "pets_avatar_fkey" FOREIGN KEY ("avatar_id") REFERENCES "public"."medias" ("id") ON DELETE SET NULL ON UPDATE RESTRICT;
ALTER TABLE "public"."pets" ADD CONSTRAINT "pets_current_owner_uuid_fkey" FOREIGN KEY ("current_owner_uuid") REFERENCES "public"."users" ("uuid") ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE "public"."pets" ADD CONSTRAINT "pets_father_id_fkey" FOREIGN KEY ("father_id") REFERENCES "public"."pets" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE "public"."pets" ADD CONSTRAINT "pets_id_pet_breed_fkey" FOREIGN KEY ("pet_breed_id") REFERENCES "public"."pet_breeds" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE "public"."pets" ADD CONSTRAINT "pets_id_pet_type_fkey" FOREIGN KEY ("pet_type_id") REFERENCES "public"."pet_types" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE "public"."pets" ADD CONSTRAINT "pets_mother_id_fkey" FOREIGN KEY ("mother_id") REFERENCES "public"."pets" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table post_pet
-- ----------------------------
ALTER TABLE "public"."post_pet" ADD CONSTRAINT "post_pet_pet_id_fkey" FOREIGN KEY ("pet_id") REFERENCES "public"."pets" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE "public"."post_pet" ADD CONSTRAINT "post_pet_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table post_reacts
-- ----------------------------
ALTER TABLE "public"."post_reacts" ADD CONSTRAINT "post_reacts_mating_pet_id_fkey" FOREIGN KEY ("mating_pet_id") REFERENCES "public"."pets" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE "public"."post_reacts" ADD CONSTRAINT "post_reacts_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE "public"."post_reacts" ADD CONSTRAINT "post_reacts_reactor_uuid_fkey" FOREIGN KEY ("reactor_uuid") REFERENCES "public"."users" ("uuid") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table posts
-- ----------------------------
ALTER TABLE "public"."posts" ADD CONSTRAINT "posts_creator_uuid_fkey" FOREIGN KEY ("creator_uuid") REFERENCES "public"."users" ("uuid") ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE "public"."posts" ADD CONSTRAINT "posts_location_fkey" FOREIGN KEY ("location_id") REFERENCES "public"."locations" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table report_comment
-- ----------------------------
ALTER TABLE "public"."report_comment" ADD CONSTRAINT "report_post_copy1_creator_uuid_fkey" FOREIGN KEY ("creator_uuid") REFERENCES "public"."users" ("uuid") ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE "public"."report_comment" ADD CONSTRAINT "report_post_copy1_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table report_post
-- ----------------------------
ALTER TABLE "public"."report_post" ADD CONSTRAINT "report_post_creator_uuid_fkey" FOREIGN KEY ("creator_uuid") REFERENCES "public"."users" ("uuid") ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE "public"."report_post" ADD CONSTRAINT "report_post_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts" ("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table request_contact
-- ----------------------------
ALTER TABLE "public"."request_contact" ADD CONSTRAINT "request_contact_from_user_uuid_fkey" FOREIGN KEY ("from_user_uuid") REFERENCES "public"."users" ("uuid") ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE "public"."request_contact" ADD CONSTRAINT "request_contact_to_user_uuid_fkey" FOREIGN KEY ("to_user_uuid") REFERENCES "public"."users" ("uuid") ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_avatar_id_fkey" FOREIGN KEY ("avatar_id") REFERENCES "public"."medias" ("id") ON DELETE SET NULL ON UPDATE RESTRICT;
ALTER TABLE "public"."users" ADD CONSTRAINT "users_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "public"."locations" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE "public"."users" ADD CONSTRAINT "users_setting_id_fkey" FOREIGN KEY ("setting_id") REFERENCES "public"."settings" ("id") ON DELETE SET NULL ON UPDATE RESTRICT;
