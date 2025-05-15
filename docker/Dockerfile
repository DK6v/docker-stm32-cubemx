FROM ubuntu:24.04 AS install

ENV SHELL="/bin/bash"
ENV PATH="$PATH:/install"

WORKDIR /install

RUN \
# exit immediately if any command exits with a non-zero status
set -e; \
echo "----- Install pre-requirements -----"; \
export DEBIAN_FRONTEND=noninteractive; \
apt-get update; \
apt-get install -y \
  unzip; \
echo "----- DONE -----"

RUN \
# exit immediately if any command exits with a non-zero status
set -e; \
echo "----- Install packages -----"; \
apt-get install -y \
  openjdk-21-jre \    
  libglib2.0-0 \
  gsettings-desktop-schemas \
  x11-apps; \
echo "----- DONE -----"

RUN \
set -e; \
echo "----- Change user -----"; \
usermod -l project ubuntu; \
groupmod -n project ubuntu; \
usermod -d /project -m project; \
echo "----- DONE -----"

COPY *.stm32cubemx*.zip .
COPY auto-install.xml .
RUN \
echo "----- Install Stm32CubeMX -----"; \
unzip *.stm32cubemx*.zip; \
rm -rf *.zip; \
ls -al; \
SetupSTM32CubeMX* auto-install.xml; \
ls -al /cubemx; \
echo "----- DONE -----"

# Cleanup
RUN \
echo "----- Cleanup -----"; \
apt-get autoremove -y; \
apt-get clean; \
rm -rf /install /tmm/* /var/lib/apt/lists/*; \
echo "----- DONE -----"


## STAGE SQUASH
# -------------------------------------
FROM scratch
COPY --from=install / /

WORKDIR /cubemx
ENV PATH="$PATH:/cubemx"

COPY entrypoint.sh .
RUN chmod +x *.sh

ENTRYPOINT [ "entrypoint.sh" ]
