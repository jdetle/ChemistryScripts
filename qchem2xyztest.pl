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

$count = 0;
print "$length_file\n";
for($i=0; $i<$length_file; $i++)
{
    if ($FILE[$i] =~ m/Standard/g)
    {
        print "HIT\n";
        if ($count == 3)
        {
            $opt_line = $i + 2;
            last;
        }
        $count = $count + 1;
    }
}

for($i=$opt_line; $i<$length_file; $i++)
{
    if($FILE[$i] =~ m/Molecular/)
    {$last_line = $i-1;
        last; }
    else
    { push (@coordinates, $FILE[$i]);}
}
print "$last_line\n";
print "$opt_line\n";
$length_coordinates = @coordinates -2;
print "$length_coordinates\n";
print XYZ "$length_coordinates\n\n";
for($i=0; $i<$length_coordinates; $i++)
{
    @elements = split(/\s+/, $coordinates[$i]);
    $junk0 = $elements[0];
    $atom_num = $elements[2];
    $dimer_num = $elements[2];
    $base_type = $elements[3];
    $atom_label = $elements[4];
    $x_coor = $elements[3];
    $y_coor = $elements[4];
    $z_coor = $elements[5];
    $base_pair = $elements[8];
    $dimer_num2 = $elements[9];
    $mystery_num = $elements[10];
    $atom_label =~ m/(.)(\d+)/;
    $atom_symbol = $1;
    printf XYZ ("%s %s %s %s\n", $atom_num, $x_coor, $y_coor, $z_coor);
}

close XYZ;
