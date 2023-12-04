%dw 2.0
output application/json
import lines from dw::core::Strings
var caloriesPerElf = ((payload splitBy "\n\n") map (line) -> line splitBy  "\n") map (elf) -> 
    sum(elf)
---

{
    part1: max(caloriesPerElf),
    part2: sum((caloriesPerElf orderBy -$)[0 to 2])
}

