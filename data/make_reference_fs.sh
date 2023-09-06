#!/bin/sh

mkdir -p data/snap-2.0.1
if [ ! -x docker/r-tagc-4.3.1-TAGC.sif -o ! -x docker/snap-aligner-2.0.1.sif ]; then
cat  << EOF
ERROR: Please build images first by executing the following:
(cd docker && make sif)
EOF
    exit 1
fi


# Get the file
if [ ! -f data/hs37d5.fa.gz ]; then
    echo "Downloading reference file hs37d5.fa.gz"
    apptainer exec docker/r-tagc-4.3.1-TAGC.sif \
        wget -O - \
        ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/technical/reference/phase2_reference_assembly_sequence/hs37d5.fa.gz | \
        \
        gunzip -c | \
        gzip -c > data/hs37d5.fa.gz
fi

# Run snap
echo "Creating snap index"
apptainer exec docker/snap-aligner-2.0.1.sif \
    snap-aligner index data/hs37d5.fa.gz data/snap-2.0.1

# Copy snap results to squashfs
echo "Making squashfs filesystem for mounting"
mksquashfs data/snap-2.0.1 data/snap-hs37d5.squashfs

# Remove other stuff and leave squashfs
echo "Removing fa and snap data"
rm -rf data/hs37d5.fa.gz data/snap-2.0.1/
