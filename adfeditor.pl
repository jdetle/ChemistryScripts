#!/usr/bin/perl

$outfile=$ARGV[0];

if( $outfile =~ m/(\w+)\.zmat/ )
{$outputname = $1;}
else
{
print "File not recognized \n";
exit();
}
open OUT, "$outfile" or die "Can't open $outfile. \n";
@FILE = <OUT>;
close(OUT);

$newzmatfile = ($outputname. "adf" . ".zmat" );
open(ZMAT, ">$newzmatfile");

$lengthfile = @FILE;

for($i=0; $i<$lengthfile; $i++)
{
    $coordinates[$i] = $FILE[$i];
    @entries = split(/\s+/ , $coordinates[$i]);
    $atoms[$i] = $entries[0];
    @splitatom = split(/\d/, $atoms[$i]);
    $atoms2[$i] = $splitatom[0];
    if($atoms2[$i] =~ m/X/g)
    {
        print "X! \n";
        $atoms2[$i] = 'Xx';
    }

}

for($i=0; $i<$lengthfile; $i++)
{
    @entries2 = split(/\s+/, $coordinates[$i]);
    for($j=0; $j<$lengthfile; $j++)
    {
       if($entries2[1] =~ m/$atoms[$j]/)
       { 
           print "Connect 1!\n";
           $connect1[$i] = $j;
       }
       if($entries2[3] =~ m/$atoms[$j]/)
       {
           print "Connect 2!\n";
           $connect2[$i] = $j;
       }
       if($entries2[5] =~ m/$atoms[$j]/)
       {
           print "Connect 3!\n";
           $connect3[$i] = $j;

       }
       print "$i -i  $j -j \n";
    }
}

for($i=0; $i<$lengthfile; $i++)
{
    $j = $i+1;
    @entries3 = split(/\s+/, $coordinates[$i]);
    $lengthentries = @entries3;
    $coords[$i] = "$j. $atoms2[$i] $connect1[$i] $connect2[$i] $connect3[$i] $entries3[2] $entries3[4] $entries3[6]\n";
    print ZMAT "$coords[$i]";
}

