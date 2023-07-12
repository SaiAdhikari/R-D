#! /bin/bash

heap_dump=heap_dump_$(date +%Y%m%d%H%M%S).hprof
thread_dump=thread_dump_$(date +%Y%m%d%H%M%S).txt

if ! command -v ps &> /dev/null
then
    echo "ps command not found. Installing..."
    yum install -y procps
    echo "ps command installed."
else
    echo "ps command already installed."
fi

# Get the PID of the Java process
pid=$(ps -aux | grep java | grep -v ms-properties | head -n 1 | awk '{print $2}')

/bin/jmap -dump:file=$heap_dump $pid

/bin/jstack $pid > $thread_dump



aws s3 cp $heap_dump s3://6063-snapshots-backups/$arg1-1.1-$arg3/

aws s3 cp $thread_dump s3://6063-snapshots-backups/$arg1-1.1-$arg3/

