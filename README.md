# Project template

This repository is a template to develop a reproducible, portable, and scalable workflow. The **only** requirements to run it are [Nextflow](https://www.nextflow.io) and [Apptainer](https://apptainer.org). A project and the associated software environment are meant to be fully self-contained in the repository and to be deployed with minimal tweaks to [`nextflow.config`](#nextflowconfig), on any machine or cluster, by simply running:

```bash
nextflow run main.nf
```

The following is a list of brief descriptions of the files and directories to be found in this project template:

## README.md

The file you are reading. It should contain a brief description of the project, and any other relevant information, such as links to documentation or papers.

It may be useful to provide the following command, which is sufficient to run the full project's workflow from this repository, specifying the configuration file and a path for the optional worflow DAG diagram:


```bash
nextflow run main.nf -c nextflow.config -resume -with-dag misc/flowchart.svg
```

## main.nf

The main [Nextflow script](https://www.nextflow.io/docs/latest/script.html), containing the workflow that will be executed when calling `nextflow run`.

Typically it will contain only [workflow](https://www.nextflow.io/docs/latest/workflow.html) definitions, while [process](https://www.nextflow.io/docs/latest/process.html) definitions may be organised in the [`modules/`](#modules/) directory and imported in the main Nextflow file to keep it more readable.

It already contains `PUBLISH_CONFIG()`, which is used to save the [`nextflow.config`](#nextflowconfig) file among the output files whenever the workflow is ran. This is important to automatically keep track of potential tunable parameters specified in `nextflow.config` on which the workflow's results will depend.

## nextflow.config

The Nextflow [configuration](https://www.nextflow.io/docs/latest/config.html) file.
It already contains a few parameters for a number of different scopes, you will typically need to modify `process.executor`, `process.queue`, `workDir`, and `env.out_dir` to adapt them to the infrastructure where the workflow will be executed.

## bin/

Custom scripts directory.
All executable scripts in `bin/` can be directly called in Nextflow processes as if they were in `$PATH`.

## env/

Here are the [Singularity](https://docs.sylabs.io/guides/latest/user-guide/) image(s) and the corresponding [Dockerfile](https://docs.docker.com/engine/reference/builder/)(s).
The [`nextflow.config`](#nextflowconfig) instructs Nextflow to run processes in software containers spawned from the specified Singularity image.

Due to space reasons, it might be that only the Dockerfile(s) could be conveniently stored in remote repositories. This should be sufficient to grant reproducibility. As a reminder, a Singularity image can be created starting from a Dockerfile by first building a Docker image, _e.g._:

```bash
docker build -t project - < env/project.dockerfile
docker save -o env/project.tar.gz project
singularity build env/project.sif docker-archive://project:latest
```

## misc/

Miscellanea directory. It may be used to collect documents, notes, slides, or anything that can be useful in the project development and needs to be preserved in the project repository.
It may also contain images that are displayed in this README file, like this:

<img src="misc/img.png" alt="drawing" width="128"/>

## modules/

Store here Nextflow scripts. Large workflows benefit from being split into multiple [modules](https://training.nextflow.io/basic_training/modules/) that contain libraries of process and/or workflow definitions, which can be imported into other Nextflow scripts, like [`main.nf`](#main.nf).

A module `utils.nf` is provided with this repository and contains three useful, general purpose processes: `publish()`, `split()`, and `concatenate()`.

## src/

If you are developing software packages for your project they should live in `src/`. Executables may be symbolically linked in [bin/](#bin) so that they can be called within Nextflow processes.
