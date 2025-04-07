# How many new outputs were created by block 123,456?\
BLOCK=123456
OUTPUTS=$(bitcoin-cli getblockstats $BLOCK)
echo $OUTPUTS | jq .outs
