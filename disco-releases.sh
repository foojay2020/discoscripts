#!/bin/sh

#FUNCTION DEFINITIONS
infoFunction() {
    echo "################################"
    echo "#                              #"
    echo "#   foojay jdk discovery api   #"
    echo "#                              #"
    echo "#      disco-releases.sh       #"
    echo "#                              #"
    echo "################################"
    echo 
    echo
    echo "Be aware that you need to have jq installed"
    echo
    echo "Script parameters:"
    echo "--help          : Shows this info"
    echo "--release       : Release  e.g. 1, 5, 9, 11, 18"
    echo 
    echo "disco-releases.sh"
    echo "disco-releases.sh --maintained"
    echo "disco-releases.sh --supported"
    echo "disco-releases.sh --release 5"
    echo "disco-releases.sh --help"
    echo
    exit 1
}

# FIELDS
releaseField="release"

# CHECK FOR GIVEN PARAMETERS
while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param=$2
    
        if [ "$1" == "--help" ]; then
          infoFunction
        fi

        if [ "$1" == "--maintained" ]; then
          declare maintained=true
        fi

        if [ "$1" == "--supported" ]; then
          declare supported=true
        fi

        if [ "$param" = "$releaseField" ]; then
        	declare releaseValue=$2
        fi
   fi

  shift
done

# CALL THE DISCOAPI
url="http://81.169.252.235:8080/disco/v1.0/releases"

if [[ $maintained ]]; then    
    url="${url}/maintained"    
elif [[ $supported ]]; then    
    url="${url}/supported"
elif [[ $releaseValue ]]; then  
    url="${url}/${releaseValue}"
fi


#echo $url

# READ REST RESPONSE INTO VARIABLE
json="$(curl ${url} 2>/dev/null)"
#echo $json


# PRINT OUT
if [[ $releaseValue ]]; then
    echo "$json" | jq
else
    echo "$json" | jq '.[]'
fi    
