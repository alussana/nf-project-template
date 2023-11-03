#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { example_process } from './modules/example_module'

// ===== //

workflow EXAMPLE_WORKFLOW {

    main:
        out_ch = example_process()

    emit:
        out_ch

}

workflow {

    EXAMPLE_WORKFLOW()

}