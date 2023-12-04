%dw 2.0
output application/json
import * from dw::core::Strings
var games = (payload splitBy "\n") map (line) -> {
    gameNumber: (substringBefore(line, ":") splitBy " ")[1] as Number,
    games: ((substringAfter(line, ":") splitBy ";") map (balls) -> balls splitBy ",") 
}
---
sum(((games map (games) -> {
    gameNumber: games.gameNumber,
    games: ((flatten(games.games)) map (item) -> 
        if (item contains "red") 
            ((item filter isNumeric($)) as Number) > 12
        else if (item contains "green") 
             ((item filter isNumeric($)) as Number) > 13 
        else if (item contains "blue")  
            ((item filter isNumeric($)) as Number) > 14
        else null) filter $
    }) filter isEmpty($.games)).gameNumber)
