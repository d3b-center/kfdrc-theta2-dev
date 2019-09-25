class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: cnvkit_batch
baseCommand: []
inputs:
  input_sample: {type: File, doc: "tumor bam file", secondaryFiles: [^.bai]}
  input_control: {type: ['null', File], doc: "normal bam file", secondaryFiles: [^.bai]}
  reference: {type: ['null', File], doc: "fasta file, needed if cnv kit cnn not already built", secondaryFiles: [.fai]}
  wgs_mode: {type: ['null', string], doc: "for WGS mode, input Y. leave blank for hybrid mode"}
  output_basename: {type: string}
  capture_regions: {type: ['null', File], doc: "target regions for WES"}
  annotation_file: {type: ['null', File], doc: "refFlat.txt file,  needed if cnv kit cnn not already built"}

outputs:
  output_calls:
    type: File
    outputBinding:
      glob: '*.call.cns'
  output_cnr:
    type: File
    outputBinding:
      glob: '*.cnr'
  output_reference:
    type: File?
    outputBinding:
      glob: '*_cnvkit_reference.cnn'
arguments:
  - position: 1
    shellQuote: false
    valueFrom: >-
      ln -s $(inputs.input_sample.path) .; ln -s
      $(inputs.input_sample.secondaryFiles[0].path)
      ./$(inputs.input_sample.basename).bai

      ${ 
          var cmd = "";
          if (inputs.input_control != null) {
              cmd = "ln -s $(inputs.input_control.path) .; ln -s $(inputs.input_control.secondaryFiles[0].path) ./$(inputs.input_control.basename).bai"
          }
          return cmd;
      }

      cnvkit.py batch  
      -p $(inputs.threads)
      ${
          var cmd = "";
          if (inputs.wgs_mode == 'Y') {
              cmd = " -m wgs ";
          }
          return cmd;
      } $(inputs.input_sample.path)  ${
          var cmd = "--normal ";
          if (inputs.input_control != null) {
              cmd += inputs.input_control.path + " ";
          }
          return cmd;
      } --fasta $(inputs.reference.path)  ${
          var cmd = "";
          if (inputs.capture_regions != null) {
              cmd = "--targets " + inputs.capture_regions.path;
          }
          return cmd;
      } --annotate $(inputs.annotation_file.path) --output-reference
      $(inputs.output_basename)_cnvkit_reference.cnn
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: $(inputs.threads)
  - class: DockerRequirement
    dockerPull: 'images.sbgenomics.com/milos_nikolic/cnvkit:0.9.3'
  - class: InlineJavascriptRequirement
