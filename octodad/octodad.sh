#!/bin/sh
# Octodad: Dadliest Catch

OCTODAD_HOME="/opt/octodad"
USER_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/octodad"

mkdir -p "${USER_DATA_HOME}"
cd "${USER_DATA_HOME}"

if [ ! -d "Content" ]; then ln --symbolic "${OCTODAD_HOME}/Content"; fi

for TARGET in \
  'libfmodevent-4.44.30.so'\
  'libfmodevent.so'\
  'libfmodex-4.44.30.so'\
  'libfmodex.so'\
  'OctodadDadliestCatch' ; do
  if [ ! -f "${TARGET}" ]; then ln --symbolic "${OCTODAD_HOME}/${TARGET}"; fi
done

./"OctodadDadliestCatch"
