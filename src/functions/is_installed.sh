# Check if command is available in the system
is_installed() {
	local result=1
	if [ -z $(command -v $1) ]; then
		local result=0
	fi
	# Echo is like return here
	echo $result
}