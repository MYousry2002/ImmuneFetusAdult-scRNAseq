java -jar /home/me1117/ena-file-downloader.jar --accessions= /home/me1117/ImmuneFetusAdult-scRNAseq/dataset/fetus/spleen/accessions.tsv --format=READS_SUBMITTED --location= /home/me1117/ImmuneFetusAdult-scRNAseq/dataset/fetus/spleen --protocol=FTP --asperaLocation=null --email=mohamed_elsadec@dfci.harvard.edu

java -jar /home/me1117/ena-file-downloader.jar --accessions= /home/me1117/ImmuneFetusAdult-scRNAseq/dataset/fetus/thymus/accessions.tsv --format=READS_SUBMITTED --location= /home/me1117/ImmuneFetusAdult-scRNAseq/dataset/fetus/thymus --protocol=FTP --asperaLocation=null --email=mohamed_elsadec@dfci.harvard.edu


curl --location --fail https://service.azul.data.humancellatlas.org/manifest/files/ksQwlKVkY3AzOKRjdXJsxBAr0-qMD_ha_6sF520uu5BgxBCHtVkux8JdqJj8XDnSV8iFxCBXAXjYM7fJ0XAOVxgsjYDUqjdUHz44UdgPbvYYi7afLw | curl --continue-at - --retry 15 --retry-delay 10 --config -