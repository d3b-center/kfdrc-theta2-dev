class: Workflow
cwlVersion: v1.0
id: cram2bam_cnvkitbatch_wf

requirements:
  - class: ScatterFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: SubworkflowFeatureRequirement

inputs:
    input_sample: {type: File, secondaryFiles: [.crai]}
    input_control: {type: File, secondaryFiles: [.crai]}
    reference: {type: File, doc: "input reference fasta"}
    annotation_file: {type: File, doc: "refflat.txt file"}
    output_basename: string
    wgs_mode: {type: ['null', string], doc: "for WGS mode, input Y. leave blank for hybrid mode"}
    threads: {type: ['null', int], default: 16}

outputs:
  cnvkit_calls: {type: File, outputSource: cnvkit/output_calls}
  cnvkit_cnr: {type: File, outputSource: cnvkit/output_cnr}
  cnvkit_ref: {type: File, outputSource: cnvkit/output_reference}
steps:
  samtools_sample_cram2bam:
    run: ../tools/samtools_cram2bam.cwl
    in:
      input_reads: input_sample
      reference: reference
    out: [bam_file]
  
  samtools_normal_cram2bam:
    run: ../tools/samtools_cram2bam.cwl
    in:
      input_reads: input_control
      reference: reference
    out: [bam_file]
  
  cnvkit:
    run: ../tools/cnvkit_batch.cwl
    in:
      annotation_file: annotation_file
      reference : reference
      output_basename: output_basename
      wgs_mode: wgs_mode
      threads: threads
      input_control: samtools_normal_cram2bam/bam_file
      input_sample: samtools_sample_cram2bam/bam_file
    out: [output_calls, output_cnr, output_reference]

$namespaces:
  sbg: https://sevenbridges.com

hints:
  - class: sbg:maxNumberOfParallelInstances
    value: 2