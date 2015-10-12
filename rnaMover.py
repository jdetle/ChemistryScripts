import os, glob, re

RNA_bases = ['A', 'G', 'C', 'U', 'T']
adna_trimers = []
bdna_trimers = []
arnaPaths = []
brnaPaths = []
made = []
adnaAppend = '_canon_adna.xyz'
bdnaAppend = '_canon_bdna.xyz'
arnaAppend = '_canon_arna.xyz'
brnaAppend = '_canon_brna.xyz'
os.chdir("/Users/johndetlefs/Documents/ZMAT/finalproject1");
cpArna = []
rmArna = []
cpBrna = []
rmBrna = []
counter = 0
for i in range(len(RNA_bases)):
    for j in range(len(RNA_bases)):
        for k in range(len(RNA_bases)):
            tempAdna = RNA_bases[i]+RNA_bases[j]+RNA_bases[k]+adnaAppend
            tempBdna = RNA_bases[i]+RNA_bases[j]+RNA_bases[k]+bdnaAppend
            tempArna = RNA_bases[i]+RNA_bases[j]+RNA_bases[k]+arnaAppend
            tempBrna = RNA_bases[i]+RNA_bases[j]+RNA_bases[k]+brnaAppend
            adna_trimers.append(tempAdna)
            bdna_trimers.append(tempBdna)
            arnaPaths.append(tempArna)
            brnaPaths.append(tempBrna)
            cpArna.append('cp' + ' ' + adna_trimers[counter] + ' ' +'RNAcalcs/'+arnaPaths[counter])
            rmArna.append('rm' + ' ' + adna_trimers[counter])
            cpBrna.append('cp' + ' ' + bdna_trimers[counter] + ' ' +'RNAcalcs/'+brnaPaths[counter])
            rmBrna.append('rm' + ' ' + bdna_trimers[counter])
            counter += 1;

print len(cpArna), len(rmArna)
counter = 0

for i in range(len(RNA_bases)):
    for j in range(len(RNA_bases)):
        for k in range(len(RNA_bases)):
            if RNA_bases[i] == 'U':
                if RNA_bases[j] == 'T' or RNA_bases[k] == 'T':
                    os.system(rmArna[counter])
                    os.system(rmBrna[counter])
                else:
                    print cpBrna[counter]
                    os.system(cpArna[counter])
                    os.system(cpBrna[counter])
            counter += 1;
