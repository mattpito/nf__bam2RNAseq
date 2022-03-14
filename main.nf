#! /usr/bin/env nextflow

params.sorted_bam = file("/Users/manthospitoulias/Desktop/test_files/bam_files/*.sorted.bam")


process bam2fq {

    input:
    file bam from params.sorted_bam
    output:
    file "${bam}.fastq" into bam2fq_ch1, bam2fq_ch2

    shell:
    """
    samtools bam2fq $bam > ${bam}.fastq
    """
}


process split_r1{

    input:
    file x from bam2fq_ch1

    output:
    file "${x}_r1.fastq" into r1_fastq

    shell:
    """
    cat $x | grep '^@.*/1\$' -A 3 |grep -v -- "^--\$" > ${x}_r1.fastq
    """

	

}

process split_r2{

    input:
    file x from bam2fq_ch2

    output:
    file "${x}_r2.fastq" into r2_fastq

    shell:
    """
    cat $x | grep '^@.*/2\$' -A 3 |grep -v -- "^--\$" > ${x}_r2.fastq
    """

	

}

