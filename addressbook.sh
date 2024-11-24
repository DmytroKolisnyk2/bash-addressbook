#!/bin/bash

ADDRESS_BOOK="addressbook.txt"

if [ ! -f "$ADDRESS_BOOK" ]; then
    touch "$ADDRESS_BOOK"
fi

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

    matching_contacts=$(grep -i "$query" "$ADDRESS_BOOK")
    if [ -n "$matching_contacts" ]; then
        echo "Matching contact(s):"
        echo "$matching_contacts"
        echo "Are you sure you want to delete these contact(s)? (y/n)"
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

    matching_contacts=$(grep -i "$query" "$ADDRESS_BOOK")
    if [ -n "$matching_contacts" ]; then
        echo "Matching contact(s):"
        echo "$matching_contacts"
    else
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
