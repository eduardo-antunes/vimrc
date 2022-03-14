" Font configuration:

let s:font_family = 'Iosevka'
let s:font_size = 14

" Font-related functions:

let s:actual_font_size = s:font_size

function! SetFont()
  execute 'GuiFont! ' . s:font_family . ':h' . s:font_size
  let s:actual_font_size = s:font_size
endfunction

function! AdjustSize(amount)
  let s:actual_font_size = s:actual_font_size+a:amount
  execute 'GuiFont! ' . s:font_family . ':h' . s:actual_font_size
endfunction

" Fullscreen functions:

let s:fullscreen = v:false

function! ToggleFullScreen()
  let s:fullscreen = !s:fullscreen
  call GuiWindowFullScreen(s:fullscreen)
endfunction

" GUI-related key bindings:

nnoremap <C-+> <cmd>call AdjustSize( 1)<cr>
nnoremap <C-=> <cmd>call AdjustSize( 1)<cr>
nnoremap <C--> <cmd>call AdjustSize(-1)<cr>
nnoremap <C-0> <cmd>call SetFont()<cr>
nnoremap <F11> <cmd>call ToggleFullScreen()<cr>

call SetFont() " Setting the font on startup

" General GUI settings:

GuiTabline v:false
