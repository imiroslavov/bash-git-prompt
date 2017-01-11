#!/bin/bash

COLOR=16;

while [ $COLOR -lt 245 ]; do
	echo -e "$COLOR\t \\033[38;5;${COLOR}m\\033[48;5;${COLOR}m#########\\033[0m"

	((COLOR++))
done  

