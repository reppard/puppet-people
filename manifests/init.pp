# == Class: people
# Class for setting up users and their dotfiles as well as some default
# vim configuration.  Pretty specific to my setup
#
# === Parameters
# user and passwd.  Probably more to come.
#
# === Variables
# See parameters
#
# === Examples
#
#  class { people:
#    $user   = some_user,
#    $passwd = 'S0m3D3f@ultS@lt',
#  }
#
# === Authors
# Reppard Walker <reppardwalker@gmail.com>
#
# === Copyright
# Copyright 2015 Reppard Walker
#
class people (
  $user   = false,
  $passwd = '$1$mBuqh43.$nv3F3TsEa4r8h/uZfpjgf.',
){
  $home = "/home/${user}"

  if $user == false {
    fail('You must pass a username to this class')
  }
  user { $user:
    ensure     => present,
    password   => $passwd,
    managehome => true,
  }
  file { $home:
    ensure  => directory,
    owner   => $user,
    group   => $user,
    require => User[$user],
  }
  class { 'people::dotfiles': user => $user }
  class { 'vim':
    user     => $user,
    home_dir => $home,
    require  => File[$home],
  }
  vim::plugin { 'nerdtree':
    source   => 'https://github.com/scrooloose/nerdtree.git',
    require  => File[$home],
  }
  vim::plugin { 'solarized':
    source   => 'https://github.com/altercation/vim-colors-solarized.git',
    require  => File[$home],
  }
  vim::plugin { 'ack':
    source   => 'https://github.com/mileszs/ack.vim.git',
    require  => File[$home],
  }
  vim::plugin { 'ctrlp' :
    source   => 'https://github.com/kien/ctrlp.vim.git',
    require  => File[$home],
  }
  vim::plugin { 'syntastic':
    source   => 'https://github.com/scrooloose/syntastic.git',
    require  => File[$home],
  }
  vim::plugin { 'vim-puppet':
    source   => 'https://github.com/rodjek/vim-puppet.git',
    require  => File[$home],
  }
}
