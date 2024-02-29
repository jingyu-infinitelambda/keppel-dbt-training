# Lesson 6 - Orchestration with dbt Cloud 

In this lab, you will create multiple dbt Cloud jobs, and setup simple and complex orchestration.

**Note:** Each section of this lab is accompanied by a link to documentation (highlighted with blue text) that can help you complete your task. You are encouraged to go through it even if you have been able to complete your assignment without it.

## Create a branch for this lab - `lab-6`

## Exercise 1: Setup

Update the materialization of `fct_orders` to incremental using a config block.

* [Incremental Models in dbt](https://docs.getdbt.com/docs/build/incremental-models)

Click "Save" and run the following command and observe the logs. You should see `create or replace transient table` in the DDL.
```
dbt run --select fct_orders --full-refresh
```

* [full refresh](https://docs.getdbt.com/reference/resource-configs/full_refresh)

Now, run this command and observe the logs. This time, you should see a different set of DDL and DML.
```
dbt run --select fct_orders
```

**When you are done, merge the branch to main.**


## Exercise 2: Simple Orchestration

1. Create an incremental job for updating `fct_orders` to run at 5:00 AM, Monday to Saturday. You can name it **Daily Incremental Run (orders)**

2. Create a full refresh job to run on Sunday at 5:00 AM. You can name it **Full Refresh (orders)**


## Exercise 3: Complex Orchestration

Update the **Daily Incremental Run (orders)** job to run every 30 minutes, Monday to **Sunday** (not Saturday!). 

Use cron expression for scheduling to ensure that the job **does not run between 5am to 8am**, to avoid clashing with the Full Refresh (orders) job.

* [Editor for Cron tab expressions](https://crontab.guru/)
