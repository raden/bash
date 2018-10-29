#!/usr/bin/bash
rm /tmp/unifi-speedtest*.txt

printf "Saya akan buat ujian speedtest sebanyak $1 kali\n"

for i in `seq 1 $1`;do echo Ujian $i|tee -a /tmp/unifi-speedtest3.txt; speedtest|grep "Testing\|Download"|grep -v speed|sed -e "s/([^)]*)//" |tee -a /tmp/unifi-speedtest.txt; done

cat /tmp/unifi-speedtest.txt|awk {'print $2'}|grep -v from > /tmp/unifi-speedtest2.txt

step=$(wc -l /tmp/unifi-speedtest2.txt|awk {'print $1'})

sed -i 's/Ujian//g' /tmp/unifi-speedtest3.txt

#for i in `seq 1 $step`;do echo $i|tee -a /tmp/unifi-speedtest3.txt;done

paste /tmp/unifi-speedtest3.txt /tmp/unifi-speedtest2.txt > /tmp/unifi-speedtest4.txt

cat /tmp/unifi-speedtest4.txt

rm -f /tmp/unifi.plot

echo "set xlabel \"Ujian\" " >> /tmp/unifi.plot
echo "set ylabel \"Kelajuan\" " >> /tmp/unifi.plot
echo "set yrange [0:10]" >> /tmp/unifi.plot
echo "set xrange [0:$step]" >> /tmp/unifi.plot

echo "plot \"/tmp/unifi-speedtest4.txt\" with linespoint " >> /tmp/unifi.plot

gnuplot -p /tmp/unifi.plot
