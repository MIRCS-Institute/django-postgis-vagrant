#!/bin/bash
# miniconda_install.sh
# Download and install the latest Miniconda

miniconda=Miniconda-latest-Linux-x86.sh
condapackages="django pandas Jinja2 sqlalchemy psycopg2"

cd /vagrant
if [[ ! -f $miniconda ]]; then
    wget --quiet http://repo.continuum.io/miniconda/$miniconda
fi
chmod +x $miniconda
sudo ./$miniconda -b -p /opt/anaconda
sudo chown -R vagrant /opt/anaconda

#Install conda packages
/opt/anaconda/bin/conda config --add channels IOOS
/opt/anaconda/bin/conda install --yes -q -c https://conda.anaconda.org/ioos $condapackages
/opt/anaconda/bin/pip install aldjemy


# Add the Anaconda python executables to the path for the vagrant user
cat >> /home/vagrant/.bashrc << END
# add for anaconda install
PATH=/opt/anaconda/bin:\$PATH
PATH=/opt/anaconda/lib:\$PATH

END

# Run the ipython notebook server on all IP addresses.
# This is in the Vagrantfile.. suggest leaving it out here.
# cd /home/vagrant && /opt/anaconda/bin/ipython notebook --no-browser --ip="*" &
