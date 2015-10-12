#!/usr/bin/perl

$outfile=$ARGV[0];
$patch1=$ARGV[1];
$patch2=$ARGV[2];
$patch3=$ARGV[3];

if( $outfile =~ m/(\w+)\.zmat/ )
{$outputname = $1;}
else
{
print "File not recognized \n";
exit();
}

$newzmatfile = ($outputname. "qchem" . ".zmat" );
open(ZMAT, ">$newzmatfile");

if($patch1 eq 'adenine.zmat' || $patch1 eq 'guanine.zmat')
{
     $true1 = 1;
     if($patch1 eq 'adenine.zmat')
     {
     $size1 = 10;
     $table1 = ('$adevar[');
     $replace1 = ('$keyadevar{');
     }
     else
     {
     $size1 = 11;
     $table1= ('$guavar{');
     $replace1 = ('$keyguavar{');
     }
}
else
{
     $true1 = 0;
     if($patch1 eq 'thymine.zmat')
     {
     $size1 = 9;
     $table1 = ('$thyvar{');
     $replace1 = ('$keythyvar{');
     }
     else
     {
     $size1 = 8;
     $table1 = ('$cytvar{');
     $replace1 = ('$cytvar{');
     }
}

if($patch2 eq 'adenine.zmat' || $patch2 eq 'guanine.zmat')
{
     $true2 = 1;
     if($patch2 eq 'adenine.zmat')
     {
     $size2 = 10;
     $table2 = ('$adevar2{');
     $replace2 = ('$keyadevar2{');
     }
     else
     {
     $size2 = 11;
     $table2= ('$guavar2{');
     $replace2 = ('$keyguavar2{');
     }
}
else
{
     $true2 = 0;
     if($patch2 eq 'thymine.zmat')
     {
     $size2 = 9;
     $table2 = ('$thyvar2{');
     $replace2 = ('$keythyvar2{');
     }
     else
     {
     $size2 = 8;
     $table2 = ('$cytvar2{');
     $replace2 = ('$keycytvar2{');
     }
}



if($patch3 eq 'adenine.zmat' || $patch3 eq 'guanine.zmat')
{
     $true3 = 1;
     if($patch3 eq 'adenine.zmat')
     {
     $size3 = 10;
     $table3 = ('$adevar{');
     $replace3 = ('$keyadevar3{');
     }
     else
     {
     $size3 = 11;
     $table3= ('$guavar{');
     $replace3 = ('$keyguavar3{');
     }
}
else
{
     $true3 = 0;
     if($patch3 eq 'thymine.zmat')
     {
     $size3 = 9;
     $table3 = ('$thyvar{');
     $replace3 = ('$keythyvar3{');
     }
     else
     {
     $size3 = 8;
     $table3 = ('$cytvar{');
     $replace3 = ('$keycytvar3{');
     }
}


open(TXT, "<$outfile");
@zmat= <TXT>;
$length_file= @zmat;

%adevar = (
r1 => 1.364,
r3 => 1.369,
r4 => 1.35,
r5 => 1.35,
r6 => 1.35,
r8 => 1.09,
r9 => 1.4,
r10 => 1.01,
r11 => 1.01,
r12 => 1.4,
r13 => 1.4,
r14 => 1.4,
r15 => 1.09,
r16 => 1.01,
a3 => 60.0,
a4 => 60.0,
a5 => 60.0,
a6 => 60.0,
a8 => 120.0,
a9 => 127.37,
a10 => 118.92,
a11 => 120.72,
a12 => 108.0,
a13 => 108.0,
a14 => 108.0,
a15 => 120.0,
a16 => 120.0,
d4 => 180.0,
d5 => 180.0,
d6 => 180.0,
d8 => 180.0,
d9 => 180.0,
d12 => 180.0,
d13 => 180.0,
d14 => 180.0,
d15 => 180.0,
d16 => 180.0,
d10 => 180.0,
d11 => 0.0,
);


%guavar = (
r1 => 1.364,
r3 => 1.369,
r4 => 1.35,
r5 => 1.35,
r6 => 1.35,
r7 => 1.01,
r8 => 1.23,
r9 => 1.33,
r10 => 1.01,
r11 => 1.01,
r12 => 1.4,
r13 => 1.4,
r14 => 1.4,
r15 => 1.09,
r16 => 1.01,
a3 => 60.0,
a4 => 60.0,
a5 => 60.0,
a6 => 60.0,
a7 => 122.80,
a8 => 127.37,
a9 => 120.21,
a10 => 118.92,
a11 => 120.72,
a12 => 108.0,
a13 => 108.0,
a14 => 108.0,
a15 => 120.0,
a16 => 120.0,
d4 => 180.0,
d5 => 180.0,
d6 => 180.0,
d7 => 180.0,
d8 => 180.0,
d9 => 180.0,
d12 => 180.0,
d13 => 180.0,
d14 => 180.0,
d15 => 180.0,
d16 => 180.0,
d10 => 180.0,
d11 => 0.0,
);

%thyvar = (
r1=>1.3444,
r3=>1.4027,
r4=>1.4633,
r5=>1.4598,
r6=>1.3415,
r7=>1.013,
r8=>1.2239,
r9=>1.2274,
r10 => 1.2000,
r11 => 1.0853,
r12 => 1.017,
r13 => 1.0000,
a3 => 58.9,151,
a4 => 61.0565,
a5 => 59.0266,
a6 => 59.318,
a7 => 114.8936,
a8 => 124.3918,
a9 => 126.2615,
a10 => 121.6574,
a11=>115.4234,
a12=>115.3126,
a13=>109.5,
a14=>109.5,
a15=>109.5,
d4 => 180.,
d5 => 180.,
d6 => 180.,
d7 => 180.,
d8 => 180.,
d9 => 180.,
d10=>180.,
d11=>180.,
d12=>180.,
d13=>-30.,
d14=>210.,
	d15 => 90.,

);

%cytvar = (
r1 => 1.364,
r3 => 1.369,
r4 => 1.35,
r5 => 1.35,
r6 => 1.35,
r7 => 1.01,
r8 => 1.23,
r9 => 1.33,
r10 => 1.01,
r11 => 1.01,
r12 => 1.09,
r13 => 1.09,
a3 => 60.0,
a4 => 60.0,
a5 => 60.0,
a6 => 60.0,
a7 => 122.80,
a8 => 127.37,
a9 => 120.21,
a10 => 118.92,
a11 => 120.72,
a12 => 124.57,
a13 => 116.56,
d4 => 180.0,
d5 => 180.0,
d6 => 180.0,
d7 => 180.0,
d8 => 180.0,
d9 => 180.0,
d12 => 180.0,
d13 => 180.0,
d10 => 180.0,
d11 => 0.0,
);

%adevar2 = (
r51 => 1.364,
r53 => 1.369,
r54 => 1.35,
r55 => 1.35,
r56 => 1.35,
r58 => 1.09,
r59 => 1.4,
r510 => 1.01,
r511 => 1.01,
r512 => 1.4,
r513 => 1.4,
r514 => 1.4,
r515 => 1.09,
r516 => 1.01,
a53 => 60.0,
a54 => 60.0,
a55 => 60.0,
a56 => 60.0,
a58 => 120.0,
a59 => 127.37,
a510 => 118.92,
a511 => 120.72,
a512 => 108.0,
a513 => 108.0,
a514 => 108.0,
a515 => 120.0,
a516 => 120.0,
d54 => 180.0,
d55 => 180.0,
d56 => 180.0,
d58 => 180.0,
d59 => 180.0,
d512 => 180.0,
d513 => 180.0,
d514 => 180.0,
d515 => 180.0,
d516 => 180.0,
d510 => 180.0,
d511 => 0.0,
);


%guavar2 = (
r51 => 1.364,
r53 => 1.369,
r54 => 1.35,
r55 => 1.35,
r56 => 1.35,
r57 => 1.01,
r58 => 1.23,
r59 => 1.33,
r510 => 1.01,
r511 => 1.01,
r512 => 1.4,
r513 => 1.4,
r514 => 1.4,
r515 => 1.09,
r516 => 1.01,
a53 => 60.0,
a54 => 60.0,
a55 => 60.0,
a56 => 60.0,
a57 => 122.80,
a58 => 127.37,
a59 => 120.21,
a510 => 118.92,
a511 => 120.72,
a512 => 108.0,
a513 => 108.0,
a514 => 108.0,
a515 => 120.0,
a516 => 120.0,
d54 => 180.0,
d55 => 180.0,
d56 => 180.0,
d57 => 180.0,
d58 => 180.0,
d59 => 180.0,
d512 => 180.0,
d513 => 180.0,
d514 => 180.0,
d515 => 180.0,
d516 => 180.0,
d510 => 180.0,
d511 => 0.0,
);

%thyvar2 = (
r51=>1.3444,
r53=>1.4027,
r54=>1.4633,
r55=>1.4598,
r56=>1.3415,
r57=>1.013,
r58=>1.2239,
r59=>1.2274,
r510 => 1.2000,
r511 => 1.0853,
r512 => 1.017,
r513 => 1.0000,
a53 => 58.9,151,
a54 => 61.0565,
a55 => 59.0266,
a56 => 59.318,
a57 => 114.8936,
a58 => 124.3918,
a59 => 126.2615,
a510 => 121.6574,
a511=>115.4234,
a512=>115.3126,
a513=>109.5,
a514=>109.5,
a515=>109.5,
d54 => 180.,
d55 => 180.,
d56 => 180.,
d57 => 180.,
d58 => 180.,
d59 => 180.,
d510=>180.,
d511=>180.,
d512=>180.,
d513=>-30.,
d514=>210.,
        d515 => 90.,

);

%cytvar2 = (
r51 => 1.364,
r53 => 1.369,
r54 => 1.35,
r55 => 1.35,
r56 => 1.35,
r57 => 1.01,
r58 => 1.23,
r59 => 1.33,
r510 => 1.01,
r511 => 1.01,
r512 => 1.09,
r513 => 1.09,
a53 => 60.0,
a54 => 60.0,
a55 => 60.0,
a56 => 60.0,
a57 => 122.80,
a58 => 127.37,
a59 => 120.21,
a510 => 118.92,
a511 => 120.72,
a512 => 124.57,
a513 => 116.56,
d54 => 180.0,
d55 => 180.0,
d56 => 180.0,
d57 => 180.0,
d58 => 180.0,
d59 => 180.0,
d512 => 180.0,
d513 => 180.0,
d510 => 180.0,
d511 => 0.0,
);

%adevar3 = (
r91 => 1.364,
r93 => 1.369,
r94 => 1.35,
r95 => 1.35,
r96 => 1.35,
r98 => 1.09,
r99 => 1.4,
r910 => 1.01,
r911 => 1.01,
r912 => 1.4,
r913 => 1.4,
r914 => 1.4,
r915 => 1.09,
r916 => 1.01,
a93 => 60.0,
a94 => 60.0,
a95 => 60.0,
a96 => 60.0,
a98 => 120.0,
a99 => 127.37,
a910 => 118.92,
a911 => 120.72,
a912 => 108.0,
a913 => 108.0,
a914 => 108.0,
a915 => 120.0,
a916 => 120.0,
d94 => 180.0,
d95 => 180.0,
d96 => 180.0,
d98 => 180.0,
d99 => 180.0,
d912 => 180.0,
d913 => 180.0,
d914 => 180.0,
d915 => 180.0,
d916 => 180.0,
d910 => 180.0,
d911 => 0.0,
);


%guavar3 = (
r91 => 1.364,
r93 => 1.369,
r94 => 1.35,
r95 => 1.35,
r96 => 1.35,
r97 => 1.01,
r98 => 1.23,
r99 => 1.33,
r910 => 1.01,
r911 => 1.01,
r912 => 1.4,
r913 => 1.4,
r914 => 1.4,
r915 => 1.09,
r916 => 1.01,
a93 => 60.0,
a94 => 60.0,
a95 => 60.0,
a96 => 60.0,
a97 => 122.80,
a98 => 127.37,
a99 => 120.21,
a910 => 118.92,
a911 => 120.72,
a912 => 108.0,
a913 => 108.0,
a914 => 108.0,
a915 => 120.0,
a916 => 120.0,
d94 => 180.0,
d95 => 180.0,
d96 => 180.0,
d97 => 180.0,
d98 => 180.0,
d99 => 180.0,
d912 => 180.0,
d913 => 180.0,
d914 => 180.0,
d915 => 180.0,
d916 => 180.0,
d910 => 180.0,
d911 => 0.0,
);

%thyvar3 = (
r91=>1.3444,
r93=>1.4027,
r94=>1.4633,
r95=>1.4598,
r96=>1.3415,
r97=>1.013,
r98=>1.2239,
r99=>1.2274,
r910 => 1.2000,
r911 => 1.0853,
r912 => 1.017,
r913 => 1.0000,
a93 => 58.9,151,
a94 => 61.0565,
a95 => 59.0266,
a96 => 59.318,
a97 => 114.8936,
a98 => 124.3918,
a99 => 126.2615,
a910 => 121.6574,
a911=>115.4234,
a912=>115.3126,
a913=>109.5,
a914=>109.5,
a915=>109.5,
d94 => 180.,
d95 => 180.,
d96 => 180.,
d97 => 180.,
d98 => 180.,
d99 => 180.,
d910=>180.,
d911=>180.,
d912=>180.,
d913=>-30.,
d914=>210.,
        d915 => 90.,

);

%cytvar3 = (
r91 => 1.364,
r93 => 1.369,
r94 => 1.35,
r95 => 1.35,
r96 => 1.35,
r97 => 1.01,
r98 => 1.23,
r99 => 1.33,
r910 => 1.01,
r911 => 1.01,
r912 => 1.09,
r913 => 1.09,
a93 => 60.0,
a94 => 60.0,
a95 => 60.0,
a96 => 60.0,
a97 => 122.80,
a98 => 127.37,
a99 => 120.21,
a910 => 118.92,
a911 => 120.72,
a912 => 124.57,
a913 => 116.56,
d94 => 180.0,
d95 => 180.0,
d96 => 180.0,
d97 => 180.0,
d98 => 180.0,
d99 => 180.0,
d912 => 180.0,
d913 => 180.0,
d910 => 180.0,
d911 => 0.0,
);


@keyade = keys(%adevar);
@keygua = keys(%guavar);
@keythy = keys(%thyvar);
@keycyt = keys(%cytvar);
@keyade2 = keys(%adevar2);
@keygua2 = keys(%guavar2);
@keythy2 = keys(%thyvar2);
@keycyt2 = keys(%cytvar2);
@keyade3 = keys(%adevar3);
@keygua3 = keys(%guavar3);
@keythy3 = keys(%thyvar3);
@keycyt3 = keys(%cytvar3);





$sizeadevar = @keyade;
$sizeguavar = @keygua;
$sizethyvar = @keythy;
$sizecytvar = @keycyt;




for($i=0; $i<$length_file; $i++)
{
    push (@coordinates, $zmat[$i]);
}
print "$coordinates[1]\n";


if($patch1 =~ m/adenine/)
{
     $tablesize1 = $sizeadevar;
     $jlength1 = 15; 
     for($i=0; $i<$tablesize1; $i++)
{
    for($j=0; $j<8+$jlength1; $j++)
    {
        $coordinates[$j] =~ s/ $keyade[$i] / $adevar{$keyade[$i]} /g;  #ignorescase,notimportant
    }
}
}

elsif($patch1 =~ m/thymine/)
{
     $tablesize1 = $sizethyvar;
     $jlength1 = 16; 
       
for($i=0; $i<$tablesize1; $i++)
{

    for($j=0; $j<8+$jlength1; $j++)
    {
        $coordinates[$j] =~ s/ $keythy[$i] / $thyvar{$keythy[$i]} /g;  #ignorescase,notimportant
    }
}
}
elsif($patch1 =~ m/cytosine/)
{
     $tablesize1 = $sizecytvar;
     $jlength1 = 14;
for($i=0; $i<$tablesize1; $i++)
{
 
      for($j=0; $j<8+$jlength1; $j++)
    {
        $coordinates[$j] =~ s/ $keycyt[$i] / $cytvar{$keycyt[$i]} /g;  #ignorescase,notimportant
    }
}
}
elsif($patch1 =~ m/guanine/)
{
     $tablesize1 = $sizeguavar;
     $jlength1 = 17;
for($i=0; $i<$tablesize1; $i++)
{
 
      for($j=0; $j<8+$jlength1; $j++)
    {
        $coordinates[$j] =~ s/ $keygua[$i] / $guavar{$keygua[$i]} /g;  #ignorescase,notimportant
    }
}
}
else
{
     $tablesize1 = URA;
}
if($patch2 =~ m/adenine/)
{
     $tablesize2 = $sizeadevar;
     $jlength2 = 15;
     $stop2 = 12 + $jlength2 + $jlength1;
     for($i=0; $i<$tablesize2; $i++)

{
    for($j=6+$jlength1; $j<$stop2; $j++)
    {



         $coordinates[$j] =~ s/ $keyade2[$i] / $adevar2{$keyade2[$i]} /g;  #ignorescase,notimportant
    }
}

}
elsif($patch2 =~ m/thymine/)
{
     $tablesize2 = $sizethyvar;
     $jlength2 = 16;
     $stop2 = 12 + $jlength2 + $jlength1;
     for($i=0; $i<$tablesize2; $i++)

{
    for($j=6+$jlength1; $j<$stop2; $j++)
    {



         $coordinates[$j] =~ s/ $keythy2[$i] / $thyvar2{$keythy2[$i]} /g;  #ignorescase,notimportant
    }
}

}
elsif($patch2 =~ m/cytosine/)
{
     $tablesize2 = $sizecytvar;
     $jlength2 = 14;
     $stop2 = 12 + $jlength2 + $jlength1;
     for($i=0; $i<$tablesize2; $i++)

{
    for($j=6+$jlength1; $j<$stop2; $j++)
    {



         $coordinates[$j] =~ s/ $keycyt2[$i] / $cytvar2{$keycyt2[$i]} /g;  #ignorescase,notimportant
    }
}



}
elsif($patch2 =~ m/guanine/)
{
     $tablesize2 = $sizeguavar;
     $jlength2 = 17;
     $stop2 = 12 + $jlength2 + $jlength1;
     for($i=0; $i<$tablesize2; $i++)

{
    for($j=6+$jlength1; $j<$stop2; $j++)
    {



         $coordinates[$j] =~ s/ $keygua2[$i] / $guavar2{$guaade2[$i]} /g;  #ignorescase,notimportant
    }
}

 
}
else
{
     $tablesize2 = URA;
}
if($patch3 =~ m/adenine/)
{
     $tablesize3 = $sizeadevar;
     $jlength3 = 15;
     $stop3 = 14 + $jlength3 + $jlength2+ $jlength1;
     for($i=0; $i<$tablesize3; $i++)
{


    for($j=$stop2; $j<$stop3; $j++)
    {

         $coordinates[$j] =~ s/ $keyade2[$i] / $adevar2{$keyade2[$i]} /g;  #ignorescase,notimportant
    }
}


}
elsif($patch3 =~ m/thymine/)
{
     $tablesize3 = $sizethyvar;
     $jlength3 = 16;
     $stop3 = 14 + $jlength3 + $jlength2+ $jlength1;
     for($i=0; $i<$tablesize3; $i++)
{


    for($j=$stop2; $j<$stop3; $j++)
    {

         $coordinates[$j] =~ s/ $keythy3[$i] / $thyvar3{$keythy3[$i]} /g;  #ignorescase,notimportant
    }
}

}
elsif($patch3 =~ m/cytosine/)
{
     $tablesize3 = $sizecytvar;
     $jlength3 = 14;
     $stop3 = 14 + $jlength3 + $jlength2+ $jlength1;
     for($i=0; $i<$tablesize3; $i++)
{


    for($j=$stop2; $j<$stop3; $j++)
    {

         $coordinates[$j] =~ s/ $keycyt3[$i] / $cytvar3{$keycyt3[$i]} /g;  #ignorescase,notimportant
    }
}

}
elsif($patch3 =~ m/guanine/)
{
     $tablesize3 = $sizeguavar;
     $jength3 = 17;
     $stop3 = 14 + $jlength3 + $jlength2+ $jlength1;
    for($i=0; $i<$tablesize3; $i++)
{


    for($j=$stop2; $j<$stop3; $j++)
    {

         $coordinates[$j] =~ s/ $keygua3[$i] / $guavar3{$keygua3[$i]} /g;  #ignorescase,notimportant
    }
}


}
else
{
     $tablesize3 = URA;
}




#print "$adevar{1}";
#print "$length_file\n";
#print "($table1 .1.})";
$totalsize = 13+ $jlength1 + $jlength2 + $jlength3;

#print "$tablesize1\n";





#$stop2 = 12 + $jlength2 + $jlength1;
#$stop3 = 14 + $jlength3 + $jlength2+ $jlength1;
#print "$stop2\n";
#print "$stop3\n";
#print "$tablesize2\n";
#print "$tablesize3\n";





for($i=0; $i<=$totalsize; $i++)
{
	print ZMAT ("$coordinates[$i]");
}

close ZMAT;




