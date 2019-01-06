select *, {{ determine_bmi('avg_bmi', ref('bmi_categories')) }} as bmi_cat from (
    select team_api_id, avg(bmi) as avg_bmi from (
        select distinct m.team_api_id, p.player_api_id, p.bmi from {{ ref('player_bmi') }} p
        left join {{ ref('match_players') }} m
        on p.player_api_id = m.player_api_id
    ) r
    group by team_api_id
) r