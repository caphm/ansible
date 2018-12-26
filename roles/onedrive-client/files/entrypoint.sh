#!/bin/bash

# Setup user/group ids
if [ ! -z "${ONEDRIVE_UID}" ]; then
  if [ ! "$(id -u onedrive)" -eq "${ONEDRIVE_UID}" ]; then
    
    # usermod likes to chown the home directory, so create a new one and use that
    # However, if the new UID is 0, we can't set the home dir back because the
    # UID of 0 is already in use (executing this script).
    if [ ! "${ONEDRIVE_UID}" -eq 0 ]; then
      mkdir /tmp/temphome
      usermod -d /tmp/temphome onedrive
    fi
    
    # Change the UID
    usermod -o -u "${ONEDRIVE_UID}" onedrive
    
    # Cleanup the temp home dir
    if [ ! "${ONEDRIVE_UID}" -eq 0 ]; then
      usermod -d /config onedrive
      rm -Rf /tmp/temphome
    fi
  fi
fi

if [ ! -z "${ONEDRIVE_GID}" ]; then
  if [ ! "$(id -g onedrive)" -eq "${ONEDRIVE_GID}" ]; then
    groupmod -o -g "${ONEDRIVE_GID}" onedrive
  fi
fi

# Start OndeDrive Free Client as designated user
exec su-exec onedrive "$@"
