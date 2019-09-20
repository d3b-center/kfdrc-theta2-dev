cwlVersion: v1.0
class: CommandLineTool
id: cnvkit_export_theta
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'images.sbgenomics.com/milos_nikolic/cnvkit:0.9.3'
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 16000
    coresMin: 4

baseCommand: [cnvkit.py, export, theta]  
arguments:
  - position: 1
    shellQuote: false
    valueFrom: >- 
      -r $(inputs.input_reference_cnn.path)
      -v $(inputs.input_paired_vcf.path)
      -i $(inputs.tumor_ID)
      -n $(inputs.normal_ID)
      $(inputs.input_tumor_cns.path)

inputs:
  input_tumor_cns: File
  input_reference_cnn: File
  input_paired_vcf: File
  input_normal_ID: string
  input_tumor_ID: string

outputs:
  call_interval_count:
    type: File
    outputBinding:
      glob: '*.call.interval_count'
  call_tumor_snp:
    type: File
    outputBinding:
      glob: '*.call.tumor.snp_formatted.txt'
  call_normal_snp:
    type: File
    outputBinding:
      glob: '*.call.normal.snp_formatted.txt'
    
