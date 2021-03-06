FROM goodrainapps/jekyll:3.6.2

MAINTAINER zhouyq@goodrain.com


# set timezone and install nginx
ENV TZ=Asia/Shanghai
RUN apk add --no-cache tzdata nginx \
    && mkdir /run/nginx \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >  /etc/timezone


# add cron
# RUN crontab -l | { cat; echo "* * * * * cd /srv/jekyll;./build.sh "; } | crontab -

WORKDIR /srv/jekyll

COPY Gemfile /srv/jekyll
COPY Gemfile.lock /srv/jekyll

# 安装组件
RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com && bundle
#RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.org && bundle

COPY . /srv/jekyll
COPY etc /etc

EXPOSE 80
EXPOSE 4000
ENTRYPOINT ["/srv/jekyll/run.sh"]
