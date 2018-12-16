select l.id as league_id, l.name as league_name, l.country_id, c.name as country_name from "League" as l
inner join "Country" as c
on l.country_id = c.id