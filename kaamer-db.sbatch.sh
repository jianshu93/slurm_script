#!/bin/bash

#SBATCH --partition=ieg_lm,ieg_128g,ieg_64g   ### Partition (like a queue in PBS)
#SBATCH --job-name=GWMC_gtdbtk  ### Job Name
#SBATCH -o /condo/ieg/jianshu/log/jarray.%j.%N.out         ### File in which to store job output/error
#SBATCH -e /condo/ieg/jianshu/log/jarray.%j.%N.err
#SBATCH --time=120:00:00          ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1                   ### Node count required for the job
#SBATCH --ntasks=1                  ### Nuber of tasks to be launched per Node
#SBATCH --cpus-per-task=24          ### Number of threads per task (OMP threads)
#SBATCH --mem=240G                   ### memory for each job
#SBATCH --mail-type=FAIL            ### When to send mail
#SBATCH --mail-user=jianshuzhao@yahoo.com. ### mail to send
#SBATCH --get-user-env              ### Import your user environment setup
#SBATCH --requeue                   ### On failure, requeue for another try
#SBATCH --verbose                   ### Increase informational messages

module purge
source ~/.bashrc
conda init bash
conda activate base

/condo/ieg/jianshu/miniconda3/bin/kaamer-db -make -f gpff -i /condo/ieg/jianshu/db/refseq-bacteria.gpff.gz -d /condo/ieg/jianshu/db/kaamerdb-refseq-bacteria -t 24