#!/usr/bin/env sh
DIR=~/Downloads
MIRROR=https://github.com/dgraph-io/dgraph/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    local platform="${os}-${arch}"
    local url=$MIRROR/$ver/dgraph-${platform}.tar.gz
    local lfile=$DIR/dgraph-${platform}-${ver}.tar.gz
    if [ ! -e $lfile ];
    then
        wget -q -O $lfile $url
    fi
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

dl_ver() {
    local ver=$1
    printf "  %s:\n" $ver
    dl $ver darwin amd64
    dl $ver linux amd64
    dl $ver windows amd64
}

dl_ver ${1:-v20.07.2}
