#!/bin/bash

# display help function
show_help() {
   echo "Traverses all the files in the specified (or current directory)."
   echo
   echo "Syntax: scriptTemplate [-dir|h|d|r]"
   echo "options:"
   echo "dir     Print the GPL license notification."
   echo "h       Print this Help."
   echo "d       Depth of recursion in directory."
   echo "r       Search recursively."
   echo
}

# variables to store args
allovedArgs=("dir" "h" "d" "r")

recursive=False

# check provided args and store into values
if [ $# -gt 4 ]; then
    echo "to many args: $@"
    exit 1
elif [ $# -le 4 ] && [ $# -gt 0 ]; then
    # Iterate through command-line arguments
    for arg in "$@"; do
    echo "Argument: $arg"

        # Check if arg is equal to "h"
        if [ "$arg" == "h" ]; then
            echo "Help argument detected!"
            show_help
            exit 0
        elif [ "$arg" == "r"]; then
            echo "Recursive argument detected!"
            recurssive = 

        fi
    done
else
    echo "no args given, using current dir $(pwd)"
    exit 1
fi
