##wuwei無為
``` 
these serverless applications (off-chain workers) gets data from currencies making use of Chainlink nodes.
it implements a bridge, allowing data to be shared between smart contracts
and dApps across different blockchains. it intends to bring open source infrastructure to defi
from an automated and devops perspective.

it gets data from and fetchs the following USDT pairs

each update costs~ 0.011613807 Ether + 0.1 Link + 0.044876 ꜩ
``` 
**specifications** 
``` 
this application makes use of cloud service providers as Infura, Nautilus Cloud, AWS Lambda 
and uses web3 and conseiljs SDKs.
```
**directory tree**
```
.
├── README.md
├── tz-wuwei
│   ├── index.js
│   ├── michelson_smartpy
│   │   ├── client.tz
│   │   ├── wuwei_smartpy.py
│   │   └── wuwei.tz
│   ├── package.json
│   └── README.md
└── web3-wuwei
    ├── abi.js
    ├── index.js
    ├── package.json
    ├── README.md
    └── solidity
        └── wuwei.sol
```

**kovan solidity sample**
[0x6e291a2df3b24d1c96dc75e95b9552d7e450f7ad](https://kovan.etherscan.io/address/0x6e291a2df3b24d1c96dc75e95b9552d7e450f7ad)

**carthagenet michelson sample** 
[KT1AoxNnzM1eyjMPStXDkjCknerbg9qPi2Kb](https://better-call.dev/carthagenet/KT1AoxNnzM1eyjMPStXDkjCknerbg9qPi2Kb/operations)
