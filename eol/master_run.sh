#!/bin/bash
pri=8
for ((i=$pri;i<11;i++))
do
	if [ $i -eq $pri ]
	then
		sed /XYZ/d "pdt" > pdt${i}.sh
	else
		sed s/XYZ/$NEXTID/g "pdt" > pdt${i}.sh
	fi

	chmod +x pdt${i}.sh
	sed -i s/PASO/$i/g pdt${i}.sh
	NEXTID=`sbatch pdt${i}.sh | awk '{ print $4 }'`
done
