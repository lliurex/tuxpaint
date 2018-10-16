#!/bin/bash
#//EP added in version 0.9.22
# called from within XCode
# contains customization tasks

export APP="${BUILT_PRODUCTS_DIR}/${TARGET_NAME}.app"
#export CUSTOM="${BUILT_PRODUCTS_DIR}/../../../custom/content.zip"
export CUSTOM="content.zip"
export DST="$APP/Contents/Resources"
export FONTS="$DST/fonts"
export LOG="/tmp/custom.log"

if [ -f $CUSTOM ];
then
	echo Custom content file "$CUSTOM" found
	echo Installing custom content into target "$APP"
	echo Content folder is "$DST"
	
	# clean up fonts folder
	echo Cleaning up fonts folder "$FONTS"
	/usr/bin/sudo /bin/mv -f "$FONTS/default_font.ttf" /tmp	# save the font(s) we want to keep
	/usr/bin/sudo /bin/rm -rf "$FONTS/"*				# empty fonts folder
	/usr/bin/sudo /bin/mv -f "/tmp/default_font.ttf" "$FONTS"	# restore the font(s) we want to keep

	# install content from archive
	echo Extracting content from archive into target
	/usr/bin/unzip -o "$CUSTOM" -d "$DST" > "$LOG"

	echo Custom content has been installed
else
	echo Custom content file $CUSTOM not found
fi

