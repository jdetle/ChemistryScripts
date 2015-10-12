import glob, os

DNA_bases = ['A', 'G', 'T', 'C', 'U']
adna_trimers = []
bdna_trimers = []
not_made = []
adnaAppend = '_canon_adna.xyz'
bdnaAppend = '_canon_bdna.xyz'
os.chdir("/Users/johndetlefs/Documents/ZMAT/finalproject1");
print os.getcwd()
for i in range(len(DNA_bases)):
    for j in range(len(DNA_bases)):
        for k in range(len(DNA_bases)):
            tempAdna = DNA_bases[i]+DNA_bases[j]+DNA_bases[k]+adnaAppend
            tempBdna = DNA_bases[i]+DNA_bases[j]+DNA_bases[k]+bdnaAppend
            adna_trimers.append(tempAdna)
            bdna_trimers.append(tempBdna)

for i in range(len(adna_trimers)):
    if len(glob.glob(adna_trimers[i])) == 0:
        not_made.append(adna_trimers[i])
for i in range(len(bdna_trimers)):
    if len(glob.glob(bdna_trimers[i])) == 0:
        not_made.append(bdna_trimers[i])
print len(not_made)
