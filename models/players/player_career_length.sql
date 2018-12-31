{{ config(materialized='ephemeral') }}

select player_api_id, DATE_PART('year', last_played::date) - DATE_PART('year', first_played::date) as career_length from {{ ref('player_match_count') }}