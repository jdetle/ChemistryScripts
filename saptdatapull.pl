#!/usr/bin/perl

#Argument is output file name; creates an xyz file of the same name

$output_file=$ARGV[0];
if ($output_file =~ m/(\w+)\.out/ )
{$base_name = $1;}
else
{print "File type incorrect.  Please input a .out file \n";}
$xyz_file = ($base_name . "_pdb.xyz" );
open(XYZ, ">$xyz_file");

open OUT, "$output_file" or die "Can't open $output_file. \n";
@FILE = <OUT>;
close(OUT);
$length_file = @FILE;

$count = 2;
for($i=0; $i<$length_file; $i++)
{
    if ($FILE[$i] =~ m/^\s*Total\s*Energy\s*$/)
    {
     push (@coordinates, $FILE[$i]);
    }
}


$length_coordinates = @coordinates;
print XYZ "$length_coordinates\n\n";

for($i=0; $i<$length_coordinates; $i++)
{
    @elements = split(/\s+/, $coordinates[$i]);
    printf XYZ ("%s %s %s %s\n", $atom_symbol, $x_coor, $y_coor, $z_coor);
}

close XYZ;
