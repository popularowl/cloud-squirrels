FROM jenkins/jenkins:latest

RUN /usr/local/bin/install-plugins.sh git matrix-auth blueocean

ENV JENKINS_USER admin
ENV JENKINS_PASS admin

# allows to skip Jenkins setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Jenkins runs all grovy files from init.groovy.d dir
# use this for creating default admin user
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

# volume for Jenkins settings
VOLUME /var/jenkins_home