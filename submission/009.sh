# How many satoshis did this transaction pay for fee?:
#  `c346d9277128f5d67740f8847f11aff5cef440b6d102fcd5ddcdb40d9a12df42`


TXID="c346d9277128f5d67740f8847f11aff5cef440b6d102fcd5ddcdb40d9a12df42"

RAW_TX=$(bitcoin-cli getrawtransaction $TXID true)

TOTAL_INPUT=0
for INPUT in $(echo $RAW_TX | jq -r '.vin[] | "\(.txid):\(.vout)"'); do
  TXID_IN=$(echo $INPUT | cut -d':' -f1)
  VOUT_IN=$(echo $INPUT | cut -d':' -f2)
  VALUE=$(bitcoin-cli getrawtransaction $TXID_IN true | jq -r ".vout[$VOUT_IN].value")
  SATOSHIS=$(echo "$VALUE * 100000000" | bc | awk '{print int($1)}')
  TOTAL_INPUT=$((TOTAL_INPUT + SATOSHIS))
done

TOTAL_OUTPUT=0
for VALUE in $(echo $RAW_TX | jq -r '.vout[].value'); do
  SATOSHIS=$(echo "$VALUE * 100000000" | bc | awk '{print int($1)}')
  TOTAL_OUTPUT=$((TOTAL_OUTPUT + SATOSHIS))
done
FEE_SATOSHIS=$((TOTAL_INPUT - TOTAL_OUTPUT))
echo $FEE_SATOSHIS

