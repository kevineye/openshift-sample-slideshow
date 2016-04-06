FROM nginx:alpine

# documentation specific to openshift containers
# https://docs.openshift.org/latest/creating_images/guidelines.html#openshift-specific-guidelines

# change listening port from 80 to 8080 and disable user switch
# openshift containers do not run as privileged users
RUN sed -r -i 's/listen +80;/listen 8080;/' /etc/nginx/conf.d/default.conf \
 && sed -r -i 's/user +nginx;/#user nginx;/' /etc/nginx/nginx.conf
EXPOSE 8080

# make various directories world-writable
# openshift containers run as random users
RUN chmod -R go+u /var/cache/nginx /var/run

# run as a non-root user by ID
# openshift will not actually run as this uid
# it picks a random uid
USER 1000

# copy in sample files
COPY public-html /usr/share/nginx/html
