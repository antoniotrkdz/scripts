#!/bin/bash

#The list of all available packages in the repos you have in
#/etc/apt/sources.list can be found in /var/lib/apt/lists.

if getopts 'v' flag; then
	#If the version numbers are also wanted:
	grep -E "^(Package: |Version: )" /var/lib/apt/lists/*_Packages | cut -d " " -f 2  | sed 'N;s/\n/ /'
else 
	#To visualise the list (without version numbers):
	grep "^Package: " /var/lib/apt/lists/*_Packages | cut -d " " -f 2  | sort
fi



