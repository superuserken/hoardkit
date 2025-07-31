# Hoard Kit (hoardkit)
Hoard Kit is a collection of Shell scripts made to help data hoarders and data curators alike to manage their digital data hoard. Please read the documentation for each tools (modules) before running them, and backup your data while your at it. These tools are mainly created for my own personal use, so feel free to modify and tailor them to your own unique needs.

## How To Use
1. Download this repository.
2. Go to the terminal and navigate into the main repository folder using the "cd" command.
3. Once inside the repository directory, add a permission to the "hoardkit.sh" script by running "chmod +x hoardkit.sh" in the terminal.
4. Run the "hoardkit.sh" script by running "./hoardkit.sh" in the terminal. Available modules will be listed along with a short description of its functionality and how to run them (the basic syntax is ./hoardkit.sh module /path/to/rename).
5. Do whatever you want.

## Warnings
- Any script involving file deletion will permanently delete files, it will not go to the Trash folder, and some may not have a confirmation prompt before deletion, SO PLEASE USE THEM AT YOUR OWN RISK. Tools with deletion functionalities will have an exclamation point (!) in the list below.
- Please navigate to the [/(repository-directory)/output] folder for any output files created by any tools in this kit, unless specified (some scripts may only output there). Output files are in text (.txt) format with the (YYYYMMDDHHMMSS_module-name.txt) as the default format.
- When specifying any directory for any tools in this kit, it is best to start from the root directory in Linux systems, I haven't tested how any tools will work in non-Linux systems (/home/user/path). PLEASE TEST THEM FIRST TO SEE THE BEHAVIOUR OF CERTAIN TOOLS.

## Modules
### batch-rename
A tool that renames all files and folders in a single directory path only to either lowercase, UPPERCASE, or Titlecase.
### find-hidden
A tool that recursively finds dot files (hidden files) and hidden folders within a directory and outputs a list of those files.
### index-dir
A tool that recursively creates an HTML index of a directory, including all files and folders contained within the specified directory.
### delete-path!
A tool that deletes all files and folders listed in a text (.txt) file.
### show-perms
A tool that recursively scans a directory and shows the number of files and folders with a certain permission type, useful for finding permission inconsistencies.
### populate-dir
A tool that populates all empty folders within a directory with a text file (PLACEHOLDER.txt).
### find-ext
A tool that finds all files with a given extention, or files without one. It uses the whole filename.extention to detect certain types (.jpg and .JPG is the same, but .jpg and .jpeg is not) or the lack of one. A list will be outputed containing the number, and the file paths.
### change-perms
A tool that recursively sets permissions on files and folders to user-specified defaults (e.g., 644 for files, 755 for directories).