FROM ubuntu:14.04

MAINTAINER amedee

RUN apt-get update
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get -y install make g++ python git ruby ruby-dev software-properties-common
RUN add-apt-repository -y ppa:nginx/stable && apt-get update && apt-get -y install nginx

#Do not forget to install your markdown converter gem  
#( e.g. kramdown or rdisount)
RUN gem install bundler therubyracer jekyll kramdown --no-rdoc --no-ri

#Download website from github and build it
ENV GIT_REPO https://github.com/amedeedaboville/amedeedaboville.com.git
ENV TMP_GIT_CLONE $HOME/tmp/
ENV PUBLIC_WWW /var/www/blog

RUN git clone $GIT_REPO $TMP_GIT_CLONE
RUN jekyll build -s $TMP_GIT_CLONE -d $PUBLIC_WWW
RUN cp $TMP_GIT_CLONE/nginx.conf /etc/nginx/nginx.conf
RUN cp $TMP_GIT_CLONE/sites-available /etc/nginx/sites-available/default
RUN rm -Rf $TMP_GIT_CLONE

#Set the default workdir
WORKDIR $PUBLIC_WWW

#Expose the default port from jekyll
EXPOSE 80

#Set the default command to execute at launch
CMD ["nginx"]
