#!/bin/bash

apt-get update -y && apt-get upgrade -y
apt-get install -y ansible

touch /root/user_data_completed