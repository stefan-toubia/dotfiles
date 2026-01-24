# Helper functions

# Source file if it exists
function source_if() {
	[[ -f "$1" ]] && source "$1"
}

# Function to list PATH elements
function pathlist() {
	echo "$PATH" | tr ':' '\n'
}

# Function to remove // comments from a file
function recomments() {
	sed '/^\/\//d; s/\/\/.*$//' "$1"
}

# Function to pretty-print JSON
function jql() {
	jq . "$@" | bat --language json
}
