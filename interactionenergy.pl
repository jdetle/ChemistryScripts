#!/usr/bin/perl


$psi4output=$ARGV[0];


if( $psi4output =~ m/(\w+)\.out/ )
{$outputname = $1;}
else
{
print "File not recognized \n";
exit();
}

$interaction = ($outputname. "int" . ".out");
open(PSI4, "<$psi4output");
open(OUT, ">$interaction");


@values = <PSI4>;

$length_file = @values;
print "$length_file";
print "$values[1]";
$count = 0;

for($i=0; $i<$length_file; $i++)
{
    if ($values[$i] =~ m/SCS Total Energy/i)
    {
    print "hit\n";
    push(@coordinates, $values[$i]);
    $count = $count+1; 
    }
}

for($i=0; $i<$count; $i++)
{
    @elements = split(/\s+/, $coordinates[$i]);
    print "$elements[5]\n";
    if($i==0)
    {
        if($elements[5] < -1500 || $elements[5] > -1000)
        {
            print "There may be a problem with your structure for $psi4output, check and be careful! failed at $i \n";
            
            exit();
        }
        else
        {
            $ABCenergy = $elements[5];
        }
    } 
     if($i==1)
    {
        if($elements[5] < -1000 || $elements[5] > -700)
        {
            print "There may be a problem with your structure for $psi4output, check and be careful! failed at $i \n";
            exit();
        }
        else
        {
            $BCenergy = $elements[5];
        }
    } 
     if($i==2)
    {
        if($elements[5] < -1000 || $elements[5] > -700)
        {
            print "There may be a problem with your structure for $psi4output, check and be careful! failed at $i \n";
            exit();
        }
        else
        {
            $ACenergy = $elements[5];
        }
    } 
    if($i==3)
    {
        if($elements[5] < -1000 || $elements[5] > -700)
        {
            print "There may be a problem with your structure for $psi4output, check and be careful! failed at $i \n";
            exit();
        }
        else
        {
            $ABenergy = $elements[5];
        }
    } 
    if($i==4)
    {
        if($elements[5] < -500 || $elements[5] > -300)
        {
            print "There may be a problem with your structure for $psi4output, check and be careful! failed at $i \n";
            exit();
        }
        else
        {
            $Cenergy = $elements[5];
        }
    } 
    if($i==5)
    {
        if($elements[5] < -500 || $elements[5] > -300)
        {
            print "There may be a problem with your structure for $psi4output, check and be careful! failed at $i \n";
            exit();
        }
        else
        {
            $Aenergy = $elements[5];
        }
    } 
     if($i==6)
    {
        if($elements[5] < -500 || $elements[5] > -300)
        {
            print "There may be a problem with your structure for $psi4output, check and be careful! failed at $i \n";
            exit();
        }
        else
        {
            $Benergy = $elements[5];
        }
    } 
      
       
}
$twobodyab = ($ABenergy - $Aenergy - $Benergy); 
$twobodybc = ($BCenergy - $Benergy - $Cenergy);
$twobodyac = ($ACenergy - $Aenergy - $Cenergy);
$onethreeinteraction = ($ABCenergy - $twobodyab - $twobodybc - $twobodyac - $Aenergy - $Benergy - $Cenergy);


print "$onethreeinteraction \n";



    

