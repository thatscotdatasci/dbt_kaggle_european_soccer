select player_api_id, count(player_api_id) as match_count, min(date) as first_played, max(date) as last_played
from {{ ref('match_players') }}
group by player_api_id