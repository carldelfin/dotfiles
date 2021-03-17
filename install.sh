#!/bin/bash

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "$package - attempt to capture frames"
      echo " "
      echo "$package [options] application [arguments]"
      echo " "
      echo "options:"
      echo "-h, --help                show help"
      echo "-f, --full                do a full system install"
      echo "-m, --minimal             do a minimal system install"
      exit 0
      ;;
    -f|--full)
      shift
      source ~/dotfiles/install/minimal_install.sh
      source ~/dotfiles/install/full_install.sh
      exit 0
      shift
    -m|--minimal)
      shift
      source ~/dotfiles/install/minimal_install.sh
      exit 0
      shift
      ;;
    *)
      break
      ;;
  esac
done
