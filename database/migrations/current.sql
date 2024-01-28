-- Create a schema
DROP SCHEMA IF EXISTS app_public CASCADE;
CREATE SCHEMA app_public;

-- roles
drop role if exists anon;
create role anon;

drop role if exists student;
create role student;
grant anon to student;
grant usage on schema app_public to student;


-- jwt auth
drop function if exists current_user_id;
create function current_user_id() returns integer as $$
  select nullif(current_setting('jwt.claims.user_id', true), '')::integer;
$$ language sql stable;


-- users
DROP TABLE IF EXISTS app_public.user CASCADE;
CREATE TABLE app_public.user(
    id serial not null primary key,
    first_name text not null,
    last_name text not null,
    created_at timestamptz not null default now()
);

INSERT INTO app_public.user (first_name, last_name) VALUES ('Adam', 'Testowy');
INSERT INTO app_public.user (first_name, last_name) VALUES ('Katarzyna', 'Obserwacja');
INSERT INTO app_public.user (first_name, last_name) VALUES ('Agata', 'Próbna');
INSERT INTO app_public.user (first_name, last_name) VALUES ('Andrzej', 'Badawczy');

-- grades
DROP TABLE IF EXISTS app_public.grades CASCADE;
CREATE TABLE app_public.grades(
    id serial not null primary key,
    user_id integer not null references app_public.user (id),
    value text not null,
    created_at timestamptz not null default now()
);
CREATE INDEX ON app_public.grades (user_id);

ALTER TABLE app_public.grades ENABLE ROW LEVEL SECURITY;
grant select on app_public.grades to student;
create policy select_own on app_public.grades for select using (
    user_id = app_public.current_user_id()
);

INSERT INTO app_public.grades (user_id, value) VALUES (1, '5');
INSERT INTO app_public.grades (user_id, value) VALUES (1, '3');
INSERT INTO app_public.grades (user_id, value) VALUES (1, '2');
INSERT INTO app_public.grades (user_id, value) VALUES (2, '4-');
INSERT INTO app_public.grades (user_id, value) VALUES (2, '6-');
INSERT INTO app_public.grades (user_id, value) VALUES (2, '5-');
INSERT INTO app_public.grades (user_id, value) VALUES (3, '1');
INSERT INTO app_public.grades (user_id, value) VALUES (3, '2');
INSERT INTO app_public.grades (user_id, value) VALUES (4, '5');
INSERT INTO app_public.grades (user_id, value) VALUES (4, '4');