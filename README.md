# ansible_microservices
Ansible microservices repo contains ansible recipes to make it easier to deploy a full Kafka infrastructure with service discovery. It relies heavily on repo https://www.github.com/jaubin/rhelbuildtools

## How-to run
First of all, upload the RPM packages generated in https://www.github.com/jaubin/rhelbuildtools to a Yum repo.

Then customize files in group_vars according to documentation, given that :
* zookeeper group is intended for Zookeeper hosts
* kafka group is intended for Kafka hosts
* avro group is intended for Avro hosts

Then customize the host file according to your needs.

Finally you can run the playbook with command :

̀```bash
ansible-playbook playbook.yml -i hosts --sudo --private-key=~/ssh/id_rsa
```
