#!/bin/bash

echo "Please select the service:"
read arg1

echo "Please select the version (1.1 or 1.1-Prod):"
read arg2

echo "Please select the environment (qa or prod):"
read arg3

./dump.sh $arg1 $arg2 $arg3

container_id=$(docker ps | grep $arg1:$arg2 | awk '{print $1}')
echo $container_id
cat dump.sh | docker exec -i $container_id bash

<<com
set the heap dump directory and file name
#dump_dir=/path/to/dump/folder
#dump_file_name=heap_dump_$(date +%Y%m%d%H%M%S).hprof
#thread_dump_name=thread_dump_$(date +%Y%m%d%H%M%S).txt

if ! command -v ps &> /dev/null
then
    echo "ps command not found. Installing..."
    yum install -y procps
    echo "ps command installed."
else
    echo "ps command already installed."
fi

# Get the PID of the Java process
pid=$(ps aux | grep java | grep -v ms-properties | head -n 1 | awk '{print $2}')

/bin/jmap -dump:file=$dump_file_name $pid

/bin/jstack $pid > $thread_dump_name

aws s3 cp dump_file_name s3://6063-snapshots-backups/$arg1-1.1-$arg3/

aws s3 cp thread_dump_name s3://6063-snapshots-backups/$arg1-1.1-$arg3/

com


