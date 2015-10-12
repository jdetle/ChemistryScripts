#!/usr/bin/perl
use File::Copy;

#Arguments are the zmat file name input file
#outfilename shoould be as example AGA_CONFORMATION_BDNA.zmat
$zmatfile=$ARGV[0];
$charminputtemplate=$ARGV[1];
$zmatfilename = $zmatfile;

print "$zmatfile\n";

if ($zmatfilename =~ m/bdna/)
{
$pdb = 'bdna';
}
else
{
$pdb = 'adna';
}
#print "$zmatfilename\n";
if ($zmatfilename =~ m/(\w+)\.zmat/ )
{
$filename= $1;
$conformation = $2;
@components =split(/([A-Z])/, $zmatfilename);
$junk  = $components[0];
$base1 = $components[1];
$inyo  = $components[2];
$base2 = $components[3];
$trunk = $components[4];
$base3 = $components[5];

print "$base1\n";
print "$base2\n";
print "$base3\n";
$TRIMER = "$base1$base2$base3";
}
else
{
print "file format not recognized\n";
exit();
}
$charminput = ($filename . ".inp");
print "$charminput\n";
if( $base1 eq 'A' )
{$base1 = 'ADE';}
elsif( $base1 eq 'G' )
{$base1 = 'GUA';}
elsif( $base1 eq 'T' )
{$base1 = 'THY';}
elsif( $base1 eq 'C' )
{$base1 = 'CYT';}
else
{$base1 = 'URA';}
if( $base2 eq 'A' )
{$base2 = 'ADE';}
elsif( $base2 eq 'G' )
{$base2 = 'GUA';}
elsif( $base2 eq 'T' )
{$base2 = 'THY';}
elsif( $base2 eq 'C' )
{$base2 = 'CYT';}
else 
{$base2 = 'URA'}
if( $base3 eq 'A' )
{$base3 = 'ADE';}
elsif( $base3 eq 'G' )
{$base3 = 'GUA';}
elsif( $base3 eq 'T' )
{$base3 = 'THY';}
elsif( $base3 eq 'C' )
{$base3 = 'CYT';}
else 
{$base3 = 'URA';}

print "$base1\n";
print "$base2\n";
print "$base3\n";
print "$TRIMER\n";
print "$pdb\n";
print "$charminput\n";

$pdbtype = ("$TRIMER" . "_" . "$conformation" . "_" . "$pdb");
print "$pdbtype\n";




open(READ,"<$charminputtemplate");
@charminputarray = <READ>;
$length1 = @charminputarray;
open(WRITE,">$charminput");

for($i=0; $i<$length1; $i++)
{
    if($charminputarray[$i] =~ m/set base1/g)
    {
        $charminputarray[$i] = "set base1 $base1\n";
    }
    if($charminputarray[$i] =~ m/set base2/g)
    {
        $charminputarray[$i] = "set base2 $base2\n";
    }
    if($charminputarray[$i] =~ m/set base3/g)
    {
        $charminputarray[$i] = "set base3 $base3\n";
    }
    if($charminputarray[$i] =~ m/set trimer/g)
    {
        $charminputarray[$i] = "set trimer $TRIMER\n";
    }
    if($charminputarray[$i] =~ m/set file/g)
    {
        $charminputarray[$i] = "set file $filename\n";
    }

    #print "$charminputarray[$i]";
}

for($i=0; $i<$length1; $i++)
{
    print WRITE "$charminputarray[$i]";
}



