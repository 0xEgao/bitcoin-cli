# Which public key signed input 0 in this tx:
#!/bin/bash

# Transaction ID to analyze
TXID="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"

# Get the raw transaction details with verbosity 1
raw_tx=$(bitcoin-cli getrawtransaction $TXID 1)

# Extract the witness public key from input 0, array element 2, characters 5-70
pubkey=$(echo $raw_tx | jq -r '.vin[0].txinwitness[2][4:70]')
echo $pubkey
