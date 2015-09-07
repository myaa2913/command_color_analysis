cd "C:\Users\Matt\Dropbox\github\command_colors_analysis"

import delim using "c_c_results.csv", clear

*how many of the scenarios have we played?
preserve
drop if scenario == ""
g played = 1 if matt != . & steve != .
tab played,m   /*we've played ~19% of the scenarios*/
restore

drop if matt == . | steve == .
replace bfv = bfv[_n-1] if bfv == . 

keep codex bfv matt steve
replace codex = codex[_n-1] if codex == ""

collapse (sum) bfv matt steve, by(codex)

g win = "matt" if matt > steve
replace win = "steve" if steve > matt

g matt_per = matt/bfv
g steve_per = steve/bfv

export delim using "c_c_clean_data.csv", replace

