#!/usr/bin/env bash
set -e
umask 002

# D-Bus is an Inter-Process Communication (IPC) and Remote Procedure Calling (RPC) mechanism.
# D-Bus allows QT applications to send messages to each other.
DBUS_SESSION_BUS_ADDRESS=$(dbus-daemon --fork --config-file=/usr/share/dbus-1/session.conf --print-address)
export DBUS_SESSION_BUS_ADDRESS

uid=${UID:-1000}
if [ "$uid" -eq 0 ]; then
  uid='1000'
fi

gid=${gid:-1000}
if [ "$gid" -eq 0 ]; then
  gid='1000'
fi

if ! getent passwd "$uid" > /dev/null; then
  useradd --uid "$uid" -m project || exit 1
  echo "** User 'project' created with UID ${UID}"
fi
USER=$(getent passwd "$uid" | cut -d: -f1)

if ! getent group "$gid" > /dev/null; then
  addgroup --quiet --gid "$gid" project || exit 1
  echo "** Group 'project' created with GID ${GID}"
fi
GROUP=$(getent group "$gid" | cut -d: -f1)
usermod -a -G "$USER" "$GROUP"

# Change ownership of the working directory
chown "$uid:$gid" /project

su "$USER" -s /bin/bash -c " \
  echo '--- START STM32 CUBEMX ---'
  java -jar STM32CubeMX
"
