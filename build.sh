#!/bin/bash
image_name="proj3-im"
build_dir="."   #root of project where build/ folder exists

echo "Building docker image: $image_name "

docker build -t "$image_name" "$build_dir"   #$build_dir given where docker build inside build dir for dockerfile

if [ $? -eq 0 ]; then
    echo "Docker image $image_name built successfully!"
else
    echo "Error building Docker image."
    exit 1
fi
