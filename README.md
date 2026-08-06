# Bash-Text-Management-Utility
Assignment: Bash Text Management Utility

Usage
-----

usage() {
cat <<EOF
Usage:

Add line at top
./otTextEditor addLineTop <file> <line>

Add line at bottom
./otTextEditor addLineBottom <file> <line>

Add line at specific position
./otTextEditor addLineAt <file> <line number> <line>

Replace first occurrence of a word
./otTextEditor updateFirstWord <file> <old word> <new word>

Replace all occurrences
./otTextEditor updateAllWords <file> <old word> <new word>

Delete first occurrence of a word
./otTextEditor deleteWord <file> <word>

Insert a word
./otTextEditor insertWord <file> <existing word> <new word>

Delete a line
./otTextEditor deleteLine <file> <line number>

Delete line containing a word
./otTextEditor deleteLineContaining <file> <word>

Show file
./otTextEditor show <file>

Count lines
./otTextEditor countLines <file>

Count words
./otTextEditor countWords <file>

Show line numbers
./otTextEditor lineNumbers <file>
EOF

exit 1
}
| Statement                                 | Explanation                                                                                                 |
| ----------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `usage() {`                               | Defines a function named **usage** that displays the help menu.                                             |
| `cat <<EOF`                               | Starts a **Here Document (Heredoc)**. Everything between `<<EOF` and `EOF` is displayed exactly as written. |
| `Usage:`                                  | Displays the title of the help menu.                                                                        |
| `./otTextEditor addLineTop ...`           | Displays the syntax for adding a line at the beginning of a file.                                           |
| `./otTextEditor addLineBottom ...`        | Displays the syntax for appending a line to the end of a file.                                              |
| `./otTextEditor addLineAt ...`            | Displays the syntax for inserting a line at a specified line number.                                        |
| `./otTextEditor updateFirstWord ...`      | Displays the syntax for replacing only the first occurrence of a word.                                      |
| `./otTextEditor updateAllWords ...`       | Displays the syntax for replacing every occurrence of a word.                                               |
| `./otTextEditor deleteWord ...`           | Displays the syntax for deleting the first occurrence of a word.                                            |
| `./otTextEditor insertWord ...`           | Displays the syntax for inserting a new word after an existing word.                                        |
| `./otTextEditor deleteLine ...`           | Displays the syntax for deleting a specific line.                                                           |
| `./otTextEditor deleteLineContaining ...` | Displays the syntax for deleting all lines containing a specified word.                                     |
| `./otTextEditor show ...`                 | Displays the syntax for printing the file contents.                                                         |
| `./otTextEditor countLines ...`           | Displays the syntax for counting the number of lines.                                                       |
| `./otTextEditor countWords ...`           | Displays the syntax for counting the number of words.                                                       |
| `./otTextEditor lineNumbers ...`          | Displays the syntax for printing the file with line numbers.                                                |
| `EOF`                                     | Marks the end of the Here Document.                                                                         |
| `exit 1`                                  | Terminates the script with exit status **1**, indicating incorrect usage or invalid arguments.              |
| `}`                                       | Ends the `usage()` function.                                                                                |


check_file
-----------
check_file() {
    [ -f "$1" ] || {
        echo "Error: File '$1' not found."
        exit 1
    }
}

| Statement                            | Explanation                                                                              |
| ------------------------------------ | ---------------------------------------------------------------------------------------- |
| `check_file() {`                     | Defines a function named **check_file** that verifies whether the specified file exists. |
| `[ -f "$1" ]`                        | Checks whether the file passed as the first argument exists and is a regular file.       |
|  |                                   | ` | Logical **OR** operator. Executes the block on the right only if the test on the left fails. |
| `{ ... }`                            | Groups multiple commands together so they can be executed as a single block.             |
| `echo "Error: File '$1' not found."` | Displays an error message if the file does not exist.                                    |
| `exit 1`                             | Stops the script with an error status.                                                   |
| `}`                                  | Ends the command block.                                                                  |
| `}`                                  | Ends the `check_file()` function.                                                        |

addLineTop
----------
addLineTop() {
    check_file "$1"
    sed -i "1i $2" "$1"
}

| Statement             | Explanation                                                                 |
| --------------------- | --------------------------------------------------------------------------- |
| `addLineTop() {`      | Defines a function named `addLineTop`.                                      |
| `check_file "$1"`     | Calls the `check_file()` function to ensure the specified file exists.      |
| `sed -i "1i $2" "$1"` | Inserts the text stored in `$2` before line **1** of the file.              |
| `sed`                 | Stream Editor used to edit text files.                                      |
| `-i`                  | Performs the modification directly in the original file (in-place editing). |
| `"1i $2"`             | `1` represents line number 1, and `i` means **insert before** that line.    |
| `"$1"`                | The file to be modified.                                                    |
| `}`                   | Ends the `addLineTop()` function.                                           |

addLineBottom
--------------
addLineBottom() {
    check_file "$1"
    echo "$2" >> "$1"
}

| Statement           | Explanation                                                                   |
| ------------------- | ----------------------------------------------------------------------------- |
| `addLineBottom() {` | Defines the `addLineBottom` function.                                         |
| `check_file "$1"`   | Ensures the file exists before modifying it.                                  |
| `echo "$2"`         | Prints the new line provided by the user.                                     |
| `>>`                | Appends the output to the end of the file without removing existing contents. |
| `"$1"`              | File that will be modified.                                                   |
| `}`                 | Ends the function.                                                            |

addLineAt
---------
addLineAt() {
    check_file "$1"
    sed -i "${2}i $3" "$1"
}

| Statement                | Explanation                                        |
| ------------------------ | -------------------------------------------------- |
| `addLineAt() {`          | Defines the `addLineAt` function.                  |
| `check_file "$1"`        | Verifies the file exists.                          |
| `sed -i "${2}i $3" "$1"` | Inserts the text before the specified line number. |
| `${2}`                   | The line number provided by the user.              |
| `i`                      | Insert before the specified line.                  |
| `$3`                     | The new line to insert.                            |
| `"$1"`                   | File to modify.                                    |
| `}`                      | Ends the function.                                 |

updateFirstWord
---------------
updateFirstWord() {
    check_file "$1"
    sed -i "0,/$2/s//$3/" "$1"
}

| Statement                    | Explanation                                                                |
| ---------------------------- | -------------------------------------------------------------------------- |
| `updateFirstWord() {`        | Defines a function named `updateFirstWord`.                                |
| `check_file "$1"`            | Verifies that the specified file exists before modifying it.               |
| `sed -i "0,/$2/s//$3/" "$1"` | Replaces only the first occurrence of the specified word with a new word.  |
| `sed`                        | Stream Editor used to search and modify text.                              |
| `-i`                         | Performs the modification directly in the original file.                   |
| `0,/$2/`                     | Searches from the beginning of the file until the first match of the word. |
| `s//`                        | Performs the substitution on the matched word.                             |
| `$3`                         | The replacement word.                                                      |
| `"$1"`                       | File to modify.                                                            |
| `}`                          | Ends the function.                                                         |

updateAllWords
---------------
updateAllWords() {
    check_file "$1"
    sed -i "s/$2/$3/g" "$1"
}

| Statement                 | Explanation                                                 |
| ------------------------- | ----------------------------------------------------------- |
| `updateAllWords() {`      | Defines the `updateAllWords` function.                      |
| `check_file "$1"`         | Verifies the file exists.                                   |
| `sed -i "s/$2/$3/g" "$1"` | Replaces all occurrences of the old word with the new word. |
| `s`                       | Substitute command.                                         |
| `$2`                      | Word to search for.                                         |
| `$3`                      | Replacement word.                                           |
| `g`                       | Global flag that replaces every occurrence on each line.    |
| `"$1"`                    | File to modify.                                             |
| `}`                       | Ends the function.                                          |

deleteWord
----------
deleteWord() {
    check_file "$1"
    sed -i "0,/$2/s//$3/" "$1"
}

| Statement                    | Explanation                                                               |
| ---------------------------- | ------------------------------------------------------------------------- |
| `deleteWord() {`             | Defines the `deleteWord` function.                                        |
| `check_file "$1"`            | Verifies that the file exists.                                            |
| `sed -i "0,/$2/s//$3/" "$1"` | Replaces the first occurrence of the specified word with an empty string. |
| `$2`                         | Word to remove.                                                           |
| `$3`                         | Empty string (`""`) passed from the `case` statement.                     |
| `}`                          | Ends the function.                                                        |

insertWord
----------
insertWord() {
    check_file "$1"
    sed -i "s/$2/$2 $3/g" "$1"
}

| Statement                    | Explanation                                                                                     |
| ---------------------------- | ----------------------------------------------------------------------------------------------- |
| `insertWord() {`             | Defines the `insertWord` function.                                                              |
| `check_file "$1"`            | Ensures the file exists.                                                                        |
| `sed -i "s/$2/$2 $3/g" "$1"` | Replaces every occurrence of the existing word with the existing word followed by the new word. |
| `$2`                         | Existing word.                                                                                  |
| `$3`                         | New word to insert.                                                                             |
| `g`                          | Applies the replacement globally.                                                               |
| `}`                          | Ends the function.                                                                              |

deleteLine
-----------
deleteLine() {
    check_file "$1"
    sed -i "${2}d" "$1"
}

| Statement             | Explanation                                                  |
| --------------------- | ------------------------------------------------------------ |
| `deleteLine() {`      | Defines a function named `deleteLine`.                       |
| `check_file "$1"`     | Verifies that the specified file exists before modifying it. |
| `sed -i "${2}d" "$1"` | Deletes the specified line from the file.                    |
| `sed`                 | Stream Editor used to edit text files.                       |
| `-i`                  | Performs the modification directly in the original file.     |
| `${2}`                | Represents the line number passed by the user.               |
| `d`                   | `sed` delete command. Deletes the specified line.            |
| `"$1"`                | File to modify.                                              |
| `}`                   | Ends the function.                                           |

deleteLineContaining
--------------------
deleteLineContaining() {
    check_file "$1"
    sed -i "/$2/d" "$1"
}

| Statement                  | Explanation                                       |
| -------------------------- | ------------------------------------------------- |
| `deleteLineContaining() {` | Defines the `deleteLineContaining` function.      |
| `check_file "$1"`          | Ensures the file exists.                          |
| `sed -i "/$2/d" "$1"`      | Deletes every line containing the specified word. |
| `/pattern/`                | Searches for the specified pattern.               |
| `d`                        | Deletes every matching line.                      |
| `"$1"`                     | File to modify.                                   |
| `}`                        | Ends the function.                                |

show
-----
show() {
    check_file "$1"
    cat "$1"
}

| Statement         | Explanation                                            |
| ----------------- | ------------------------------------------------------ |
| `show() {`        | Defines the `show` function.                           |
| `check_file "$1"` | Verifies the file exists.                              |
| `cat "$1"`        | Displays the contents of the file.                     |
| `cat`             | Concatenates and prints file contents to the terminal. |
| `}`               | Ends the function.                                     |


countLines
----------
countLines() {
    check_file "$1"
    wc -l "$1"
}

| Statement         | Explanation                        |
| ----------------- | ---------------------------------- |
| `countLines() {`  | Defines the `countLines` function. |
| `check_file "$1"` | Ensures the file exists.           |
| `wc -l "$1"`      | Counts the total number of lines.  |
| `wc`              | Word Count command.                |
| `-l`              | Counts only lines.                 |
| `}`               | Ends the function.                 |


countWords
------------
countWords() {
    check_file "$1"
    wc -w "$1"
}

| Statement         | Explanation                        |
| ----------------- | ---------------------------------- |
| `countWords() {`  | Defines the `countWords` function. |
| `check_file "$1"` | Ensures the file exists.           |
| `wc -w "$1"`      | Counts the total number of words.  |
| `-w`              | Counts words only.                 |
| `}`               | Ends the function.                 |


lineNumbers
------------
lineNumbers() {
    check_file "$1"
    nl "$1"
}

| Statement         | Explanation                                             |
| ----------------- | ------------------------------------------------------- |
| `lineNumbers() {` | Defines the `lineNumbers` function.                     |
| `check_file "$1"` | Verifies the file exists.                               |
| `nl "$1"`         | Displays every line with its corresponding line number. |
| `nl`              | Number Lines command.                                   |
| `}`               | Ends the function.                                      |




























