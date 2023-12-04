%dw 2.0
output application/json
import * from dw::core::Strings

var points = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096]
var allGames = (payload splitBy "\n") map (line) -> {
    cardNumber: substringAfterLast(substringBefore(line,":"), " ") as Number,
    games: do {
        var winningCards = (substringAfter(substringBefore(line, "|"),":") splitBy " ") filter !isEmpty($)
        var myCards = (substringAfter(line, "|") splitBy " ") filter !isEmpty($)
        var matches = myCards reduce (item, acc=[]) -> (acc ++ [if (winningCards contains item) item else null]) filter !isEmpty($)
        ---
        {
        // winningCards: winningCards,
        // myCards: myCards,
        matches: matches,
        size: sizeOf(matches),
        points: if (isEmpty(matches)) 
                    null
                else
                 points[sizeOf(matches)-1] 
        }
    },
}
---

sum(allGames.games.points filter !isEmpty($))
