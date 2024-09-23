#!/bin/bash

ADDRESS_BOOK="addressbook.txt"

add_contact() {
    echo "Enter Name:"
    read name
    echo "Enter Phone Number:"
    read phone
    echo "Enter Email:"
    read email

    echo "$name;$phone;$email" >> "$ADDRESS_BOOK"
    echo "Contact added successfully."
}


remove_contact() {
    echo "Enter the name, phone, or email of the contact to remove:"
    read query

    grep -i "$query" "$ADDRESS_BOOK"
    if [ $? -eq 0 ]; then
        echo "Are you sure you want to delete this contact? (y/n)"
        read confirmation
        if [ "$confirmation" == "y" ]; then
            grep -iv "$query" "$ADDRESS_BOOK" > temp.txt && mv temp.txt "$ADDRESS_BOOK"
            echo "Contact removed successfully."
        else
            echo "Operation cancelled."
        fi
    else
        echo "No matching contact found."
    fi
}

search_contact() {
    echo "Enter search query:"
    read query

    grep -i "$query" "$ADDRESS_BOOK"

    if [ $? -ne 0 ]; then
        echo "No contacts found"
    fi
}

if [ "$1" == "add" ]; then
    add_contact
elif [ "$1" == "search" ]; then
    search_contact
elif [ "$1" == "remove" ]; then
    remove_contact
else
    echo "Possible commands: $0 {add|search|remove}"
fi
