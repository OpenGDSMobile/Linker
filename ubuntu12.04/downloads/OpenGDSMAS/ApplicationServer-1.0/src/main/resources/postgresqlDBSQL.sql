CREATE DATABASE hmwdb
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'en_US.UTF-8'
       LC_CTYPE = 'en_US.UTF-8'
       CONNECTION LIMIT = -1;
       
       
CREATE TABLE usertable
(
  userid text,
  passwd text,
  username text,
  email text
)