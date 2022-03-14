#! /usr/bin/env nextflow

sam_com="Samtools bam2fq"
params.query="file.bam"

println "I will reverse engineer $params.query via $sam_com"