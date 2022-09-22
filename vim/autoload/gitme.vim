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

function! gitme#files()
    if empty(gitme#root())
        return []
    endif

    let cmd = "git ls-files ".gitme#root()." --full-name -oc --exclude-standard | uniq | sort 2> /dev/null"
    return systemlist(cmd)
endfunction
