#!/bin/sh

#FUNCTION DEFINITIONS
infoFunction() {
    echo "################################"
    echo "#                              #"
    echo "#   foojay jdk discovery api   #"
    echo "#                              #"
    echo "#       disco-packages.sh      #"
    echo "#                              #"
    echo "################################"
    echo
    echo
    echo "Be aware that you need to have jq and wget installed"
    echo
    echo "Script parameters:"
    echo "--help                  : Shows this info"
    echo "--version               : Version                (mandatory or version by definition)  e.g. 1.8.0_265 or 11 or 13.0.5.1"
    echo "--version_by_definition : Version by definition  (mandatory if no version)             e.g. latest, latest_sts, latest_mts, latest_lts"
    echo "--distro                : Distribution                                e.g. adopt, azure_zulu, dragonwell, corretto, liberica, oracle_open_jdk, redhat, sap_machine, zulu"
    echo "--jvm_implementation    : JVM Implementation                          e.g. hotspot, openj9"
    echo "--architecture          : Architecture                                e.g. aarch64, arm, arm64, mips, ppc, ppc64, ppc64le, riscv64, s390x, sparc, sparcv9, x64, x86, amd64"
    echo "--archive_type          : File extension                              e.g. cab, deb, dmg, exe, msi, pkg, rpm, tar, zip"
    echo "--package_type          : Package type                                e.g. jre, jdk"
    echo "--operating_system      : Operating System  (mandatory)               e.g. windows, macos, linux"
    echo "--libc_type             : Type of libc                                e.g. glibc, libc, musl, c_std_lib"           
    echo "--release_status        : Release status                              e.g. ea, ga"
    echo "--term_of_support       : Term of support                             e.g. sts, mts, lts"
    echo "--bitness               : Bitness                                     e.g. 32, 64"
    echo "--javafx_bundled        : With JavaFX                                 e.g. true, false"
    echo "--directly_downloadable : Directly downloadable                       e.g. true, false"
    echo "--latest                : Latest                                      e.g. overall, per_distro"
    echo "--dest                  : Destination                                 e.g. /Users/HanSolo"
    echo 
    echo "Usage example:"
    echo "disco-packages.sh --dest /Users/Hansolo --operating_system windows --version 1.8.0_265 --distro zulu --package_type jdk --architecture x64 --archive_type zip --release_status ga"
    echo
    exit 1
}


# FIELDS
destField="dest"
versionField="version"
fromVersionField="from_version"
toVersionField="to_version"
operatingSystemField="operating_system"
libcTypeField="libc_type"
archiveTypeField="archive_type"
architectureField="architecture"
distroField="distro"
jvmImplementationField="jvm_implementation"
bitnessField="bitness"
packageTypeField="package_type"
releaseStatusField="release_status"
supportTermField="support_term"
versionByDefinitionField="version_by_definition"
directlyDownloadableField="directly_downloadable"
javafxBundledField="javafx_bundled"
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

        if [ "$param" = "$operatingSystemField" ]; then
        	declare operatingSystemValue=$2        	
        fi

        if [ "$param" = "$libcTypeField" ]; then
            declare libcTypeValue=$2         
        fi

        if [ "$param" = "$archiveTypeField" ]; then
        	declare archiveTypeValue=$2
        fi

        if [ "$param" = "$architectureField" ]; then
        	declare architectureValue=$2
        fi

        if [ "$param" = "$distroField" ]; then
        	declare distroValue=$2
        fi

        if [ "$param" = "$jvmImplementationField" ]; then
        	declare jvmImplementationValue=$2
        fi

		if [ "$param" = "$bitnessField" ]; then
        	declare -i bitnessValue=$2
        fi

        if [ "$param" = "$packageTypeField" ]; then
            declare packageTypeValue=$2
        fi

        if [ "$param" = "$releaseStatusField" ]; then
        	declare releaseStatusValue=$2
        fi

        if [ "$param" = "$supportTermField" ]; then
        	declare supportTermValue=$2
        fi

        if [ "$param" = "$versionByDefinitionField" ]; then
        	declare versionByDefinitionValue=$2
        fi

        if [ "$param" = "$directlyDownloadableField" ]; then
            declare directlyDownloadableValue=$2
        fi

        if [ "$param" = "$javafxBundledField" ]; then
        	declare javafxBundledValue=$2
        fi

        if [ "$param" = "$latestField" ]; then
        	declare latestValue=$2
        fi        
   fi

  shift
done

# CALL THE DISCOAPI
url="https://api.foojay.io/disco/v1.0/packages"
present="0"


if [[ $versionValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}version=${versionValue}"
    let present="1"
elif [[ $versionByDefinitionValue ]]; then 
    if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
    url="${url}version_by_definition=${versionByDefinitionValue}"
    let present="1"
else
    infoFunction
fi

if [[ $operatingSystemValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}operating_system=${operatingSystemValue}"
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

if [[ $libcTypeValue ]]; then 
    if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
    url="${url}libc_type=${libcTypeValue}"
    let present="1"
fi

if [[ $archiveTypeValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}archive_type=${archiveTypeValue}"
    let present="1"
fi

if [[ $architectureValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}architecture=${architectureValue}"
    let present="1"
fi

if [[ $distroValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}distro=${distroValue}"
    let present="1"
fi

if [[ $jvmImplementationValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}jvm_implementation=${jvmImplementationValue}"
    let present="1"
fi

if [[ $bitnessValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}bitness=${bitnessValue}"
    let present="1"
fi

if [[ $packageTypeValue ]]; then 
    if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}package_type=${packageTypeValue}"
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

if [[ $directlyDownloadableValue ]]; then 
    if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
    url="${url}directly_downloadable=${directlyDownloadableValue}"
    let present="1"
fi

#if [[ $releaseValue ]]; then 
#	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
#	url="${url}release=${releaseValue}"
#    let present="1"
#    echo $url
#fi

if [[ $javafxBundledValue ]]; then 
	if [ $present -eq "1" ]; then url="${url}&"; else url="${url}?"; fi
	url="${url}javafx_bundled=${javafxBundledValue}"
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
#echo "$json" | jq -c '.[]|"\(.id) , \(.filename) , \(.ephemeral_id)"' 

#echo "$json" | jq -c '.[]|"\(.id)"' 

noOfEntries=$(echo ${json} | jq length)
if [[ "$noOfEntries" > 1 ]]; then
    echo
    read -r -p "Found ${noOfEntries} packages, would you like to select the first one only (Y/n)? " response
    response=${response:l} # bash version: response=${response,,}
    echo 
elif [[ "$noOfEntries" = 1 ]]; then
    echo
    echo "Exactly one package found that matches the given parameters"
    echo
else
    echo
    echo "Sorry no packages found that matches the given parameters"
    exit 1
fi


ephemeralIdsUrl="https://api.foojay.io/disco/v1.0/ephemeral_ids/"
#for k in $(jq '.[] | keys | .[]' <<< "$json"); do # iterate through keys of array
for k in $(jq '.[] | .ephemeral_id' <<< "$json"); do
    dlUrl="${ephemeralIdsUrl}${k//\"}"    
    packageInfoJson="$(curl "$(echo "$dlUrl" | tr -d \")" 2>/dev/null)"
    filename="$(echo "$packageInfoJson" | jq '.filename' | tr -d \")"
    downloadLink="$(echo "$packageInfoJson" | jq '.direct_download_uri' | tr -d \")"
    if [[ $destValue ]]; then
        filename="${destValue}/${filename}"
    fi

    read -p "Download ${filename} (y/N) ?" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo Download package to $filename
    #echo $filename $downloadLink
        wget -O $filename $downloadLink
    fi    

    # EXIT AFTER FIRST FILE HAS BEEN DOWNLOADED IF USER DECIDED NO
    if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
        exit 1 
    fi    
done
