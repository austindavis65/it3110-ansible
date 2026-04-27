# System Monitor Script

To use this script all you need to do is run the file called startup.sh

Ansible is required to use this.
This script must be run in a directory where you can write and execute files.

This script lets you see the disk usage %, memory usage %, and CPU usage % on a remote server that you can ssh to.
It will ask for an IP, user, and pass as well as a service that you wish to know if it is active or not.
It will output a file into a directory called outputs that gives the time and date that it was ran.

