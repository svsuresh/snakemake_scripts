import os


sample_dict = {}
# print(os.listdir("raw_data"))
for i in (os.listdir("raw_data")):
    sample_dict[i] = ["raw_data" + os.sep + i + os.sep + j for j in os.listdir(os.path.join("raw_data", i))]

print(sample_dict)

samples = glob_wildcards("raw_data/{sample}/{id}.fastq").sample
# print(reps)
samples = sorted(set(samples))
# print(ids)
print(samples)

rule all:
    input:
        expand("merge/{sample}_merged.fastq", sample=samples)

rule first:
    input:
        lambda wildcards: sample_dict[wildcards.sample]
    output:
        "merge/{sample}_merged.fastq"
    shell:
        "cat {input} > {output}"
