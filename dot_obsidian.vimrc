set clipboard=unnamed

unmap <Space>

" move tabs
nmap H :obcommand<space>workspace:previous-tab<CR>
nmap L :obcommand<space>workspace:next-tab<CR>

" move window
nmap <Space>l :obcommand<space>editor:focus-right<CR>
nmap <Space>h :obcommand<space>editor:focus-left<CR>
nmap <Space>k :obcommand<space>editor:focus-top<CR>
nmap <Space>j :obcommand<space>editor:focus-bottom<CR>

nmap za :obcommand<space>editor:toggle-fold<CR>

nmap <Space>s :obcommand<space>editor:toggle-source<CR>
