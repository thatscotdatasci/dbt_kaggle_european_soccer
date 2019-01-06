select r.*, w.win, l.loss, d.draw from (
    select team_api_id, count(team_api_id) as matches_played, sum(home) as home_matches_played
    from {{ ref('match_results') }}
    group by team_api_id
) r
join (
    {{ get_team_results('loss') }}
) l
on r.team_api_id = l.team_api_id
join (
    {{ get_team_results('win') }}
) w
on r.team_api_id = w.team_api_id
join (
    {{ get_team_results('draw') }}
) d
on r.team_api_id = d.team_api_id