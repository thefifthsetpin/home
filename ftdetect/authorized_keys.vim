"	Vim assumes ".conf" as the type.  Stupid vim.
" if exists("did_load_filetypes")
" 	finish
" endif

augroup filetypedetect
	au! BufRead,BufNewFile authorized_keys		setfiletype authorized_keys
	au! BufRead,BufNewFile .ssh/id_rsa.*.pub		setfiletype authorized_keys
