# reminder
A CLI tool for scheduling nofications written for the fish shell

## Requirements
```
notify-send
the fish shell
```

## Usage
You can schedule events by with `reminder set [notification] [date]`, where `notification` is the string that should be displayed at time `date `.  
All notifications scheduled can be listed with `reminder list`.  
` reminder update ` checks which notifications should be displayed now and removes them from the cache.  
This subcommand has to be called periodically and the way this is done is up to you but calling `reminder auto-update` calls the update subcommand every minute.
