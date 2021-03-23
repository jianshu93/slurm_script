#!/bin/bash

#SBATCH --partition=ieg_128g,ieg_lm,ieg_64g,ieg_plus    ### Partition (like a queue in PBS)
#SBATCH --job-name=Haibei_wp_megahit  ### Job Name
#SBATCH -o /condo/ieg/jianshu/jarray.%j.%N.out         ### File in which to store job output/error
#SBATCH -e /condo/ieg/jianshu/jarray.%j.%N.err
#SBATCH --time=06:00:00          ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1                   ### Node count required for the job
#SBATCH --ntasks=1                  ### Nuber of tasks to be launched per Node
#SBATCH --cpus-per-task=2          ### Number of threads per task (OMP threads)
#SBATCH --mem=20G                   ### memory for each job
#SBATCH --mail-type=FAIL            ### When to send mail
#SBATCH --mail-user=jianshuzhao@yahoo.com. ### mail to send
#SBATCH --get-user-env              ### Import your user environment setup
#SBATCH --requeue                   ### On failure, requeue for another try
#SBATCH --verbose                   ### Increase informational messages
#SBATCH --array=101,104,11,111,114,121,124,131,134,14,141,144,151,154,161,164,171,174,181,184,191,194,201,204,21,211,214,221,224,231,234,24,241,244,251,254,261,264,271,274,281,284,291,294,301,304,31,311,314,321,324,331,334,34,341,344,351,354,361,364,41,44,51,54,61,64,71,74,81,84,91,94



module purge

source ~/.bashrc
conda init bash
conda activate base

name=WP${SLURM_ARRAY_TASK_ID}"0"
wd=/condo/ieg/qiqi/Haibei_metaG
output=/condo/ieg/qiqi/Haibei_result/01.AOA.minimap2

/condo/ieg/qiqi/miniconda3/bin/coverm genome -d /condo/ieg/qiqi/Haibei_result/miga_drep_archaea_hq_unique_checked -x fasta -b ${output}/${name}_sorted.bam --min-covered-fraction 0.01 -m trimmed_mean --trim-min 0.1 --trim-max 0.9 --min-read-percent-identity 0.95 --min-read-aligned-percent 0.70 > ${output}/${name}.coverm_TAD80_new1.txt

/condo/ieg/qiqi/miniconda3/bin/coverm genome -d /condo/ieg/qiqi/Haibei_result/miga_drep_archaea_hq_unique_checked -x fasta -b ${output}/${name}_sorted.bam --min-covered-fraction 0.01 -m rpkm --min-read-percent-identity 0.95 --min-read-aligned-percent 0.70 > ${output}/${name}.coverm_RPKM_new1.txt
