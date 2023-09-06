# Tutorial for TimeAttackGenComp
This directory contains a step-by-step approach for running this software and exploring it's use.


## Prerequisites
In order to run this tutorial, you need a network connection and the ability to build and run containers. The examples here will focus on building containers using `podman` and running containers using `apptainer`. By using virtualization, most other prequisites are managed via pulled containers.

- linux environment. If you don't have one (for instance, you're running a mac or windows computer) then there are virtualization options. For me I've been using QEMU to emulate x86 since I have a macbook, running ubuntu. 
- Podman/apptainer. 
- Java (recent version)
- git (to clone this repo!)
- make (to build containers)

## Cloning the Repository
The first step is to clone this repository:
```sh
$ git clone https://github.com/steveneschrich/TimeAttackGenComp
$ cd TimeAttackGenComp
```

## Configuration
There are a number of related steps that are needed prior to running the data through the pipeline. There are a number of internals, configuration files and annotation files that have to be in place for genome alignment and comparison. 

### Retrieving Example Data
We will use some public RNAseq data for the tutorial. See [Example Data](Example_Data.md) for retrieving the data files (fastqs). Note the data will be large, so be sure you have disk space before starting.

### Building Containers
To make the execution of TimeAttackGenComp reproducible and not require extensive software installation, we use containers for the different tools used (and there are a number). Here we have reduced it to building three containers (see the docker/ subdirectory):
- bcftools
- r-tagc
- snap-aligner

Using make (and podman/apptainer), we can build the containers simply for local use:
```sh
$ (cd docker && make sif)
```

The containers should build and be available as `sif` files suitable for singularity/apptainer:
```sh
$ du -h docker/*.sif
163M	docker/bcftools-1.15.1.sif
374M	docker/r-tagc-4.3.1-TAGC.sif
77M	docker/snap-aligner-2.0.1.sif
```


### Creating Reference Data
The snap aligner is used for aligning sequence to a known genome. In our case, the samples are human so we need a human reference. This process can be run using a shell script:

```sh
$ data/make_reference_fs.sh
```

The result of this script should be a file called `data/snap-hs37d5.squashfs`. Note that this is a very large file (as are the source files) and the process takes quite a while to run. 

### Getting Cromwell

The tool runs as a WDL (workflow description language) job. We use the `cromwell` engine for running WDL jobs. Therefore in order to run the pipeline, we'll need to download cromwell and get it setup. This step requires java.

You can (likely) use the latest version of cromwell. Releases of cromwell can be found at https://github.com/broadinstitute/cromwell/releases. 

```sh
$ wget https://github.com/broadinstitute/cromwell/releases/download/85/cromwell-85.jar
$ wget https://github.com/broadinstitute/cromwell/releases/download/85/womtool-85.jar
```
You can verify that cromwell is now available (help message):
```sh
$ java -jar cromwell-85.jar 
```

## Running a test
```sh
java -Dconfig.file=conf/application_local_apptainer.conf -jar cromwell-85.jar run wdl/tasks/snap_aligner.wdl
```

