#!/bin/sh

USERNAME=snapcast
OWNER=${OWNER:-65534}
GROUP=${GROUP:-65534}
echo "lol"
# create users matching ids passed if necessary
if [[ ${GROUP} -gt 65534 || ${GROUP} -lt 1000 ]]; then
  echo "invalid gid"
  exit 1
fi

if [[ ${OWNER} -gt 65534 || ${OWNER} -lt 1000 && ${OWNER} -ne 666 ]]; then
  echo "invalid uid"
  exit 1
fi

if getent passwd ${OWNER} ; then deluser $(getent passwd ${OWNER} | cut -d: -f1); fi
if getent group ${GROUP} ; then delgroup $(getent group ${GROUP} | cut -d: -f1); fi

addgroup --gid $GROUP $USERNAME
useradd -g $GROUP -u $OWNER -m -s /bin/nologin $USERNAME

# create the directory if necessary
if [ ! -d /tmp/snapcast/ ]; then
  mkdir -p /tmp/snapcast/
  chown $OWNER:$GROUP /tmp/snapcast/
fi

echo setup finished
exec /bin/su $USERNAME -s /bin/sh -c /usr/bin/snapserver "$@"