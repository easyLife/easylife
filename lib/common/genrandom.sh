GenRandom() {

	# generate a random number between 0 and given function-parameter ($1)
	RNUMBER=$[ $RANDOM % $1 ]
	return $RNUMBER
}

