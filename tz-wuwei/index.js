
/*
    dependencies
    https://cryptonomic.github.io/ConseilJS/#/
*/
require('dotenv').config();

const { 
    registerFetch, 
    registerLogger, 
    Signer, 
    TezosMessageUtils, 
    TezosConseilClient, 
    OperationKindType, 
    TezosNodeReader, 
    TezosNodeWriter, 
    TezosParameterFormat
} = require('conseiljs')

const { 
    KeyStoreUtils, 
    SoftSigner 
} = require('conseiljs-softsigner')

const fetch = require('node-fetch')
const log = require('loglevel')

const logger = log.getLogger('conseiljs')
logger.setLevel('debug', false)
registerLogger(logger)
registerFetch(fetch)

/* 
node configuration
https://nautilus.cloud/
 */
const tezosNode = process.env.TEZOS_NODE
const conseilServer = { url: process.env.CONSEIL_SERVER, apiKey: process.env.API_KEY, network: process.env.NETWORK }
const networkBlockTime = 30 + 1

let address = process.env.WUWEI_KT_ADDRESS;

function clearRPCOperationGroupHash(hash) {
    return hash.replace(/\"/g, '').replace(/\n/, '');
}

//const exec = async (obj) => {
exports.handler = async (event) => {
    // event.body.arr
    //let parameter = `(Right "${event.queryStringParameters.seed}")`

    var arr = event.price_feed
    console.log(arr)
    let parameter = `(Right {Elt "AED" ${arr[0]}; Elt "BRL" ${arr[1]}; Elt "CAN" ${arr[2]}; Elt "CHF" ${arr[3]}; Elt "CNY" ${arr[4]}; Elt "EUR" ${arr[5]}; Elt "HKD" ${arr[6]}; Elt "INR" ${arr[7]}; Elt "JPY" ${arr[8]}; Elt "KRW" ${arr[9]}; Elt "QAR" ${arr[10]}; Elt "RUB" ${arr[11]}; Elt "SGD" ${arr[12]}})`
    console.log(parameter)

    const keystore = await KeyStoreUtils.restoreIdentityFromSecretKey(process.env.SECRET_KEY)
    const signer = await SoftSigner.createSigner(TezosMessageUtils.writeKeyWithHint(keystore.secretKey, 'edsk'), -1)

    console.log(`~~ invokeContract`)
    const fee = Number((await TezosConseilClient.getFeeStatistics(conseilServer, conseilServer.network, OperationKindType.Transaction))[0]['high'])
    console.log(fee)
    let storageResult = await TezosNodeReader.getContractStorage(tezosNode, address)
    console.log(`~~ initial storage: ${JSON.stringify(storageResult)}`)

    const { gas, storageCost } = await TezosNodeWriter.testContractInvocationOperation(tezosNode, 'main', keystore, address, 10000, fee, 1000, 100000, '', parameter, TezosParameterFormat.Michelson)
    console.log(storageCost)
    const freight = storageCost
    console.log(`~~ cost: ${JSON.stringify(await TezosNodeWriter.testContractInvocationOperation(tezosNode, 'main', keystore, address, 10000, fee, 1000, 100000, '', parameter, TezosParameterFormat.Michelson))}`)
    const nodeResult = await TezosNodeWriter.sendContractInvocationOperation(tezosNode, signer, keystore, address, 0, fee, 1000, 100000, '', parameter, TezosParameterFormat.Michelson)

    const groupid = clearRPCOperationGroupHash(nodeResult.operationGroupID)
    console.log(`~~ Injected transaction(invocation) operation with ${groupid}`)
 
    const response = {
        statusCode: 200,
        body: event,
    };

    return response;
}

/* exec({
    price_feed: [
      '35900',   '56590',
      '31310',   '9250',
      '66440',   '8581',
      '77870',   '819200',
      '1056400', '11681400',
      '38580',   '790100',
      '13740'
    ]
  }) */
