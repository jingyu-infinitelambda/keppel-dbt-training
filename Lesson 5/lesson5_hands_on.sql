-- create MASKING_ADMIN role
USE ROLE useradmin;
CREATE ROLE masking_admin;

use role securityadmin;
GRANT CREATE MASKING POLICY on SCHEMA DBT_TRAIN_DB.DBT_TRAIN_JAFFLE_SHOP to ROLE masking_admin;
GRANT APPLY MASKING POLICY on ACCOUNT to ROLE masking_admin;

-- create DBT_TRAIN_READER and DBT_TRAIN_ANALYST role 
USE ROLE useradmin;
CREATE ROLE DBT_TRAIN_READER;
CREATE ROLE DBT_TRAIN_ANALYST;

GRANT USAGE ON WAREHOUSE DBT_TRAIN_WH TO ROLE DBT_TRAIN_READER;
GRANT USAGE ON DATABASE DBT_TRAIN_DB TO ROLE DBT_TRAIN_READER;
GRANT USAGE ON SCHEMA DBT_TRAIN_JAFFLE_SHOP TO ROLE DBT_TRAIN_READER;
GRANT SELECT ON TABLE RAW_CUSTOMERS TO ROLE DBT_TRAIN_READER;

GRANT USAGE ON WAREHOUSE DBT_TRAIN_WH TO ROLE DBT_TRAIN_ANALYST;
GRANT USAGE ON DATABASE DBT_TRAIN_DB TO ROLE DBT_TRAIN_ANALYST;
GRANT USAGE ON SCHEMA DBT_TRAIN_JAFFLE_SHOP TO ROLE DBT_TRAIN_ANALYST;
GRANT SELECT ON TABLE RAW_CUSTOMERS TO ROLE DBT_TRAIN_ANALYST;

-- grant MASKING_ADMIN, DBT_TRAIN_READER, DBT_TRAIN_ANALYST role to attendees
GRANT ROLE MASKING_ADMIN TO USER jsmith;
GRANT ROLE DBT_TRAIN_READER TO USER jsmith;
GRANT ROLE DBT_TRAIN_ANALYST TO USER jsmith;


-- Volunteer 2
SHOW GRANTS OF ROLE DBT_TRAIN_ROLE;
SHOW GRANTS TO ROLE DBT_TRAIN_ROLE;
SHOW GRANTS ON TABLE RAW_CUSTOMERS;
