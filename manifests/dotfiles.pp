# dotfiles class

class people::dotfiles(
  $user    = false,
  $version = '1.0.0',
){

  if $user == false {
    fail( 'You must define a user')
  }

  $repo  = "https://github.com/${user}/dotfiles.git"
  $home  = "/home/${user}"
  $path  = "${home}/dotfiles"

  exec { 'clone_dotfiles':
    command => "git clone ${repo}",
    cwd     => $home,
    creates => $path,
    path    => ['/usr/bin', '/usr/sbin'],
    require => Package['git'],
  }

  file { $path:
    ensure  => directory,
    recurse => true,
    owner   => $user,
    group   => $user,
    require => Exec['clone_dotfiles'],
  }

  file { "${home}/.tmux.conf":
    ensure  => link,
    target  => "${path}/tmux.conf",
    require => Exec['clone_dotfiles'],
  }

  file { "${home}/.gitconfig":
    ensure  => link,
    target  => "${path}/gitconfig",
    require => Exec['clone_dotfiles'],
  }

  File <| title == "${home}/.vimrc.local" |> {
    source => undef,
    content => undef,
    replace => true,
    ensure => link,
    target => "${path}/vimrc",
    require => Exec['clone_dotfiles'],
  }
}


