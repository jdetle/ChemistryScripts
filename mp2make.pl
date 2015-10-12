#!/usr/bin/perl

#Arguments are output file name, ; creates an xyz file of the same name

$output_file=$ARGV[0];
$molecule1 = $ARGV[1];
$molecule2=$ARGV[2];
$molecule3=$ARGV[3];

open(TXT, "<$molecule1");
@MOL1 = <TXT>;
close(TXT);
open(TXT, "<$molecule2");
@MOL2 = <TXT>;
close(TXT);
open(TXT, "<$molecule3");
@MOL3= <TXT>;
close(TXT);

$size1 = @MOL1;
$size2 = @MOL2;
$size3 = @MOL3;

if($molecule1 eq 'adenine.zmat' || $molecule1 eq 'guanine.zmat')
{
     $true1 = 1;
     if($molecule1 eq 'adenine.zmat')
     {
     $size1 = 15;
     }
     else
     {
     $size1 = 16;
     }
}
else
{
     $true1 = 0;
     if($molecule1 eq 'thymine.zmat')
     {
     $size1 = 15;
     }
     else
     {
     $size1 = 13;
     }
}

if($molecule2 eq 'adenine.zmat' || $molecule2 eq 'guanine.zmat')
{
     $true1 = 1;
     if($molecule2 eq 'adenine.zmat')
     {
     $size2 = 15;
     }
     else
     {
     $size2 = 16;
     }
}
else
{
     $true1 = 0;
     if($molecule2 eq 'thymine.zmat')
     {
     $size2 = 15;
     }
     else
     {
     $size2 = 13;
     }
}

if($molecule3 eq 'adenine.zmat' || $molecule3 eq 'guanine.zmat')
{
     $true1 = 1;
     if($molecule3 eq 'adenine.zmat')
     {
     $size3 = 15;
     }
     else
     {
     $size3 = 16;
     }
}
else
{
     $true1 = 0;
     if($molecule3 eq 'thymine.zmat')
     {
     $size3 = 15;
     }
     else
     {
     $size3 = 13;
     }
}




    
if ($output_file =~ m/(\w+)\.out/ )
  {$base_name = $1;} 
else
  {print "File type incorrect.  Please input a .out file \n";}
$xyz_file = ($base_name . Ghostscsmp2 . ".xyz" );

open(XYZ, ">$xyz_file");

open OUT, "$output_file" or die "Can't open $output_file. \n";
@FILE = <OUT>;
close(OUT);
$length_file = @FILE;
for($i=0; $i<$length_file; $i++)
{
 if ($FILE[$i] =~ m/\s*coor\s*rota\s*zdir\s*1.0\s*phi\s*90\s*$/)
   {
    $opt_line = $i + 8;
    print "$opt_line \n";
    last;
   }
}



#for($i=$opt_line; $i<$length_file; $i++)
#{
#  if ($FILE[$i] =~ m/\s*$/)
#   {
#    $z_line = $i ;
#    last;
#   }
#}
#print "Opt line $opt_line \n";
#print "Z line $z_line \n";
#$start_line = $z_line + 5;

for($i=$opt_line; $i<$length_file; $i++)
{
  if($FILE[$i] =~ m/^\s*$/)
  {$last_line = $i ; 
   last; }
  else
  { push (@coordinates, $FILE[$i]);}
}	

print "$last_line \n";
$length_coordinates = @coordinates-12;
print "$length_coordinates \n";

@coordinates1 = @coordinates;
@coordinates2 = @coordinates;
@coordinates3 = @coordinates;
@coordinates4 = @coordinates;

#Lookup table for atomic symbols
%symbols = (
1 => H,
2 => He,
3 => Li,
4 => Be,
5 => B,
6 => C,
7 => N,
8 => O,
9 => F,
10 => Ne,
11 => Na,
12 => Mg,
13 => Al,
14 => Si,
15 => P,
16 => S,
17 => Cl,
18 => Ar,
);
print "$size1, $size2, $size3 \n";
$count = 0;
for($k=1; $k<8; $k++)
{
@coor_print="";
if($k == 1)
{
print XYZ "#! Interaction energy calculations \n";

print XYZ "moleculeABC {  \n";
}
elsif($k == 2)
{
print XYZ "set globals {
basis aug-cc-pvdz

 mp2_os_scale 0 \n mp2_ss_scale 1.76
}
maxiter = 150
ABC_energy = energy('mp2') \n";
 
print XYZ "moleculeBC {  \n";
}
elsif($k == 3)
{
print XYZ "set globals{
basis aug-cc-pvdz

 mp2_os_scale 0 \n mp2_ss_scale 1.76
}

maxiter = 150
BC_energy = energy('mp2')\n";
print XYZ "moleculeAC { \n";
}

elsif($k == 4)
{ 
print XYZ "set globals {
basis aug-cc-pvdz
mp2_os_scale 0 \n mp2_ss_scale 1.76
}

AC_energy = energy('mp2')\n";

print XYZ "moleculeAB { \n";
}

elsif($k == 5)
{ 
print XYZ "set globals {
basis aug-cc-pvdz
mp2_os_scale 0 \n mp2_ss_scale 1.76
}

maxiter = 150
AB_energy = energy('mp2')\n";
print XYZ "moleculeC { \n";
}

elsif($k == 6)
{ 
print XYZ "set globals{
basis aug-cc-pvdz
mp2_os_scale 0 \n mp2_ss_scale 1.76
}

maxiter =150
C_energy = energy('mp2')\n";

print XYZ "moleculeA { \n";
}

else
{ 
print XYZ "set globals {
basis aug-cc-pvdz
 mp2_os_scale 0 \n mp2_ss_scale 1.76
}

maxiter = 150
A_energy = energy ('mp2')\n";

print XYZ "moleculeB { \n";

}
for($i=0; $i<=$length_coordinates; $i++)
{
   	@elements = split(/\s+/, $coordinates[$i]);
    	$junk0 = $elements[0];
    	#$atom_num = $elements[1];
    	
    	$junk2 = $elements[1];
        $junk3 = $elements[2];
   	$junk4 = $elements[3];
        $atom_name = $elements[4];
        $x = $elements[5];
   	$y = $elements[6];
   	$z = $elements[7];
        $atom_name =~  s/\d+$//;
        print "$atom_name \n";
        if($atom_name eq 'C5M')
        {
              print "TRUE \n \n \n";
               $atom_name = 'C';
        }
        #print "$k\n";
   	#print "$i\n";
   	if($k==1)
   	{ 
       	#print "IF";
                
        	push(@coor_print, "$atom_name $x $y $z");
      

   	}
   	elsif($k == 2)
   	{ 
                
                if($i<$size1)
      		{
          		#print "IFLENGTH";
           		push(@coor_print, "Gh($atom_name) $x $y $z");
          	}
      		else
      		{
          		push(@coor_print, "$atom_name $x $y $z");
        	}
     	}
     	elsif($k == 3)
     	{
                if($i>=$size1 && $i<$size1+$size2)
        	{
             		push(@coor_print, "Gh($atom_name) $x $y $z");
        	}
        	else
        	{
         		push(@coor_print, "$atom_name $x $y $z");
        	}  
     	}
     	elsif($k == 4)
     	{
                if($i>=$size1+$size2)
        	{
             		push(@coor_print, "Gh($atom_name) $x $y $z");
        	}
        	else
        	{
         		push(@coor_print, "$atom_name $x $y $z");
        	}
     	}
	elsif($k == 5)
     	{
                if($i<$size1+$size2)
        	{
             		push(@coor_print, "Gh($atom_name) $x $y $z");
        	}
        	else
        	{
         		push(@coor_print, "$atom_name $x $y $z");
        	}
     	}
	elsif($k == 6)
     	{
    		if($i>=$size1)
        	{
             		push(@coor_print, "Gh($atom_name) $x $y $z");
        	}
        	else
        	{
         		push(@coor_print, "$atom_name $x $y $z");
        	}
     	}
	else
     	{
        	#print "ELSE";
	        if($i<$size1 || $i>=$size1+$size2)
       		{
             	push(@coor_print, "Gh($atom_name) $x $y $z");
        	}
        	else
        	{
         	push(@coor_print, "$atom_name $x $y $z");
        	}
        }	
   
{
 print XYZ "$coor_print[$i] \n";
}
$count = 0;

}
print XYZ "\n";
print XYZ "} \n";
}

print XYZ "set globals {
basis aug-cc-pvdz
mp2_os_scale 0 \n mp2_ss_scale 1.76
}

maxiter=150
B_energy = energy('mp2')\n";

print XYZ "InteractionEnergy = ABC_energy - A_energy - B_energy - C_energy - AB_energy - AC_energy - BC_energy \n";
