python3 -c "`printf '%s\n' 'import sys,csv' 'for row in csv.reader(sys.stdin):' ' print("\t".join(row))'`"
