set expandtab
set shiftwidth=4
set softtabstop=4

"Check if sandbox is mounted and corresponds to current project being edited
"Returns 1 if a corresponding sandbox is running, 0 otherwise
function! CheckIfSandboxRunning()
    let l:dfoutput = systemlist('df -h')
    let l:pattern = '\v^bindfs\s+\d+\.?\d*\w\s+\d+\.?\d*\w\s+\d+\.?\d*\w\s+\d+\%\s+(.*)$'

    for l:line in l:dfoutput
        let l:match = matchlist(l:line, l:pattern) 
	if (len(l:match) == 0) "If no match
	    continue
	endif
	"Check if path to shining match current file path
	let l:match2 = matchlist(l:match[1], '\v^(.*/shining_software)/build/rootfs.shining')
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

"Runs documentation check test
function! ToggleDocTestMode()
    let l:sandboxrunning = CheckIfSandboxRunning()
    if (l:sandboxrunning == 0)
	echo "Sandbox needs to be running to enable doc testing..."
	return 0
    endif
    " echo "Sandbox is running, toggling doclint"
    let l:index = index(b:ale_linters, 'doclint')
    if (l:index == -1)
        echo "Enabling doc linting"
	call add(b:ale_linters, 'doclint')
	" execute ":ALELint"
    else
	echo "Disabling doc linting"
	call remove(b:ale_linters, l:index)
    endif
    echo b:ale_linters
    return 0
endfunction

"Returns path of shining_software/src of project being edited
function! GetShiningPath()
    let l:filepath = expand('%:p')
    let l:match3 = matchlist(l:filepath, '\v^(.*/shining_software/src/)')
    if (len(l:match3) == 0)
        return -1
    endif
    let l:shining_path = l:match3[1]
    return l:shining_path
endfunction

"Updates ctags in current project
function! UpdateTagsShining()
    let l:shining_path = GetShiningPath()
    if (l:shining_path == -1)
	echo "Could not find shining_software directory"
	return
    endif
    let l:shining_software_subpath = l:shining_path . "shining_software/"
    let l:brainos_subpath = l:shining_path . "brainos/"
    let l:cpp_subpath = l:shining_path . "cpp/"
    let l:cuda_subpath = l:shining_path . "cuda/"
    let l:opencl_subpath = l:shining_path . "opencl/"
    let l:ctags_dirs = l:shining_software_subpath . " " . l:brainos_subpath . " " . l:cpp_subpath . " " . l:cuda_subpath . " " . l:opencl_subpath
    let l:ctags_file_path = l:shining_path . "tags"
    execute "!ctags -R --fields=+l -f " . l:ctags_file_path . " " . l:ctags_dirs
endfunction

let sandboxrunning = CheckIfSandboxRunning()
if (sandboxrunning == 1)
    let b:ale_linters = ['flake8', 'sandboxpylint']
else
    let b:ale_linters = ['flake8']
endif
