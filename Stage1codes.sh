 #!/bin/bash
 
cd team_darwin
#download the file DNA.fa
wget https://raw.githubusercontent.com/HackBio-Internship/wale-home-tasks/main/DNA.fa

#Counting the number of sequences in DNA.fa 
grep -c ">" DNA.fa

#One-line command in Bash to get the total A, T, G & C counts for all the sequences in the file above
grep -Eo 'A|T|G|C' DNA.fa | sort | uniq -c | awk '{print $2": "$1}'

#setting up miniconda
wget  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
ls
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
conda config --set auto_activate_base false
conda activate base

#Installation of fastqc
sudo apt-get install fastqc

#creating the output folder
mkdir output
cd output

#downloading the required datasets
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/ACBarrie_R1.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/ACBarrie_R2.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Chara_R1.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Chara_R2.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Alsen_R1.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Alsen_R2.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Baxter_R1.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Baxter_R2.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Drysdale_R1.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Drysdale_R2.fastq.gz

mkdir Qc_report

#implementing fastqc

fastqc Baxter_R1.fastq.gz -o Qc_report
ls Qc_report
fastqc Alsen_R1.fastq.gz  -o Qc_report
ls Qc_report
fastqc Alsen_R2.fastq.gz -o Qc_report
ls Qc_report
fastqc ACBarrie_R1.fastq.gz -o Qc_report
ls Qc_report
fastqc ACBarrie_R2.fastq.gz -o Qc_report
ls Qc_report
fastqc Baxter_R2.fastq.gz -o Qc_report
ls Qc_report
fastqc Chara_R1.fastq.gz -o Qc_report
ls Qc_report
fastqc Chara_R2.fastq.gz -o Qc_report
ls Qc_report
fastqc Drysdale_R1.fastq.gz -o Qc_report
ls Qc_report
fastqc Drysdale_R2.fastq.gz -o Qc_report
ls Qc_report




