FROM ubuntu:22.04

#Metadata
LABEL base.image="ubuntu:22.04"
LABEL version="2.0.1"
LABEL description="SNAP 2.0.1 aligner"
LABEL tag="TimeAttackGenComp"

RUN buildDeps='wget gcc g++ make ' && \
    apt-get update -qq && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        $buildDeps \
        bzip2 \
        zlib1g-dev \
    && \
    cd /tmp && \
    wget --quiet --no-check-certificate \
        https://github.com/amplab/snap/archive/refs/tags/v2.0.1.tar.gz && \
    tar -xvzf v2.0.1.tar.gz && \
    cd snap-2.0.1/ && \
    make && \
    install -D -m 0755 snap-aligner /usr/local/bin/snap-aligner && \
    cd ../ && \
    rm  -rf snap-2.0.1 v2.0.1.tar.gz && \
    apt-get purge -y --auto-remove $buildDeps
