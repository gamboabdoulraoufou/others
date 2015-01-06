
# On met d'abord à jour notre liste de packages.
apt-get update
apt-get upgrade

#Ensuite, on installe apache2 qui est la dernière version d'Apache.
apt-get install apache2

# On installe PHP et  ses dépendances
apt-get install libapache2-mod-php5 php5-mysql

#Installing pip anaconda (python) and virtualenv 
apt-get install bzip2
wget http://09c8d0b2229f813c1b93-c95ac804525aac4b6dba79b00b39d1d3.r79.cf1.rackcdn.com/Anaconda-2.0.1-Linux-x86_64.sh
bash Anaconda-2.0.1-Linux-x86_64.sh -b # -b stands for batch install
apt-get install python-pip python-virtualenv

# On verifie si le server est en écoute
netstat -antp | grep apache2

# On installe anaconda, pip et virtualenv

# On ajoute les utilusateurs
sudo su
adduser eurecia
# su - eurecia # pour se connecter en tant que eurecia
# su - abdoul_test


# Configuration du VirtualHost
cd /etc/apache2/sites-available/
cp default www.toto.com
cp default www.tutu.com
cp default www.myapp.com

nano www.toto.com

#configurer le fichier comme celui là
"""
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        ServerName www.toto.com
        
        DocumentRoot /var/www/toto/
        <Directory />
                Options FollowSymLinks
                AllowOverride all 
        </Directory>
        <Directory /var/www/toto/>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride all 
                Order allow,deny
                allow from all
        </Directory>

        ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
        <Directory "/usr/lib/cgi-bin">
                AllowOverride None
                Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
                Order allow,deny
                Allow from all
        </Directory>

        ErrorLog /var/log/apache2/error.log

        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel warn

        CustomLog /var/log/apache2/access.log combined

    Alias /doc/ "/usr/share/doc/"
    <Directory "/usr/share/doc/">
        Options Indexes MultiViews FollowSymLinks
        AllowOverride None
        Order deny,allow
        Deny from all
        Allow from 127.0.0.0/255.0.0.0 ::1/128
    </Directory>

</VirtualHost>
"""

# Acrivier les virtualshosts dans sites-enabled
cd ~
cd /etc/apache2/sites-enabled
ln -s ../sites-available/toto .
ln -s ../sites-available/tutu .
ln -s ../sites-available/myapp .

# Création des repertoires et pages du site
cd ~

mkdir /var/www/toto/
touch /var/www/toto/index.html
echo '<html><body><h1>Bienvenus sur toto.com !</h1></body></html>' > /var/www/toto/index.html

mkdir /var/www/tutu/
touch /var/www/tutu/index.html
echo '<html><body><h1>Bienvenus sur toto.com !</h1></body></html>' > /var/www/tutu/index.html

touch /home/eurecia/index.html
echo '<html><body><h1>La jolie page de ma sœur !</h1></body></html>' > /home/eurecia/index.html

mkdir -p /home/eurecia/public_html/


cd /var/www/
ln -s /home/eurecia/ myapp

cd ~ 
touch /home/eurecia/public_html/index.html
echo '<html><body><h1>La jolie page de my app </h1></body></html>' > /home/eurecia/public_html/index.html

# Initialiser le server
/etc/init.d/apache2 restrart



# Configuration d'un acces SSH
# Installation ssh
sudo apt-get install openssh-server

# Lancer le serviece SSH
sudo /etc/init.d/ssh start

# Connection ssh
ssh eurecia@www.myapp.com

# Configuration d'un ftp
# Installation d'un server ftp
sudo apt-get install proftpd # choisir le mode independament

# Configuration du server ftp
sudo nano /etc/proftpd/proftpd.conf



# connection
ftp ftp.myapp.com


--------------------------------------------
# Installation du mode WSGI
aptitude install libapache2-mod-wsgi

#Creating virtualenv
cd var/www/myapp
virtualenv env-eurecia

#activate the virtual env
env-myapp/bin/pip
source env-myapp/bin/activate
pip --version

# Desactivate vritual env
deactivate


#Installing Django inside virtualenv
env/bin/pip install django
python
import django 
exit
env-myapp/bin/python
import django
exit

# Creating django project
env-myapp/bin/django-admin.py startproject eurecia .

#env/bin/python manage.py runserver 0.0.0.0:8000

#Installing mod_wsgi for Apache
apt-get install libapache2-mod-wsgi

#Configuring mod_wsgi eurecia virtual host
nano /etc/apache2/sites-available/myapp
"""
<VirtualHost *:80>
    WSGIDaemonProcess eurecia python-path=/var/www/myapp/eurecia:/var/www/myapp/env-myapp/lib/python2.7/site-packages
    WSGIProcessGroup eurecia 
    WSGIScriptAlias / /var/www/myapp/eurecia/eurecia/wsgi.py 
    #WSGIScriptPath /var/www/myapp/eurecia/ 

    ServerAdmin webmaster@localhost 
    ServerName www.myapp.com 
    #DocumentRoot /var/www/myapp 

    <Directory /var/www/myapp/eurecia/>
        <Files wsgi.py> 
            Order deny,allow 
            Allow from all 
        </Files> 
    </Directory> 

    ErrorLog ${APACHE_LOG_DIR}/error.log 
    # Possible values include: debug, info, notice, warn, error, crit, 
    # alert, emerg. 
    LogLevel warn 
    
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
"""

    
cd ~
etc/init.d/apache2 restrat



