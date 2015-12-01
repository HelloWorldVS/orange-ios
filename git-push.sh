#!/bin/sh

 DISPLAY_MESSAGE=""

 echo "Please input the commit message(Required):"
 read message

 if [ "" = "$message" ]
 then
     message="Update some files."
     DISPLAY_MESSAGE="(No Message default is)"
 fi

 while true;do
     echo  "The message$DISPLAY_MESSAGE: $message, do you commit and push(yes or no)?"
     read sure
     case $sure in
         Y|y|yes|YES)
             break;;
         N|n|no|NO)
             exit;;
     esac
done

echo commit...
git commit -m $message
 
echo push to git.orange.com...
git push -u orange --all

echo push to Github...
git push -u github --all
