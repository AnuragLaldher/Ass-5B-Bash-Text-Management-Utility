#!/usr/bin/env bash

usage() {
cat <<EOF
Usage:

Add line at top
./otTextEditor addlinetop <file> <line>

Add line at bottom
./otTextEditor addlinebottom <file> <line>

Add line at specific position
./otTextEditor addlineat <file> <line number> <line>

Replace first occurrence of a word
./otTextEditor updatefirstword <file> <old word> <new word>

Replace all occurrences of a word
./otTextEditor updateallwords <file> <old word> <new word>

Delete first occurrence of a word
./otTextEditor deleteword <file> <word>

Insert a word after another word
./otTextEditor insertword <file> <existing word> <new word>

Delete a line
./otTextEditor deleteline <file> <line number>

Delete lines containing a word
./otTextEditor deletelinecontaining <file> <word>

Show file
./otTextEditor show <file>

Count lines
./otTextEditor countlines <file>

Count words
./otTextEditor countwords <file>

Show line numbers
./otTextEditor linenumbers <file>
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
addlinetop() {
    check_file "$1"
    sed -i "1i $2" "$1"
}

#######################################
# Add Line at Bottom
#######################################
addlinebottom() {
    check_file "$1"
    echo "$2" >> "$1"
}

#######################################
# Add Line at Specific Position
#######################################
addlineat() {
    check_file "$1"
    sed -i "${2}i $3" "$1"
}

#######################################
# Replace First Occurrence
#######################################
updatefirstword() {
    check_file "$1"
    sed -i "0,/$2/s//$3/" "$1"
}

#######################################
# Replace All Occurrences
#######################################
updateallwords() {
    check_file "$1"
    sed -i "s/$2/$3/g" "$1"
}

#######################################
# Delete First Occurrence of Word
#######################################
deleteword() {
    check_file "$1"
    sed -i "0,/$2/s//$3/" "$1"
}

#######################################
# Insert Word
#######################################
insertword() {
    check_file "$1"
    sed -i "s/$2/$2 $3/g" "$1"
}

#######################################
# Delete Line
#######################################
deleteline() {
    check_file "$1"
    sed -i "${2}d" "$1"
}

#######################################
# Delete Line Containing Word
#######################################
deletelinecontaining() {
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
countlines() {
    check_file "$1"
    wc -l "$1"
}

#######################################
# Extra Feature : Count Words
#######################################
countwords() {
    check_file "$1"
    wc -w "$1"
}

#######################################
# Extra Feature : Show Line Numbers
#######################################
linenumbers() {
    check_file "$1"
    nl "$1"
}

#######################################
# Main
#######################################

case "$1" in

addlinetop)
    [ $# -eq 3 ] || usage
    addlinetop "$2" "$3"
    ;;

addlinebottom)
    [ $# -eq 3 ] || usage
    addlinebottom "$2" "$3"
    ;;

addlineat)
    [ $# -eq 4 ] || usage
    addlineat "$2" "$3" "$4"
    ;;

updatefirstword)
    [ $# -eq 4 ] || usage
    updatefirstword "$2" "$3" "$4"
    ;;

updateallwords)
    [ $# -eq 4 ] || usage
    updateallwords "$2" "$3" "$4"
    ;;

deleteword)
    [ $# -eq 3 ] || usage
    deleteword "$2" "$3" ""
    ;;

insertword)
    [ $# -eq 4 ] || usage
    insertword "$2" "$3" "$4"
    ;;

deleteline)
    [ $# -eq 3 ] || usage
    deleteline "$2" "$3"
    ;;

deletelinecontaining)
    [ $# -eq 3 ] || usage
    deletelinecontaining "$2" "$3"
    ;;

show)
    [ $# -eq 2 ] || usage
    show "$2"
    ;;

countlines)
    [ $# -eq 2 ] || usage
    countlines "$2"
    ;;

countwords)
    [ $# -eq 2 ] || usage
    countwords "$2"
    ;;

linenumbers)
    [ $# -eq 2 ] || usage
    linenumbers "$2"
    ;;

*)
    usage
    ;;
esac
