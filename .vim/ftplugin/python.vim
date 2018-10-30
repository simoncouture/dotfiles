set expandtab
set shiftwidth=4
set softtabstop=4

"Check if sandbox is mounted and corresponds to current project being edited
"Returns 1 if a corresponding sandbox is running, 0 otherwise
function! CheckIfSandboxRunning()
    let l:dfoutput = systemlist('df -h')
    let l:pattern = '\v^bindfs\s+\d+\w\s+\d+\w\s+\d+\w\s+\d+\%\s+(.*)$' 

    for l:line in l:dfoutput
        let l:match = matchlist(l:line, l:pattern) 
	if (len(l:match) == 0) "If no match
	    continue
	endif
	"Check if path to shining match current file path
	let l:match2 = matchlist(l:match[1], '\v^(.*/shining_software)/build/rootfs.nspawn')
	if (len(l:match2) == 0)
	    continue
	endif
	let l:sandboxpath = l:match2[1]
        let l:filepath = expand('%:p')
	let l:match3 = matchlist(l:filepath, '\v^(.*/shining_software)/src')
	if (len(l:match3) == 0)
	    continue
	endif
	let l:filepath = l:match3[1]
	if (l:filepath == l:sandboxpath) 
	    return 1
	endif
    endfor
return 0
endfunction

let sandboxrunning = CheckIfSandboxRunning()
if (sandboxrunning == 1)
    let b:ale_linters = ['flake8', 'sandboxpylint']
else
    let b:ale_linters = ['flake8']
endif
