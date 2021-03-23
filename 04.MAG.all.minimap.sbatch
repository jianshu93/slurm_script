#!/bin/bash

#SBATCH --partition=ieg_64g,ieg_lm,ieg_128g,ieg_plus,large_lm    ### Partition (like a queue in PBS)
#SBATCH --job-name=Haibei_wp_megahit  ### Job Name
#SBATCH -o /condo/ieg/jianshu/log/jarray.%j.%N.out         ### File in which to store job output/error
#SBATCH -e /condo/ieg/jianshu/log/jarray.%j.%N.err
#SBATCH --time=12:00:00          ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1                   ### Node count required for the job
#SBATCH --ntasks=1                  ### Nuber of tasks to be launched per Node
#SBATCH --cpus-per-task=8          ### Number of threads per task (OMP threads)
#SBATCH --mem=18G                   ### memory for each job
#SBATCH --mail-type=FAIL            ### When to send mail
#SBATCH --mail-user=jianshuzhao@yahoo.com. ### mail to send
#SBATCH --get-user-env              ### Import your user environment setup
#SBATCH --requeue                   ### On failure, requeue for another try
#SBATCH --verbose                   ### Increase informational messages
#SBATCH --array=127,131,132,244,245,247,264,265,266,281,282,284,304,497,539,540,550,551,552


module purge

source ~/.bashrc
conda init bash
conda activate base

name=pico${SLURM_ARRAY_TASK_ID}
wd=/condo/ieg/jianshu/pico/01.resample_reads
output=/condo/ieg/jianshu/pico/10.minimap_MAG_derep

/condo/ieg/jianshu/miniconda3/bin/minimap2 -a -t 8 -x sr -o ${output}/${name}_MAG_derep.sam /condo/ieg/jianshu/pico/pico_derep_MAG_rename.fasta ${wd}/${name}.resampled_1.fastq.gz ${wd}/${name}.resampled_2.fastq.gz
/condo/ieg/jianshu/miniconda3/bin/samtools view -bS -@ 8 ${output}/${name}_MAG_derep.sam > ${output}/${name}_MAG_derep.bam
/condo/ieg/jianshu/miniconda3/bin/samtools sort -@ 8 -O bam -o ${output}/${name}_MAG_derep_sorted.bam ${output}/${name}_MAG_derep.bam
rm -rf ${output}/${name}_MAG_derep.sam
rm -rf ${output}/${name}_MAG_derep.bam
/condo/ieg/jianshu/miniconda3/bin/coverm genome -d /condo/ieg/jianshu/pico/09.DAS_derep_contig_rename -x fasta -b ${output}/${name}_MAG_derep_sorted.bam -m trimmed_mean --trim-min 0.1 --trim-max 0.9 --min-read-percent-identity 0.95 --min-read-aligned-percent 0.70 --contig-end-exclusion 75 > ${output}/${name}.coverm_TAD80_end75.txt
/condo/ieg/jianshu/miniconda3/bin/coverm genome -d /condo/ieg/jianshu/pico/09.DAS_derep_contig_rename -x fasta -b ${output}/${name}_MAG_derep_sorted.bam -m rpkm --trim-min 0.1 --trim-max 0.9 --min-read-percent-identity 0.95 --min-read-aligned-percent 0.70 --contig-end-exclusion 75 > ${output}/${name}.coverm_RPKM_end75.txt
/condo/ieg/jianshu/miniconda3/bin/coverm genome -d /condo/ieg/jianshu/pico/09.DAS_derep_contig_rename -x fasta -b ${output}/${name}_MAG_derep_sorted.bam -m mean --trim-min 0.1 --trim-max 0.9 --min-read-percent-identity 0.95 --min-read-aligned-percent 0.70 --contig-end-exclusion 75 > ${output}/${name}.coverm_mean_end75.txt

/condo/ieg/jianshu/miniconda3/bin/coverm genome -d /condo/ieg/jianshu/pico/09.DAS_derep_contig_rename -x fasta -b ${output}/${name}_MAG_derep_sorted.bam -m trimmed_mean --trim-min 0.1 --trim-max 0.9 --min-read-percent-identity 0.95 --min-read-aligned-percent 0.70 > ${output}/${name}.coverm_TAD80.txt
/condo/ieg/jianshu/miniconda3/bin/coverm genome -d /condo/ieg/jianshu/pico/09.DAS_derep_contig_rename -x fasta -b ${output}/${name}_MAG_derep_sorted.bam -m rpkm --trim-min 0.1 --trim-max 0.9 --min-read-percent-identity 0.95 --min-read-aligned-percent 0.70 > ${output}/${name}.coverm_RPKM.txt
/condo/ieg/jianshu/miniconda3/bin/coverm genome -d /condo/ieg/jianshu/pico/09.DAS_derep_contig_rename -x fasta -b ${output}/${name}_MAG_derep_sorted.bam -m mean --trim-min 0.1 --trim-max 0.9 --min-read-percent-identity 0.95 --min-read-aligned-percent 0.70 > ${output}/${name}.coverm_mean.txt

