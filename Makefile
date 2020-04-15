.PHONY: setup
setup: ansible asdf golang pipx snap yarn
	echo "setup completed"

.PHONY: ansible
ansible:
	ansible-playbook --ask-become-pass --extra-vars="hosts=localhost" site.yml

.PHONY: asdf
asdf:
	asdf plugin-add helm
	asdf plugin-add kops
	asdf plugin-add terraform

.PHONY: golang
golang:
	go get -u github.com/cswank/kcli
	go get -u github.com/senorprogrammer/wtf
	go get -u github.com/ueokande/logbook
	go get -u github.com/wercker/stern
	go get -u github.com/xo/usql
	go get -u github.com/prometheus/prometheus/cmd/...
	go get -u github.com/hairyhenderson/gomplate/cmd/gomplate

.PHONY: pipx
pipx:
	pipx install autopep8 || pipx upgrade autopep8
	pipx install bump2version || pipx upgrade bump2version
	pipx install j2cli || pipx upgrade j2cli
	pipx install linode-cli || pipx upgrade linode-cli
	pipx install pipenv || pipx upgrade pipenv
	pipx install python-language-server || pipx upgrade python-language-server
	pipx install tldr || pipx upgrade tldr
	pipx install yaml-resume || pipx upgrade yaml-resume

.PHONY: snap
snap:
	sudo snap install authy --beta
	sudo snap install intellij-idea-community --classic
	sudo snap install kontena-lens --classic
	sudo snap install kubectl
	sudo snap install postman
	sudo snap install vault
	sudo snap install yq

.PHONY: yarn
yarn:
	yarn add global kubelive
