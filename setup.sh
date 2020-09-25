#!/bin/bash

echo "Enter gpg-password"

read PASSWORD

echo "$PASSWORD" > gpg-password

cp pre-commit.sh .git/hooks/pre-commit

chmod a+x .git/hooks/pre-commit