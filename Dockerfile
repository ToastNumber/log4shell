FROM centos
WORKDIR /usr/local/log4shell
COPY ./ ./
RUN yum install gcc java-1.8.0-openjdk-devel maven make wget groff-base sudo -y
RUN make customize-config
RUN make /usr/local/var/openldap-data
RUN make /usr/local/etc/slapd.d
RUN rm -rf openldap*
CMD ["/usr/sbin/init"]
