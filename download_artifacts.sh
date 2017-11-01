#! /bin/bash
# download artifacts from wukong with webhook payload
set -x
ARTIFACT_PATHS=
MINIO_KEYS=
MINIO_KEYS_FILENAME=.minio_keys

function clean_cache(){
    if [ -f $MINIO_KEYS_FILENAME ];then
        rm $MINIO_KEYS_FILENAME
    fi
}

function rdom(){
    local IFS=\>
    read -d \< ENTITY CONTENT
}

function get_artifacts_paths() {
    key=$1
    i=0
    ARTIFACT_PATHS=()
    while rdom; do
        if [[ $ENTITY = $key ]]; then
            ARTIFACT_PATHS[$i]=$WUKONG_ENDPOINT/$NAMESPACE$CONTENT
            i=$[ $i + 1 ]
        fi
    done < $MINIO_KEYS_FILENAME
    echo artifact paths are ${ARTIFACT_PATHS[*]}
}

#
# get_minio_keys
# usage get_minio_keys namespace prefix
# 
function get_minio_keys(){
    url=$WUKONG_ENDPOINT/$1?prefix=$2
    MINIO_KEYS=$(curl -L -s $url -H "authorization: token ${TOKEN}")
    clean_cache
    echo $MINIO_KEYS > $MINIO_KEYS_FILENAME
}

#
# download_file
# usage download_file file_url
#
function download_file(){
    echo file url is $1
    curl -L $1 -H "authorization: token ${TOKEN}" -O
}

function main(){
    base_paths=($ARTIFACT_PATHS_0 $ARTIFACT_PATHS_1)
    for base_path in ${base_paths[*]};do
        get_minio_keys $NAMESPACE $base_path
        echo base path is $base_path
        get_artifacts_paths Key
        echo artifact paths are ${ARTIFACT_PATHS[*]}
        for url in ${ARTIFACT_PATHS[*]};do
            download_file $url
        done
    done
    clean_cache
}
echo "print env in script file"
env
main
