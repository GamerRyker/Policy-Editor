#!/bin/bash

  echo "Welcome to the Policy Revert, this is for when your school's IT admin wants to check your shizz and you need to revert the policies"
  echo "IMPORTANT! THIS WILL BLOCK YOUR UNALLOWED EXTENSIONS AND LOOSE YOUR DEV TOOLS IN CHROME!!"

  read -p "Would you like to continue? y or n: " CONTINUE_REV

  if [ "$CONTINUE_REV" = 'y' ]; then
    cd /etc && rm -rf opt

    echo "Thanks for playing" && reboot
  else
    echo "Never mind, " && exit
  fi
    
    
