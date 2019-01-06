select team_api_id, avg(age) as avg_age from (
    select distinct m.team_api_id, p.player_api_id, p.age from {{ ref('player_age') }} p
    left join {{ ref('match_players') }} m
    on p.player_api_id = m.player_api_id
) r
group by team_api_id