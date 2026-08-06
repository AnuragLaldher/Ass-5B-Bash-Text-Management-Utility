#!/usr/bin/env bash

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

Replace all occurrences of a word
./otTextEditor updateAllWords <file> <old word> <new word>

Delete first occurrence of a word
./otTextEditor deleteWord <file> <word>

Insert a word after another word
./otTextEditor insertWord <file> <existing word> <new word>

Delete a line
./otTextEditor deleteLine <file> <line number>

Delete lines containing a word
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

# Check file exists
check_file() {
    [ -f "$1" ] || {
        echo "Error: File '$1' not found."
        exit 1
    }
}

#######################################
# Add Line at Top
#######################################
addLineTop() {
    check_file "$1"
    sed -i "1i $2" "$1"
}

#######################################
# Add Line at Bottom
#######################################
addLineBottom() {
    check_file "$1"
    echo "$2" >> "$1"
}

#######################################
# Add Line at Specific Position
#######################################
addLineAt() {
    check_file "$1"
    sed -i "${2}i $3" "$1"
}

#######################################
# Replace First Occurrence
#######################################
updateFirstWord() {
    check_file "$1"
    sed -i "0,/$2/s//$3/" "$1"
}

#######################################
# Replace All Occurrences
#######################################
updateAllWords() {
    check_file "$1"
    sed -i "s/$2/$3/g" "$1"
}

#######################################
# Delete First Occurrence of Word
#######################################
deleteWord() {
    check_file "$1"
    sed -i "0,/$2/s//$3/" "$1"
}

#######################################
# Insert Word
#######################################
insertWord() {
    check_file "$1"
    sed -i "s/$2/$2 $3/g" "$1"
}

#######################################
# Delete Line
#######################################
deleteLine() {
    check_file "$1"
    sed -i "${2}d" "$1"
}

#######################################
# Delete Line Containing Word
#######################################
deleteLineContaining() {
    check_file "$1"
    sed -i "/$2/d" "$1"
}

#######################################
# Extra Feature : Show File
#######################################
show() {
    check_file "$1"
    cat "$1"
}

#######################################
# Extra Feature : Count Lines
#######################################
countLines() {
    check_file "$1"
    wc -l "$1"
}

#######################################
# Extra Feature : Count Words
#######################################
countWords() {
    check_file "$1"
    wc -w "$1"
}

#######################################
# Extra Feature : Show Line Numbers
#######################################
lineNumbers() {
    check_file "$1"
    nl "$1"
}

#######################################
# Main
#######################################

case "$1" in

addLineTop)
    [ $# -eq 3 ] || usage
    addLineTop "$2" "$3"
    ;;

addLineBottom)
    [ $# -eq 3 ] || usage
    addLineBottom "$2" "$3"
    ;;

addLineAt)
    [ $# -eq 4 ] || usage
    addLineAt "$2" "$3" "$4"
    ;;

updateFirstWord)
    [ $# -eq 4 ] || usage
    updateFirstWord "$2" "$3" "$4"
    ;;

updateAllWords)
    [ $# -eq 4 ] || usage
    updateAllWords "$2" "$3" "$4"
    ;;

deleteWord)
    [ $# -eq 4 ] || usage
    deleteWord "$2" "$3" ""
    ;;

insertWord)
    [ $# -eq 4 ] || usage
    insertWord "$2" "$3" "$4"
    ;;

deleteLine)
    [ $# -eq 3 ] || usage
    deleteLine "$2" "$3"
    ;;

deleteLineContaining)
    [ $# -eq 3 ] || usage
    deleteLineContaining "$2" "$3"
    ;;

show)
    [ $# -eq 2 ] || usage
    show "$2"
    ;;

countLines)
    [ $# -eq 2 ] || usage
    countLines "$2"
    ;;

countWords)
    [ $# -eq 2 ] || usage
    countWords "$2"
    ;;

lineNumbers)
    [ $# -eq 2 ] || usage
    lineNumbers "$2"
    ;;

*)
    usage
    ;;
esac
