#!/bin/bash

# Initialize CouchDB database
COUCHDB_URL="http://localhost:5984"
COUCHDB_USER="admin"
COUCHDB_PASSWORD="admin"

# Create the necessary databases
curl -X PUT "$COUCHDB_URL/_users" -u $COUCHDB_USER:$COUCHDB_PASSWORD
curl -X PUT "$COUCHDB_URL/_replicator" -u $COUCHDB_USER:$COUCHDB_PASSWORD
curl -X PUT "$COUCHDB_URL/_global_changes" -u $COUCHDB_USER:$COUCHDB_PASSWORD
curl -X PUT "$COUCHDB_URL/notes" -u $COUCHDB_USER:$COUCHDB_PASSWORD

# Create an admin user
curl -X PUT "$COUCHDB_URL/_node/couchdb@localhost/_config/admins/$COUCHDB_USER" --data "\"$COUCHDB_PASSWORD\""

# Set up security configurations
curl -X PUT "$COUCHDB_URL/notes/_security" -u $COUCHDB_USER:$COUCHDB_PASSWORD -H "Content-Type: application/json" -d '{"admins": {"names": [], "roles": []}, "members": {"names": [], "roles": []}}'
