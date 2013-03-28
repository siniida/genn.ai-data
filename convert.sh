#!/bin/sh

function usage() {
	echo "Usage.."
}

if [ $# -eq 0 ]
then
	usage
	exit 1
fi

if [ ! -f $1 ]
then
	usage
	exit 1
fi

KEY=''
DATE=''
cat $1 | while read LINE
do
	case ${LINE} in
		"# key:"*)
			KEY=`echo ${LINE} | awk '{print $NF}'`
			;;
		"#"*)
			;;
		"")
			printf "put 'condition', '${KEY}', 'template:filter', '%s'\n\n" ${DATA};
			DATA=''
			;;
		*)
			DATA+=`echo ${LINE} | sed -e 's/ //g'`
			;;
	esac
done

