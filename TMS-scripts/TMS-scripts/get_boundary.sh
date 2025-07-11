#!/bin/bash

# shell commands to look at boudry lines - H -> T, T->TER for QC


# for f in "$@"; do
#   echo "$f"
#   grep -B 1 '^ATOM.* T ' "$f" | head -n 2
#   grep -B 1 'TER'
# done


for f in "$@"; do
  echo "== $f =="

  # 1. Last ATOM line from chain H
  # echo "[Last H line:]"
  grep -B 1 '^ATOM.* T ' "$f" | head -n 2

  # 2. First ATOM line from chain T
  # echo "[First T line:]"
  # grep '^ATOM.* T ' "$f" | head -n 1

  # 3. Line before TER (last atom before chain end)
  # echo "[Before TER:]"
  grep -C 1 '^TER' "$f" |  head -n 1
   
  echo  
done
