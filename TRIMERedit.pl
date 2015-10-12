#!usr/bin/perl/

$trimerout=$ARGV[0];
$charmmfile=$ARGV[1];
$trimerwrite= $trimerout;
open(OUT, "<$trimerout");

open(CHA, "<$charmmfile");

@FILE = <CHA>;
$length_file = @FILE;

$count= 0;
print "$length_file\n";
for($i=0; $i<$length_file; $i++)
{
 if ($FILE[$i] =~ m/RISEM/)
   {
    print "RISEM/n";
    $risem = $i;
    push(@charmmvals, $FILE[$i]);
   }
     elsif ($FILE[$i] =~ m/SLIDEM/)
   {
     $slidem = $i;
         push(@charmmvals, $FILE[$i]);

   } elsif ($FILE[$i] =~ m/SHIFTM/)
   {
    $shiftm = $i;
          push(@charmmvals, $FILE[$i]);
   } elsif ($FILE[$i] =~ m/RISEU/)
   {
    $riseu = $i;
     push(@charmmvals, $FILE[$i]);
   } elsif ($FILE[$i] =~ m/SLIDEU/)
   {
    $slideu = $i;
     push(@charmmvals, $FILE[$i]);
   } elsif ($FILE[$i] =~ m/SHIFTU/)
   {
    $shiftu = $i;
     push(@charmmvals, $FILE[$i]);

   }
    elsif ($FILE[$i] =~ m/TWIST/ && $count < 1)
   {    $tiltm = $i;
    $count++;
     push(@charmmvals, $FILE[$i]);
   } elsif ($FILE[$i] =~ m/ROLL/ && $count < 2)
   {
    $twistm = $i;
    $count++;
     push(@charmmvals, $FILE[$i]);
   } elsif ($FILE[$i] =~ m/TILT/ && $count < 3)
   {
    $rollm = $i;
    $count++;
      push(@charmmvals, $FILE[$i]);
   } elsif ($FILE[$i] =~ m/TWIST/)
   {
    $tiltu = $i;
      push(@charmmvals, $FILE[$i]);
   } elsif ($FILE[$i] =~ m/ROLL/)
   {
    $twistu = $i;
     push(@charmmvals, $FILE[$i]);
   } elsif ($FILE[$i] =~ m/TILT/)
   {
     push(@charmmvals, $FILE[$i]);
    $rollu = $i;
   }
}

$lengthcharmm = @charmmvals;
print "$lengthcharmm \n";

for($i=0; $i<$lengthcharmm; $i++)
{
   @components = split(/\s+/,$charmmvals[$i]);
   $number = $components[4];
   if($i<6){
   @newnumber = split(/\D+/,$number);
   print "$newnumber[0] $newnumber[1] $newnumber[2] $newnumber[3] $newnumber[4]";
   $num = ($newnumber[1] . '.' . $newnumber[2] . "\n");
   }
   else {
   @newnumber = split(/\"/,$number);
   $num = ($newnumber[0] . $newnumber[1] . '.' . $newnumber[2] . "\n");
   } 
   
   push(@replacementvals, $num);
} 
$sizenew = @replacementvals;

for($i=0; $i<$sizenew; $i++)
   {
      print "$replacementvals[$i]";
   }
@FILE2 = <OUT>;
$sizezmat = @FILE2;
print "$sizezmat \n";

for($i=4; $i<$sizezmat; $i++)
{
   if($FILE2[$i] =~ m/risem/i )
   {
      $opt_line=$i;
      print "$opt_line \n";
      
   }
   else
   {
      next;
   }
}
$last_line=$opt_line+12;
for($i=$opt_line; $i<$last_line; $i++)
{
     chomp($FILE2[$i]); 
     $FILE2[$i] = ($FILE2[$i] . $replacementvals[$i-$opt_line] );
      print "$FILE2[$i]";
}
open(WRITE, ">$trimerwrite");
for($i=0; $i<$sizezmat; $i++)
{
   print WRITE "$FILE2[$i]";
}


