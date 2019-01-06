select * from (
    (
        {{ get_match_results('home') }}
    )
    union all
    (
        {{ get_match_results('away') }}
    )
) r