let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Downloads/CurrentAddress
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +16 main.m
badd +29 Classes/MapViewController.m
badd +19 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/Frameworks/CoreLocation.framework/Headers/CLGeocoder.h
badd +16 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/Frameworks/MapKit.framework/Headers/MKPlacemark.h
badd +50 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/Frameworks/MapKit.framework/Headers/MKMapView.h
badd +9 Classes/PlacemarkViewController.h
badd +1 .git/index
badd +11 Categories/MKMapView+ZoomLevel.h
badd +17 Categories/MKMapView+ZoomLevel.m
badd +4 .clang_complete
badd +0 fugitive:///Users/fimkap/Downloads/CurrentAddress/.git//0/Classes/MapViewController.m
argglobal
silent! argdel *
argadd main.m
edit .git/index
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 12 + 23) / 46)
exe '2resize ' . ((&lines * 31 + 23) / 46)
exe 'vert 2resize ' . ((&columns * 82 + 82) / 165)
exe '3resize ' . ((&lines * 31 + 23) / 46)
exe 'vert 3resize ' . ((&columns * 82 + 82) / 165)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=1
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 11 - ((4 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
11
normal! 0
wincmd w
argglobal
edit fugitive:///Users/fimkap/Downloads/CurrentAddress/.git//0/Classes/MapViewController.m
setlocal fdm=diff
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
edit Classes/MapViewController.m
setlocal fdm=diff
setlocal fde=ObjectiveCFolds()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
exe '1resize ' . ((&lines * 12 + 23) / 46)
exe '2resize ' . ((&lines * 31 + 23) / 46)
exe 'vert 2resize ' . ((&columns * 82 + 82) / 165)
exe '3resize ' . ((&lines * 31 + 23) / 46)
exe 'vert 3resize ' . ((&columns * 82 + 82) / 165)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
let g:this_session = v:this_session
let g:this_obsession = v:this_session
let g:this_obsession_status = 2
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
