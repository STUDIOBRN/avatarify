# Web-camera device id
# Call `v4l2-ctl --list-devices` and find your web-camera device, e.g. /dev/videoX, where X is camera id
# CAMID 2 for mac air 
CAMID=2

# ################################################
# Normally you don't want to change settings below

# [Linux] Virtual camera device
# Make sure this id is greater than maximum device id in the list `v4l2-ctl --list-devices`
# Don't set a big number, it's known that Zoom does not detect cameras with id like 99
CAMID_VIRT=9

# Conda environment name
CONDA_ENV_NAME=avatarify
