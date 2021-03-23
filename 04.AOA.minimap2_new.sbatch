#!/bin/bash

#SBATCH --partition=ieg_lm,ieg_128g,ieg_64g,ieg_plus    ### Partition (like a queue in PBS)
#SBATCH --job-name=Haibei_wp_megahit  ### Job Name
#SBATCH -o /condo/ieg/jianshu/log/jarray.%j.%N.out         ### File in which to store job output/error
#SBATCH -e /condo/ieg/jianshu/log/jarray.%j.%N.err
#SBATCH --time=10-00:00:00          ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1                   ### Node count required for the job
#SBATCH --ntasks=1                  ### Nuber of tasks to be launched per Node
#SBATCH --cpus-per-task=12          ### Number of threads per task (OMP threads)
#SBATCH --mem=20G                   ### memory for each job
#SBATCH --mail-type=FAIL            ### When to send mail
#SBATCH --mail-user=jianshuzhao@yahoo.com. ### mail to send
#SBATCH --get-user-env              ### Import your user environment setup
#SBATCH --requeue                   ### On failure, requeue for another try
#SBATCH --verbose                   ### Increase informational messages
#SBATCH --array=11,14,21,24


module purge

source ~/.bashrc
conda init bash
conda activate base

name=WP${SLURM_ARRAY_TASK_ID}"0"
wd=/condo/ieg/qiqi/Haibei_metaG
output=/condo/ieg/qiqi/Haibei_result/01.AOA.minimap2

/condo/ieg/qiqi/miniconda3/bin/minimap2 -a -t 12 -x sr -o ${output}/${name}.sam ${output}/AOA.fasta ${wd}/${name}_paired_1.fastq.gz ${wd}/${name}_paired_2.fastq.gz
/condo/ieg/qiqi/miniconda3/bin/samtools view -bS -@ 12 ${output}/${name}.sam > ${output}/${name}.bam
/condo/ieg/qiqi/miniconda3/bin/samtools sort -@ 12 -O bam -o ${output}/${name}_sorted.bam ${output}/${name}.bam
rm -rf ${output}/${name}.sam
rm -rf ${output}/${name}.bam
