# nf__bam2fastq
Nextflow workflow starting from bam files, reverse engineering to fastq files. Files can be used for transcript abundance quantification e.g.,  STAR/RSEM or Kallisto.



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


