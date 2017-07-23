# Run Chrome Headless in a container
#
# Inspired by https://raw.githubusercontent.com/justinribeiro/dockerfiles/master/chrome-headless
#
# What's New 
# 
# 1. Pulls from Chrome Stable
# 2. You can now use the ever-awesome Jessie Frazelle seccomp profile for Chrome.
#     wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O ~/chrome.json
#
#
# To run (without seccomp):
# docker run -d -p 9222:9222 --cap-add=SYS_ADMIN valentinvieriu/chrome-headless
# 
# To run a better way (with seccomp):
# docker run -d -p 9222:9222 --security-opt seccomp=$HOME/chrome.json valentinvieriu/chrome-headless 
#
# Basic use: open Chrome, navigate to http://localhost:9222/
#

# Base docker image 
FROM debian:sid
LABEL name="chrome-headless" \ 
			maintainer="Valentin Vieriu<valentin.vieriu@gmail.com>" \
			version="1.0" \
			description="Google Chrome Headless in a container"

ARG CHROME_VERSION=59.0.3071.115-1
ENV CHROME_VERSION $CHROME_VERSION

# Install deps + add Chrome Stable + purge all the things
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
  gnupg \
	--no-install-recommends \
	&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update && apt-get install -y \
	google-chrome-stable=$CHROME_VERSION \
	--no-install-recommends \
	&& apt-get purge --auto-remove -y curl gnupg \
	&& rm -rf /var/lib/apt/lists/*

# Add Chrome as a user
RUN groupadd -r chrome && useradd -r -g chrome -G audio,video chrome \
    && mkdir -p /home/chrome && chown -R chrome:chrome /home/chrome

# Run Chrome non-privileged
USER chrome

# Expose port 9222
EXPOSE 9222

# Autorun chrome headless with no GPU
ENTRYPOINT [ "google-chrome-stable" ]
CMD [ "--headless", "--disable-gpu", "--remote-debugging-address=0.0.0.0", "--remote-debugging-port=9222" ]