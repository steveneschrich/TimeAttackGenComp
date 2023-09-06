# Example Data
For the purposes of this tutorial, we will use RNA sequencing data from the SEQC project (https://pubmed.ncbi.nlm.nih.gov/25150838/). Using the Illumina HiSeq, the SEQC profiled pooled cell lines (UHR) and human brain samples (HBRR) derived from the MAQC consortium project (as well as mixtures of the two samples). This data was deposited in SRA.

We will use 4 samples from the BioProject (https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA208369&o=acc_s%3Aa) for SRA Study SRP025982 (https://trace.ncbi.nlm.nih.gov/Traces/index.html?view=study&acc=SRP025982). The samples are:

- A: SAMN02716695 - SRR1215996 (UHR)
- B: SAMN02716670 - SRR1216024 (HBRR)
- C: SAMN02716699 - SRR1216052 (A:B 3:1)
- D: SAMN02716659 - SRR1216080 (A:B 1:3)

The steps below can be summarized as:
- Start the toolkit container
- Prefetch the files (raw format)
- Convert raw format to fastq files

## SRA Toolkit
We will run the SRA toolkit (https://hpc.nih.gov/apps/sratoolkit.html) from a container to download the data (note we will store the data in `example_data`):
```sh
mkdir example_data && cd example_data
apptainer shell docker://ncbi/sra-tools:latest
```

### SRA Configuration Notes
Before we actually start downloading the data, we should specify that we are ok with simplified base quality scores (see https://ncbiinsights.ncbi.nlm.nih.gov/2021/10/19/sra-lite/ for details). 

And this exercise requires a great deal of disk space! So tell the sra-toolkit to download to the current directory (so you can choose a directory with enough space):

To do this, you can run:
```sh
vdb-config --prefetch-to-cwd --simplified-quality-scores yes
```

Once this is configured, we can prefetch samples before converting them to fastq files.

## Prefetch
The toolkit allows us to download samples robustly prior to converting them to fastq format.

```sh
prefetch --progress SRR1215996 SRR1216024 SRR1216052 SRR1216080
```
Note that we are only getting a subset of the project (which is very large)!

This step will generate 4 directories (corresponding to the samples):
```
658.4M	SRR1215996/SRR1215996.sralite
616.1M	SRR1216024/SRR1216024.sralite
654.4M	SRR1216052/SRR1216052.sralite
600.4M	SRR1216080/SRR1216080.sralite
```

## Fastq conversion
Once the prefetch finishes, you can dump fastq files from the image:
```sh
for i in SRR*; do
    fasterq-dump -p $i
    gzip $i_*.fastq
done
```

The result of these steps should be 4 fastq pairs:
```
627.0M	SRR1215996_1.fastq.gz
626.6M	SRR1215996_2.fastq.gz
586.6M	SRR1216024_1.fastq.gz
586.2M	SRR1216024_2.fastq.gz
623.6M	SRR1216052_1.fastq.gz
622.8M	SRR1216052_2.fastq.gz
572.0M	SRR1216080_1.fastq.gz
572.0M	SRR1216080_2.fastq.gz
```
These four samples will be the basis for the tutorial. 

## Finishing Up
Be sure to exit the container and go back to the project directory:
```sh
exit
cd ..
```