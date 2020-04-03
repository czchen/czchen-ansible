.PHONY: setup
setup: ansible snap
	echo "setup completed"

.PHONY: ansible
ansible:
	ansible-playbook --ask-become-pass --extra-vars="hosts=localhost" site.yml

.PHONY: snap
snap:
	sudo snap install authy --beta
	sudo snap install intellij-idea-community --classic
	sudo snap install kontena-lens --classic
	sudo snap install kubectl
	sudo snap install vault
	sudo snap install yq
