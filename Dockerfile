###
# To manually start your image:
# Make sure you create the folders suites, scrips and reports
# docker run --rm -ti --network=host -v "$PWD/output:/output" -v "$PWD/suites:/suites" -v "$PWD/scripts:/scripts" -v "$PWD/reports:/reports"  robot  bash
#  1. docker build . (copy imageid)
#  2. docker run -it --name <name_of_the_conatiner> <image ID> /bin/bash
#  3. robot Tests/Sources/. --outputdir Tests/Results

###

FROM python:3.10.0

LABEL name="Docker build demo Robot Framework"

MAINTAINER "HariHaraSai"
RUN echo "$PWD"
WORKDIR /Automation
COPY Libraries /Automation/Libraries
COPY Tests /Automation/Tests

ENV PYTHONPATH "${PYTHONPATH}:/Automation/Libraries"

RUN apt-get update \
    && apt-get install -y xvfb wget ca-certificates fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 \
       libatspi2.0-0 libcups2 libdbus-1-3 libgbm1 libgtk-3-0 libnspr4 libnss3 \
       libxcomposite1 libxkbcommon0 libxrandr2 xdg-utils ntpdate openssl

RUN python3 -m pip install robotframework && pip install robotframework-requests &&  pip install robotframework-selenium2library \
    && pip install xvfbwrapper && pip install robotframework-xvfb && pip install certifi && pip install asn1crypto \
    && pip install bcrypt && pip install robotframework-sshlibrary && pip install cryptography && pip install pyOpenSSL \
    && pip install idna && pip install requests[security] && pip install PyYAML

# install chrome and chromedriver in one run command to clear build caches for new versions (both version need to match)
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome*.deb \
    && rm google-chrome*.deb \
    && wget -q https://chromedriver.storage.googleapis.com/95.0.4638.54/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && rm chromedriver_linux64.zip \
    && mv chromedriver /usr/local/bin \
    && chmod +x /usr/local/bin/chromedriver

CMD ["robot Tests/Sources/."]
