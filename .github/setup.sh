wget https://bitcoincore.org/bin/bitcoin-core-28.0/bitcoin-28.0-x86_64-linux-gnu.tar.gz
tar -xzvf bitcoin-28.0-x86_64-linux-gnu.tar.gz
ln -s $PWD/bitcoin-28.0/bin/* /usr/local/bin/
mkdir -p ~/.bitcoin
echo "rpcconnect=boss2025.xyz" >> ~/.bitcoin/bitcoin.conf
echo "rpcuser=classroom" >> ~/.bitcoin/bitcoin.conf
echo "rpcpassword=pL9NpO8hjJEp" >> ~/.bitcoin/bitcoin.conf
echo $(bitcoin-cli --version)