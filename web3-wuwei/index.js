/* 
dependencies
https://web3js.readthedocs.io/en/v1.3.0/
https://infura.io/docs
*/

const Web3 = require('web3');
const Tx = require('ethereumjs-tx').Transaction
const axios = require('axios')
const { abi } = require('./abi')

require('dotenv').config();

console.log(process.env.ETHEREUM_PRIVATE_KEY);
const sol_address = process.env.SOL_ADDRESS; // 0x6e291a2df3b24d1c96dc75e95b9552d7e450f7ad
const web3 = new Web3(process.env.INFURA_NODE);
const signer = web3.eth.accounts.privateKeyToAccount(process.env.ETHEREUM_PRIVATE_KEY);

web3.eth.accounts.wallet.add(signer);

console.log(["CHAIN LINK NODE REQUESTS", sol_address])

const wuwei = new web3.eth.Contract(abi, sol_address);
const gas = 30700000000

/*
request prices from chainlink node operation cost eth/link
*/

const tx = wuwei.methods.requestAll()
var arr = []

const operation = async () => {
    await tx
        .send({
            from: signer.address,
            gas: await tx.estimateGas(),
        })
        .once('transactionHash', txhash => {

            console.log(txhash)
            wuwei.methods.aedPrice().call().then(res => {
                arr.push(res)
                console.log(res)
            })
            wuwei.methods.brlPrice().call().then(res => {
                arr.push(res)
                console.log(res)
            })
            wuwei.methods.canPrice().call().then(res => {
                arr.push(res)
                console.log(res)
            })
            wuwei.methods.chfPrice().call().then(res => {
                arr.push(res)
                console.log(res)
            })  
            wuwei.methods.cnyPrice().call().then(res => {
                arr.push(res)
                console.log(res)
            })
            wuwei.methods.eurPrice().call().then(res => {
                arr.push(res)
                console.log(res)
            })
            wuwei.methods.hkdPrice().call().then(res => {
                arr.push(res)
                console.log(res)
            })
            wuwei.methods.rupeePrice().call().then(res => {
                arr.push(res)
                console.log(res)
            })    
            wuwei.methods.jpyPrice().call().then(res => {
                arr.push(res)
                console.log(res)
            })
            wuwei.methods.krwPrice().call().then(res => {
                arr.push(res)
                console.log(res)
            })
            wuwei.methods.qarPrice().call().then(res => {
                arr.push(res)
            })
            wuwei.methods.rublePrice().call().then(res => {
                arr.push(res)
                console.log(res)
            })    
            wuwei.methods.sgdPrice().call().then(res => {
                arr.push(res)
                console.log(res)
                console.log({
                    price_feed : arr
                })
                axios.post(process.env.TZ_WUWEI, {
                    price_feed : arr
                }).then(res => console.log(res)).catch(e => console.log(e))
            })

/*             axios.post(process.env.TZ_WUWEI, {
                price_feed : arr
            })
            .then(console.log(res)) 
*/
        })

    return arr
}

//operation()


exports.handler = async (event) => {
    arr = []
    await operation()
    const response = {
        statusCode: 200,
        body: JSON.stringify(arr),
    };

    return response;
}
