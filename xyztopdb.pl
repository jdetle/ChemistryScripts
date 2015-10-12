#!/usr/bin/perl

$outfile=$ARGV[0];
$patch1=$ARGV[1];
$patch2=$ARGV[2];
$patch3=$ARGV[3];

if( $outfile =~ m/(\w+)\.xyz/ )
{$outputname = $1;}
else
{
print "File not recognized \n";
exit();
}

$pdbfile = ($outputname . ".pdb" );

if($patch1 eq 'adenine.zmat' || $patch1 eq 'guanine.zmat')
{
     $true1 = 1;
     if($patch1 eq 'adenine.zmat')
     {
     $size1 = 10;
     }
     else
     {
     $size1 = 11;
     }
}
else
{
     $true1 = 0;
     if($patch1 eq 'thymine.zmat')
     {
     $size1 = 9;
     }
     else
     {
     $size1 = 8;
     }
}

if($patch2 eq 'adenine.zmat' || $patch2 eq 'guanine.zmat')
{
     $true2 = 1;
     if($patch2 eq 'adenine.zmat')
     {
     $size2 = 10;
     }
     else
     {
     $size2 = 11;
     }
}
else
{
     $true2 = 0;
     if($patch2 eq 'thymine.zmat')
     {
     $size2 = 9;
     }
     else
     {
     $size2 = 8;
     }
}




if($patch3 eq 'adenine.zmat' || $patch3 eq 'guanine.zmat')
{
     $true3 = 1;
     if($patch3 eq 'adenine.zmat')
     {
     $size3 = 10;
     }
     else
     {
     $size3 = 11;
     }
}
else
{
     $true3 = 0;
     if($patch3 eq 'thymine.zmat')
     {
     $size3 = 9;
     }
     else
     {
     $size3 = 8;
     }
}

if($patch1 =~ m/adenine/)
{
     $basename1 = ADE;
}
elsif($patch1 =~ m/thymine/)
{
     $basename1 = THY;
}
elsif($patch1 =~ m/cytosine/)
{
     $basename1 = CYT;
}
elsif($patch1 =~ m/guanine/)
{
     $basename1 = GUA;
}
else
{
     $basename1 = URA;
}
if($patch2 =~ m/adenine/)
{
     $basename2 = ADE;
}
elsif($patch2 =~ m/thymine/)
{
     $basename2 = THY;
}
elsif($patch2 =~ m/cytosine/)
{
     $basename2 = CYT;
}
elsif($patch2 =~ m/guanine/)
{
     $basename2 = GUA;
}
else
{
     $basename2 = URA;
}
if($patch3 =~ m/adenine/)
{
     $basename3 = ADE;
}
elsif($patch3 =~ m/thymine/)
{
     $basename3 = THY;
}
elsif($patch3 =~ m/cytosine/)
{
     $basename3 = CYT;
}
elsif($patch3 =~ m/guanine/)
{
     $basename3 = GUA;
}
else
{
     $basename3 = URA;
}

open(TXT, "<$outfile");
@xyz= <TXT>;
$lengthfile= @xyz;
close(TXT);
for($i=0; $i<$lengthfile; $i++)
{
   if($xyz[$i] =~ /\s*Center\s*$/)
   {
     $opt_line = $i+2;
     print "$opt_line\n";
      last;
   }
}

%ade = (
1 => N1,
2 => C2,
3 => N3,
4 => C4,
5 => C5,
6 => C6,
7 => N6,
8 => N7,
9 => C8,
10 => N9,
);

%gua = (
1 => N1,
2 => C2,
3 => N2,
4 => N3,
5 => C4,
6 => C5,
7 => C6,
8 => O6,
9 => N7,
10 => C8,
11 => N9,

);

%thy = (
1 => N1,
2 => C2,
3 => O2,
4 => N3,
5 => C4,
6 => O4,
7 => C5,
8 => C5M,
9 => C6,

#"N1"
#"C2"
#"O2"
#"N3"
#"C4"
#"O4"
#"C5"
#"C5M"
#"C6"

);



%cyt = (
1 => N1,
2 => C2,
3 => O2,
4 => N3,
5 => C4,
6 => N4,
7 => C5,
8 => C6,


);
$opt_line = 0;
for($i=$opt_line; $i<$lengthfile; $i++)
{
    if($xyz[$i] =~/^\s*$/)
    {
       $last_line = $i;
       last;
    }
    else
    {
       push(@coordinates, $xyz[$i]);
    }
}


$lengthxyz= @coordinates;

#for($i=0; $i<$lengthxyz; $i++)
#{
    #print "$coordinates[$i] \n";
#}
print "$lengthxyz";
open(PDB, ">$pdbfile");
$count=1;

print "$size1, $size2, $size3 \n";

for($j=0; $j<$lengthxyz; $j++)
{
    
    if($coordinates[$j] =~ m/H/)
    {
         if($count==$size1+$size2+$size3)
         {
             exit;
         }
         else
         {
           next;
         }
    }
    elsif($count <= $size1)
    {
        @elements = split(/\s+/, $coordinates[$j]);
         
        $atom = $elements[0];
        $x = $elements[1];
        $y = $elements[2];
        $z = $elements[3];
        $dimer = 1;
        if($true1)    
        { 
            	if($basename1 eq 'ADE')
            	{
             		printf PDB ("ATOM %6s %3s %4s %5s %11.3f %7.3f %7.3f %5.2f %5.2f %11s\n",$count,$ade{$count},$basename1, $dimer, $x,$y,$z,0.00, 0.00, $atom);
             		$count++;
            	}
            	else
            	{
               		printf PDB ("ATOM %6s %3s %4s %5s %11.3f %7.3f %7.3f %5.2f %5.2f %11s\n",$count,$gua{$count},$basename1, $dimer, $x,$y,$z,0.00, 0.00, $atom);
               		$count++;
            	}
        }
        else
        {
        	if($basename1 eq 'THY')
                {
               		printf PDB ("ATOM %6s %3s %4s %5s %11.3f %7.3f %7.3f %5.2f %5.2f %11s\n",$count,$thy{$count},$basename1, $dimer, $x,$y,$z,0.00, 0.00, $atom);
                        $count++;
             	}
		else
		{
			printf PDB ("ATOM %6s %3s %4s %5s %11.3f %7.3f %7.3f %5.2f %5.2f %11s\n",$count,$cyt{$count},$basename1, $dimer, $x,$y,$z,0.00, 0.00, $atom);
            		$count++;
		}
        }
        
     }
          
     elsif($count > $size1 && $count <= $size2+$size1)
     {
        @elements = split(/\s+/, $coordinates[$j]);
        
        $atom = $elements[0];
        $x = $elements[1];
        $y = $elements[2];
        $z = $elements[3];
         $dimer = 2;
        if($true2)
        {
                if($basename2 eq 'ADE')
                {
                        printf PDB ("ATOM %6s %3s %4s %5s %11.3f %7.3f %7.3f %5.2f %5.2f %11s\n",$count,$ade{$count-$size1},$basename2,$dimer, $x,$y,$z,0.00, 0.00, $atom);
                        $count++;
                }
                else
                {
                        printf PDB ("ATOM %6s %3s %4s %5s %11.3f %7.3f %7.3f %5.2f %5.2f %11s\n",$count,$gua{$count-$size1},$basename2,$dimer,$x,$y,$z,0.00, 0.00,$atom);
                        $count++;
                }
        }
        else
        {
                
                if($basename2 eq 'THY')
                {
                        printf PDB ("ATOM %6s %3s %4s %5s %11.3f %7.3f %7.3f %5.2f %5.2f %11s\n",$count,$thy{$count-$size1},$basename2,$dimer,$x,$y,$z,0.00, 0.00,$atom);
                        $count++;
                }
                else
                {
                        printf PDB ("ATOM %6s %3s %4s %5s %11.3f %7.3f %7.3f %5.2f %5.2f %11s\n",$count,$cyt{$count-$size1},$basename2,$dimer,$x,$y,$z,0.00, 0.00,$atom);
                        $count++;
                }
        }
     }
     else
     {
        @elements = split(/\s+/, $coordinates[$j]);
        $atom = $elements[0];
        $x = $elements[1];
        $y = $elements[2];
        $z = $elements[3];
         $dimer = 3;
        if($true3)
        {
                if($basename3 eq 'ADE')
                {
                        printf PDB ("ATOM %6s %3s %4s %5s %11.3f %7.3f %7.3f %5.2f %5.2f %11s\n",$count,$ade{$count-$size1-$size2},$basename3,$dimer,$x,$y,$z,0.00, 0.00,$atom);
                        $count++;
                }
                else
                {
                        printf PDB ("ATOM %6s %3s %4s %5s %11.3f %7.3f %7.3f %5.2f %5.2f %11s\n",$count,$gua{$count-$size1-$size2},$basename3,$dimer,$x,$y,$z,0.00, 0.00,$atom);
                        $count++;
                }
		}
		else
		{
			if($basename3 eq 'THY')
			{
				printf PDB ("ATOM %6s %3s %4s %5s %11.3f %7.3f %7.3f %5.2f %5.2f %11s\n",$count,$thy{$count-$size1-$size2},$basename3,$dimer,$x,$y,$z,0.00, 0.00, $atom);
				$count++;
			}
			else
			{
				printf PDB ("ATOM %6s %3s %4s %5s %11.3f %7.3f %7.3f %5.2f %5.2f %11s\n",$count,$cyt{$count-$size1-$size2},$basename3,$dimer,$x,$y,$z,0.00, 0.00,$atom);
                        $count++;
                }
        }   
     

$count=$count+1;
     }
printf PDB ("TER %7s %6s %4s\n", $count, $basename3, $dimer);
printf PDB ("END");


}

