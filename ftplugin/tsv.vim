set nowrap
set listchars=eol:\ ,tab:»-,trail:·,precedes:…,extends:…,nbsp:‗
set list
set noexpandtab
set softtabstop=0
set shiftwidth=0

" +python3 version
function! g:TsvDetectTabStop()
python3 << EOF
lines = vim.current.buffer[:]
cells = [cell for line in lines for cell in line.split('\t')]
max_cell_width = 0
if cells:
    max_cell_width = max([len(cell) for cell in cells])
tabstop = max_cell_width + 1 or 20
vim.command('setlocal tabstop=' + str(tabstop))

verbose = bool(int(vim.eval('&verbose')))
if verbose:
    print('Set tabstop to ' + str(tabstop))
EOF
endfunction

au bufenter,bufwrite *.tsv call g:TsvDetectTabStop()
