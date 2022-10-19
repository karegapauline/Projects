process sayHello {
 input:
 val y
 output:
 stdout
 script:
 """
 print "$y world!"
 """
}

process split {
 input: 
 val y
 output: 
 path 'chunk_*'
 script:
 """
 print "$y"| split -b 6 - chunk_
 """
}

 workflow {
 init_ch=Channel.of('Bonjour', 'Ciao', 'Hello', 'Hola')
 tosplit_ch=sayHello(init_ch)
 split(tosplit_ch).view()
}
