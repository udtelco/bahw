#!/usr/bin/env bash
# BAHW startup helper script
# Please read readme for some details
# Usage :
#    runme.sh
# to use the default image tag , or
#    runme.sh docker-image-tag
#
if [[ "$1" -eq "" ]]
then
  IMAGE=theunixmaster/bahw-app:1.0.0
else
  IMAGE=$1
fi

if ! [[ $(docker build --tag $IMAGE .) ]]
then
 echo ERROR: Image build failed - aborting
 exit 10
fi
if ! [[ $(docker push $IMAGE) ]]
then
 echo WARN: Image push failed - not aborting
fi
#
# TO BE DONE :
# Update deployment.yaml with $IMAGE substituting default value
# something like
#   sed -e s/theunixmaster/bahw-app:1.0.0/$IMAGE/g deployment.yaml
# but a lot more fancy because of need to escape strings and preserve original file
# Will be obsolete upon completion of helm chart

if ! [[ $(kubectl create -f deployment.yaml) ]]
then
  echo ERROR: k8s failed deployment
  exit 20
fi
if ! [[ $(kubectl create -f service.yaml) ]]
then
  echo FAIL: k8s failed to expose services
  exit 21
fi