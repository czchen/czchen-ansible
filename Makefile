.PHONY: setup
setup: ansible asdf krew golang pipx snap yarn
	echo "setup completed"

.PHONY: ansible
ansible:
	ansible-playbook --ask-become-pass --extra-vars="hosts=localhost" site.yml

define install-asdf
	asdf plugin-add $(1) || true
	asdf plugin-update $(1)
	asdf install $(1) $(2)
	asdf global $(1) $(2)
endef
.PHONY: asdf
asdf:
	$(call install-asdf,helm,3.1.2)
	$(call install-asdf,k9s,0.19.2)
	$(call install-asdf,nodejs,10.20.1)
	$(call install-asdf,sbt,1.3.10)
	$(call install-asdf,terraform,0.12.24)
	$(call install-asdf,yarn,1.22.4)

.PHONY: krew
krew:
	kubectl krew install ctx
	kubectl krew install debug
	kubectl krew install grep
	kubectl krew install iexec
	kubectl krew install tail
	kubectl krew install tree

define install-golang
	go get -u $(1)
endef
.PHONY: golang
golang:
	$(call install-golang,github.com/bronze1man/yaml2json)
	$(call install-golang,github.com/cswank/kcli)
	$(call install-golang,github.com/prometheus/prometheus/cmd/...)
	$(call install-golang,github.com/senorprogrammer/wtf)
	$(call install-golang,github.com/ueokande/logbook)
	$(call install-golang,github.com/wercker/stern)
	$(call install-golang,github.com/xo/usql)

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
	$(call install-pipx,mycli)
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
	$(call install-snap,intellij-idea-community,--classic)
	$(call install-snap,kontena-lens,--classic)
	$(call install-snap,postman)
	$(call install-snap,kubectl)
	$(call install-snap,vault)
	$(call install-snap,yq)

define install-yarn
	yarn add global $(1)
endef
.PHONY: yarn
yarn:
	$(call install-yarn,kubelive)
