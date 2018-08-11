# ansible_microservices
Ansible microservices repo contains ansible recipes to make it easier to deploy a full Kafka infrastructure with service discovery. It relies heavily on repo https://www.github.com/jaubin/rhelbuildtools

It requires Ansible 2.4+ to run, which is provided on RHEL 7 and Debian stable through backports.

## How-to run
First of all, upload the RPM packages generated in https://www.github.com/jaubin/rhelbuildtools to a Yum repo.

Then customize files in ```inventory/<your_env>/group_vars``` according to documentation, given that :
* zookeeper group is intended for Zookeeper hosts
* kafka group is intended for Kafka hosts
* api-gateway is intended for the API gateway hosts

Then customize the ```inventory/<your_env>/hosts``` file according to your needs.

Finally you can run the playbook with command :

```bash
ansible-playbook playbook.yml -i inventory/<your_env>/hosts --sudo --private-key=~/ssh/id_rsa
```

## Development resources

If you want to develop without the need of many machines I've provided the docker-compose file I used, alongside the
SSH key used to log on machines. All of this is in directory ```dev_resources```. The goal there is to make you save time
when you wish to modify the playbooks.

I strongly recommend that you put the ```dev_resources``` directory in some other location before playing with it.

Some important notices :
* The user used to log in on the control with SSH is ```app-admin```. The key to use for logging in is provided in the ```ssh``` subdirectory. This user has complete sudo rights. In order to log onto the Control container use command :
```
ssh -p 2229 -i ssh/id_rsa -o StrictHostKeyChecking=no app-admin@localhost
```
* You'll probably want to adjust the mapped directories. Make sure the volumes are bound in such a way that users in Docker containers have read-write access to each of the directories bound to docker containers.
* In the control container, from which the playbook is expected to be run, you must first run the following commands :
```bash
sudo yum -y install ansible
sudo mkdir ~app-admin/.ansible
sudo chown -R app-admin:app-admin ~app-admin/.ansible
export ANSIBLE_HOST_KEY_CHECKING=False
```
Then you can run the playbook with command :
```
ansible-playbook playbook.yml -i inventory/devel/hosts -u user --become -e "ansible_ssh_pass=secret"
```
Note that you must ensure that your Docker containers can reach Internet, as the playbook will install packages from YUM repos. Linux users will also need to reconfigure their firewall to allow
network communications from / to the containers.

### Testing service discovery

First of all compile the app within folder ```test_app_dir/test_app``` using command ```mvn clean install```. It is assumed that Maven is installed on your workstation.

From within Docker, connect to the app-test container using command :
```
ssh user@app-test
```
The password is ```secret```.

Inside the container run :
```
sudo yum -y install curl java-1.8.0-openjdk-devel
/appdir/test_app/start_app.sh
```

Happy hacking !
