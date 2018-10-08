#! /bin/bash
QT_LOGGING_RULES='*=false'
export QT_LOGGING_RULES
outputs_txt=data/disparity-outputs.txt
left_img_txt=data/disparity-left-images.txt
right_img_txt=data/disparity-right-images.txt
viewer=$(command -v pfsv)
outdir="outputs"
[ ! -d $outdir ] && mkdir $outdir

main() {
    ./run-network.sh -n DispNetCorr1D -v $left_img_txt $right_img_txt $outputs_txt
}

show() { 
    pfms=$(cat $outputs_txt)
    #echo $pfms
    mlen=${#pfms[*]}
    for pfm in ${pfms[@]}; do
        echo $pfm
        pfm1=$outdir/$pfm
        mv -f $pfm $pfm1
        $1 $pfm1 &
    done
}

if [ -z $viewer ]; then 
	xdg-open https://sourceforge.net/projects/pfstools/files/pfstools/
    exit 1
fi
time main
time show $viewer
read -p "Close all windows?" -n 1 -r
[[ $REPLY =~ ^[Yy]$ ]] && pkill -9 pfsv
