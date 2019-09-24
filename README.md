# kfdrc-theta2-dev

THetA2: A tool that estimates purity for CNV analysis + identifies subclonal populations within tumor samples.

Tools Used:
Cnvkit - Version 0.9.3 - cnvkit.py export theta command generates the input files required to run THetA2. 
	Input Files:
		* sample.cns
		* reference.cnn
		* sample_paired.vcf
	Input Flags:
		* - i sample identification tag
		* - n normal identification tag

THeTa2 - Version 0.7 - RunTHetA - Generates purity and subclonal information from cnvkit output files
	Input Files (generated from cnvkit):
		* .call.tumor.snp_formatted.txt
		* .call.normal.snp_formatted.txt
		* .call.interval_count

