#!/bin/bash
set -euo pipefail

# make software accessible:
module load nextflow

echo ____________________________________
nextflow -version
echo ____________________________________


## Override defaults set by nextflow module:
export NXF_WORK="$scrproj/work"
export NXF_TEMP="$scrproj/tmp"
export NXF_HOME="/projects/$USER/software/nextflow_config"
export _JAVA_OPTIONS='-Xmx16G' # increase heap to avoid java.lang.OutOfMemoryError



nextflow run "$pipelinepath"  -ansi-log false \
	--input "$samplefile" --trim_fastq \
	--save_trimmed --save_mapped --save_output_as_bam --outdir "$pipeoutdir" \
	--tools mutect2,strelka,tiddit,freebayes,vep,snpeff -resume \
	-c curc_alpine.config,fastp.config


