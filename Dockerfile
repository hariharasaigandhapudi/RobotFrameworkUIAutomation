FROM ubuntu:18.04

LABEL name="Docker build demo Robot Framework"

MAINTAINER "HariHaraSai"
RUN echo "$PWD"
WORKDIR /home/Automation
COPY Libraries /home/Automation/Libraries
COPY Tests /home/Automation/Tests

RUN apt-get update \
    && apt-get install -y xvfb wget ca-certificates fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 \
       libatspi2.0-0 libcups2 libdbus-1-3 libgbm1 libgtk-3-0 libnspr4 libnss3 \
       libxcomposite1 libxkbcommon0 libxrandr2 xdg-utils ntpdate openssl libcurl3-gnutls libcurl3-nss libcurl4 libcurl3

# install chrome and chromedriver in one run command to clear build caches for new versions (both version need to match)
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome*.deb \
    && rm google-chrome*.deb \
    && wget -q https://chromedriver.storage.googleapis.com/95.0.4638.54/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && rm chromedriver_linux64.zip \
    && mv chromedriver /usr/local/bin \
    && chmod +x /usr/local/bin/chromedriver
 
FROM python:3.10
    
RUN apt-get install -y nginx git python-setuptools python-dev


RUN pip install robotframework && pip install robotframework-requests &&  pip install robotframework-seleniumlibrary \
    && pip install xvfbwrapper && pip install robotframework-xvfb && pip install certifi && pip install asn1crypto \
    && pip install bcrypt && pip install robotframework-sshlibrary && pip install cryptography && pip install pyOpenSSL \
    && pip install idna && pip install requests[security] && pip install PyYAML

CMD ["robot /home/Automation/Tests/Sources/."]
