# Only one single output remains unspent from block 123,321. What address was it sent to?
blockhash=$(bitcoin-cli getblockhash 123321)
block_data=$(bitcoin-cli getblock $blockhash 2)

for txid in $(echo $block_data | jq -r '.tx[].txid'); do
    for vout_index in $(seq 0 $(($(echo $block_data | jq -r ".tx[] | select(.txid == \"$txid\") | .vout | length") - 1))); do
        output=$(bitcoin-cli gettxout $txid $vout_index)
        [[ ! -z "$output" ]] && echo $output | jq -r '.scriptPubKey.address' && exit 0
    done
done
