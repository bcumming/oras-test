#!/usr/bin/env bash

rm img[12].sqfs

echo =========== img1.sqfs ===========
mkdir -p images/img1
echo "hello world" > images/img1/hello.txt
mksquashfs images/img1 img1.sqfs -quiet

echo =========== img2.sqfs ===========
mkdir -p images/img2
echo "hello there" > images/img2/there.txt
echo ================================
mksquashfs images/img2 img2.sqfs -quiet
rm -rf images

echo
