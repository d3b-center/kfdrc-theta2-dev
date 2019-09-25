cwlVersion: v1.0
class: CommandLineTool
id: theta2
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'davidcurley/theta2:0.7'
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: 8

baseCommand: [/THetA/bin/RunTHetA]
arguments:
  - position: 1
    shellQuote: false
    valueFrom: >-
      --TUMOR_FILE $(inputs.input_tumor_snp.path)
      --NORMAL_FILE $(inputs.input_normal_snp.path)
      --OUTPUT_PREFIX $(inputs.input_output_basename)
      --NUM_PROCESSES 8
      $(inputs.input_interval_count.path)
inputs:
  input_tumor_snp: File
  input_normal_snp: File
  input_interval_count: File
  input_output_basename: string
outputs:
  n2_graph:
    type: File
    outputBinding:
      glob: '*.n2.graph.pdf'
  n2_results:
    type: File
    outputBinding:
      glob: '*.n2.results'
  n2_withBounds:
    type: File
    outputBinding:
      glob: '*.n2.withBounds'
  n3_graph:
    type: File
    outputBinding:
      glob: '*.n3.graph.pdf'
  n3_results:
    type: File
    outputBinding:
      glob: '*.n3.results'
  n3_withBounds:
    type: File
    outputBinding:
      glob: '*.n3.withBounds'
  best_results:
    type: File
    outputBinding:
      glob: '*.BEST.results'
