#! /bin/bash
main() {
    ./run-network.sh -n DispNetCorr1D -v data/disparity-left-images.txt data/disparity-right-images.txt data/disparity-outputs.txt
}

show() { 
    pfms=$(cat data/disparity-outputs.txt)
    #echo $pfms
    mlen=${#pfms[*]}
    for pfm in ${pfms[@]}; do
        echo $pfm
        pfsv $pfm &
    done
}

time main
time show
