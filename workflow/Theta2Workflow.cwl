class: Workflow
cwlVersion: v1.0
id: cnvkit_theta2_wf
$namespaces:
  sbg: 'https://sevenbridges.com'
inputs:
  - id: normal_ID
    type: string
    doc: Normal bs_id
    'sbg:x': 0
    'sbg:y': 535
  - id: output_basename
    type: string
    'sbg:x': 348.5657653808594
    'sbg:y': 46.16606521606445
  - id: paired_vcf
    type: File
    doc: Tumor/normal paired vcf file
    'sbg:x': 0
    'sbg:y': 428
  - id: reference_cnn
    type: File
    doc: 'Copy number reference profile for sample, .cnn'
    'sbg:x': 0
    'sbg:y': 321
  - id: tumor_ID
    type: string
    doc: Tumor bs_id
    'sbg:x': 0
    'sbg:y': 107
  - id: tumor_cns
    type: File
    doc: 'Tumor segmented log2 ratios file, .cns'
    'sbg:x': 0
    'sbg:y': 214
outputs:
  - id: theta_best_results
    outputSource:
      - RunTHetA/best_results
    type: File
    'sbg:x': 886.4033813476562
    'sbg:y': 642
  - id: theta_n2_graph
    outputSource:
      - RunTHetA/n2_graph
    type: File
    'sbg:x': 886.4033813476562
    'sbg:y': 535
  - id: theta_n2_results
    outputSource:
      - RunTHetA/n2_results
    type: File
    'sbg:x': 886.4033813476562
    'sbg:y': 428
  - id: theta_n2_withBounds
    outputSource:
      - RunTHetA/n2_withBounds
    type: File
    'sbg:x': 886.4033813476562
    'sbg:y': 321
  - id: theta_n3_graph
    outputSource:
      - RunTHetA/n3_graph
    type: File
    'sbg:x': 886.4033813476562
    'sbg:y': 214
  - id: theta_n3_results
    outputSource:
      - RunTHetA/n3_results
    type: File
    'sbg:x': 886.4033813476562
    'sbg:y': 107
  - id: theta_n3_withBounds
    outputSource:
      - RunTHetA/n3_withBounds
    type: File
    'sbg:x': 886.4033813476562
    'sbg:y': 0
steps:
  - id: RunTHetA
    in:
      - id: input_interval_count
        source: cnvkit_export_theta/call_interval_count
      - id: input_normal_snp
        source: cnvkit_export_theta/call_normal_snp
      - id: input_output_basename
        source: output_basename
      - id: input_tumor_snp
        source: cnvkit_export_theta/call_tumor_snp
    out:
      - id: best_results
      - id: n2_graph
      - id: n2_results
      - id: n2_withBounds
      - id: n3_graph
      - id: n3_results
      - id: n3_withBounds
    run: ../tools/THetA2.cwl
    'sbg:x': 505.203125
    'sbg:y': 279
  - id: cnvkit_export_theta
    in:
      - id: input_normal_ID
        source: normal_ID
      - id: input_paired_vcf
        source: paired_vcf
      - id: input_reference_cnn
        source: reference_cnn
      - id: input_tumor_ID
        source: tumor_ID
      - id: input_tumor_cns
        source: tumor_cns
    out:
      - id: call_interval_count
      - id: call_normal_snp
      - id: call_tumor_snp
    run: ../tools/cnvkit_export_theta.cwl
    'sbg:x': 163.34375
    'sbg:y': 374.5
hints:
  - class: 'sbg:maxNumberOfParallelInstances'
    value: 2
requirements: []
