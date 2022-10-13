for i in *.gz; do
gunzip "$i"
done

### then compute the number of sequnces read per file
for i in *.fastq; do
wc -l "$i"
done

### run fastqc of fastq files to check the quality
for i in *.fastq; do
fastqc --nogroup "$i" --outdir fastqc
done

### trim the fastq files to remove adapters and the low quality reads
for i in *.fastq; do 
trimmomatic SE -phred33  ${i} ${i::13}"_trimmed".fastq HEADCROP:6 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done


### then check the sequence length after trimming
for i in *.fastq; do
head -2 "$i_trim.fastq" | tail -1 | wc âc
done

### the trimmed fastq files mapped onto sample-metadata were imported into qiime2 as qiime2 artifact with extension .qza
qiime tools import --type 'SampleData[SequencesWithQuality]' --input-path sample-metadata.tsv --output-path single-end-demux.qza --input-format SingleEndFastqManifestPhred33V2

### view the Summary of the imported data

qiime demux summarize --i-data single-end-demux.qza --o-visualization demux.qzv

### perform Quality control to confirm the quality scores of the reads

qiime quality-filter q-score --i-demux single-end-demux.qza --o-filtered-sequences demux-filtered.qza --o-filter-stats demux-filter-stats.qza

qiime metadata tabulate --m-input-file demux-filter-stats.qza --o-visualization demux-filter-stats.qzv

qiime deblur denoise-16S --i-demultiplexed-seqs demux-filtered.qza --p-trim-length 120 --o-representative-sequences rep-seqs.qza --o-table table.qza --p-sample-stats --o-stats deblur-stats.qza 

### Feature Table(OTU) creation

qiime deblur visualize-stats --i-deblur-stats deblur-stats.qza --o-visualization deblur-stats.qzv

### view the feature table summary

qiime feature-table summarize --i-table table.qza --o-visualization table.qzv --m-sample-metadata-file Trimmed_seqs_Manifest 

### Feature Table Tabulate seqs

qiime feature-table tabulate-seqs --i-data rep-seqs.qza --o-visualization rep-seqs.qzv

### Phylogenetic Tree Creation

qiime alignment mafft --i-sequences rep-seqs.qza --o-alignment aligned-rep-seqs.qza

qiime alignment mask --i-alignment aligned-rep-seqs.qza --o-masked-alignment masked-aligned-rep-seqs.qza

qiime phylogeny fasttree --i-alignment masked-aligned-rep-seqs.qza --o-tree unrooted-tree.qza

qiime phylogeny midpoint-root --i-tree unrooted-tree.qza --o-rooted-tree rooted-tree.qza

### perform core metrics 

qiime diversity core-metrics-phylogenetic --i-phylogeny rooted-tree.qza --i-table table.qza --p-sampling-depth 1000 --m-metadata-file Trimmed_seqs_Manifest --output-dir metrics

### Alpha Diversity significance (within sample)

qiime diversity alpha-group-significance --i-alpha-diversity metrics/faith_pd_vector.qza --m-metadata-file Trimmed_seqs_Manifest  --o-visualization metrics/faith-pd-group-significance.qzv

### Beta Diversity/Between sample diversity

qiime emperor plot --i-pcoa metrics/unweighted_unifrac_pcoa_results.qza --m-metadata-file Trimmed_seqs_Manifest --o-visualization metrics/unweighted-unifrac-emperor.qzv

### Taxonomic Assignment

wget -O "gg-13-8-99-515-806-nb-classifier.qza" "https://data.qiime2.org/2019.4/common/gg-13-8-99-515-806-nb-classifier.qza"

qiime feature-classifier classify-sklearn --i-classifier gg-13-8-99-515-806-nb-classifier.qza --i-reads rep-seqs.qza --o-classification taxonomy.qza

qiime metadata tabulate --m-input-file taxonomy.qza --o-visualization taxonomy.qzv

qiime taxa barplot --i-table table.qza --i-taxonomy taxonomy.qza --m-metadata-file Trimmed_seqs_Manifest --o-visualization taxa-bar-plots.qzv


### export the feature  Biom Table from qiime2 env into the dir called phyloseq

qiime tools export --input-path table.qza --output-path phyloseq

### Export taxonomy table to the same dir

qiime tools export --input-path taxonomy.qza --output-path phyloseq

### Export Phylogenetic tree to the same dir

qiime tools export --input-path unrooted-tree.qza --output-path phyloseq

###now we have the qiime2 outputs as feature-table.biom, taxonomy.tsv and tree.nwk which will be imported into phyloseq for further analysis

