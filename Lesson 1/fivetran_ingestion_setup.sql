begin;

   -- create variables for user / password / role / warehouse / database (needs to be uppercase for objects)
   set role_name = 'DBT_TRAIN_ROLE';
   set user_name = 'DEMO_KEPPEL';
   set user_password = '<hidden>';
   set warehouse_name = 'DBT_TRAIN_WH';
   set database_name = 'DBT_TRAIN_DB';

   -- change role to securityadmin for user / role steps
   use role securityadmin;

   -- create role for fivetran
   create role if not exists identifier($role_name);
   grant role identifier($role_name) to role SYSADMIN;

   -- create a user for fivetran
   create user if not exists identifier($user_name)
   password = $user_password
   default_role = $role_name
   default_warehouse = $warehouse_name;

   grant role identifier($role_name) to user identifier($user_name);

   -- set binary_input_format to BASE64
   ALTER USER identifier($user_name) SET BINARY_INPUT_FORMAT = 'BASE64';

   -- change role to sysadmin for warehouse / database steps
   use role sysadmin;

   -- create a warehouse for fivetran
   create warehouse if not exists identifier($warehouse_name)
   warehouse_size = xsmall
   warehouse_type = standard
   auto_suspend = 60
   auto_resume = true
   initially_suspended = true;

   -- create database for fivetran
   create database if not exists identifier($database_name);

   -- grant fivetran role access to warehouse
   grant USAGE
   on warehouse identifier($warehouse_name)
   to role identifier($role_name);

   -- grant fivetran access to database
   grant CREATE SCHEMA, MONITOR, USAGE
   on database identifier($database_name)
   to role identifier($role_name);

   -- change role to ACCOUNTADMIN for STORAGE INTEGRATION support (only needed for Snowflake on GCP)
   use role ACCOUNTADMIN;
   grant CREATE INTEGRATION on account to role identifier($role_name);
   use role sysadmin; 
   
 commit;