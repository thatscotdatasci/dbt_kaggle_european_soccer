select id, bmi, case
    when bmi > (select overweight from {{ ref('bmi_categories') }} limit 1) THEN 'obese'
    when bmi > (select healthy from {{ ref('bmi_categories') }} limit 1) THEN 'overweight'
    when bmi > (select underweight from {{ ref('bmi_categories') }} limit 1) THEN 'healthy'
    else 'underweight'
end as bmi_cat
from {{ ref('player_bmi') }}