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
    if ($FILE[$i] =~ m/^\s*CHARMM>\s*coor\s*print\s*$/)
    {
        if ($count == 2)
        {
            $opt_line = $i + 7;
            last;
        }
        $count = $count + 1;
    }
}

for($i=$opt_line; $i<$length_file; $i++)
{
    if($FILE[$i] =~ m/^\s*$/)
    {$last_line = $i;
        last; }
    else
    { push (@coordinates, $FILE[$i]);}
}

$length_coordinates = @coordinates;
print XYZ "$length_coordinates\n\n";
for($i=0; $i<$length_coordinates; $i++)
{
    @elements = split(/\s+/, $coordinates[$i]);
    $junk0 = $elements[0];
    $atom_num = $elements[1];
    $dimer_num = $elements[2];
    $base_type = $elements[3];
    $atom_label = $elements[4];
    $x_coor = $elements[5];
    $y_coor = $elements[6];
    $z_coor = $elements[7];
    $base_pair = $elements[8];
    $dimer_num2 = $elements[9];
    $mystery_num = $elements[10];
    $atom_label =~ m/(.)(\d+)/;
    $atom_symbol = $1;
    printf XYZ ("%s %s %s %s\n", $atom_symbol, $x_coor, $y_coor, $z_coor);
}

close XYZ;
