#!/bin/env bash
shopt -s nullglob
set -e

BUILDDIR=./build

usage() {
  echo "Usage: $0 [ OPTIONS ]" 
  echo
  echo "Builds all haskell files in present working directory with -O2"
  echo "Options:"
  echo "  -c     Remove all files from 'build' directory and exit"
  echo "  -h     Show this help message and exit"
}

while getopts "hc" arg; do
  case $arg in
    h) # Help
      usage
      exit 0
    ;;
    c) # Clean
      command="rm $BUILDDIR/*"
      echo $command
      exec $command
      exit 0
      ;;
  esac
done

if [ ! -d $BUILDDIR ]; then
  mkdir $BUILDDIR
fi

for file in $(pwd)/*.hs
do
  tmpdir=$(mktemp -d)
  # check if executable already exists
  target="$BUILDDIR/$(basename $file .hs)"
  command="ghc -no-keep-o-files -no-keep-hi-files -outputdir $tmpdir -O2 $file -o $target"
  if [ -f $target ]; then
    targetLastModified=$(date -r $target "+%s")
    sourceLastModified=$(date -r $file "+%s")
    if [ $targetLastModified -gt $sourceLastModified ]; then
      echo "Nothing to do for $target"
      rm -rf $tmpdir &
    else
      exec $command && rm -rf $tmpdir &
    fi
  else
      exec $command && rm -rf $tmpdir &
  fi
done
wait
