%dw 2.0
output application/json
import * from dw::core::Strings
var games = (payload splitBy "\n") map (line) -> {
    gameNumber: (substringBefore(line, ":") splitBy " ")[1] as Number,
    games: ((substringAfter(line, ":") splitBy ";") map (balls) -> balls splitBy ",") 
}

var part2 = games map (games) -> {
    gameNumber: games.gameNumber,
    minRed: max((flatten(games.games) reduce (item, acc =[]) ->
    (acc ++ [(if (item contains "red") (item filter isNumeric($)) as Number  else null)] filter !isEmpty($)))), 
    minGreen: max((flatten(games.games) reduce (item, acc =[]) ->
    (acc ++ [(if (item contains "green") (item filter isNumeric($)) as Number else null)] filter !isEmpty($)))),
    minBlue: max((flatten(games.games) reduce (item, acc =[]) ->
    (acc ++ [(if (item contains "blue") (item filter isNumeric($)) as Number else null)] filter !isEmpty($)))),
    
    }
---


sum((part2 map(item) -> {
    gameNumber: item.gameNumber,
    power: item.minRed * item.minBlue * item.minGreen
}).power)
