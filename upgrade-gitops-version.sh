#!/bin/bash

# Exit when any command fails
set -e

environment=$1
old_ver=$2
new_ver=$3

echo "old version: $old_ver"
echo "new version: $new_ver"

# Pull docker image
docker pull brizaldi/simple-bank:$old_ver

# Simulate release of the new docker images
docker tag brizaldi/simple-bank:$old_ver brizaldi/simple-bank:$new_ver

# Push new version to dockerhub
docker push brizaldi/simple-bank:$new_ver

# Create temporary folder
tmp_dir=$(mktemp -d)
echo $tmp_dir

# Clone GitHub repo
git clone git@github.com:firsttimeeagle-org/gitops.git $tmp_dir

# Update image tag
sed -i -e "s/newTag:.*/newTag: $new_ver/g" $tmp_dir/environments/dev/simple-bank/kustomization.yaml

# Commit and push
cd $tmp_dir
git add .
git commit -m "Update $environment image to $new_ver"
git push

# Optionally on build agents - remove folder
rm -rf $tmp_dir