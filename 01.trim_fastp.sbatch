#!/bin/bash

#SBATCH --partition=ieg_128g,ieg_lm,ieg_plus,ieg_64g,ieg         ### Partition (like a queue in PBS)
#SBATCH --job-name=Haibei_wp_fastp  ### Job Name
#SBATCH -o jarray.%j.%N.out         ### File in which to store job output/error
#SBATCH -e jarray.%N.%j.err
#SBATCH --time=01-00:00:00          ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1                   ### Node count required for the job
#SBATCH --ntasks=1                  ### Nuber of tasks to be launched per Node
#SBATCH --cpus-per-task=16          ### Number of threads per task (OMP threads)
#SBATCH --mem=20G                   ### memory for each job
#SBATCH --mail-type=FAIL            ### When to send mail
#SBATCH --mail-user=jianshuzhao@yahoo.com. ### mail to send
#SBATCH --get-user-env              ### Import your user environment setup
#SBATCH --requeue                   ### On failure, requeue for another try
#SBATCH --verbose                   ### Increase informational messages
#SBATCH --array=101,104,11,111,114,121,124,131,134,14,141,144,151,154,161,164,171,174,181,184,191,194,201,204,21,211,214,221,224,231,234,24,241,244,251,254,261,264,271,274,281,284,291,294,301,304,31,311,314,321,324,331,334,34,341,344,351,354,361,364,41,44,51,54,61,64,71,74,81,84,91,94



module purge

module load MEGAHIT/1.2.9-foss-2019a-Python-3.8.0

name=WP${SLURM_ARRAY_TASK_ID}"0"
wd=/condo/ieg/qiqi/metawarp_2015_Tibetan
output=/condo/ieg/qiqi/metawarp_2015_Tibetan/02.trim_fastp
~/anaconda3/bin/fastp -i ${wd}/01.raw_reads/${name}_R1.fastq.gz -o ${output}/${name}_trimmed_R1.fastq.gz -I ${wd}/01.raw_reads/${name}_R2.fastq.gz -O ${output}/${name}_trimmed_R2.fastq.gz --detect_adapter_for_pe --length_required 50 --cut_front --cut_tail --cut_mean_quality 10 -w 16
