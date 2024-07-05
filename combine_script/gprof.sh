#!/bin/bash


read -p "enter the file name: " my_application
read -p "enter the executable file name: " exe_filename


if [ ! -f "$my_application".c ]; then

  echo "File $my_application.c does not exist"
  
  exit 1
fi


gcc -pg -o "$exe_filename" "$my_application".c

./"$exe_filename"


gprof "$exe_filename" gmon.out > analysis.txt

echo "Profiling completer eport stored in analysis.txt"