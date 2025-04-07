# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
XPUB="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"

# Getting checksum to use with deriveaddresses commad ,i need to appned /0/* at the end of the XPUB so that it can have range
CHECKSUM=$(bitcoin-cli getdescriptorinfo "tr($XPUB/*)" | jq -r '.checksum')

#Deriving address requires me to have checksum so i got it from getdescriptorinfo
TAPROOT=$(bitcoin-cli deriveaddresses "tr($XPUB/*)#$CHECKSUM" "[100,100]")

# Echoing the derived address
echo $TAPROOT | jq -r '.[0]'

