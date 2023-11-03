# Project template

This repository contains a template to develop a reproducible, portable, and scalable workflow.

## README.md

The file you are reading. It should contain a brief description of the project, and any other relevant information, such as links to documentation or papers.

It may be useful to provide the following command, which is sufficient to run the full project's workflow from this repository:


```
nextflow run main.nf -c nextflow.config -resume -with-dag misc/flowchart.svg
```

## main.nf

The main [Nextflow script](https://www.nextflow.io/docs/latest/script.html), containing the workflow that will be executed when calling `nextflow run`.
Typically it will contain only [workflow](https://www.nextflow.io/docs/latest/workflow.html) definitions, while [process](https://www.nextflow.io/docs/latest/process.html) definitions may be organised in the [`modules/`](#modules/) directory and imported in the main Nextflow file to keep it more readable.

## nextflow.config

The Nextflow [configuration](https://www.nextflow.io/docs/latest/config.html) file.
It already contains a few parameters for a number of different scopes, you will typically need to modify `process.executor`, `process.queue`, `workDir`, and `env.out_dir` to adapt them to the infrastructure where the workflow will be executed.

## bin/

Custom scripts directory.
All executable scripts in `bin/` can be directly called in Nextflow processes as if they were in `$PATH`.

## env/

Here there should be found the [Singularity](https://docs.sylabs.io/guides/latest/user-guide/) image(s) and the corresponding [Dockerfile](https://docs.docker.com/engine/reference/builder/)(s).
The [`nextflow.config`](#nextflow.config) instructs Nextflow to automatically run processes in software containers spawned from the specified Singularity image.
In this way the software environment required by the workflow is portable and self-contained with this repository.

As a reminder, a Singularity image can be created starting from a Dockerfile by first building a Docker image. For example:

```
docker build -t project - < env/project.dockerfile
singularity build project.sif docker-daemon://project:latest
``` 

## misc/

Miscellanea directory. It may be used to collect documents, notes, slides, or anything that can be useful in the project development and needs to be preserved in the project repository.
It may also contain images that are displayed in this README file, like this:

<img src="misc/img.png" alt="drawing" width="128"/>

## modules/

Store here Nextflow scripts. Large workflows benefit from being split into multiple [modules](https://training.nextflow.io/basic_training/modules/) that contain libraries of process and/or workflow definitions, which can be imported into other Nextflow scripts, like [`main.nf`](#main.nf).

## src/

If you are developing software packages for the project they should live in `src/`. Executables may be symbolically linked in [bin/](#bin) so that they can be called by Nextflow processes.
