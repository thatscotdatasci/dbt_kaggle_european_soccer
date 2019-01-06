select * from (
    (
        {{ get_match_results(True) }}
    )
    union all
    (
        {{ get_match_results(False) }}
    )
) r