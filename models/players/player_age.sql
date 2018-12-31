{{ config(materialized='ephemeral') }}

select id, DATE_PART('year', current_date) - DATE_PART('year', birthday::date) as age from "Player"