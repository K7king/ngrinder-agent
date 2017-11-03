#!/bin/sh
 su - root -c docker run -d -p 80:80 --name="ngrinder-controller" -h "ngrinder-controller" ngrinder:controller
echo ____________DOCKER_CONTROLLER____________
su - root -c docker inspect --format '{{ .NetworkSettings.IPAddress }}' ngrinder-controller >>etc/hosts
echo _______________DOCKER IP SETTING_____________
curpath=`dirname $0`
cd ${curpath}
while :
do
	if [ -d ./update_package/lib ]
	then
		echo UPDATE TO NEWER VERSION
		# update package and run
		rm -rf ./lib
		cp -rf ./update_package/* .
		rm -rf ./update_package
	fi
	./run_agent_internal.sh $@
	if [ ! -d ./update_package/lib ]
	then
		break
	fi
done
