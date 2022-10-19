#!/usr/bin/env nextflow
nextflow.enable.dsl=2
workflow {
  init_ch=Channel.of('Bonjour', 'Ciao', 'Hello', 'Hola')
  filepairs_ch=Channel.fromFilePairs('dummy{,2}.fa')
  uniquefile_ch=Channel.fromPath('dummy2.fa')
  SRA_ch=Channel.fromSRA('SRP043510')

  //The next line will be our init_ch and will print each element of a list one by one
  init_ch.view()
  //The next line will be our filepairs_ch
  filepairs_ch.view()
  //The next line will be our uniquefile_ch
  uniquefile_ch.view()
  //And for last here is an exemple of SRA_ch
  SRA_ch.view()
}
