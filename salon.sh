#! /bin/bash
PSQL="psql -X --dbname=salon --username=sameer --tuples-only -c"


echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"


MAIN_MENU() {
    SERVICES=$($PSQL "SELECT * FROM services")
    echo "$SERVICES" | while read SERVICE_ID BAR NAME
    do
        echo "$SERVICE_ID) $NAME"
    done

    read SERVICE_ID_SELECTED
    case $SERVICE_ID_SELECTED in
        1) BOOK_APPOINTMENT;;
        2) BOOK_APPOINTMENT;;
        3) BOOK_APPOINTMENT;;
        4) BOOK_APPOINTMENT;;
        5) BOOK_APPOINTMENT;;
        *) MAIN_MENU "I could not find that service. What would you like today?\n";;
    esac
}


BOOK_APPOINTMENT() {
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")

    if [[ -z $CUSTOMER_NAME ]]
    then
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME
        CREATE_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
        echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
        read SERVICE_TIME
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
        CREATE_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
        echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    else
        echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
        read SERVICE_TIME
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
        CREATE_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
        echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    fi

}


MAIN_MENU
# BOOK_APPOINTMENT
