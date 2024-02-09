#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { example_process } from './modules/example_module'

include { publish } from './modules/utils'
include { split } from './modules/utils'
include { concatenate } from './modules/utils'

// ===== //

workflow EXAMPLE_WORKFLOW {

    main:
        out_ch = example_process()

    emit:
        out_ch

}

workflow PUBLISH_CONFIG {

    main:
        config_ch = Channel.fromPath("${projectDir}/nextflow.config")
        val_ch = Channel.of('workflow/nextflow.config')
        
        publish( val_ch.combine( config_ch ) )

}

workflow {

    EXAMPLE_WORKFLOW()

    PUBLISH_CONFIG()

}