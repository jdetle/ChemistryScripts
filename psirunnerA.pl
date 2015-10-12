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
 
       
        
         
		
        	print "$i, $j, 0\n";  
        	system("psi4", "$name[$i]$name[$j]$name[$k]_canon_acharmGhostscsmp2.xyz", "$name[$i]$name[$j]$name[$k]_canon_acharmGhostscsmp2.out");
             }   
           }
    }


