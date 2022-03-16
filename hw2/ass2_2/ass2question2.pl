#!/usr/bin/perl -w

print "Input:\n";
chomp ( $num = <STDIN> );
@num = split( //, $num );
@back = reverse( @num );

$size = @num;

for( $i = 0; $i < $size; $i++ ){
	if( $num[$i] ne $back[$i] ){
		$a = "";
		last;
		#print"not a palidrome\n";
	}
	else{
		$a = "true";
		#print"palidrome\n";
	}
		
} 

if( $a ){
	print "palindrome\n";
}
else{
	print "Not palindrome\n";
}



