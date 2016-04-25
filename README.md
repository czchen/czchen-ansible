# czchen-ansible

[![Build Status](https://gitlab.com/czchen/czchen-ansible/badges/branch/build.svg)](https://gitlab.com/czchen/czchen-ansible)

czchen environment setup script. Use the following command to setup environment
in `localhost`.

```
ansible-playbook --ask-become-pass --extra-vars="hosts=localhost" playbooks/czchen.yml
```
