############################################################
# Dockerfile to build Nginx with Letsencrypt
############################################################

# Set the base image to Ubuntu
FROM phusion/baseimage:latest

# File Author / Maintainer
MAINTAINER Alex K <alexeykcontact@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# Copy application
COPY ./src/app /usr/share/
COPY ./src/app.js /usr/share/
COPY ./src/package.json /usr/share/

# Install node modules
RUN /usr/share/npm install

# Init
RUN mkdir -p /etc/my_init.d