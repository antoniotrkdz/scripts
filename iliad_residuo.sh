#! /bin/bash
curl -s 'https://www.iliad.it/account/' --data-urlencode "login-ident:$(head -n 1 ./.iliad_credentials)" --data-urlencode "login-pwd:$(tail -n 1 ./.iliad_credentials)" --cookie-jar /tmp/iliad_cookie --location > /dev/null
RESPONSE=$(curl -s 'https://www.iliad.it/account/' --cookie /tmp/iliad_cookie | grep -zoP '[0-9,]*(?=.)( \/ )?[0-9]+(?=GB)' | cut -f1,2 -d/ | tr -d ' ')
USED=$(echo $RESPONSE | tr ',' '.' | cut -f1 -d/)
TOTAL=$(echo $RESPONSE | cut -f2 -d/)
echo "$TOTAL-$USED" | bc
