{{ config(materialized='ephemeral') }}

select id, (weight*0.453592)/((height/100.0)^2.0) as bmi from "Player"