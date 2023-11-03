#!/bin/bash

# Function to list files recursively with depth limit and check for executables and soft links
list_files_recursive() {
  local folder="$1"
  local depth="$2" # Setting a default recursion depth

  # Print the current dir path
  echo "Listing files in: $folder"

  # List files in the current dir
  for file in "$folder"/*; do
    # Should separate files from folders as folders have -x attribute and treted as executable 
    if [ -f "$file" ]; then
      if [ -L "$file" ]; then
        echo "File $file is a soft link"
      elif [ -x "$file" ]; then
        echo "File $file is executable"
      fi
    fi
  done

  # Check if the depth limit has been reached
  if [ "$depth" -eq 0 ]; then
    return
  fi

  # Recursively list files in subdirectories
  local subfolders
  subfolders=$(find "$folder" -mindepth 1 -maxdepth 1 -type d)

  for subfolder in $subfolders; do
    list_files_recursive "$subfolder" $((depth - 1))
  done
}

# Function to display help
show_help() {
   echo "Traverses all the files in the specified (or current directory)."
   echo
   echo "Syntax: scriptTemplate [-dir|h|d|r]"
   echo "options:"
   echo "dir     Takes a path to the directory."
   echo "h       Print this Help."
   echo "d       Depth of recursion in directory. Default is 2"
   echo "r       Search recursively."
}

# Initialize variables
recursive=false  # By default parses only provided dir
depth=2  # Setting a default recursion depth

# Parse command-line arguments, exit if to many arg provided
if [ $# -gt 4 ]; then
  echo "To many arguments provided"
  exit 1
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    -r)
      recursive=true
      shift
      ;;
    -d)
      shift
      depth="$1"
      shift
      ;;
    -h)
      show_help
      exit 0
      ;;
    *)
      folder="$1"
      shift
      ;;
  esac
done

# If folder is not provided, use the current directory
if [ -z "$folder" ]; then
  folder="$(pwd)"
fi

# Check if the recursive flag is set and use ls accordingly
if [ "$recursive" = true ]; then
  list_files_recursive "$folder" "$depth"
else
  for file in "$folder"/*; do
    # Should separate files from folders as folders have -x attribute and treted as executable 
    if [ -f "$file" ]; then
      if [ -L "$file" ]; then
        echo "File $file is a soft link"
      elif [ -x "$file" ]; then
        echo "File $file is executable"
      fi
    fi
  done
fi
