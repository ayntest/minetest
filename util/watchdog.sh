#!/bin/bash
cd $HOME

while :
do
	ps ax | grep '/minetestserver' | grep -v grep && printf 'The server is running!\n' && exit
	
	if [ -f .stop ]; then
		rm .stop .hold
		printf 'stopped\n'
		exit
	else
		while [ -f .hold ]; do
			echo 'Hold on!'
			sleep 15
		done
	fi
	
	while [ -f .maintenance ]; do
		TIME=$(cat .maintenance)
		ttytter -status="$(printf 'Maintenance completed in %d seconds' )"
		rm .maintenance
	done
	START=$(date +%s)
	bin/./minetestserver --config minetest.conf --world worlds/libertyland $1 &
	PID=$!
	printf '%s' $PID > server.pid
	wait $PID
	EC=$?
	END=$(date +%s)
	if [[ $(( $END - $START )) -lt 10 ]]; then
		printf '%s Server is not starting up!\n' $(date +%F-%T)
		exit 1
	elif [[ $EC -ne 0 ]]; then
		printf 'applications.m-ayntest-net.crash 1 %s\n' $(date +%s) >/dev/tcp/10.129.163.189/2003
		printf '%s\n%s---------' "$(date '+%F %T')" "$(tail -20 debug.txt|grep -iE '(error|debug)')" >> log/crashes.log
		ttytter -status='The server has crashed, brb!'
	fi
	# update news
	cp -v ~/worlds/libertyland/news.txt ~/worlds/libertyland/text/news
	# remove online players
	rm -v ~/worlds/libertyland/online-players
	# restart the script
	[[ -f .restart_watchdog ]] && rm -v .restart_watchdog && exec $(basename $0)
	sleep 3
done
