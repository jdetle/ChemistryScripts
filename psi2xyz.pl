#!/usr/bin/perl

#Argument is output file name; creates an xyz file of the same name

$output_file=$ARGV[0];
if ($output_file =~ m/(\w+)\.out/ )
  {$base_name = $1;} 
else
  {print "File type incorrect.  Please input a .out file \n";}
$xyz_file = ($base_name . ".xyz" );
open(XYZ, ">$xyz_file");

open OUT, "$output_file" or die "Can't open $output_file. \n";
@FILE = <OUT>;
close(OUT);
$length_file = @FILE;
for($i=0; $i<$length_file; $i++)
{
 if ($FILE[$i] =~ m/\s*Center\s*X\s*Y\s*Z\s*$/)
   {
    $opt_line = $i + 2;
    last;
   }
}

#for($i=$opt_line; $i<$length_file; $i++)
#{
#  if ($FILE[$i] =~ m/^\s*$/)
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
  {$last_line = $i; 
   last; }
  else
  { push (@coordinates, $FILE[$i]);}
}	

#print "$last_line \n";
$length_coordinates = @coordinates;
#print "$length_coordinates \n";

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

$count = 0;
for($i=0; $i<$length_coordinates; $i++)
{
   @elements = split(/\s+/, $coordinates[$i]);
    $junk0 = $elements[0];
    #$atom_num = $elements[1];
    $atom_name = $elements[1];
    #$junk3 = $elements[3];
   $x = $elements[2];
   $y = $elements[3];
   $z = $elements[4];
    push (@coor_print, "$atom_name $x $y $z");
    $count++;
    #   if ($atom_name>0)
    #{$count++;
    #push (@coor_print, "$symbols{$atom_name} $x $y $z");
    #}
}	

print XYZ "$count \n \n";
for($i=0; $i<$count; $i++)
{
 print XYZ "$coor_print[$i] \n";
}
