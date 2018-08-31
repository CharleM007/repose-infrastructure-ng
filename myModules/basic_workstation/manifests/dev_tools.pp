# Aggregates all the various dev tools we use
class basic_workstation::dev_tools(
  $user = undef,
  $fullName = undef,
  $email = undef,
  $user_home = "/home/$user"
) {
  #java
  class{ 'java':
    distribution => 'jdk',
    package      => 'openjdk-8-jdk',
    version      => 'present',
  }

  #groovy
  include 'repose_groovy'

  #scala
  include 'scala'

  #maven
  class{"repose_maven":
    user => "${user}",
  }

  #gradle
  class{ "repose_gradle":
    user => "${user}",
  }

  #intellij idea
  include 'repose_idea'

  #network tools
  package {'wireshark':
    ensure => present,
  }

  #git
  package {['git', 'gitk']:
    ensure => present
  }

  file {"$user_home/.gitconfig":
    content => template("basic_workstation/gitconfig"),
    owner   => $user,
    group   => $user,
    require => Package['git']
  }

  #debug tools
  package {'visualvm':
    ensure => present
  }

  #docker, and use Google's DNS server to prevent resolution issues
  class{ 'docker':
    dns => '8.8.8.8',
  }

  #vim
  package {'vim-gnome':
    ensure => present
  }

  #dot file viewer
  package {'xdot':
    ensure => present
  }

  #sdkman
  class { 'sdkman' :
    owner   => $user,
    homedir => $user_home,
  }

  #todo: figure out how to get slack

  #todo: figure out a way to get zoom and vpn in here
}
