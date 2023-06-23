FROM ubuntu:22.04

#Metadata
LABEL base.image="ubuntu:22.04"
LABEL version="1.15.1"
LABEL description="bcftools 1.15.1"
LABEL tag="TimeAttackGenComp"

RUN buildDeps='wget gcc g++ make' && \
    # Update/install dependencies
    apt-get update -qq && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        $buildDeps \ 
        zlib1g-dev \
        libbz2-dev \
        bzip2 \
        liblzma-dev \
        libcurl4-openssl-dev \
    && \ 
    # Download bcftools and compile
    wget --quiet --no-check-certificate \
        -O bcftools-1.15.1.tar.bz2 \
        https://github.com/samtools/bcftools/releases/download/1.15.1/bcftools-1.15.1.tar.bz2  \
    && \
    tar -xvjf bcftools-1.15.1.tar.bz2 && \
    cd bcftools-1.15.1/ && \
    make && \
    install -D -m 0755  bcftools /usr/local/bin/bcftools && \
    cd ../ && \
    # Cleanup
    rm  -rf bcftools-1.15.1 bcftools-1.15.1.tar.bz2 && \
    apt-get purge -y --auto-remove $buildDeps

