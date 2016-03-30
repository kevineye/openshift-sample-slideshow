FROM nginx:alpine

# documentation specific to openshift containers
# https://docs.openshift.org/latest/creating_images/guidelines.html#openshift-specific-guidelines

# change listening port from 80 to 8080
# openshift containers do not run as privileged users
RUN sed -r -i 's/listen +80;/listen 8080;/' /etc/nginx/nginx.conf
EXPOSE 8080

# make various directories world-writable
# openshift containers run as random users
RUN chmod -R go+u /var/cache/nginx /var/run

# copy in sample files
COPY public-html /etc/nginx/html
