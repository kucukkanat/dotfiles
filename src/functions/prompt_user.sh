prompt_user() {
	printf "\n"
	read -n 1 -p "${blu}$1 y/n ?${end} " user_answer
	printf "\n"
	if [[ $user_answer == y ]] || [[ -z $user_answer ]]; then
		eval $2
	else
		eval $3
	fi
}