function! s:set_as_scratch_buffer()
   setlocal noswapfile
   setlocal nomodifiable
   setlocal bufhidden=delete
   setlocal buftype=nofile
   setlocal nobuflisted
   setlocal nonumber
   setlocal nowrap
   setlocal cursorline
endfunction

function! s:activate_window_by_buffer_name(name)
   for i in range(1, winnr('$'))
      let name = bufname(winbufnr(i))
      let full_name = fnamemodify(bufname(winbufnr(i)), ':p')
      if name == a:name || full_name == a:name
         exec i.'wincmd w'
         return 1
      endif
   endfor

   return 0
endfunction

let s:help_window_name = 'HTML\ help'

function! s:show_help()
   let current_name = fnamemodify(@%, ':p')

   if ! s:activate_window_by_buffer_name(s:help_window_name)
      exec 'top 5 split '.s:help_window_name
      call s:set_as_scratch_buffer()
   endif

   setlocal modifiable

   let help_lines = ['line1', 'line2']
   call setline(1, help_lines)

   setlocal nomodifiable

   call s:activate_window_by_buffer_name(current_name)
endfunction

command! -nargs=0 HtmlHelp call s:show_help()
au! BufRead,BufNewFile *.html call s:show_help()
