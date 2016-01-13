#!/usr/bin/env bash

#Made by Rowen Stipe because I fucking felt like it.

git-repos() {
	if [ -d ./Repos ]; then
			cd ./Repos
			for i in $(ls -d */)
			do
				cd ${i%%/}
				git pull
				cd ..
			done
			cd ..
	fi
	
	if [ ! -d ./Repos ]; then
		mkdir ./Repos
		cd Repos
	 	git clone https://github.com/irungentoo/toxcore # Toxcore
		git clone https://github.com/tux3/qTox # qTox
		git clone https://github.com/GrayHatter/uTox # uTox
		git clone https://github.com/Antox/Antox # Antox
		git clone https://github.com/Antidote-for-Tox/Antidote # Antidote
		git clone https://github.com/JFreegman/toxic # Toxic
		git clone https://github.com/subliun/toxme # Toxme
		git clone https://github.com/Tox/Tox-Client-Standard # Tox/TCS
		git clone https://github.com/Tox/Sounds # Tox/Sounds
		git clone https://github.com/Tox/tox.chat # Tox/tox.chat
		git clone https://github.com/Tox/homebrew-tox # Tox/homebrew-tox
		git clone https://github.com/Tox/ToxStatus # Tox/ToxStatus
		cd ..
	fi
		
}

gource-gen() {
	if [ -d ./Logs ]; then
		rm -r ./Logs
	fi
	mkdir ./Logs
	cd ./Repos
	for i in $(ls -d */)
	do
		cd ${i%%/}
		gource --output-custom-log ../../Logs/${i%%/}.txt
		cd ..
	done
	cd ../Logs
	mv ./ToxStatus.txt ./Tox-ToxStatus.txt
	mv ./Sounds.txt ./Tox-Sounds.txt
	mv ./tox.chat.txt ./Tox-tox.chat.txt
	mv ./homebrew-tox.txt ./Tox-homebrew-tox.txt
	mv ./Tox-Client-Standard.txt ./Tox-Tox-Client-Standard.txt
	cd ..
}

gource-comb() {
	cd ./Logs
	sed -i -r 's#\(.*\)\|#\1|/toxcore#' toxcore.txt
	sed -i -r 's#\(.*\)\|#\1|/qTox#' qTox.txt
	sed -i -r 's#\(.*\)\|#\1|/uTox#' uTox.txt
	sed -i -r 's#\(.*\)\|#\1|/Antidote#' Antidote.txt
	sed -i -r 's#\(.*\)\|#\1|/Antox#' Antox.txt
	sed -i -r 's#\(.*\)\|#\1|/toxic#' toxic.txt
	sed -i -r 's#\(.*\)\|#\1|/Tox\/homebrew\-tox#' Tox-homebrew-tox.txt
	sed -i -r 's#\(.*\)\|#\1|/toxme#' toxme.txt
	sed -i -r 's#\(.*\)\|#\1|/Tox\/tox\.chat#' Tox-tox.chat.txt
	sed -i -r 's#\(.*\)\|#\1|/Tox\/Sounds#' Tox-Sounds.txt
	sed -i -r 's#\(.*\)\|#\1|/Tox\/Tox\-Client\-Standard#' Tox-Tox-Client-Standard.txt
	
	cat toxcore.txt qTox.txt uTox.txt Antox.txt antidote.txt toxic.txt toxme.txt Tox-homebrew-tox.txt Tox-tox.chat.txt Tox-Sounds.txt Tox-Tox-Client-Standard.txt | sort -n > tox-history.txt
	
	perl -p -i -e 's/Tux3 \/ Mlkj \/ !Lev.uXFMLA/tux3/g' tox-history.txt
	perl -p -i -e 's/tux3\/mlkj/tux3/g' tox-history.txt
	cd ..
}

git-avatar() {
	mkdir ./avatar
	cd ./Repos
	for i in $(ls -d */)
	do
		cd ${i%%/}
		../../../gravatar-gource.py
		cd ..
	done
	cd ..
}

mkdir ./Gource-tox
cd ./Gource-tox
git-repos
gource-gen
gource-comb
#git-avatar

echo "------------------------------"
echo "-----DONE-----DONE---DONE-----"
echo "------------------------------"
echo "Now run if all went well: gource ./Gource-tox/Logs/tox-history.txt --camera-mode overview --file-idle-time 0  --hide mouse,progress --user-image-dir ./Gource-tox/avatar --key --seconds-per-day 1 -1920x1080"
exit 0