cwlVersion: v1.0
class: Workflow
id: cnvkit-theta2-wf

requirements: 
  - class: ScatterFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: SubworkflowFeatureRequirement

inputs:
  tumor_cns: { type: File, doc: "Tumor segmented log2 ratios file, .cns"}
  reference_cnn: { type: File, doc: "Copy number reference profile for sample, .cnn"}
  paired_vcf: { type: File, doc: "Tumor/normal paired vcf file"}
  tumor_ID: {type: string, doc: "Tumor bs_id"}
  normal_ID: {type: string, doc: "Normal bs_id"}	
  output_basename: {type: string}

outputs:
  theta_n2_graph: { type: File, outputSource: RunTHetA/n2_graph}
  theta_n2_results: { type: File, outputSource: RunTHetA/n2_results}
  theta_n2_withBounds: {type: File, outputSource: RunTHetA/n2_withBounds}
  theta_n3_graph: {type: File, outputSource: RunTHetA/n3_graph}
  theta_n3_results: {type: File, outputSource: RunTHetA/n3_results}
  theta_n3_withBounds: {type: File, outputSource: RunTHetA/n3_withBounds}
  theta_best_results: {type: File, outputSource: RunTHetA/best_results}

steps:
  cnvkit_export_theta:
    run: ../tools/cnvkit_export_theta.cwl
    in:
      input_tumor_cns: tumor_cns
      input_reference_cnn: reference_cnn
      input_paired_vcf: paired_vcf
      input_tumor_ID: tumor_ID
      input_normal_ID: normal_ID
    out: [call_interval_count, call_tumor_snp, call_normal_snp]
  
  RunTHetA:
    run: ../tools/THetA2.cwl
    in:
      input_interval_count: cnvkit_export_theta/call_interval_count
      input_tumor_snp: cnvkit_export_theta/call_tumor_snp
      input_normal_snp: cnvkit_export_theta/call_normal_snp
      input_output_basename: output_basename
    out: [n2_graph, n2_results, n2_withBounds, n3_graph, n3_results, n3_withBounds, best_results]

$namespaces:
  sbg: https://sevenbridges.com

hints:
  - class: 'sbg:maxNumberOfParallelInstances'
    value: 2
