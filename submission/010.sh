# Only one tx in block 444,431 signals opt-in RBF. What is its txid?

block_hash=$(bitcoin-cli getblockhash 444431)
#BIP125 gives the sequence number to us ,if it is lesser than this nubmer it signals opt-in RBF
rbf_tx=$(bitcoin-cli getblock $block_hash 2 | \
jq -r '.tx[] | select(.vin[].sequence < 4294967294) | .txid')

if [ -n "$rbf_tx" ]; then
    echo "$rbf_tx"
fi
