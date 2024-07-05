#!/bin/bash

echo "welcom to profiling toolkit"
echo "-------------------------------------"
echo "1. Advisor Toolkit"
echo "2. VTune Toolkit"
echo "3. HPCToolkit"
echo "4. Gprof Toolkit"
echo "5. exit"

read -p "enter your choice: " choice

case $choice in
  1) echo "launching Advisor Toolkit..."
      ./advisor.sh
      ;;
  2) echo "launching VTune Toolkit..."
      ./vtune.sh
      ;;
  3) echo "launching HPCToolkit..."
      ./hpctoolkit.sh
      ;;
  4) echo "launching Gprof Toolkit..."
      ./gprof.sh
      ;;
  5) echo "exiting..."
      exit 0
      ;;
  *) echo "invalid choice better luck next time"
      ;;
esac