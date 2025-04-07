# (true / false) Verify the signature by this address over this message:
#   address: `1NChfewU45oy7Dgn51HwkBFSixaTnyakfj`
#   message: `1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa`
#   signature: `HCsBcgB+Wcm8kOGMH8IpNeg0H4gjCrlqwDf/GlSXphZGBYxm0QkKEPhh9DTJRp2IDNUhVr0FhP9qCqo2W0recNM=`


ADDRESS="1NChfewU45oy7Dgn51HwkBFSixaTnyakfj"
MESSAGE="1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa"
SIGNATURE="HCsBcgB+Wcm8kOGMH8IpNeg0H4gjCrlqwDf/GlSXphZGBYxm0QkKEPhh9DTJRp2IDNUhVr0FhP9qCqo2W0recNM="

RESULT=$(bitcoin-cli verifymessage "$ADDRESS" "$SIGNATURE" "$MESSAGE")
echo "$RESULT"


