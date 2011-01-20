#!/bin/sh

if [ -z $1 ] ; then
	echo "usage: $0 <filename>"
	exit 0
fi

FILE=$1
if [ ! -f ${FILE} ] ; then
	echo "No such file ( ${FILE} )."
	exit 1
fi

FREETAG=fromscan
UNIXTIMETAG="`date +%s`"
FILENAME=`basename ${FILE}`
IMGTHUMB=${FILENAME}.thumb.png
IMGCTYPE="image\/png"

TMPDIR=/tmp

JSON=${TMPDIR}/${UNIXTIMETAG}.json

# make thumbnail
convert -geometry 100x120 ${FILE} ${TMPDIR}/${IMGTHUMB}
# gen base64 encode strings from thumbnail image
BASE64E=`base64 ${TMPDIR}/${IMGTHUMB}`
# remove thumbnail
rm ${TMPDIR}/${IMGTHUMB}

# create json
cat > ${JSON} <<EOF
{
	"unix_time":"${UNIXTIMETAG}",
	"tag":[
		"${FREETAG}"
		],
	"filename": "${FILENAME}",
	"_attachments":
	{
		"${IMGTHUMB}":
		{
			"content_type":"${IMGCTYPE}",
			"data": "${BASE64E}"
		}
	}
}
EOF

curl -X POST -d @${JSON} http://username:password@relaxserver:5984/docstore
RC=$?

# remove json
rm ${JSON}

echo "End of script."
echo "return code = ${RC}"
