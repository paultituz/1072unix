#!/usr/bin/perl -w 
system "touch data.txt";
system "ls in | wc -l > data.txt";

open(data_file,"data.txt");
$file_count = <data_file>;
chomp $file_count;

system "touch report.txt";
system "rm report.txt";
system "touch report.txt";
open(RE,">> report.txt");

if ($file_count <= 1){
 if($file_count ==0){
  print "ERROE: NO file to compare\n";
  print RE "ERROE: NO file to compare\n";
 }
 elsif ($file_count == 1){
  print "ERROE: Only one file , NO need to compare\n";
  print RE "ERROE: Only one file , NO need to compare\n";
 }
}
else{
system "ls in > data.txt";
open(data_file,"data.txt");
$array = [[]];
$array->[0][0]= "Name/Word";
for ($i=1;$array->[0][$i] = <data_file>;$i++){
 chomp $array->[0][$i];
}
system "rm data.txt";

$word_count = 0;
for ($i=1;$i <= $file_count;$i++){
 open(text_file,"in/$array->[0][$i]");
 while($save = <text_file>){
  chomp $save;
  $save = lc ($save);
  @word = split(/[ .,?!]+/,$save);
  for($j=0;$j<=$#word;$j++){
   if($word[$j]eq''){
    $j++;
   }
   if($word_count==0){
    $array->[1][0]=$word[0];
    $array->[1][1]=1;
    for($p=2;$p<=$file_count;$p++){
     $array->[1][$p]=0;
    }
    $word_count++;
   }
   else{
    for($k=1;$k<=$word_count;$k++){
     if($array->[$k][0] eq $word[$j]){
      $array->[$k][$i]++;
      last;
     }
     elsif($k==$word_count){
      $array->[$word_count+1][0]=$word[$j];
      for($p=1;$p<=$file_count;$p++){
       if($p==$i){
        $array->[$word_count+1][$p]=1;
       }
       else{
        $array->[$word_count+1][$p]=0;
       }
      }
      $word_count++;
      last;
     }
    }
   }
  }
 }
}

for($i=1;$i<=$file_count;$i++){
  $abs[$i]=0;
}
for($i=1;$i<=$file_count;$i++){
 for($j=1;$j<=$word_count;$j++){
  $abs[$i]=$array->[$j][$i]*$array->[$j][$i]+$abs[$i];
 }
}
for($i=1;$i<=$file_count;$i++){
 $abs[$i]=sqrt($abs[$i]);
}

$result = [[]];
$result->[0][0]="NULL";
for($i=1;$i<=$file_count;$i++){
 $result->[0][$i]=$array->[0][$i];
 $result->[$i][0]=$result->[0][$i];
 $result->[$i][$i]="NULL";
}
for($i=1;$i<$file_count;$i++){
 for($j=$i+1;$j<=$file_count;$j++){
  $times=0;
  for($k=1;$k<=$word_count;$k++){
   $times=$times+$array->[$k][$i]*$array->[$k][$j];
  }
  $result->[$i][$j]=$times/$abs[$i]/$abs[$j];
  $result->[$j][$i]=$result->[$i][$j];
 }
}

for($i=1;$i<=$file_count;$i++){
 for($j=$i+1;$j<=$file_count;$j++){
   if($result->[$i][$j] eq 1){
    print "$result->[0][$i] and $result->[0][$j] are the same\n";
   }
   elsif($result->[$i][$j]gt"0.75"){
    $out = int($result->[$i][$j]*100);
    print "$result->[0][$i] and $result->[0][$j] are $out% same\n";
   }
   print RE "$result->[0][$i] $result->[0][$j] $result->[$i][$j]\n";
  }
}
}

