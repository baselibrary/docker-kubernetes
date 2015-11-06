#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi
versions=( "${versions[@]%/}" )


for version in "${versions[@]}"; do	
  fullRelease="$(git ls-remote --tags https://github.com/kubernetes/kubernetes.git | cut -d$'\t' -f2 | grep -E '^refs/tags/v'"${version}"'.[0-9]$' | cut -dv -f2 | sort -rV | head -n1 )"
  (
		set -x
		cp docker-entrypoint.sh "$version/"
		sed '
			s/%%KUBERNETES_MAJOR%%/'"$version"'/g;
			s/%%KUBERNETES_RELEASE%%/'"$fullRelease"'/g;
		' Dockerfile.template > "$version/Dockerfile"
	)
done
