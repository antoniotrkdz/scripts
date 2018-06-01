let numbg = 255
while numbg >= 0
    exec 'hi col_'.numbg.' ctermbg='.numbg.' ctermfg=white'
    exec 'syn match col_'.numbg.' "ctermbg='.numbg.':...." containedIn=ALL'
    call append(0, 'ctermbg='.numbg.':....')
    let numbg = numbg - 1
endwhile

let numfg = numbg + 256
while numfg >= numbg
    exec 'hi col_'.numfg.' ctermfg='.numfg.' ctermbg=black'
    exec 'syn match col_'.numfg.' "ctermfg='.numfg.':...." containedIn=ALL'
    call append(257, 'ctermfg='.numfg.':....')
    let numfg = numfg - 1
endwhile
