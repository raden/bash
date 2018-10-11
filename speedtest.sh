#for i in `seq 1`;do echo Test $i; speedtest|grep "Testing\|Download"|grep -v speed|sed -e "s/([^(]*)//"; done

for i in `seq 1 2`;do echo Test $i; speedtest|grep "Testing\|Download"|grep -v speed|sed -r 's/\([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\)//g'; done

