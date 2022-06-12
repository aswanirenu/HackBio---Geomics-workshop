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

#Installation of software
sudo apt-get -y install fastqc
sudo apt-get -y install fastp
sudo apt-get -y install bwa
sudo apt-get -y install samtools

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

#implementing fastp

#download trim.sh script for implementing fastp for all sequences
wget https://raw.githubusercontent.com/josoga2/yt-dataset/main/dataset/trim.sh

bash trim.sh

#renaming
mv \Qc_reads trimmed_reads

#implementing BWA (burrow wheelar alignment)

mkdir references
cd references

#download the required reference genome
wget https://raw.githubusercontent.com/josoga2/yt-dataset/main/dataset/references/reference.fasta

#download script for performing bwa
wget https://raw.githubusercontent.com/josoga2/yt-dataset/main/dataset/aligner.sh

bash aligner.sh

#implementing samtools (manipulating sam/bam/cram files)

cd alignment_map

#converting sam to bam
#samtools view -S -b filename.bam > filename.sam

samtools view -S -b Alsen.bam > Alsen.sam
samtools view -S -b Baxter.bam > Baxter.sam
samtools view -S -b Chara.bam > Chara.sam
samtools view -S -b Drysdale.bam > Drysdale.sam

#view bam files
samtools view ACBarrie.bam | less
samtools view Alsen.bam | less
samtools view Baxter.bam | less
samtools view Chara.bam | less
samtools view Drysdale.bam | less

#sort according to ascending order
samtools sort ACBarrie.bam -o sorted_ACBarrie.bam
samtools sort Alsen.bam -o sorted_Alsen.bam
samtools sort Baxter.bam -o sorted_Baxter.bam
samtools sort Chara.bam -o sorted_Chara.bam
samtools sort Drysdale.bam -o sorted_Drysdale.bam

#visualize to check if bam files are sorted
samtools view sorted_ACBarrie.bam | head -n 5
samtools view sorted_Alsen.bam | head -n 5
samtools view sorted_Baxter.bam | head -n 5
samtools view sorted_Chara.bam | head -n 5
samtools view sorted_Drysdale.bam | head -n 5

cd raw_reads

#move alignment_map and repaired folders to output folder
mv -v alignment_map/ output/
mv -v repaired/ output/





