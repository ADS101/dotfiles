default_user=`ls /home | head -n1 | awk '{print }'`

echo "%sudo ALL=(ALL) ALL"

usermod -aG sudo $default_user

echo "Okay! You can switch back to $default_user now!"
