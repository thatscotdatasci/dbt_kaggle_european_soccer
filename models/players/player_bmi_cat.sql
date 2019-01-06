select id, player_api_id, bmi, {{ determine_bmi('bmi', ref('bmi_categories')) }} as bmi_cat
from {{ ref('player_bmi') }}