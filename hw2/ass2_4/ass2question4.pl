#!/usr/bin/perl -w
print "County name,Population density,Prencentage of water\n";
print "***************************************************\n";


my $filename = 'census.txt';
open(my $fh,'<:encoding(UTF-8)',$filename)
	or die "Could not open file 'filename' $!";

$count = 0; 
while (my $row = <$fh>){
	chomp $row;

	@cut = split (/	/,$row);
	$all[$count] = $cut[0]; 
	
	$all[$count + 1 ]= $cut[1]/$cut[3];
	
	
	$all[$count + 2 ]= $cut[2]/($cut[3]+$cut[2])*100;

	print "$all[$count],$all[$count + 1 ],$all[$count + 2 ]\n"; 
	
	$count = $count + 3;

}

$hd=1;# highest poplu.. density
$ld=1;# lowest ... den...
$hw=2;# highest percent.. of water
$lw=2;# lowest p.. ... ...

for($i=4;$i < $#all-2;$i=$i+3){

	if($all[$i] - $all[$hd] > 0){
	$hd=$i;
}
	elsif($all[$i] - $all[$ld] < 0){
	$ld=$i;
}

	if($all[$i+1] - $all[$hw] > 0){
	$hw=$i+1;
}
	elsif($all[$i+1] - $all[$lw] < 0){
	$lw=$i+1;
}

}

print "******************************************************************\n";
print "Highest population density: $all[$hd-1]  $all[$hd]\n";
print "Lowest population density: $all[$ld-1]  $all[$ld]\n";
print "Highest percentage of Water: $all[$hw-2]  $all[$hw]\n";
print "Lowest percentage of Water: $all[$lw-2]  $all[$lw]\n";
print "******************************************************************\n";

