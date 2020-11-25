#!/bin/sh

#FUNCTION DEFINITIONS
infoFunction() {
    echo "################################"
    echo "#                              #"
    echo "#   foojay jdk discovery api   #"
    echo "#                              #"
    echo "#    disco-distributions.sh    #"
    echo "#                              #"
    echo "################################"
    echo 
    echo
    echo "Be aware that you need to have jq installed"
    echo
    echo "Script parameters:"
    echo "--help  : Shows this info"    
    echo 
    echo "disco-distributions.sh"
    echo "disco-releases.sh --help"
    echo
    exit 1
}

if [ "$1" == "--help" ]; then
  infoFunction
fi

# CALL THE DISCOAPI
url="http://81.169.252.235:8080/disco/v1.0/distributions"


#echo $url

# READ REST RESPONSE INTO VARIABLE
json="$(curl ${url} 2>/dev/null)"
#echo $json

# PRINT OUT
echo "$json" | jq '.[]'    
