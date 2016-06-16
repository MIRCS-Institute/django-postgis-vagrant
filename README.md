# django-postgis-vagrant

To run the project do the following:

1. Install Vagrant by following the instructions https://www.vagrantup.com/docs/installation/
2. Clone this repo to your machine
3. Navigate to inside django-postgis-vagrant/
4. Run vagrant up
5. Once the installation finsihes navigate to django-postgis-vagrant/data
6. Inside the data folder clone https://github.com/alexetnunes/mircs-geogenealogy
7. Navigate back to django-postgis-vagrant/ (cd ..)
8. Run vagrant provision
9. To Stop the server run: vagrant halt
10. To Start the serve run: vagrant up


#Restarting Django to see Debug Output
1. 'vagrant ssh' to get into the box after having executed 'vagrant up'
2. 'ps aux | grep py' to list running Python processes
3. Copy the first of the two listed commands to your clipboard
4. run 'kill -9 pid1 pid2' where pid1 and pid2 are the process IDs given in the 'ps aux' output
5. paste the command from your clipboard and execute
6. You should now see django output in your terminal
