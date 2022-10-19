#Activate preferred/installed version of qiime2

conda activate qiime2-2022.2

#Import paired end seqs using preferred/applicable method/format (for manifest file method, header should be "sample-id,absolute-filepath,direction"

qiime tools import --type 'SampleData[PairedEndSequencesWithQuality]' --input-path manifest_1.txt --output-path demux-paired-end.qza --input-format PairedEndFastqManifestPhred33 

#Trim primers, for bacterial 16SrRNA gene V4 region

qiime cutadapt trim-paired --i-demultiplexed-sequences demux-paired-end.qza --p-cores 4 --p-front-f CCTACGGGNGGCWGCAG --p-front-r GACTACHVGGGTATCTAATCC --o-trimmed-sequences trimmed.qza --verbose 


# Check quality plots and sequence length (Summarise the reads)
#create visualization artefact
qiime demux summarize --i-data trimmed.qza --o-visualization trimmed.qzv 

#view artefact
qiime tools view trimmed.qzv

#Based on plots, decide appropriate cut offs for denoising
#Denoise ...DADA2 or Deblur..or..other

#DADA2
qiime dada2 denoise-paired --i-demultiplexed-seqs trimmed.qza --p-trunc-len-f 283 --p-trunc-len-r 237 --p-n-threads 3 --p-n-reads-learn 1000000 --o-representative-sequences rep-seqs.qza --o-table table.qza --o-denoising-stats denoise-stats.qza --verbose

#create visualization artefact for denoising stats

qiime metadata tabulate \
--m-input-file denoise-stats.qza \
--o-visualization stats-dada2.qzv

#view denoisind stats

qiime tools view stats-dada2.qzv

#Create visualization artefact for denoising table
qiime feature-table summarize \
--i-table table.qza \
--o-visualization table.qzv 

#view table
qiime  tools view table.qzv

#Create visualization artefact for representative seqs
qiime feature-table tabulate-seqs \
--i-data rep-seqs.qza \
--o-visualization rep-seqs.qzv 

#view rep_seqs
qiime  tools view rep-seqs.qzv


#2. using deblur
qiime quality-filter q-score --i-demux trimmed.qza --o-filtered-sequences demux-filtered.qza --o-filter-stats demux-filter-stats.qza

qiime metadata tabulate --m-input-file demux-filter-stats.qza --o-visualization demux-filter-stats.qzv

qiime  tools view demux-filter-stats.qzv

time qiime deblur denoise-16S --i-demultiplexed-seqs demux-filtered.qza --p-trim-length 230 --o-representative-sequences rep-seqs-deblur.qza --o-table  table-deblur.qza --p-sample-stats --o-stats deblur-stats.qza --verbose
#####--p-trim-length N ->anything shorter than N will be discarded
qiime deblur visualize-stats --i-deblur-stats deblur-stats.qza --o-visualization deblur-stats.qzv
qiime tools view deblur-stats.qzv
qiime feature-table summarize --i-table table-deblur.qza --o-visualization table.qzv --m-sample-metadata-file metadata.tsv
qiime feature-table tabulate-seqs --i-data rep-seqs-deblur.qza --o-visualization rep-seqs-deblur.qzv
qiime  tools view rep-seqs-deblur.qzv

qiime feature-table summarize \
--i-table table.qza \
--o-visualization table.qzv \
--m-sample-metadata-file metadata.tsv
qiime feature-table tabulate-seqs \
--i-data rep-seqs.qza \
--o-visualization rep-seqs.qzv 

qiime  tools view table.qzv


#Classify rep-seqs/ASVs/OTUs using preferred method
#classify with blast silva 138

qiime feature-classifier classify-consensus-blast \
--i-query rep-seqs-deblur.qza \
--i-reference-taxonomy Silva-v138-515f-806r-taxonomy.qza \
--i-reference-reads SILVA-138-SSURef-515f-806r-Seqs.qza \
--o-classification taxonomy \
--p-perc-identity 0.90 \
--p-maxaccepts 1

#filter known contaminants
qiime taxa filter-table \
--i-table table-deblur.qza \
--i-taxonomy taxonomy.qza \
--p-exclude Unassigned,Metagenome,Mitochondria,Chloroplast,Cyanobacteria,Cenchrus,Hydra \
--o-filtered-table filtered-table1.qza

#Export preffered formats
#Export the feature table data 
qiime tools export --input-path filtered-table1.qza --output-path b3
#Convert the biom file into a .tsv file
biom convert -i b3/feature-table.biom -o b3/otu_table.txt --to-tsv
#Export the taxonomy file
qiime tools export --input-path taxonomy.qza --output-path b3

#manually remove filtered contaminants from the taxonomy file
