" TODO: disable commands when not in a git repo

" Grab the project root directory
function! gitme#root()
    let l:cmd = 'git rev-parse --show-toplevel 2> /dev/null'
    return trim(system(l:cmd))
endfunction

function! gitme#branch()
    let l:cmd = 'git rev-parse --abbrev-ref HEAD 2> /dev/null'
    return trim(system(l:cmd))
endfunction

" Echo the blame of the current line
function! gitme#blame()
    let l:cmd = "git blame -w ".expand("%")." -L".expand(line('.')).",+1 2> /dev/null"
    return trim(system(l:cmd))
endfunction

function! gitme#files()
    if empty(gitme#root())
        return []
    endif

    let l:cmd = "git ls-files -oc --exclude-standard | uniq 2> /dev/null"
    return split(system(l:cmd), "\n")
endfunction

" worktree list (does not return the current wt)
function! gitme#wtl()
    let l:root = gitme#root()
    let l:cmd = "git worktree list 2> /dev/null"

    let l:wtrees = split(system(l:cmd), "\n")
    return filter(l:wtrees, "len(v:val) >= 3")
endfunction

function! gitme#wtd(worktree)
    let l:root = split(a:worktree)[0]

    let l:cmd = "git worktree remove ".l:root
    call system(l:cmd)
endfunction

" Given an element from gitme#wtl, switches vim to that worktree
function! gitme#wts(worktree) abort

    let l:curdir = getcwd()
    let l:root = split(a:worktree)[0]

    if l:curdir ==? l:root
        return
    endif

    " Save existing session
    exec "mks! ".gitme#root()."/Session.vim"
    exec "bufdo bd"

    " Switch dir to the new worktree
    exec "chdir ".l:root

    " Restore session if one exists
    if filereadable(l:root."/Session.vim")
        exec "source ".l:root."/Session.vim"
    else
        exec "Ex"
    endif

    exec "clearjumps"

    " XXX: Need to make sure I can reset and restore tags. We wouldn't want to
    " accidentally jump back to the wrong file...
    if &tagstack && exists('*settagstack')
        " TODO: restore tags?
        call settagstack(win_getid(), {'length': 0, 'curidx': 0, 'items': []}, "r")
    endif
endfunction
