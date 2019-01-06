{{ config(materialized='ephemeral') }}

select id, player_api_id, (weight*0.453592)/((height/100.0)^2.0) as bmi from "Player"