FROM centos:centos7

ENV STORAGE=malloc
ENV STORAGE_SIZE=2G

RUN yum update -y && \
  yum install -y epel-release && \
  yum install -y varnish && \
  yum install -y libmhash-devel && \
  yum clean all


RUN mkdir -p /var/lib/varnish/


ADD default.vcl /etc/varnish/
ADD devicedetect.vcl /etc/varnish/
# ADD secret /etc/varnish/

ADD start.sh /start.sh
RUN chmod 0755 /start.sh

EXPOSE 80

CMD ["/start.sh"]
