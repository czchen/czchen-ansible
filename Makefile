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

define install-pipx
	pipx install $(1) || pipx upgrade $(1)
endef
.PHONY: pipx
pipx:
	$(call install-pipx,autopep8)
	$(call install-pipx,bump2version)
	$(call install-pipx,httpie)
	$(call install-pipx,j2cli)
	$(call install-pipx,linode-cli)
	$(call install-pipx,pipenv)
	$(call install-pipx,python-language-server)
	$(call install-pipx,tldr)
	$(call install-pipx,yaml-resume)

define install-snap
	sudo snap install $(1) $(2)
	sudo snap refresh $(1)
endef
.PHONY: snap
snap:
	$(call install-snap,authy,--beta)
	$(call install-snap,google-cloud-sdk)
	$(call install-snap,intellij-idea-community,--classic)
	$(call install-snap,kontena-lens,--classic)
	$(call install-snap,postman)
	$(call install-snap,kubectl)
	$(call install-snap,vault)
	$(call install-snap,yq)

.PHONY: yarn
yarn:
	yarn add global kubelive
