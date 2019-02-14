#!/usr/bin/bash
LORONG=~/tmp

hari=$(date +"%d-%b-%Y")
kadar=$(echo 1*`lynx -dump -source http://www.maybank2u.com.my/mbb_info/m2u/M2UCurrencyConverter.do|grep USD|awk -F"|" {'print $6'}|uniq`|bc)
printf "$hari\t$kadar\n"|tee -a $LORONG/gaji-rate.txt

rm -f $LORONG/gaji.plot

#step=$(wc -l $LORONG/gaji-rate.txt|awk {'print $1'})

sed -i 's/Okt/Oct/g' $LORONG/gaji-rate.txt
sed -i 's/Dis/Dec/g' $LORONG/gaji-rate.txt

tarikh_mula=$(head -n 1 $LORONG/gaji-rate.txt|awk {'print $1'})
tarikh_akhir=$(tail -n 1 $LORONG/gaji-rate.txt|awk {'print $1'})

#echo "set xlabel \"Tarikh\" " >> $LORONG/gaji.plot
#echo "set ylabel \"Kadar\" " >> $LORONG/gaji.plot
#echo "set xrange [0:$step]" >> $LORONG/gaji.plot
#echo "set xrange ['"$tarikh_mula"':'"$tarikh_akhir"']" >> $LORONG/gaji.plot
#echo "set yrange [0:10]" >> $LORONG/gaji.plot

#echo "plot \"$LORONG/gaji-rate.txt\" with linespoint " >> $LORONG/gaji.plot


echo "set xdata time" >> $LORONG/gaji.plot
echo "#set datafile separator" >> $LORONG/gaji.plot
echo #set style data lines" >> $LORONG/gaji.plot
echo "set xlabel \"Tarikh\" " >> $LORONG/gaji.plot
echo "set ylabel \"Kadar\" "  >> $LORONG/gaji.plot
echo " set timefmt '%d-%b-%Y' " >> $LORONG/gaji.plot
echo "set format x '%d %b'" >> $LORONG/gaji.plot
echo "set xrange ["$tarikh_mula":"$tarikh_akhir"]" >> $LORONG/gaji.plot
sed -i 's/\[/\['\''/g'  $LORONG/gaji.plot
sed -i 's/\]/\'\''\]/g'  $LORONG/gaji.plot
#sed -i -E 's/\-*[0-9]\:[0-9]/"\1"'\''\:'\''"\1"/g'   $LORONG/gaji.plot
sed -i -E 's/\-2018\:/\-2018'\''\:'\''/g'   $LORONG/gaji.plot

echo "set yrange [4:4.25]" >> $LORONG/gaji.plot
echo "#set autoscale y" >> $LORONG/gaji.plot
echo "#plot "/tmp/gaji-rate.txt" with linesp" >> $LORONG/gaji.plot
echo "#plot '/tmp/gaji-rate.txt' using 1:v1 title 'Tarikh' with lines, '/tmp/gaji-rate.txt' using 1:2 title 'Kadar' with lines" >> $LORONG/gaji.plot
echo "plot '/home/najmi/tmp/gaji-rate.txt' using 1:2 with linespoint" >> $LORONG/gaji.plot

gnuplot -p $LORONG/gaji.plot
