#!/bin/bash

echo "Getting User input"

read -e -p "Enter the Artist: " artist
read -e -p "Enter the Album: " album
read -e -p "Enter the genre: " genre
read -e -p "Enter the track: " track
read -e -p "Enter the title: " title

mkdir "$HOME/flac/$artist/$album" --parents

pacpl --rip $track --to flac --outdir "$HOME/flac/$artist/$album" --artist "$artist" --album "$album" --title "$title" --genre "$genre" --nscheme "%tr %ti" --nocddb

echo "Done the RIP thing"
