pragma solidity ^0.6.0;

import "https://raw.githubusercontent.com/smartcontractkit/chainlink/develop/evm-contracts/src/v0.6/ChainlinkClient.sol";

contract Wuwei is ChainlinkClient {
  
    uint256 public cnyPrice;
    uint256 public brlPrice;
    uint256 public eurPrice;
    uint256 public rupeePrice;
    uint256 public canPrice;
    uint256 public jpyPrice;
    uint256 public krwPrice;
    uint256 public rublePrice;
    uint256 public chfPrice;
    uint256 public hkdPrice;
    uint256 public sgdPrice;
    uint256 public aedPrice;
    uint256 public qarPrice;

    // sar 
    // rial

    uint256 public times = 10000;
    
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;
    
    /**
     * Network: Kovan
     * Oracle: Chainlink - 0x2f90A6D021db21e1B2A077c5a37B3C7E75D15b7e
     * Job ID: Chainlink - 29fa9aa13bf1468788b7cc4a500a45b8
     * Fee: 0.1 LINK
     */
    constructor() public {
        setPublicChainlinkToken();
        oracle = 0x2f90A6D021db21e1B2A077c5a37B3C7E75D15b7e;
        jobId = "29fa9aa13bf1468788b7cc4a500a45b8";
        fee = 0.1 * 10 ** 18; // 0.1 LINK
    }
    
    /**
     * Create a Chainlink request to retrieve API response, find the target price
     * data, then multiply by 100 (to remove decimal places from price).
     */
    function requestCnyPrice() public returns (bytes32 requestId) 
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillCny.selector);
        
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=CNY");
        
        
        request.add("path", "CNY");
        
        request.addInt("times", int(times));
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    function requestBrlPrice() public returns (bytes32 requestId) 
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillBrl.selector);
        
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=BRL");
        request.add("path", "BRL");
        request.addInt("times", int(times));

        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    function requestEurPrice() public returns (bytes32 requestId) 
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillEur.selector);
        
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=EUR");
        request.add("path", "EUR");
        request.addInt("times", int(times));

        return sendChainlinkRequestTo(oracle, request, fee);
    }
  
    function requestRupeePrice() public returns (bytes32 requestId)
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillRupee.selector);
        
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=INR");
        request.add("path", "INR");
        request.addInt("times", int(times));
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }

    
    function requestJpyPrice() public returns (bytes32 requestId)
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillJpy.selector);
        
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=JPY");
        request.add("path", "JPY");
        request.addInt("times", int(times));
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    function requestKrwPrice() public returns (bytes32 requestId)
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillKrw.selector);
        
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=KRW");
        request.add("path", "KRW");
        request.addInt("times", int(times));
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    function requestRublePrice() public returns (bytes32 requestId)
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillRuble.selector);
        
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=RUB");
        request.add("path", "RUB");
        request.addInt("times", int(times));
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    function requestChfPrice() public returns (bytes32 requestId)
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillChf.selector);
        
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=CHF");
        request.add("path", "CHF");
        request.addInt("times", int(times));
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    function requestHkdPrice() public returns (bytes32 requestId)
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillHkd.selector);
        
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=HKD");
        request.add("path", "HKD");
        request.addInt("times", int(times));
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    function requestSgdPrice() public returns (bytes32 requestId)
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillSgd.selector);
        
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=SGD");
        request.add("path", "SGD");
        request.addInt("times", int(times));
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    
    function requestQarPrice() public returns (bytes32 requestId)
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillQar.selector);
        
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=QAR");
        request.add("path", "QAR");
        request.addInt("times", int(times));
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    function requestAedPrice() public returns (bytes32 requestId)
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillAed.selector);
        
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=AED");
        request.add("path", "AED");
        request.addInt("times", int(times));
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    
    function requestCanPrice() public returns (bytes32 requestId)
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillCan.selector);
        
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=CAN");
        request.add("path", "CAN");
        request.addInt("times", int(times));
        
        return sendChainlinkRequestTo(oracle, request, fee);
    }
    

    function requestAll() public 
    {
        
        this.requestCnyPrice();
        this.requestBrlPrice();
        this.requestEurPrice();
        this.requestRupeePrice();
        this.requestJpyPrice();
        this.requestKrwPrice();
        this.requestRublePrice();
        this.requestChfPrice();
        this.requestHkdPrice();
        this.requestSgdPrice();
        this.requestQarPrice();
        this.requestAedPrice();
        this.requestCanPrice();
 
    }
    
    /**
     * Receive the response in the form of uint256
     */ 
    function fulfillCny(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        cnyPrice = _price;
    }
    
    function fulfillBrl(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        brlPrice = _price;
    }
    
    function fulfillEur(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        eurPrice = _price;
    }
    
    function fulfillRupee(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        rupeePrice = _price;
    }
    
    function fulfillJpy(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        jpyPrice = _price;
    } 
    
    function fulfillKrw(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        krwPrice = _price;
    }    
    
    function fulfillRuble(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        rublePrice = _price;
    } 
    
    function fulfillChf(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        chfPrice = _price;
    } 
    
    function fulfillHkd(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        hkdPrice = _price;
    } 
    
    function fulfillSgd(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        sgdPrice = _price;
    } 
        
    function fulfillQar(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        qarPrice = _price;
    } 
    
    function fulfillAed(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        aedPrice = _price;
    } 
    
    function fulfillCan(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        canPrice = _price;
    }

}