" Grab the project root directory
function! gitme#root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

function! gitme#branch()
    return system('git rev-parse --abbrev-ref HEAD 2> /dev/null')[:-2]
endfunction

" Echo the blame of the current line
function! gitme#blame()
    let l:cmd = "git blame -w ".expand("%")." -L".expand(line('.')).",+1"
    return trim(system(cmd))
endfunction

function! gitme#files()
    return system("git ls-files -oc --exclude-standard | uniq")
endfunction
