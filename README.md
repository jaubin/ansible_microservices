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

```bash
ansible-playbook playbook.yml -i hosts --sudo --private-key=~/ssh/id_rsa
```

## Development resources

If you want to develop without the need of many machines I've provided the docker-compose file I used, alongside the
SSH key used to log on machines. All of this is in directory ```dev_resources```. The goal there is to make you save time
when you wish to modify the playbooks.

I strongly recommend that you put the ```dev_resources``` directory in some other location before playing with it.

Some important notices :
* The user used to log in on containers with SSH is ```app-admin```. The key to use for logging in is provided in the ```ssh``` subdirectory. This user has complete sudo rights.
* You'll probably want to adjust the mapped directories. Make sure the volumes are bound in such a way that users in Docker containers have read-write access to each of the directories bound to docker containers.
* In the control container, from which the playbook is expected to be run, you must first run the following commands :
```bash
sudo yum -y install ansible
sudo mkdir ~app-admin/.ansible
sudo chown -R app-admin:app-admin ~app-admin/.ansible
```
Note that you must ensure that your Docker containers can reach Internet, as the playbook will install packages from YUM repos. Linux users will also need to reconfigure their firewall to allow
network communications from / to the containers.

Happy hacking !
