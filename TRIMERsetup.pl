:#!/usr/bin/perl
#Argument are the three z-matrices and the output file name


$molecule1=$ARGV[0];
$molecule2=$ARGV[1];
$molecule3=$ARGV[2];
$outfile=$ARGV[3];

if($molecule1 eq "thymine.zmat" || $molecule1 eq "uracil.zmat" || $molecule1 eq "cytosine.zmat") { $seed1 = "C6";}
elsif($molecule1 eq "guanine.zmat" || $molecule1 eq "adenine.zmat") {$seed1 = "C4";}
else {print "Your first zmatrix is not recognized. \n";}
print "Seed for molecule 1 is $seed1. \n";

if($molecule2 eq "thymine.zmat" || $molecule2 eq "uracil.zmat" || $molecule2 eq "cytosine.zmat") { $seed2 = "C65";}
elsif($molecule2 eq "guanine.zmat" || $molecule2 eq "adenine.zmat") {$seed2 = "C45";}
else {print "Your second zmatrix is not recognized. \n";}
print "Seed for molecule 2 is $seed2. \n";

if($molecule3 eq "thymine.zmat" || $molecule3 eq "uracil.zmat" || $molecule3 eq "cytosine.zmat") { $seed3 = "C69";}
elsif($molecule3 eq "guanine.zmat" || $molecule3 eq "adenine.zmat") {$seed3 = "C49";}
else {print "Your third zmatrix is not recognized. \n";}
print "Seed for molecule 3 is $seed3. \n";

#Read in initial zmat
open(TXT, "<$molecule1");
@MOL1 = <TXT>;
close(TXT);
open(TXT, "<$molecule2");
@MOL2 = <TXT>;
close(TXT);
open(TXT, "<$molecule3");
@MOL3= <TXT>;
close(TXT);
open(OUT, ">$outfile");

$length1 = @MOL1;
$length2 = @MOL2;
$length3 = @MOL3;

print OUT "X1 \n";
print OUT "X53 X1 risem \n";
print OUT "X54 X53 slidem X1 -90. \n";
print OUT "X15 X54 shiftm X53 90. X1  90. \n";
print OUT "X93 X15 riseu X54 90. X53 90. \n";
print OUT "X94 X93 slideu X15 90. X54 -90. \n";
print OUT "X19 X94 shiftu X93 -90. X15 90. \n";
print OUT "$seed1  X1  r1  X53  90. X54  90. \n";
print OUT "X2  X1  1.  $seed1  90. X53  90. \n";


#Print the first part of the zmat
for($i=3; $i<$length1; $i++)
{
  if ( $MOL1[$i] =~ m/^\s*$/g )
      { last; }
  else
  {
   chomp($MOL1[$i]);
#DEBUG print "$i \n";
   print OUT "$MOL1[$i] \n";
   next;
  }
}

$blank1 = $i;
#DEBUG print "The length of 1 is $blank1  \n";

#changed variable names to denote middle


print OUT "X55 X15 1.0 X54 90. X53 90. \n";
print OUT "X56 X15 1.0 X54 -90. X53 180. \n";
print OUT "$seed2  X15  r51   X55  tiltm  X56  twistm \n";
print OUT "X25  X15  1.   $seed2  90.   X55  rollm \n";

#Start with 3 because first three lines handled by above
for($j=3; $j<$length2; $j++)
{
  if ($MOL2[$j] =~ m/^\s*$/g )
         { last; }

  else
  {
  @components = split(/\s+/,$MOL2[$j]);
  $components[0] = ($components[0] . 5);
  $components[1] = ($components[1] . 5);
  $components[2] =~ m/([a-z])(\d+)/ ;
  $components[2] = ($1 . 5 . $2);
  $components[3] = ($components[3] . 5);
  $components[4] =~ m/([a-z]*)(\d+\.*)/ ;
  if ($1 eq "") { $components[4] = $2; }
  else { $components[4] = ($1 . 5 . $2); }
  $components[5] = ($components[5] . 5);
  $components[6] =~ m/([a-z]*)(\d+\.*)/ ;
  if ($1 eq "") { $components[6] = $2; }
  else { $components[6] = ($1 . 5 . $2); }
  print OUT "@components \n";
  neXt;
  }
}
$blank2 = $j;

print OUT "X95 X19 1.0 X94 -90. X93 90. \n";
print OUT "X96 X19 1.0 X94 90. X93 180. \n";
print OUT "$seed3  X19  r91   X95  tiltu  X96  twistu \n";
print OUT "X29  X19  1.   $seed3  90.   X95  rollu \n";


#Start with 3 because first three lines handled by above
for($k=3; $k<$length3; $k++)
{
  if ($MOL3[$k] =~ m/^\s*$/g )
         { last; }

  else
  {
  @components2 = split(/\s+/,$MOL3[$k]);
  $components2[0] = ($components2[0] . 9);
   $components2[1] = ($components2[1] . 9);
  $components2[2] =~ m/([^0-9]*)(\d+)/ ;
  $components2[2] = ($1 . 9 . $2);
  $components2[3] = ($components2[3] . 9);
  $components2[4] =~ m/([^0-9]*)(\d+\.*)/ ;
  if ($1 eq "") { $components2[4] = $2; }
  else { $components2[4] = ($1 . 9 . $2); }
  $components2[5] = ($components2[5] . 9);
  $components2[6] =~ m/([^0-9]*)(\d+\.*)/ ;
  if ($1 eq "") { $components2[6] = $2; }
  else { $components2[6] = ($1 . 9 . $2); }
  print OUT "@components2 \n";
  next;
  }
}

$blank3 = $k;


%lookup = ();
#Now print all the variable values under the zmat
print OUT "\n";
for ($i = $blank1 + 1; $i<$length1; $i++)
{
 $MOL1[$i] =~ m/\s*([^0-9]\d+)(\s*\-*\d+\.\d*)/ ;
 print OUT "$1 = $2 \n";
 $lookup{$1} = $2;
}

for ($j = $blank2 + 1; $j<$length2; $j++)
{
 $MOL2[$j] =~ m/\s*([^0-9])(\d+)(\s*\-*\d+\.\d*)/ ;
 $cat = ( $1 . 5 . $2 );
 print OUT "$cat = $3 \n";
 $lookup{$cat} = $3;
}
for ($k = $blank3 + 1; $k<$length3; $k++)
{
 $MOL3[$k] =~ m/\s*([^0-9])(\d+)(\s*\-*\d+\.\d*)/ ;
 $cat = ( $1 . 9 . $2 );
 print OUT "$cat = $3 \n";
 $lookup{$cat} = $3;
}


print OUT "\n";
print OUT "risem = \n";
print OUT "slidem = \n";
print OUT "shiftm =\n";
print OUT "riseu =\n";
print OUT "slideu =\n";
print OUT "shiftu =\n";
print OUT "twistm =\n";
print OUT "rollm =\n";
print OUT "tiltm =\n";
print OUT "twistu =\n";
print OUT "rollu =\n";
print OUT "tiltu =\n";
print OUT "}\n";
print OUT "set basis sto-3g \n";
print OUT "energy ('DF-MP2')\n";



