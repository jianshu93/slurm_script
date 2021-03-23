#!/bin/bash

#SBATCH --partition=ieg_64g,ieg_128g,ieg_lm   ### Partition (like a queue in PBS)
#SBATCH --job-name=Ok_warming_coassem_binning_metawrap  ### Job Name
#SBATCH -o /condo/ieg/jianshu/log/jarray.%j.%N.out         ### File in which to store job output/error
#SBATCH -e /condo/ieg/jianshu/log/jarray.%j.%N.err
#SBATCH --time=15-08:00:00          ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1                   ### Node count required for the job
#SBATCH --ntasks=1                  ### Nuber of tasks to be launched per Node
#SBATCH --cpus-per-task=24          ### Number of threads per task (OMP threads)
#SBATCH --mem=60G                   ### memory for each job
#SBATCH --mail-type=FAIL            ### When to send mail
#SBATCH --mail-user=jianshuzhao@yahoo.com. ### mail to send
#SBATCH --get-user-env              ### Import your user environment setup
#SBATCH --requeue                   ### On failure, requeue for another try
#SBATCH --verbose                   ### Increase informational messages

module load metaWRAP
wd=/condo/ieg/shared_data/To_Ya
contig=/condo/ieg/jianshu/ok_warming/01.coassembly/ok_coassembly_warming.contigs.fa
output=/condo/ieg/jianshu/ok_warming/02.binnning_co

gunzip ${wd}/X101N.fastq.gz ${wd}/X111N.fastq.gz ${wd}/X121N.fastq.gz ${wd}/X131N.fastq.gz ${wd}/X141N.fastq.gz ${wd}/X151N.fastq.gz ${wd}/X161N.fastq.gz

metawrap binning -a ${contig} -o ${output}/binning_warming -t 24 -m 60 --metabat2 --maxbin2 --concoct --interleaved ${wd}/X101N.fastq ${wd}/X111N.fastq ${wd}/X121N.fastq ${wd}/X131N.fastq ${wd}/X141N.fastq ${wd}/X151N.fastq ${wd}/X161N.fastq
rm ${output}/binning_control/work_files
pigz ${wd}/*.fastq
