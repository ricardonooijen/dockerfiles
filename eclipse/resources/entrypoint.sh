#!/bin/sh
#
# Entrypoint to 'sync' uid and gid of the eclipse user in the 
# container so we write as the same user that owns the possible
# mounted workspace. Otherwise we might have permission issues
# when we modify files from eclipse (especially if we run other
# build commands from outside this container).
#

set -x

# Get uid and gid of possible mounted workspace
WORKSPACE_UID=`stat -c '%u' /home/eclipse/workspace`
WORKSPACE_GID=`stat -c '%g' /home/eclipse/workspace`

if [ `id -u` != $WORKSPACE_UID ]; then
        usermod -u $WORKSPACE_UID eclipse
        # Also fix homedir permissions
        chown eclipse /home/eclipse
fi
if [ `id -g` != $WORKSPACE_GID ]; then
        groupmod -g $WORKSPACE_GID eclipse
        # Also fix homedir permissions
        chown :eclipse /home/eclipse
fi

exec gosu eclipse /opt/eclipse/oxygen/eclipse ${@}
