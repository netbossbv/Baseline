#!/bin/bash

# Path to SwiftDialog
dialog='/usr/local/bin/dialog'

# get the first name and ID of currently logged-in user
loggedInUser=$(id -un)
loggedInUserID=$(/usr/bin/id -u "$loggedInUser")
firstName=$(/usr/bin/id -F "$currentUser"| cut -d ' ' -f 2)

runAsUser() {
  if [ "$loggedInUser" != "loginwindow" ]; then
    uid=$(id -u "$loggedInUser")
    /bin/launchctl asuser "$uid" sudo -u "$loggedInUser" "$@"
  fi
}

###########################################################################################################################################################################
# Display the Welcome message using swiftDialog
###########################################################################################################################################################################

runAsUser $dialog \
--blurscreen \
--ontop \
--title "Hi $firstName!" \
--icon "https://github.com/netbossbv/Baseline/blob/c1262d0bce2f56cb05e5bc637a75d5fb72772605/pictures/LogoLarge.png" \
--message "We're going to setup your MacBook and install some required applications. This may take some time, grab a coffee!\n\nWhen the installation is finished, a message will be shown. Click 'OK' and you'll land on the desktop. Proceed to reboot your MacBook from the Apple menu.\n\n" \
--messagefont "size=14" \
--bannerimage "https://github.com/netbossbv/Baseline/blob/5c014733056a385c1dc87fce1323f8f4d5765514/pictures/Banner.png" \
--button1text "Get started" \
--titlefont "size=20" \
--timer "120" \
--big

# After the button is pressed, exit the script
exit 0