#!/bin/bash

gpg --batch --passphrase-file gpg-password --output secrets.json --decrypt secrets.json.gpg

while read -r SECRET
do
	while read -r FILE
	do
		if grep -q "$SECRET" "$FILE";
		then
			echo "Error: Plain text secret ($SECRET) found in $FILE. Your commit will be rejected."
			rm secrets.json
			exit 1
		fi
	done < <(git status --porcelain | sed s/^...//)
done < <(cat secrets.json | jq -r '.[]')

rm secrets.json