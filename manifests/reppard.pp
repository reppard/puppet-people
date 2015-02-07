class people::reppard {
  $home = '/home/reppard'
  $my = "${home}/my"
  $dotfiles = "${my}/dotfiles"

  class {'people::dotfiles':
    user => reppard,
  }

  class { 'vim':
    user     => 'reppard',
    home_dir => '/home/reppard',
  }


  vim::plugin { 'nerdtree':
    source => 'https://github.com/scrooloose/nerdtree.git',
  }
  vim::plugin { 'solarized':
    source => 'https://github.com/altercation/vim-colors-solarized.git',
  }
  vim::plugin { 'ack':
    source => 'https://github.com/mileszs/ack.vim.git',
  }
  vim::plugin { 'ctrlp' :
    source => 'https://github.com/kien/ctrlp.vim.git',
  }
  vim::plugin { 'syntastic':
    source => 'https://github.com/scrooloose/syntastic.git',
  }
  vim::plugin { 'vim-puppet':
    source => 'https://github.com/rodjek/vim-puppet.git',
  }
}
