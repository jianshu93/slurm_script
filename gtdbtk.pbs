#!/bin/bash

#SBATCH --partition=ieg_lm,ieg_128g,ieg_64g   ### Partition (like a queue in PBS)
#SBATCH --job-name=GWMC_gtdbtk  ### Job Name
#SBATCH -o /condo/ieg/jianshu/log/jarray.%j.%N.out         ### File in which to store job output/error
#SBATCH -e /condo/ieg/jianshu/log/jarray.%j.%N.err
#SBATCH --time=08:00:00          ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1                   ### Node count required for the job
#SBATCH --ntasks=1                  ### Nuber of tasks to be launched per Node
#SBATCH --cpus-per-task=32          ### Number of threads per task (OMP threads)
#SBATCH --mem=240G                   ### memory for each job
#SBATCH --mail-type=FAIL            ### When to send mail
#SBATCH --mail-user=jianshuzhao@yahoo.com. ### mail to send
#SBATCH --get-user-env              ### Import your user environment setup
#SBATCH --requeue                   ### On failure, requeue for another try
#SBATCH --verbose                   ### Increase informational messages


module purge
source ~/.bashrc
conda init bash
conda activate gtdbtk
which pplacer
which prodigal

wd=/condo/ieg/jianshu/GWMC/12.DAS_allbins_derep_renamed
output=/condo/ieg/jianshu/GWMC/12.DAS_allbins_derep_renamed_gtdbtk

/condo/ieg/jianshu/miniconda3/envs/gtdbtk/bin/gtdbtk classify_wf --genome_dir ${wd} --out_dir ${output} --cpus 32 --pplacer_cpus 8 -x fasta