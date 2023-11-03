#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
example process
*/
process example_process {

    publishDir "${out_dir}", pattern: "results/*txt", mode: 'copy'

    output:
        path 'results/*txt'

    script:
    """
    mkdir -p results
    
    hello.py > results/hello.txt
    """

}