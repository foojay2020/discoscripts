#!/bin/sh

#FUNCTION DEFINITIONS
infoFunction() {
    echo "################################"
    echo "#                              #"
    echo "#   foojay jdk discovery api   #"
    echo "#                              #"
    echo "#       disco-bundles.sh       #"
    echo "#                              #"
    echo "################################"
    echo 
    echo "Script parameters:"
    echo "--help          : Shows this info"
    echo "--os            : Operating System  (mandatory) e.g. windows, macos, linux"
    echo "--version       : Version           (mandatory) e.g. 1.8.0_265 or 11 or 13.0.5.1"
    echo "--ext           : File extension                e.g. cab,deb,dmg,msi,pkg,rpm,src_tar,tar,zip"
    echo "--arch          : Architecture                  e.g. aarch64, arm, arm64, mips, ppc, ppc64, ppc64le, riscv64, s390x, sparc, sparcv9, x64, x86, amd64"
    echo "--distro        : Distribution                  e.g. adopt, dragonwell, corretto, liberica, open_jdk, sap_machine, zulu"
    echo "--bitness       : Bitness                       e.g. 32, 64"
    echo "--bundle_type   : Bundle type                   e.g. jre, jdk"
    echo "--release_status: Release status                e.g. ea, ga"
    echo "--support_term  : Support term                  e.g. sts, mts, lts"
    echo "--fx            : With JavaFX                   e.g. true, false"
    echo "--release       : Release                       e.g. latest, next, previous, latest_sts, latest_mts, latest_lts"
    echo "--latest        : Latest                        e.g. overall, per_distro"
    echo "--dest          : Destination                   e.g. /Users/HanSolo"
    echo 
    echo "Usage example:"
    echo "disco-bundles.sh --dest /Users/Hansolo --os windows --version 1.8.0_265 --distro zulu --bundle_type jdk --arch x64 --ext zip --release_status ga"    
    echo
    exit 1
}


# FIELDS
destField="dest"
versionField="version"
fromVersionField="from_version"
toVersionField="to_version"
osField="os"
extField="ext"
archField="arch"
distroField="distro"
bitnessField="bitness"
bundleTypeField="bundle_type"
releaseStatusField="release_status"
supportTermField="support_term"
releaseField="release"
fxField="fx"
latestField="latest"

# CHECK FOR GIVEN PARAMETERS
while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param=$2
    
        if [ "$1" == "--help" ]; then
          infoFunction
        fi

        if [ "$param" = "$destField" ]; then
            declare destValue=$2
        fi

        if [ "$param" = "$versionField" ]; then
        	declare versionValue=$2
        fi

        if [ "$param" = "$fromVersionField" ]; then
        	declare fromVersionValue=$2
        fi

        if [ "$param" = "$toVersionField" ]; then
        	declare toVersionValue=$2
        fi

        if [ "$param" = "$osField" ]; then
        	declare osValue=$2        	
        fi

        if [ "$param" = "$extField" ]; then
        	declare extValue=$2
        fi

        if [ "$param" = "$archField" ]; then
        	declare archValue=$2
        fi

        if [ "$param" = "$distroField" ]; then
        	declare distroValue=$2
        fi

		if [ "$param" = "$bitnessField" ]; then
        	declare -i bitnessValue=$2
        fi

        if [ "$param" = "$bundleTypeField" ]; then
            declare bundleTypeValue=$2
        fi

        if [ "$param" = "$releaseStatusField" ]; then
        	declare releaseStatusValue=$2
        fi

        if [ "$param" = "$supportTermField" ]; then
        	declare supportTermValue=$2
        fi

        if [ "$param" = "$releaseField" ]; then
        	declare releaseValue=$2
        fi

        if [ "$param" = "$fxField" ]; then
        	declare fxValue=$2
        fi

        if [ "$param" = "$latestField" ]; then
        	declare latestValue=$2
        fi        
   fi

  shift
done

# CALL THE DISCOAPI
url="http://81.169.252.235:8080/disco/v1.0/bundles"
present="0"


if [[ $versionValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}version=${versionValue}"
    let present="1"
else
    infoFunction
fi

if [[ $osValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}os=${osValue}"
    # SET EXTENSION DEPENDENT ON THE OPERATING SYSTEM
    #if [[ $os -eq "windows" ]]; then
    #    url="${url}&ext=zip"
    #elif [[ $os -eq "macos" ]]; then
    #    url="${url}&ext=zip"
    #elif [[ $os -eq "linux" ]]; then
    #    url="${url}&ext=tar"
    #else
    #    exit 1
    #fi
    let present="1"
else
    infoFunction
fi

if [[ $extValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}ext=${extValue}"
    let present="1"
fi

if [[ $archValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}arch=${archValue}"
    let present="1"
fi

if [[ $distroValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}distro=${distroValue}"
    let present="1"
fi

if [[ $bitnessValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}bitness=${bitnessValue}"
    let present="1"
fi

if [[ $bundleTypeValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}bundle_type=${bundleTypeValue}"
    let present="1"
fi

if [[ $releaseStatusValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}release_status=${releaseStatusValue}"
    let present="1"
fi

if [[ $supportTermValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}support_term=${supportTermValue}"
    let present="1"
fi

if [[ $releaseValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}release=${releaseValue}"
    let present="1"
fi

if [[ $fxValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}fx=${fxValue}"
    let present="1"
fi

if [[ $latestValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}latest=${latestValue}"
    let present="1"
fi


#echo $url

# READ REST RESPONSE INTO VARIABLE
json="$(curl ${url} 2>/dev/null)"
#echo $json


# PRINT OUT
#echo "$json" | jq -c '.[]|"\(.id) , \(.filename) , \(.download_link)"' 

#echo "$json" | jq -c '.[]|"\(.id)"' 

noOfEntries=$(echo ${json} | jq length)
if [[ "$noOfEntries" > 1 ]]; then
    read -r -p "Found more than 1 bundle, download only the first one (Y/n)? " response
    response=${response:l} # bash version: response=${response,,}
    echo 
fi


#for k in $(jq '.[] | keys | .[]' <<< "$json"); do # iterate through keys of array
for k in $(jq '.[] | .download_link' <<< "$json"); do
    #echo $k
    bundleInfoJson="$(curl "$(echo "$k" | tr -d \")" 2>/dev/null)"
    filename="$(echo "$bundleInfoJson" | jq '.filename' | tr -d \")"
    downloadLink="$(echo "$bundleInfoJson" | jq '.download_link' | tr -d \")"
    if [[ $destValue ]]; then
        filename="${destValue}/${filename}"
    fi

    read -p "Download ${filename} (y/N) ?" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo Download bundle to $filename
    #echo $filename $downloadLink
        wget -O $filename $downloadLink
    fi    

    # EXIT AFTER FIRST FILE HAS BEEN DOWNLOADED IF USER DECIDED NO
    if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
        exit 1 
    fi    
done
