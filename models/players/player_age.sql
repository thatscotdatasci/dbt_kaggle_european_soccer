{{ config(materialized='ephemeral') }}

select id, player_api_id, DATE_PART('year', current_date) - DATE_PART('year', birthday::date) as age from "Player"