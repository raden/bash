#for i in `seq 1`;do echo Test $i; speedtest|grep "Testing\|Download"|grep -v speed|sed -e "s/([^(]*)//"; done
printf "Saya akan buat ujian speedtest sebanyak $1 kali\n"
#for i in `seq 1 $1`;do echo Ujian $i; speedtest|grep "Testing\|Download"|grep -v speed|sed -r 's/\([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\)//g'; done
for i in `seq 1 $1`;do echo Ujian $i; speedtest|grep "Testing\|Download"|grep -v speed|sed -e "s/([^)]*)//"; done

