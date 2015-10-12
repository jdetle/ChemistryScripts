#!/usr/bin/perl



$files[0] = <adenine.zmat>;
$files[1] = <thymine.zmat>;
$files[2] = <guanine.zmat>;
$files[3] = <cytozine.zmat>;
$name[0] = 'A';
$name[1] = 'T';
$name[2] = 'G';
$name[3] = 'C';
for($i=0; $i<4; $i++)
{
   for($j=0; $j<4; $j++)
   {
       for($k=0; $k<4; $k++)
       {
         
        print "$i, $j, $k \n";  
        system("perl", "xyztopdb.pl", " $name[$i]$name[$j]$name[$k]_canon_adna.xyz", "$files[$i]", "$files[$j]", "$files[$k]");
        system("cp", "$name[$i]$name[$j]$name[$k]_canon_adna.pdb", "input_pdbs");
       }
    }
}

