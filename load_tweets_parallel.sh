#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
echo "$files" | parallel sh load_denormalized.sh {}

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
echo "$files" | parallel python3 load_tweets.py --db=postgresql://postgres:pass@localhost:11240/postgres --inputs {}

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
echo "$files" | parallel python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:11241/postgres --inputs {}
