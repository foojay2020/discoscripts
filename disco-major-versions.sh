#!/bin/sh

#FUNCTION DEFINITIONS
infoFunction() {
    echo "################################"
    echo "#                              #"
    echo "#   foojay jdk discovery api   #"
    echo "#                              #"
    echo "#   disco-major-versions.sh    #"
    echo "#                              #"
    echo "################################"
    echo 
    echo
    echo "Be aware that you need to have jq installed"
    echo
    echo "Script parameters:"
    echo "--help          : Shows this info"
    echo "--major-version : Major Version  e.g. 1, 5, 9, 11, 18"
    echo 
    echo "disco-major-versions.sh"
    echo "disco-major-versions.sh --maintained true --ea true --ga true"
    echo "disco-major-versions.sh --ea true"
    echo "disco-major-versions.sh --ga true"
    echo "disco-major-versions.sh --version 11 --ea true"
    echo "disco-major-versions.sh --version 11 --ga true"
    echo "disco-major-verions.sh --help"
    echo
    exit 1
}

# FIELDS
versionField="version"
maintainedField="maintained"
eaField="ea"
gaField="ga"

# CHECK FOR GIVEN PARAMETERS
while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param=$2
    
        if [ "$1" == "--help" ]; then
          infoFunction
        fi

        if [ "$param" = "$versionField" ]; then
        	declare versionValue=$2
        fi

        if [ "$param" = "$maintainedField" ]; then
            declare maintainedValue=$2
        fi

        if [ "$param" = "$eaField" ]; then
            declare eaValue=$2
        fi

        if [ "$param" = "$gaField" ]; then
            declare gaValue=$2
        fi

   fi

  shift
done

# CALL THE DISCOAPI
url="https://api.foojay.io/disco/v1.0/major_versions"
present="0"

if [[ $versionValue ]]; then
    url="${url}/${versionValue}"
    if [[ $eaValue ]]; then
        url="${url}/ea"
    elif [[ $gaValue ]]; then
        url="${url}/ga"
    fi
else
    if [[ $maintainedValue ]]; then
        if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
        url="${url}maintained=${maintainedValue}"
        let present="1"
    fi

    if [[ $eaValue ]]; then
        if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
        url="${url}ea=${eaValue}"
        let present="1"
    fi

    if [[ $gaValue ]]; then
        if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
        url="${url}ga=${gaValue}"
        let present="1"
    fi
fi


echo $url

# READ REST RESPONSE INTO VARIABLE
json="$(curl ${url} 2>/dev/null)"
#echo $json


# PRINT OUT
if [[ $versionValue ]]; then
    echo "$json" | jq
else
    echo "$json" | jq '.[]'
fi    
