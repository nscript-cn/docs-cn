#!/bin/bash

set -e

nodejs() {
    curl https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash

    . ~/.nvm/nvm.sh
    nvm install v6.11.4
    nvm alias default 6.11.4
}

gruntcli() {
    npm install -g grunt-cli
}

typedoc() {
    npm install -g typedoc@"^0.5.10"
}

typescript() {
    npm install -g typescript@"~2.3.4"
}

tslint() {
    npm install -g tslint@"^5.4.2"
}

markdown-snippet-injector() {
    npm install -g markdown-snippet-injector@"^0.2.0"
}

install_ruby() {

    command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
    curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3.0
    . ~/.rvm/scripts/rvm
    gem install bundler
}

install_project_gems() {
    cd /vagrant
    bundle install
}

setNsRemoteRepoDirVar() {
    echo "export NS_REPO_DIR=/ns/_remoteRepo" >> ~/.bashrc
}

setSdkRemoteRepoDirVar() {
    echo "export SDK_REPO_DIR=/ns-ng-sdk/_remoteRepo" >> ~/.bashrc
}

if [ "${BASH_SOURCE[0]}" == "$0" ] ; then
    nodejs
    gruntcli
    typedoc
    typescript
    tslint
    markdown-snippet-injector
    install_ruby
    install_project_gems
    setNsRemoteRepoDirVar
    setSdkRemoteRepoDirVar
fi
