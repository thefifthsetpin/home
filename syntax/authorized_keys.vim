" Vim syntax file
" Language: .ssh public key files
" Maintainer: Dustin Jacobsen
"
"if exists("b:current_syntax")
"  finish
"endif
syntax clear

setlocal iskeyword+=-
setlocal iskeyword+=+
setlocal iskeyword+=/

let s:keytype = '<(ecdsa-sha2-nistp(256|384|521)|ssh-(rsa|dss|ed25519))>'
" looser validation & fewer () marks.
let s:keytype_loose = '<(ecdsa|ssh)-[a-z0-9-]*>'

" b64 encoded key
" {21,} should not be open-ended, but enforcing an upper bound kills performance.
let s:b64 = '<([a-z0-9+\/]{4}){21,}([a-z0-9+\/]{4}>|[a-z0-9+\/]{3}\=|[a-z0-9+\/]{2}\={2})'
" looser validation & fewer () marks.
let s:b64_loose = '[a-z0-9+\/]{84,}\={0,2}'

let s:params = '<(cert-authority|no-(pty|user-rc|(agent|port|X11)-forwarding))>'
let s:arg_names = '<(permitopen|principals|tunnel|from|command|environment)>'
let s:option_names_loose = '<[1a-z-]+>'
" looks like " marks are not optional
"let s:arg_value = '([^"]@=[a-z0-9_-]*|"([^"\\]|\\"|\\\\)*")'
let s:arg_value = '"([^"\\]|\\"|\\\\)*"'

" Lax because we're just highlighting it as part of a comment.
" Good validation would be way out of scope.
syn match email /\v\c(^|\s|['"])@1<=[a-z0-9._%+-]+\@([a-z0-9-]+\.)+[a-z]+($|\s|['"])@=/ containedin=line_comment,eol_comment

syn match modline1 /\v\c(<(vi:|vim([<=>]\d{3})?:|ex:)\s*)@8<=(set |\s)@!.*/ containedin=line_comment
syn match modline2 /\v\c(<(vi:|vim([<=>]\d{3})?:|ex:)\s*set )@8<=.*(:)@=/ containedin=line_comment

syn region line start=/^/ end=/$/ oneline contains=sshv2,line_comment,error
syn match error /\v.+/ contained
execute('syn match sshv2 /\v\c.*(^|\s)@1<='.s:keytype_loose.'\s'.s:b64_loose.'(\s|$)@=.*/ contained contains=keytype_pfx,keytype_loose')
syn match line_comment /\v^#.*/ contained

execute('syn match keytype_loose /\v(^|[^,]\s)@2<='.s:keytype_loose.'/ contained skipwhite nextgroup=b64 contains=keytype')
execute('syn match keytype /\v(^|[^,]\s)@2<='.s:keytype.'/ contained')
execute('syn match keytype_pfx /\v\c^.{5,}(\s+'.s:keytype_loose.')@=/ contained contains=principals,option')

execute('syn match option /\v\c(^|,)@1<='.s:option_names_loose.'(\='.s:arg_value.')?,?/ contained contains=odd_name,param,arg_name')
execute('syn match odd_name /\v\c'.s:option_names_loose.'\=@=/ contained nextgroup=arg_sep')
execute('syn match param /\v\c'.s:params.'\=@!/ contained')
execute('syn match arg_name /\v\c'.s:arg_names.'(\=")@=/ contained nextgroup=arg_sep')
syn match arg_sep /\v\=/ contained nextgroup=arg_value
execute('syn match arg_value /\v\c'.s:arg_value.'/ contained')

execute('syn match b64 /\v\c'.s:b64.'/ contained skipwhite nextgroup=eol_comment contains=b64_trunc')
syn match b64_trunc /\v\c(<.{3})@4<=.{-}(.{3}($|\s))@=/ contained conceal cchar=…
syn match eol_comment /\v\c\s@1<=.+$/ contained

syn match principals /\v\c(cert-authority.*)@<!(^|,)@<=principals\=@=(.*cert-authority)@!/ contained nextgroup=arg_sep

set conceallevel=2
set concealcursor=nv
set nowrap


hi def link line_comment Comment
hi def link eol_comment Comment
hi def link email SpecialComment
hi def link modline1 SpecialComment
hi def link modline2 SpecialComment
hi def link param Type
hi def link arg_name Type
hi def link arg_sep Identifier
hi def link arg_value Constant
hi def link keytype Keyword
hi def link b64 Ignore
hi def link b64_trunc Ignore
hi def link error Error
hi def link principals Error

let b:current_syntax = "sshk1"
