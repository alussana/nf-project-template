#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
publish a file giving it an arbitrary path
*/
process publish {

    publishDir "${out_dir}",
                pattern: "${outputFile}",
                mode: 'copy'

    input:
        path 'input/file'
        val outputFile

    output:
        path "${outputFile}"

    script:
    """
    mkdir -p \$(dirname ${outputFile})
    
    cp input/file ${outputFile}
    """

}

/*
split a single input file into chunks of n rows,
each named with a unique identifier

typically, each chunk in the output channel is mapped to its id with
.flatten().map{ file -> tuple( file.baseName, file ) }
*/
process split {

    input:
        path 'input/file'
        val n

    output:
        path "output/*"

    script:
    """
    mkdir -p output
    
    split -l ${n} -a 16 -x input/file output/
    """

}

/*
concatenate input files removing empty lines
*/
process concatenate {

    input:
        path 'input/*'
    
    output:
        path 'output/file'
    
    script:
    """
    mkdir -p output

    cat input/* | awk 'NF' > output/file
    """

}


/*
read an input file and emit its contents as a value
*/
process path2val {

    input:
        path "input/file.txt"

    output:
        env var

    script:
    """
    var=\$(cat input/file.txt)
    """

}