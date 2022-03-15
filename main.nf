#! /usr/bin/env nextflow

params.sorted_bam = file("/Users/manthospitoulias/Desktop/test_files/bam_files/*.sorted.bam")
params.publish_dir = './results'
//publishDir "${params.publish_dir}/RE_output", mode: 'copy'



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


process split_r1 {
    storeDir './cached/output_r1r2/'

    input:
    file x from bam2fq_ch1

    output:
    file "${x}_r1.fastq" into r1_fastq

    shell:
    """
    cat $x | grep '^@.*/1\$' -A 3 |grep -v -- "^--\$" > ${x}_r1.fastq
    """

	

}

process split_r2 {
    storeDir './cached/output_r1r2/'

    input:
    file x from bam2fq_ch2

    output:
    file "${x}_r2.fastq" into r2_fastq

    shell:
    """
    cat $x | grep '^@.*/2\$' -A 3 |grep -v -- "^--\$" > ${x}_r2.fastq
    """

	

}

Channel
    .fromFilePairs('./cached/output_r1r2//*_{r1,r2}.fastq')
    .set {samples_ch}


process repair_files {
    storeDir './cached/output_fixed_r1r2/'

    input:
    tuple val(id), file(x) from samples_ch  

    output:
    file "${id}_r1_fixed.fastq" 
    file "${id}_r2_fixed.fastq" 
    

    shell:
    """
    repair.sh in=${x[0]} in2=${x[1]} out=${id}_r1_fixed.fastq out2=${id}_r2_fixed.fastq repair
    """	

}









