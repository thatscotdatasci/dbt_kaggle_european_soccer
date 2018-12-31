select p.id, a.age, b.bmi, b.bmi_cat, c.match_count, c.first_played, c.last_played, cl.career_length from "Player" as p
left join {{ ref('player_age') }} as a
on p.id = a.id
left join {{ ref('player_bmi_cat') }} as b
on p.id = b.id
left join {{ ref('player_match_count') }} as c
on p.player_api_id = c.player_api_id
left join {{ ref('player_career_length') }} as cl
on p.player_api_id = cl.player_api_id