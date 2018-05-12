#!/bin/bash

# USAGE: ./build.sh lang=fr-FR [img_dir=img/] [upload_dest=remote-server:upload/dir/path]
# REQUIRE: twine git repo in $PYTHONPATH + Lucas-C/dotfiles_and_notes:languages/python repo directory in $PATH

set -o pipefail -o errexit -o nounset -o xtrace
cd $(dirname $0)
eval "$@"
: ${lang_tag?'Required argument'}

twine1_localizer.py translate the-temple-of-no.tws l10n/${lang_tag}.po the-temple-of-no_${lang_tag}.tws
extra_build_args=
if [ -n "${img_dir:-}" ]; then
    extra_build_args="--use-relative-imgs-dir ${img_dir}"
fi
if [ -n "${css_file:-}" ]; then
    extra_build_args="$extra_build_args --css-passage-from-file ${css_file}"
fi
tws_to_html.py --override-js-files js/{}.min.js ${extra_build_args} the-temple-of-no_${lang_tag}.tws index_${lang_tag}.html
# Inserting a lang attribute to the root <html> element to be compatible with the HTML spec and help screen readers:
sed -i 's/><html/><html lang="'${lang_tag}'"/g' index_${lang_tag}.html

if [ -n "${upload_dest:-}" ]; then
    scp index_${lang_tag}.html $upload_dest/index.html
    rsync -av sound $upload_dest
    if [ -n "${img_dir:-}" ]; then
        rsync -av img $upload_dest
    fi
fi