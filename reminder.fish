#!/bin/fish

set cache "$XDG_CACHE_HOME/reminder/reminders"
set tmp "/tmp/reminders"

if test "$argv[1]" = "update"
	set current_time (date +"%s")
	cp /dev/null $tmp
	for event in (cat $cache)
		if test (echo $event | cut -d"," -f2) -lt $current_time
			notify-send -t 0 (echo $event | cut -d"," -f1)
		else
			echo $event >> $tmp
		end
	end
	cp $tmp $cache	
else if test "$argv[1]" = "set"

	echo "$argv[2],"(date --date="$argv[3]" +"%s") >> $cache
else if test "$argv[1]" = "delete"
	cp /dev/null $tmp
	for event in (cat $cache)
		if test (echo $event | cut -d"," -f1) != "$argv[2]"
			echo $event >> $tmp
		end
	end
	cp $tmp $cache
else if test "$argv[1]" = "list"
	for event in (cat $cache)
		echo (echo $event | cut -d"," -f1)", "(echo $event | cut -d"," -f2)
	end
else if test "$argv[1]" = "auto-update"
	set -U REMINDER_UPDATE 0
	while test (math (date +"%s")%60) -ne 0
		sleep 1
	end
	while test $REMINDER_UPDATE -eq 0
		sleep 60
		reminder update
	end
else
	echo "No valid command specified"
end
