 #!/bin/bash
cd team_darwin
grep -c ">" DNA.fa
grep -Eo 'A|T|G|C' DNA.fa | sort | uniq -c | awk '{print $2": "$1}'

#setting up miniconda
wget  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
ls
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
conda config --set auto_activate_base false
conda activate base
#download and installation of fastqc
mkdir output
cd output
mkdir Qc_report
fastqc Baxter_R1.fastq.gz -o Qc_report
ls Qc_report
fastqc Alsen_R1.fastq.gz  -o Qc_report
ls Qc_report
fastqc Alsen_R2.fast.gz -o Qc_report
ls Qc_report
