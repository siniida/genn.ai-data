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
		"# type:"*)
			TYPE=`echo ${LINE} | awk '{print $NF}'`
			;;
		"#"*)
			;;
		"")
			echo "put 'condition', '${KEY}', 'template:filter', '${DATA}'"
			echo "put 'condition', '${KEY}', 'template:type', ${TYPE}"
			echo 
			DATA=''
			;;
		*)
			DATA+=`echo ${LINE} | sed -e 's/ //g'`
			;;
	esac
done

