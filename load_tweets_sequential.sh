#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
time (for file in $files; do
    echo
    sh load_denormalized.sh $file
done)


echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time (for file in $files; do
    echo
    python3 load_tweets.py --db "postgresql://postgres:pass@localhost:11240/postgres" --inputs "$file"
done)

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time (for file in $files; do
    python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:11241/ --inputs $file
done)

