" TODO: disable commands when not in a git repo

" Grab the project root directory
function! gitme#root()
    let cmd = 'git rev-parse --show-toplevel 2> /dev/null'
    return trim(system(cmd))
endfunction

function! gitme#branch()
    let cmd = 'git branch --show-current 2> /dev/null'
    return trim(system(cmd))
endfunction

" Echo the blame of the current line
function! gitme#smallblame()
    let cmd = "git blame -w ".expand("%")." -L".expand(line('.')).",+1 2> /dev/null"
    return trim(system(cmd))
endfunction

function! gitme#blame()
    let pos = winsaveview()

    setlocal cursorbind
    setlocal scrollbind

    vnew
    wincmd H

    setlocal cursorbind
    setlocal scrollbind
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal nobuflisted
    setlocal nomodified
    setlocal nolist

    let cmd = "git blame -c ".expand("#").' | sed -r ''s/^([0-9a-z^]+)\s+(\(.*)\s+[0-9]+\).*$/\1 \2)/'''
    let blame = system(cmd)
    let width = system("echo '".blame."' | wc -L | tr -d '\n'")

    silent 0put=blame
    execute "normal! Gdd"
    setlocal noma

    silent call winrestview(pos)
    execute "normal! g0"
    exec width."wincmd |"
    syncbind
endfunction

function! gitme#files()
    if empty(gitme#root())
        return []
    endif

    let cmd = "git ls-files ".gitme#root()." --full-name -oc --exclude-standard | uniq | sort 2> /dev/null"
    return systemlist(cmd)
endfunction

" worktree list (does not return the current wt)
function! gitme#wtl()
    let root = gitme#root()
    let cmd = "git worktree list 2> /dev/null"

    let wtrees = systemlist(cmd)
    return filter(wtrees, "len(v:val) >= 3")
endfunction

function! gitme#wtd(worktree)
    let root = split(a:worktree)[0]

    let cmd = "git worktree remove ".root
    call system(cmd)
endfunction

" Given an element from gitme#wtl, switches vim to that worktree
function! gitme#wts(worktree) abort

    let curdir = getcwd()
    let root = split(a:worktree)[0]

    if curdir ==? root
        return
    endif

    " Save existing session
    exec "mks! ".gitme#root()."/Session.vim"
    exec "bufdo bd"

    " Switch dir to the new worktree
    exec "chdir ".root

    " Restore session if one exists
    if filereadable(root."/Session.vim")
        exec "source ".root."/Session.vim"
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
