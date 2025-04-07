# What is the hash of block 654,321?
BLOCK=654321
BLOCK_HASH=$(bitcoin-cli getblockhash $BLOCK)
echo $BLOCK_HASH
