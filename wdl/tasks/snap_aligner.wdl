task snap_aligner {
    File fq1
    File fq2
    String ref
    String output_base
    String output_type = "wes"

    Int numThreads = 16
    String sif = "docker/snap-aligner-2.0.1.sif"
    String dockerImage = "quay.io/biocontainers/snap-aligner:2.0.1--hd03093a_1"
    String memory = "8G"

    command {
        snap-aligner \
            paired \
            ${ref} \
            ${fq1} \
            ${fq2} \
            -t ${numThreads} \
            -xf 2.0 \
            -so \
            -R '@RG\tID:${output_base}\tSM:${output_base}\tPL:ILLUMINA\tLB:${output_base}_${output_type}' \
            -o ${output_base}.bam
    }
    output {
        File bam = "${output_base}.bam"
        File bai = "${output_base}.bam.bai"
    }
    runtime {
        memory: memory
        pbs_cpu: numThreads
        pbs_walltime: "6:00:00"
        sif: sif
        docker: dockerImage
        docker_mounts: "data/snap-hs37d5.squashfs:/snap-hs37d5:image-src=/"
    }
}

workflow unittest_snap_aligner {
    String sample_base = "SRR1215996"
    File sample_r1 = "example_data/SRR1215996_1.fastq.gz"
    File sample_r2 = "example_data/SRR1215996_2.fastq.gz"
    String ref = "/snap-hs37d5"

    call snap_aligner {
        input: output_base=sample_base,
               fq1=sample_r1,
               fq2=sample_r2,
               ref=ref
    }
}