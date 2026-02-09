#!/bin/zsh
#
#  This will upload the report to https://www.huber.embl.de/users/whuber/lemur4decode/1_preprocessing_R.html
#. The only non-trivial line is the last one (mc mirror).
#  The previous lines create a new directory named 1_preprocessing_R with just the needed files instead of fiddling with --exclude and the like.
#
#  See also 
#. - for the contents of the S3 bucket from which the webserver serves: console.s3.embl.de/login
#  - for the one-time setup of the S3 key on your machine. https://git.embl.org/grp-huber/www.huber.embl.de/-/blob/main/minio-README.md?ref_type=heads 

# replace with your path
cd /Users/whuber/clones/demos/ricover-surv

export NAME=ricover-surv
chmod 644 "${NAME}.html"
find "${NAME}_files" -type d -exec chmod 755 {} \;
find "${NAME}_files" -type f -exec chmod 644 {} \;

mkdir -p "${NAME}"
cp -pr wh.css survival_spatial_compositional.csv "${NAME}.html" "${NAME}_files" "${NAME}"

mc mirror --overwrite "${NAME}" wwwhuber/www-huber/users/whuber/demos/ricover-surv/

