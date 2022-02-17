" Font configuration:

let s:font_family = "Iosevka Nerd Font"
let s:font_size = 14

" Font-related functions:

let s:actual_font_size = s:font_size

function! SetFont()
  execute "GuiFont! " . s:font_family . ":h" . s:font_size
  let s:actual_font_size = s:font_size
endfunction

function! AdjustFontSize(amount)
  let s:actual_font_size = s:actual_font_size+a:amount
  execute "GuiFont! " . s:font_family . ":h" . s:actual_font_size
endfunction

" Font-related key bindings:

nnoremap <C-+> <cmd>call AdjustFontSize( 1)<cr>
nnoremap <C-=> <cmd>call AdjustFontSize( 1)<cr>
nnoremap <C--> <cmd>call AdjustFontSize(-1)<cr>

nnoremap <C-0> <cmd>call SetFont()<cr>

call SetFont() " Setting the font on startup

" Other settings:

GuiTabline v:false
