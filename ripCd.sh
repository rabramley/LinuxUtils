#!/bin/bash

echo "Getting User input"

read -e -p "Enter the Artist: " artist
read -e -p "Enter the Album: " album
read -e -p "Enter the genre: " genre

mkdir "$HOME/flac/$artist/$album" --parents

pacpl --rip all --to flac --outdir "$HOME/flac/$artist/$album" --artist "$artist" --album "$album" --genre "$genre" --nscheme "%tr %ti"

echo "Done the RIP thing"
