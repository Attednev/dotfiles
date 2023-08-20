set fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_prompt -d "Write out the prompt"
	if git rev-parse --is-inside-work-tree > /dev/null 2>&1
		set branch $(git rev-parse --abbrev-ref HEAD)
		set git " ("
		if test -n "$(git status -s)"
			set git "$git$(set_color red)"
		else
			set git "$git$(set_color FFA500)"
		end
		set git "$git$branch$(set_color normal))"
	end
    printf '%s%s%s%s # ' (set_color cyan) $PWD (set_color normal) $git
end