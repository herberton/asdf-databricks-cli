#!/usr/bin/env bash

set -euo pipefail

# DONE: Ensure this is the correct GitHub homepage where releases can be downloaded for databricks-cli.
GH_REPO="https://github.com/databricks/cli"
TOOL_NAME="databricks"
TOOL_TEST="databricks --version"

# set OS_NAME
case "$(uname -s | cut -d '-' -f 1)" in
Linux)
    OS_NAME="linux"
    ;;
Darwin)
    OS_NAME="darwin"
    ;;
MINGW64_NT)
    OS_NAME="windows"
    ;;
*)
    echo "Unknown operating system: $(uname -s | cut -d '-' -f 1)"
    exit 1
    ;;
esac

# set OS_ARCH
case "$(uname -m)" in
i386)
    OS_ARCH="386"
    ;;
x86_64)
    OS_ARCH="amd64"
    ;;
arm)
    OS_ARCH="arm"
    ;;
arm64|aarch64)
    OS_ARCH="arm64"
    ;;
*)
    echo "Unknown architecture: $(uname -m)"
    exit 1
    ;;
esac

fail() {
	echo -e "asdf-${TOOL_NAME}: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if databricks-cli is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	# DONE: Adapt this. By default we simply list the tag names from GitHub releases.
	# Change this function if databricks-cli has other means of determining installable versions.
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	# DONE: Adapt the release URL convention for databricks-cli
	url="$GH_REPO/releases/download/v${version}/${TOOL_NAME/-/_}_cli_${version}_${OS_NAME}_${OS_ARCH}.tar.gz"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
	echo "* Downloadded file at: $(ls -lah $filename)"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		# DONE: Assert databricks-cli executable exists.
		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
