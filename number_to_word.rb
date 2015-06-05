raise ArgumentError, 'Only one argument allowed'  if ARGV.length > 1
num = ARGV.first.to_s.reverse.scan(/.{1,3}/)

words_hash = {0=>"zero",1=>"one",2=>"two",3=>"three",4=>"four",5=>"five",6=>"six",7=>"seven",8=>"eight",9=>"nine",
                    10=>"ten",11=>"eleven",12=>"twelve",13=>"thirteen",14=>"fourteen",15=>"fifteen",16=>"sixteen",
                     17=>"seventeen", 18=>"eighteen",19=>"nineteen",
                    20=>"twenty",30=>"thirty",40=>"forty",50=>"fifty",60=>"sixty",70=>"seventy",80=>"eighty",90=>"ninety"}

scale = {3=>"hundred",4 =>"thousand",6=>"million",9=>"billion"}

return words_hash[num] if words_hash.includes?(num)

nums  = n.to_s.reverse.scan(/.{1,3}/).map(&:reverse)




