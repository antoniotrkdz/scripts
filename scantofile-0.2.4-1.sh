#! /bin/sh
set +o noclobber
#
#   $1 = scanner device
#   $2 = friendly name
#

#  
#       100,200,300,400,600
#
resolution=100
device=$1
BASE=~/brscan

if [ ! -d "$BASE" ] ; then
  mkdir -p $BASE
fi

if [ ! -d $BASE/TEMP ] ; then
  mkdir -p $BASE/TEMP
fi

cd $BASE/TEMP || exit

sleep  0.01
output_tmp=$(date | sed s/' '/'_'/g | sed s/'\:'/'_'/g)

echo "scan from $2($device)"
scanimage --resolution $resolution --batch="$output_tmp"_p%04d.pnm
for pnmfile in *.pnm
do
   echo converting "$pnmfile" to "$pnmfile.ps"
   pnmtops "$pnmfile" > "$pnmfile.ps"
   rm -f "$pnmfile"
done

echo merging all .ps files into "$output_tmp"_all.ps
ARGS=""
for psfile in *.ps
do
  ARGS="$ARGS $psfile"
done
psmerge -o"$output_tmp"_all.ps $ARGS

echo converting "$output_tmp"_all.ps to "$output_tmp".pdf
ps2pdf "$output_tmp"_all.ps $BASE/"$output_tmp".pdf

##cleanup
cd $BASE || exit
rm -r $BASE/TEMP
