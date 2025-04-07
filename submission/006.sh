# Which tx in block 257,343 spends the coinbase output of block 256,128?
# need to use getrawtransaction,getblock,getblockhash
#
COINBASE_BLOCK=256128
COINBASE_TXID=$(bitcoin-cli getblock $(bitcoin-cli getblockhash $COINBASE_BLOCK) | jq -r '.tx[0]')
BLOCK=257343
BLOCK_HASH=$(bitcoin-cli getblockhash $BLOCK)
TRANSACTIONS=$(bitcoin-cli getblock $BLOCK_HASH | jq -r '.tx[]')

#Now will do loops stuff to filter out the correct txid
for TXID in $TRANSACTIONS; do
  INPUT_TXIDS=$(bitcoin-cli getrawtransaction $TXID true | jq -r '.vin[].txid')
  
  for INPUT_TXID in $INPUT_TXIDS; do
    if [[ $INPUT_TXID == $COINBASE_TXID ]]; then
      echo $TXID
      exit 0
    fi
  done
done

