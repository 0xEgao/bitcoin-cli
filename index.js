import Client from "bitcoin-core";
import fs from "fs"
const client = new Client({
    network: "regtest",
    username: "alice",
    password: "password",
    port: 18443,
    host: "http://127.0.0.1:18443",
    wallet:"testwallet",
});


async function ensureWalletLoaded(walletName) {
  try {
      await client.command('getwalletinfo'); // Check if wallet is already loaded
      console.log(`Wallet "${walletName}" is already loaded.`);
  } catch (err) {
      if (err.code === -18) { // Wallet not found or not loaded
          console.log(`Wallet "${walletName}" not found. Creating it now...`);
          await client.command('createwallet', walletName);
      } else {
          throw err;
      }
  }
}

(async () => {
  await ensureWalletLoaded('testwallet');
  const address = await client.command('getnewaddress');
  await client.command('generatetoaddress', 103, address);
  const balance = await client.command('getbalance');
  console.log(balance);

  await createTransaction();
})();



async function createTransaction() {
    try {
        // Convert string to binary encoding and then to hex
        const binaryData = Buffer.from("We are all Satoshi!!", 'binary').toString('hex');

        // Defining the outputs i.e O1 is 100btc to given address and O2 is OP_RETURN of our binary message
        const outputs = [
            { "bcrt1qq2yshcmzdlznnpxx258xswqlmqcxjs4dssfxt2": 100 },   
            { data: binaryData }                                   
        ];

        // Step 1: Creating raw transaction
        const rawTx = await client.command('createrawtransaction', [], outputs);

        // Step 2: Funding the transaction from our wallet
        const fundedTx = await client.command('fundrawtransaction', rawTx,{fee_rate: 21});

        // Step 3: Signing the transaction
        const signedTx = await client.command('signrawtransactionwithwallet', fundedTx.hex);

        // Step 4: Send the transaction to the Bitcoin network
        const txid = await client.command('sendrawtransaction', signedTx.hex);

        console.log('Transaction successfully sent! TXID:', txid);
        fs.writeFileSync('out.txt',txid);
    } catch (err) {
        console.error('Error creating transaction:', err);
    }
}
