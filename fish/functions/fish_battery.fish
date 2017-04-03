set -U fish_battery_percentage_10 red
set -U fish_battery_percentage_100 green

set -U fish_battery_status_charging ''
set -U fish_battery_status_discharging ''

function battery
  set state (pmset -g batt | grep -Eo '(dis)?charging')
  set percentage (pmset -g batt | grep -o '[0-9]*%' | grep -o '[0-9]*')
  set remaining (pmset -g batt | grep -o '[0-9]*:[0-9][0-9]')

	if test -n "$state"
	  set p (string trim "$percentage")
  	set icon (eval 'echo $fish_battery_status_'$state)

  	printf "%s%s %s%s" $remaining "($p%)" (eval 'set_color $fish_battery_percentage_'$p) $icon
	end
end
