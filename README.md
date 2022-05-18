# R-D
Run the Buildenv.sh script for creating the entire setup from end to end.
Command to run (./Buildenv.sh)
Vagrant file consists environment for docker.
It has three Docker files
Dockerfile1---frontend containers
Dockerfile2---backend containers
Dockerfile3---controller conatiner
The playbook vim_check_ansible yaml and hosts file for checking the vim package.
The playbook connected_users.yml for collecting inventory with hosts files.
Host file is an ansible inventory with all the hosts
date.sh is an shell script for creating a string with nodename,date,timestamp.
