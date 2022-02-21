/*
 Navicat Premium Data Transfer

 Source Server         : hasura
 Source Server Type    : PostgreSQL
 Source Server Version : 120007
 Source Host           : 103.195.238.188:22032
 Source Catalog        : postgres
 Source Schema         : hdb_catalog

 Target Server Type    : PostgreSQL
 Target Server Version : 120007
 File Encoding         : 65001

 Date: 25/09/2021 19:37:38
*/


-- ----------------------------
-- Table structure for event_invocation_logs
-- ----------------------------
DROP TABLE IF EXISTS "hdb_catalog"."event_invocation_logs";
CREATE TABLE "hdb_catalog"."event_invocation_logs" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT hdb_catalog.gen_hasura_uuid(),
  "event_id" text COLLATE "pg_catalog"."default",
  "status" int4,
  "request" json,
  "response" json,
  "created_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for event_log
-- ----------------------------
DROP TABLE IF EXISTS "hdb_catalog"."event_log";
CREATE TABLE "hdb_catalog"."event_log" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT hdb_catalog.gen_hasura_uuid(),
  "schema_name" text COLLATE "pg_catalog"."default" NOT NULL,
  "table_name" text COLLATE "pg_catalog"."default" NOT NULL,
  "trigger_name" text COLLATE "pg_catalog"."default" NOT NULL,
  "payload" jsonb NOT NULL,
  "delivered" bool NOT NULL DEFAULT false,
  "error" bool NOT NULL DEFAULT false,
  "tries" int4 NOT NULL DEFAULT 0,
  "created_at" timestamp(6) DEFAULT now(),
  "locked" timestamptz(6),
  "next_retry_at" timestamp(6),
  "archived" bool NOT NULL DEFAULT false
)
;

-- ----------------------------
-- Table structure for hdb_action_log
-- ----------------------------
DROP TABLE IF EXISTS "hdb_catalog"."hdb_action_log";
CREATE TABLE "hdb_catalog"."hdb_action_log" (
  "id" uuid NOT NULL DEFAULT hdb_catalog.gen_hasura_uuid(),
  "action_name" text COLLATE "pg_catalog"."default",
  "input_payload" jsonb NOT NULL,
  "request_headers" jsonb NOT NULL,
  "session_variables" jsonb NOT NULL,
  "response_payload" jsonb,
  "errors" jsonb,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "response_received_at" timestamptz(6),
  "status" text COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Table structure for hdb_cron_event_invocation_logs
-- ----------------------------
DROP TABLE IF EXISTS "hdb_catalog"."hdb_cron_event_invocation_logs";
CREATE TABLE "hdb_catalog"."hdb_cron_event_invocation_logs" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT hdb_catalog.gen_hasura_uuid(),
  "event_id" text COLLATE "pg_catalog"."default",
  "status" int4,
  "request" json,
  "response" json,
  "created_at" timestamptz(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for hdb_cron_events
-- ----------------------------
DROP TABLE IF EXISTS "hdb_catalog"."hdb_cron_events";
CREATE TABLE "hdb_catalog"."hdb_cron_events" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT hdb_catalog.gen_hasura_uuid(),
  "trigger_name" text COLLATE "pg_catalog"."default" NOT NULL,
  "scheduled_time" timestamptz(6) NOT NULL,
  "status" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'scheduled'::text,
  "tries" int4 NOT NULL DEFAULT 0,
  "created_at" timestamptz(6) DEFAULT now(),
  "next_retry_at" timestamptz(6)
)
;

-- ----------------------------
-- Table structure for hdb_metadata
-- ----------------------------
DROP TABLE IF EXISTS "hdb_catalog"."hdb_metadata";
CREATE TABLE "hdb_catalog"."hdb_metadata" (
  "id" int4 NOT NULL,
  "metadata" json NOT NULL,
  "resource_version" int4 NOT NULL DEFAULT 1
)
;

-- ----------------------------
-- Table structure for hdb_scheduled_event_invocation_logs
-- ----------------------------
DROP TABLE IF EXISTS "hdb_catalog"."hdb_scheduled_event_invocation_logs";
CREATE TABLE "hdb_catalog"."hdb_scheduled_event_invocation_logs" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT hdb_catalog.gen_hasura_uuid(),
  "event_id" text COLLATE "pg_catalog"."default",
  "status" int4,
  "request" json,
  "response" json,
  "created_at" timestamptz(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for hdb_scheduled_events
-- ----------------------------
DROP TABLE IF EXISTS "hdb_catalog"."hdb_scheduled_events";
CREATE TABLE "hdb_catalog"."hdb_scheduled_events" (
  "id" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT hdb_catalog.gen_hasura_uuid(),
  "webhook_conf" json NOT NULL,
  "scheduled_time" timestamptz(6) NOT NULL,
  "retry_conf" json,
  "payload" json,
  "header_conf" json,
  "status" text COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'scheduled'::text,
  "tries" int4 NOT NULL DEFAULT 0,
  "created_at" timestamptz(6) DEFAULT now(),
  "next_retry_at" timestamptz(6),
  "comment" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for hdb_schema_notifications
-- ----------------------------
DROP TABLE IF EXISTS "hdb_catalog"."hdb_schema_notifications";
CREATE TABLE "hdb_catalog"."hdb_schema_notifications" (
  "id" int4 NOT NULL,
  "notification" json NOT NULL,
  "resource_version" int4 NOT NULL DEFAULT 1,
  "instance_id" uuid NOT NULL,
  "updated_at" timestamptz(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for hdb_source_catalog_version
-- ----------------------------
DROP TABLE IF EXISTS "hdb_catalog"."hdb_source_catalog_version";
CREATE TABLE "hdb_catalog"."hdb_source_catalog_version" (
  "version" text COLLATE "pg_catalog"."default" NOT NULL,
  "upgraded_on" timestamptz(6) NOT NULL
)
;

-- ----------------------------
-- Table structure for hdb_version
-- ----------------------------
DROP TABLE IF EXISTS "hdb_catalog"."hdb_version";
CREATE TABLE "hdb_catalog"."hdb_version" (
  "hasura_uuid" uuid NOT NULL DEFAULT hdb_catalog.gen_hasura_uuid(),
  "version" text COLLATE "pg_catalog"."default" NOT NULL,
  "upgraded_on" timestamptz(6) NOT NULL,
  "cli_state" jsonb NOT NULL DEFAULT '{}'::jsonb,
  "console_state" jsonb NOT NULL DEFAULT '{}'::jsonb
)
;

-- ----------------------------
-- Function structure for armor
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."armor"(bytea);
CREATE OR REPLACE FUNCTION "hdb_catalog"."armor"(bytea)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pg_armor'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for armor
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."armor"(bytea, _text, _text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."armor"(bytea, _text, _text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pg_armor'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for crypt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."crypt"(text, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."crypt"(text, text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pg_crypt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for dearmor
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."dearmor"(text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."dearmor"(text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_dearmor'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for decrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."decrypt"(bytea, bytea, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."decrypt"(bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_decrypt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for decrypt_iv
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."decrypt_iv"(bytea, bytea, bytea, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."decrypt_iv"(bytea, bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_decrypt_iv'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for digest
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."digest"(text, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."digest"(text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_digest'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for digest
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."digest"(bytea, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."digest"(bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_digest'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for encrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."encrypt"(bytea, bytea, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."encrypt"(bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_encrypt'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for encrypt_iv
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."encrypt_iv"(bytea, bytea, bytea, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."encrypt_iv"(bytea, bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_encrypt_iv'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for gen_hasura_uuid
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."gen_hasura_uuid"();
CREATE OR REPLACE FUNCTION "hdb_catalog"."gen_hasura_uuid"()
  RETURNS "pg_catalog"."uuid" AS $BODY$select gen_random_uuid()$BODY$
  LANGUAGE sql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for gen_random_bytes
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."gen_random_bytes"(int4);
CREATE OR REPLACE FUNCTION "hdb_catalog"."gen_random_bytes"(int4)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_random_bytes'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for gen_random_uuid
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."gen_random_uuid"();
CREATE OR REPLACE FUNCTION "hdb_catalog"."gen_random_uuid"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/pgcrypto', 'pg_random_uuid'
  LANGUAGE c VOLATILE
  COST 1;

-- ----------------------------
-- Function structure for gen_salt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."gen_salt"(text, int4);
CREATE OR REPLACE FUNCTION "hdb_catalog"."gen_salt"(text, int4)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pg_gen_salt_rounds'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for gen_salt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."gen_salt"(text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."gen_salt"(text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pg_gen_salt'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for hmac
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."hmac"(bytea, bytea, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."hmac"(bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_hmac'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for hmac
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."hmac"(text, text, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."hmac"(text, text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pg_hmac'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for insert_event_log
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."insert_event_log"("schema_name" text, "table_name" text, "trigger_name" text, "op" text, "row_data" json);
CREATE OR REPLACE FUNCTION "hdb_catalog"."insert_event_log"("schema_name" text, "table_name" text, "trigger_name" text, "op" text, "row_data" json)
  RETURNS "pg_catalog"."text" AS $BODY$
  DECLARE
    id text;
    payload json;
    session_variables json;
    server_version_num int;
    trace_context json;
  BEGIN
    id := gen_random_uuid();
    server_version_num := current_setting('server_version_num');
    IF server_version_num >= 90600 THEN
      session_variables := current_setting('hasura.user', 't');
      trace_context := current_setting('hasura.tracecontext', 't');
    ELSE
      BEGIN
        session_variables := current_setting('hasura.user');
      EXCEPTION WHEN OTHERS THEN
                  session_variables := NULL;
      END;
      BEGIN
        trace_context := current_setting('hasura.tracecontext');
      EXCEPTION WHEN OTHERS THEN
        trace_context := NULL;
      END;
    END IF;
    payload := json_build_object(
      'op', op,
      'data', row_data,
      'session_variables', session_variables,
      'trace_context', trace_context
    );
    INSERT INTO hdb_catalog.event_log
                (id, schema_name, table_name, trigger_name, payload)
    VALUES
    (id, schema_name, table_name, trigger_name, payload);
    RETURN id;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for notify_hasura_follow_pet_INSERT
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."notify_hasura_follow_pet_INSERT"();
CREATE OR REPLACE FUNCTION "hdb_catalog"."notify_hasura_follow_pet_INSERT"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row(OLD );
      _new := row(NEW );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json(NEW )
    );
    BEGIN
    /* NOTE: formerly we used TG_TABLE_NAME in place of tableName here. However in the case of
    partitioned tables this will give the name of the partitioned table and since we use the table name to
    get the event trigger configuration from the schema, this fails because the event trigger is only created
    on the original table.  */
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
        PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('follows' AS text), CAST('follow_pet' AS text), TG_OP, _data);
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
          PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('follows' AS text), CAST('follow_pet' AS text), TG_OP, _data);
        END IF;
    END;

    RETURN NULL;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for notify_hasura_nofity_tag_user_comment_INSERT
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."notify_hasura_nofity_tag_user_comment_INSERT"();
CREATE OR REPLACE FUNCTION "hdb_catalog"."notify_hasura_nofity_tag_user_comment_INSERT"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."post_id" , OLD."comment_id" , OLD."id" , OLD."user_id"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."post_id" , NEW."comment_id" , NEW."id" , NEW."user_id"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json((SELECT  "e"  FROM  (SELECT  NEW."post_id" , NEW."comment_id" , NEW."id" , NEW."user_id"        ) AS "e"      ) )
    );
    BEGIN
    /* NOTE: formerly we used TG_TABLE_NAME in place of tableName here. However in the case of
    partitioned tables this will give the name of the partitioned table and since we use the table name to
    get the event trigger configuration from the schema, this fails because the event trigger is only created
    on the original table.  */
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
        PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('comment_tag_user' AS text), CAST('nofity_tag_user_comment' AS text), TG_OP, _data);
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
          PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('comment_tag_user' AS text), CAST('nofity_tag_user_comment' AS text), TG_OP, _data);
        END IF;
    END;

    RETURN NULL;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for notify_hasura_notify_comment_post_INSERT
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."notify_hasura_notify_comment_post_INSERT"();
CREATE OR REPLACE FUNCTION "hdb_catalog"."notify_hasura_notify_comment_post_INSERT"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."post_id" , OLD."creator_uuid" , OLD."content" , OLD."updated_at" , OLD."created_at" , OLD."id"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."post_id" , NEW."creator_uuid" , NEW."content" , NEW."updated_at" , NEW."created_at" , NEW."id"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json((SELECT  "e"  FROM  (SELECT  NEW."post_id" , NEW."creator_uuid" , NEW."content" , NEW."updated_at" , NEW."created_at" , NEW."id"        ) AS "e"      ) )
    );
    BEGIN
    /* NOTE: formerly we used TG_TABLE_NAME in place of tableName here. However in the case of
    partitioned tables this will give the name of the partitioned table and since we use the table name to
    get the event trigger configuration from the schema, this fails because the event trigger is only created
    on the original table.  */
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
        PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('comments' AS text), CAST('notify_comment_post' AS text), TG_OP, _data);
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
          PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('comments' AS text), CAST('notify_comment_post' AS text), TG_OP, _data);
        END IF;
    END;

    RETURN NULL;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for notify_hasura_notify_follow_pet_INSERT
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."notify_hasura_notify_follow_pet_INSERT"();
CREATE OR REPLACE FUNCTION "hdb_catalog"."notify_hasura_notify_follow_pet_INSERT"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."pet_id" , OLD."user_uuid" , OLD."id"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."pet_id" , NEW."user_uuid" , NEW."id"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json((SELECT  "e"  FROM  (SELECT  NEW."pet_id" , NEW."user_uuid" , NEW."id"        ) AS "e"      ) )
    );
    BEGIN
    /* NOTE: formerly we used TG_TABLE_NAME in place of tableName here. However in the case of
    partitioned tables this will give the name of the partitioned table and since we use the table name to
    get the event trigger configuration from the schema, this fails because the event trigger is only created
    on the original table.  */
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
        PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('follows' AS text), CAST('notify_follow_pet' AS text), TG_OP, _data);
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
          PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('follows' AS text), CAST('notify_follow_pet' AS text), TG_OP, _data);
        END IF;
    END;

    RETURN NULL;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for notify_hasura_notify_like_comment_INSERT
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."notify_hasura_notify_like_comment_INSERT"();
CREATE OR REPLACE FUNCTION "hdb_catalog"."notify_hasura_notify_like_comment_INSERT"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."post_id" , OLD."comment_id" , OLD."id" , OLD."reactor_uuid"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."post_id" , NEW."comment_id" , NEW."id" , NEW."reactor_uuid"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json((SELECT  "e"  FROM  (SELECT  NEW."post_id" , NEW."comment_id" , NEW."id" , NEW."reactor_uuid"        ) AS "e"      ) )
    );
    BEGIN
    /* NOTE: formerly we used TG_TABLE_NAME in place of tableName here. However in the case of
    partitioned tables this will give the name of the partitioned table and since we use the table name to
    get the event trigger configuration from the schema, this fails because the event trigger is only created
    on the original table.  */
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
        PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('comment_react' AS text), CAST('notify_like_comment' AS text), TG_OP, _data);
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
          PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('comment_react' AS text), CAST('notify_like_comment' AS text), TG_OP, _data);
        END IF;
    END;

    RETURN NULL;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for notify_hasura_notify_like_post_INSERT
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."notify_hasura_notify_like_post_INSERT"();
CREATE OR REPLACE FUNCTION "hdb_catalog"."notify_hasura_notify_like_post_INSERT"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."post_id" , OLD."mating_pet_id" , OLD."id" , OLD."reactor_uuid"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."post_id" , NEW."mating_pet_id" , NEW."id" , NEW."reactor_uuid"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json((SELECT  "e"  FROM  (SELECT  NEW."post_id" , NEW."mating_pet_id" , NEW."id" , NEW."reactor_uuid"        ) AS "e"      ) )
    );
    BEGIN
    /* NOTE: formerly we used TG_TABLE_NAME in place of tableName here. However in the case of
    partitioned tables this will give the name of the partitioned table and since we use the table name to
    get the event trigger configuration from the schema, this fails because the event trigger is only created
    on the original table.  */
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
        PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('post_reacts' AS text), CAST('notify_like_post' AS text), TG_OP, _data);
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
          PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('post_reacts' AS text), CAST('notify_like_post' AS text), TG_OP, _data);
        END IF;
    END;

    RETURN NULL;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for notify_hasura_notify_lost_pet_INSERT
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."notify_hasura_notify_lost_pet_INSERT"();
CREATE OR REPLACE FUNCTION "hdb_catalog"."notify_hasura_notify_lost_pet_INSERT"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."status" , OLD."is_closed" , OLD."uuid" , OLD."creator_uuid" , OLD."content" , OLD."location_id" , OLD."created_at" , OLD."id" , OLD."type" , OLD."additional_data"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."status" , NEW."is_closed" , NEW."uuid" , NEW."creator_uuid" , NEW."content" , NEW."location_id" , NEW."created_at" , NEW."id" , NEW."type" , NEW."additional_data"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json((SELECT  "e"  FROM  (SELECT  NEW."status" , NEW."is_closed" , NEW."uuid" , NEW."creator_uuid" , NEW."content" , NEW."location_id" , NEW."created_at" , NEW."id" , NEW."type" , NEW."additional_data"        ) AS "e"      ) )
    );
    BEGIN
    /* NOTE: formerly we used TG_TABLE_NAME in place of tableName here. However in the case of
    partitioned tables this will give the name of the partitioned table and since we use the table name to
    get the event trigger configuration from the schema, this fails because the event trigger is only created
    on the original table.  */
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
        PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('posts' AS text), CAST('notify_lost_pet' AS text), TG_OP, _data);
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
          PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('posts' AS text), CAST('notify_lost_pet' AS text), TG_OP, _data);
        END IF;
    END;

    RETURN NULL;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for notify_hasura_notify_new_request_mesage_INSERT
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."notify_hasura_notify_new_request_mesage_INSERT"();
CREATE OR REPLACE FUNCTION "hdb_catalog"."notify_hasura_notify_new_request_mesage_INSERT"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."status" , OLD."to_user_uuid" , OLD."content" , OLD."updated_at" , OLD."from_user_uuid" , OLD."created_at" , OLD."id"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."status" , NEW."to_user_uuid" , NEW."content" , NEW."updated_at" , NEW."from_user_uuid" , NEW."created_at" , NEW."id"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', NULL,
      'new', row_to_json((SELECT  "e"  FROM  (SELECT  NEW."status" , NEW."to_user_uuid" , NEW."content" , NEW."updated_at" , NEW."from_user_uuid" , NEW."created_at" , NEW."id"        ) AS "e"      ) )
    );
    BEGIN
    /* NOTE: formerly we used TG_TABLE_NAME in place of tableName here. However in the case of
    partitioned tables this will give the name of the partitioned table and since we use the table name to
    get the event trigger configuration from the schema, this fails because the event trigger is only created
    on the original table.  */
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
        PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('request_contact' AS text), CAST('notify_new_request_mesage' AS text), TG_OP, _data);
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
          PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('request_contact' AS text), CAST('notify_new_request_mesage' AS text), TG_OP, _data);
        END IF;
    END;

    RETURN NULL;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for notify_hasura_on_media_deleted_DELETE
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."notify_hasura_on_media_deleted_DELETE"();
CREATE OR REPLACE FUNCTION "hdb_catalog"."notify_hasura_on_media_deleted_DELETE"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
  DECLARE
    _old record;
    _new record;
    _data json;
  BEGIN
    IF TG_OP = 'UPDATE' THEN
      _old := row((SELECT  "e"  FROM  (SELECT  OLD."post_id" , OLD."url" , OLD."id" , OLD."type"        ) AS "e"      ) );
      _new := row((SELECT  "e"  FROM  (SELECT  NEW."post_id" , NEW."url" , NEW."id" , NEW."type"        ) AS "e"      ) );
    ELSE
    /* initialize _old and _new with dummy values for INSERT and UPDATE events*/
      _old := row((select 1));
      _new := row((select 1));
    END IF;
    _data := json_build_object(
      'old', row_to_json((SELECT  "e"  FROM  (SELECT  OLD."post_id" , OLD."url" , OLD."id" , OLD."type"        ) AS "e"      ) ),
      'new', NULL
    );
    BEGIN
    /* NOTE: formerly we used TG_TABLE_NAME in place of tableName here. However in the case of
    partitioned tables this will give the name of the partitioned table and since we use the table name to
    get the event trigger configuration from the schema, this fails because the event trigger is only created
    on the original table.  */
      IF (TG_OP <> 'UPDATE') OR (_old <> _new) THEN
        PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('medias' AS text), CAST('on_media_deleted' AS text), TG_OP, _data);
      END IF;
      EXCEPTION WHEN undefined_function THEN
        IF (TG_OP <> 'UPDATE') OR (_old *<> _new) THEN
          PERFORM hdb_catalog.insert_event_log(CAST('public' AS text), CAST('medias' AS text), CAST('on_media_deleted' AS text), TG_OP, _data);
        END IF;
    END;

    RETURN NULL;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for pgp_armor_headers
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_armor_headers"(text, OUT "key" text, OUT "value" text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_armor_headers"(IN text, OUT "key" text, OUT "value" text)
  RETURNS SETOF "pg_catalog"."record" AS '$libdir/pgcrypto', 'pgp_armor_headers'
  LANGUAGE c IMMUTABLE STRICT
  COST 1
  ROWS 1000;

-- ----------------------------
-- Function structure for pgp_key_id
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_key_id"(bytea);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_key_id"(bytea)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pgp_key_id_w'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_decrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_pub_decrypt"(bytea, bytea);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_pub_decrypt"(bytea, bytea)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_decrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_pub_decrypt"(bytea, bytea, text, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_pub_decrypt"(bytea, bytea, text, text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_decrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_pub_decrypt"(bytea, bytea, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_pub_decrypt"(bytea, bytea, text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_decrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_pub_decrypt_bytea"(bytea, bytea, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_pub_decrypt_bytea"(bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_decrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_pub_decrypt_bytea"(bytea, bytea);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_pub_decrypt_bytea"(bytea, bytea)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_decrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_pub_decrypt_bytea"(bytea, bytea, text, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_pub_decrypt_bytea"(bytea, bytea, text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_encrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_pub_encrypt"(text, bytea);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_pub_encrypt"(text, bytea)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_encrypt_text'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_encrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_pub_encrypt"(text, bytea, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_pub_encrypt"(text, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_encrypt_text'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_encrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_pub_encrypt_bytea"(bytea, bytea, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_pub_encrypt_bytea"(bytea, bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_encrypt_bytea'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_pub_encrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_pub_encrypt_bytea"(bytea, bytea);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_pub_encrypt_bytea"(bytea, bytea)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_pub_encrypt_bytea'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_decrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_sym_decrypt"(bytea, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_sym_decrypt"(bytea, text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pgp_sym_decrypt_text'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_decrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_sym_decrypt"(bytea, text, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_sym_decrypt"(bytea, text, text)
  RETURNS "pg_catalog"."text" AS '$libdir/pgcrypto', 'pgp_sym_decrypt_text'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_decrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_sym_decrypt_bytea"(bytea, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_sym_decrypt_bytea"(bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_sym_decrypt_bytea'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_decrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_sym_decrypt_bytea"(bytea, text, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_sym_decrypt_bytea"(bytea, text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_sym_decrypt_bytea'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_encrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_sym_encrypt"(text, text, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_sym_encrypt"(text, text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_sym_encrypt_text'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_encrypt
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_sym_encrypt"(text, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_sym_encrypt"(text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_sym_encrypt_text'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_encrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_sym_encrypt_bytea"(bytea, text, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_sym_encrypt_bytea"(bytea, text, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_sym_encrypt_bytea'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for pgp_sym_encrypt_bytea
-- ----------------------------
DROP FUNCTION IF EXISTS "hdb_catalog"."pgp_sym_encrypt_bytea"(bytea, text);
CREATE OR REPLACE FUNCTION "hdb_catalog"."pgp_sym_encrypt_bytea"(bytea, text)
  RETURNS "pg_catalog"."bytea" AS '$libdir/pgcrypto', 'pgp_sym_encrypt_bytea'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Indexes structure for table event_invocation_logs
-- ----------------------------
CREATE INDEX "event_invocation_logs_event_id_idx" ON "hdb_catalog"."event_invocation_logs" USING btree (
  "event_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table event_invocation_logs
-- ----------------------------
ALTER TABLE "hdb_catalog"."event_invocation_logs" ADD CONSTRAINT "event_invocation_logs_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table event_log
-- ----------------------------
CREATE INDEX "event_log_fetch_events" ON "hdb_catalog"."event_log" USING btree (
  "locked" "pg_catalog"."timestamptz_ops" ASC NULLS FIRST,
  "next_retry_at" "pg_catalog"."timestamp_ops" ASC NULLS FIRST,
  "created_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
) WHERE delivered = false AND error = false AND archived = false;
CREATE INDEX "event_log_trigger_name_idx" ON "hdb_catalog"."event_log" USING btree (
  "trigger_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table event_log
-- ----------------------------
ALTER TABLE "hdb_catalog"."event_log" ADD CONSTRAINT "event_log_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Checks structure for table hdb_action_log
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_action_log" ADD CONSTRAINT "hdb_action_log_status_check" CHECK (status = ANY (ARRAY['created'::text, 'processing'::text, 'completed'::text, 'error'::text]));

-- ----------------------------
-- Primary Key structure for table hdb_action_log
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_action_log" ADD CONSTRAINT "hdb_action_log_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table hdb_cron_event_invocation_logs
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_cron_event_invocation_logs" ADD CONSTRAINT "hdb_cron_event_invocation_logs_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table hdb_cron_events
-- ----------------------------
CREATE INDEX "hdb_cron_event_status" ON "hdb_catalog"."hdb_cron_events" USING btree (
  "status" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "hdb_cron_events_unique_scheduled" ON "hdb_catalog"."hdb_cron_events" USING btree (
  "trigger_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "scheduled_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
) WHERE status = 'scheduled'::text;

-- ----------------------------
-- Checks structure for table hdb_cron_events
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_cron_events" ADD CONSTRAINT "valid_status" CHECK (status = ANY (ARRAY['scheduled'::text, 'locked'::text, 'delivered'::text, 'error'::text, 'dead'::text]));

-- ----------------------------
-- Primary Key structure for table hdb_cron_events
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_cron_events" ADD CONSTRAINT "hdb_cron_events_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table hdb_metadata
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_metadata" ADD CONSTRAINT "hdb_metadata_resource_version_key" UNIQUE ("resource_version");

-- ----------------------------
-- Primary Key structure for table hdb_metadata
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_metadata" ADD CONSTRAINT "hdb_metadata_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table hdb_scheduled_event_invocation_logs
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_scheduled_event_invocation_logs" ADD CONSTRAINT "hdb_scheduled_event_invocation_logs_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table hdb_scheduled_events
-- ----------------------------
CREATE INDEX "hdb_scheduled_event_status" ON "hdb_catalog"."hdb_scheduled_events" USING btree (
  "status" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table hdb_scheduled_events
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_scheduled_events" ADD CONSTRAINT "valid_status" CHECK (status = ANY (ARRAY['scheduled'::text, 'locked'::text, 'delivered'::text, 'error'::text, 'dead'::text]));

-- ----------------------------
-- Primary Key structure for table hdb_scheduled_events
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_scheduled_events" ADD CONSTRAINT "hdb_scheduled_events_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Checks structure for table hdb_schema_notifications
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_schema_notifications" ADD CONSTRAINT "hdb_schema_notifications_id_check" CHECK (id = 1);

-- ----------------------------
-- Primary Key structure for table hdb_schema_notifications
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_schema_notifications" ADD CONSTRAINT "hdb_schema_notifications_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table hdb_source_catalog_version
-- ----------------------------
CREATE UNIQUE INDEX "hdb_source_catalog_version_one_row" ON "hdb_catalog"."hdb_source_catalog_version" USING btree (
  (version IS NOT NULL) "pg_catalog"."bool_ops" ASC NULLS LAST
);

-- ----------------------------
-- Indexes structure for table hdb_version
-- ----------------------------
CREATE UNIQUE INDEX "hdb_version_one_row" ON "hdb_catalog"."hdb_version" USING btree (
  (version IS NOT NULL) "pg_catalog"."bool_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table hdb_version
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_version" ADD CONSTRAINT "hdb_version_pkey" PRIMARY KEY ("hasura_uuid");

-- ----------------------------
-- Foreign Keys structure for table event_invocation_logs
-- ----------------------------
ALTER TABLE "hdb_catalog"."event_invocation_logs" ADD CONSTRAINT "event_invocation_logs_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "hdb_catalog"."event_log" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table hdb_cron_event_invocation_logs
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_cron_event_invocation_logs" ADD CONSTRAINT "hdb_cron_event_invocation_logs_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "hdb_catalog"."hdb_cron_events" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ----------------------------
-- Foreign Keys structure for table hdb_scheduled_event_invocation_logs
-- ----------------------------
ALTER TABLE "hdb_catalog"."hdb_scheduled_event_invocation_logs" ADD CONSTRAINT "hdb_scheduled_event_invocation_logs_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "hdb_catalog"."hdb_scheduled_events" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
