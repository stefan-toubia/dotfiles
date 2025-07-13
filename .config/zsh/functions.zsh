# Helper functions

# Source file if it exists
function source_if() {
	[[ -f "$1" ]] && source "$1"
}
