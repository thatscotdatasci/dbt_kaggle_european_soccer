select p.id, a.age, b.bmi, b.bmi_cat from "Player" as p
left join {{ ref('player_age') }} as a
on p.id = a.id
left join {{ ref('player_bmi_cat') }} as b
on p.id = b.id