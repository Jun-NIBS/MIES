#!/bin/sh

# Perform a clean MIES installation
# Copies the procedures to the "User Procedures" folder. This is different from
# what Readme.md suggests, but we need that for our compilation testing.

set -e

if [ "$#" -gt 0 -a "$1" = "skipHardwareXOPs" ]
then
  installHWXOPs=0
else
  installHWXOPs=1
fi

git --version > /dev/null
if [ $? -ne 0 ]
then
  echo "Could not find git executable"
  exit 1
fi

top_level=$(git rev-parse --show-toplevel)

if [ ! -d "$top_level" ]
then
  echo "Could not find git repository"
  exit 1
fi

versions="7 8"

for i in $versions
do
  case $MSYSTEM in
    MINGW*)
        IGOR_USER_FILES="$USERPROFILE/Documents/WaveMetrics/Igor Pro ${i} User Files"
        ;;
      *)
        IGOR_USER_FILES="$HOME/WaveMetrics/Igor Pro ${i} User Files"
        ;;
  esac

  rm -rf "$IGOR_USER_FILES"

  user_proc="$IGOR_USER_FILES/User Procedures"
  xops64="$IGOR_USER_FILES/Igor Extensions (64-bit)"
  xops32="$IGOR_USER_FILES/Igor Extensions"

  mkdir -p "$user_proc"

  rm -rf "$top_level"/Packages/doc/html
  cp -r  "$top_level"/Packages/*  "$user_proc"

  mkdir -p "$xops32" "$xops64"

  if [ "$installHWXOPs" = "1" ]
  then
    cp -r  "$top_level"/XOPs-IP${i}/*  "$xops32"
    cp -r  "$top_level"/XOPs-IP${i}-64bit/*  "$xops64"

    cp -r  "$top_level"/XOP-tango/* "$xops32"
    # no specific tango XOP version for IP8
    cp -r  "$top_level"/XOP-tango-IP7-64bit/* "$xops64"
  else
    cp -r  "$top_level"/XOPs-IP${i}/HDF5*  "$xops32"
    cp -r  "$top_level"/XOPs-IP${i}-64bit/HDF5*  "$xops64"
    cp -r  "$top_level"/XOPs-IP${i}/MIESUtils*  "$xops32"
    cp -r  "$top_level"/XOPs-IP${i}-64bit/MIESUtils*  "$xops64"
  fi

  echo "Release: FAKE MIES VERSION" > "$IGOR_USER_FILES"/version.txt
done

exit 0
