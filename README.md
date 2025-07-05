# hoardkit
Hoard Kit is a collection of shell scripts aimed to help data hoarders and data curators alike to manage their hoard. Please read the documentation for each tools (modules) before running them, and backup your data while your at it. These tools are mainly created for my own personal use, so feel free to modify and tailor them to your own unique needs.

## How To Use
1. Download this repository.
2. Go to the terminal and navigate into the main repository folder using the "cd" command.
3. Once inside the directory, add permission to the "hoardkit.sh" script by running "chmod +x hoardkit.sh" in the terminal.
4. Run the "hoardkit.sh" script by running "./hoardkit.sh" in the terminal. Available modules will be listed along with a short description of its functionality and how to run them.
5. Do whatever you want.

## Hoard Kit Modules
- find-dots.sh:
    A tool that recursively finds dot files (hidden files) and hidden folders within a directory and outputs a list of those files.
- index-html
    A tool that recursively creates an HTML index of a directory, including all its files and folders.
- rename-lut
    A tool that renames all files and folders in a single directory path only.
- show-rwx
    A tool that shows the number of files and folders with a certain permission type, useful for finding permission inconsistencies.

## Project Log:
- Started on July 4, 2025.
- 2025-07-04: Released first version of module (rename-lut).
- 2025-07-05: Released first version of module (find-dots), created a wrapper script (hoardkit.sh)