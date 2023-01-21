pragma solidity ^0.6.7;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {

    AggregatorV3Interface internal priceFeed;

    /**
     * kovan network ETH/ USD
     * can similarly be done for binance smart netork using the address
     * 0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE)
     */
    constructor() public {
        priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
    }

    /**
     * Returns the latest price
     */
   function getLatestPrice() public view returns (int) {
        (
            uint80 roundID,
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        return price;
    }
}



import 'https://github.com/aave/aave-protocol/blob/master/contracts/configuration/LendingPoolAddressesProvider.sol';
import 'https://github.com/aave/aave-protocol/blob/master/contracts/lendingpool/LendingPool.sol';
import 'https://github.com/aave/aave-protocol/blob/master/contracts/flashloan/base/FlashLoanReceiverBase.sol';
contract Borrower is FlashLoanReceiverBase{
    
 LendingPoolAddressesProvider provider;
 address dai;
 
 constructor(
     address _provider, address _dai) FlashLoanReceiverBase(_provider) 
     public{
     provider= LendingPoolAddressesProvider(_provider);
     dai=_dai;
    
 }
 
 function startLoan( unit amount, bytes calldata _params) external {
     
     LendingPool lendingPool=LendingPool(provider.getLendingPool());
     lendingPool.flashLoan(address(this),dai, amount, _params);
 }    
 function executeOperation(
     address _reserve,
     unit _amount,
     unit _fee,
     bytes memory _params)external{
        transferFundsBackToPoolInternal(_reserve, amount +fee);   
        
        
     }
    
    
}
