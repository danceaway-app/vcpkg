FROM ghcr.io/danceaway-app/cpp-gnu:latest
RUN sudo apt-get update && sudo apt-get install -y python3-simplejson
RUN mkdir -p /opt/vcpkg-binary-cache
