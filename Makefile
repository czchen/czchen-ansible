.PHONY: setup
setup: ansible asdf golang snap yarn
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

.PHONY: snap
snap:
	sudo snap install authy --beta
	sudo snap install intellij-idea-community --classic
	sudo snap install kontena-lens --classic
	sudo snap install kubectl
	sudo snap install vault
	sudo snap install yq

.PHONY: yarn
yarn:
	yarn add global kubelive
