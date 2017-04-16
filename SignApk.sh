#!/bin/bash

# signapk unsignedin signedout
signapk()
{
  echo "$0 $@"
  unsigned=$1
  signed=$2

  JDKVER=`java -version 2>&1 |awk 'NR==1{ gsub(/"/,""); print $3 }'`
  JDKVER=${JDKVER%.*}

  echo "JDK version : $JDKVER."

  case $JDKVER in
    1.6) jarsigner -verbose -keystore $3 -signedjar ${signed} ${unsigned} $4
  ;;

    *) jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $3 -signedjar ${signed} ${unsigned} $4
  ;;
  esac
  
  return 0
}

# show usage
function usage()
{
    echo "Usage : "
    echo "  Sign a APK you need : "
    echo "    1) Copy your keystore, $0 and unsigned file in the same directory;"
    echo "    2) Change keystore and command : $0 -s source target."
    echo "  Show usage : "
    echo "    $0 -usage"
    exit 
}

case $1 in
-s) [ $# -ne 3 ] && usage ; signapk $2 $3 Nicholas.keystore Nicholas ;;
*) usage ;;
esac

