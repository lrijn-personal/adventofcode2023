%dw 2.0
output application/json
import * from dw::core::Strings
---
//part 1
// sum((payload splitBy "\n" map (item) -> (item filter isNumeric($))) map (item) -> 
//     item[0] ++ item[-1])

//part 2
sum((((payload splitBy "\n") map (item) -> item 
    replace "one" with "one1one" 
    replace "two" with "two2two" 
    replace "three" with "three3three"
    replace "four" with "four4four"
    replace "five" with "five5five"
    replace "six" with "six6six"
    replace "seven" with "seven7seven"
    replace "eight" with "eight8eight"
    replace "nine" with "nine9nine") map (item) -> item filter isNumeric($))map (item) -> 
    item[0] ++ item[-1])


