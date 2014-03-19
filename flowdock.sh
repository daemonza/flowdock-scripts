#!/usr/bin/env bash
# Script to post messages to Flowdeck inbox or chat.
# Plug it in, and pipe to it from where it makes the most sense to you.
# Usage :
# flowdock.sh chat  <nessage>
#             inbox <source> <from_address> <subject> <content>

##### CONFIGURE
TOKEN="ADD YOUR TOKEN"

case $1 in
chat)

FLOWDOCK="https://api.flowdock.com/v1/messages/chat/$TOKEN"
MESSAGE=$2

JSON=$(cat <<EOF
{                                     
	"content" : "$MESSAGE",                 
	"external_user_name" : "Yoda"           
	}
EOF
)

echo $JSON
curl -i -X POST -H "Content-Type: application/json" -d "$JSON" $FLOWDOCK 
		
;;

inbox)
        FLOWDOCK="https://api.flowdock.com/v1/messages/team_inbox/$TOKEN"
        SOURCE=$2
        FROM_ADDR=$3
        SUBJECT=$4
        CONTENT=$5

JSON=$(cat <<EOF
		{
			"content" : "$CONTENT",
			"from_address" : "$FROM_ADDR",
			"subject" : "$SUBJECT",
			"source" : "$SOURCE"
		}
EOF
)	

echo $JSON
curl -i -X POST -H "Content-Type: application/json" -d "$JSON" $FLOWDOCK 
;;


*)
echo "Usage :"
echo "flowdock.sh chat  <nessage>"
echo "            inbox <source> <from_address> <subject> <content>"

;;

esac
