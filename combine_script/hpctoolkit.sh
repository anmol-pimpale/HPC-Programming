#!/bin/bash

# Load HPCToolkit module
source /home/apps/spack/share/spack/setup-env.sh
spack load hpctoolkit

# Define event list
events=("REALTIME" "CPUTIME" "perf::CACHE-MISSES" "MEMLEAK" "IO")

# Prompt user to select events
echo "Select events (space-separated):"
for i in "${!events[@]}"; do
  echo "$((i + 1))). ${events[$i]}"
done

read -r event_numbers

# Check if events are selected
if [ -z "$event_numbers" ]; then
  echo "No events selected"
  exit 1
fi

# Check if both REALTIME and CPUTIME are selected
if [[ "$event_numbers" == *1* && "$event_numbers" == *2* ]]; then
  echo "Cannot select both REALTIME and CPUTIME at the same time"
  exit 1
fi

# Prompt user for tracing option
echo "Do you want tracing in profiling (yes/no)?"
read tracing

# Create event string
event_string=""
for event_number in $event_numbers; do
  event_string+=" -e ${events[$event_number - 1]}"
done

# Prompt user for executable file name
echo "Enter executable file name:"
read exe_name

# Run HPCToolkit
if [[ $tracing == "yes" ]]; then
  ulimit -s unlimited
  hpcrun $event_string -t ./$exe_name
  hpcstruct ./hpctoolkit-$exe_name-measurements/
  hpcprof ./hpctoolkit-$exe_name-measurements/
  hpcviewer ./hpctoolkit-$exe_name-database/
else
  ulimit -s unlimited
  hpcrun $event_string ./$exe_name
  hpcstruct ./hpctoolkit-$exe_name-measurements/
  hpcprof ./hpctoolkit-$exe_name-measurements/
  hpcviewer ./hpctoolkit-$exe_name-database/
fi

# Show output
echo "Output:"
echo "======="
cat hpctoolkit-$exe_name-measurements/hpcprof.txt