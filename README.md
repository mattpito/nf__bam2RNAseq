# nf__bam2fastq by Manthos Pitoulias :bowtie:
Nextflow workflow starting from bam files, reverse engineering to fastq files. Files can be used for transcript abundance quantification e.g.,  STAR/RSEM or Kallisto. THIS WORKFLOW IF FOR PAIRED SEQUENCING.


## Bam to fastq

Self-explanatory. Bear in mind (again) flow is currently for paired sequencing. Will update it in time to include more cases.

**You can edit the config file to include your bam locations or the final results directory.**

## Fastq split to r1,r2.fastq
Self-explanatory. The input fastq file has a /1 or /2 id next to the reads. This is used to split the fastq to 2 subsequent fastq files that are paired BUT DESYNCED.


## Repairing the files

The process of reverse engineering can leave the paired fastq r1,r2 desynced, thus bottlenecking downstream applications ( e.g., using RSEM). That is why we repair the files with BBMAP repair.sh. This script along with its dependencies can be stored in a directory  named "bin" inside the main nextflow directory (to avoid absolute paths). E.g., 

```bash
.
├── README.md
├── another_flow.nf
├── bin
├── cached
├── main.nf
├── nextflow.config
├── results
├── test_files
└── work

```

Singleton Reads are not included (Reads without a pair after sync)
