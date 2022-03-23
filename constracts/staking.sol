//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;

contract Ownable
{

  
  string public constant NOT_CURRENT_OWNER = "018001";
  string public constant CANNOT_TRANSFER_TO_ZERO_ADDRESS = "018002";

  
  address public owner;
  address public ownAddress;

  
  event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );

  
  constructor()
    public
  {
    owner = msg.sender;
    ownAddress = address(this);
  }

  
  modifier onlyOwner()
  {
    _isOwner();
    _;
  }
  
  function _isOwner() internal view
  {
    require(msg.sender == owner, NOT_CURRENT_OWNER);
  }

  
  function transferOwnership(
    address _newOwner
  )
    public
    onlyOwner
  {
    require(_newOwner != address(0), CANNOT_TRANSFER_TO_ZERO_ADDRESS);
    emit OwnershipTransferred(owner, _newOwner);
    owner = _newOwner;
  }

}

contract ReentrancyGuard {
    uint256 private _guardCounter;

    constructor () internal {
        _guardCounter = 1;
    }

    
    modifier nonReentrant() {
        _guardCounter += 1;
        uint256 localCounter = _guardCounter;
        _;
        require(localCounter == _guardCounter, "rg");
    }
}


library SafeMath
{
  
  string constant OVERFLOW = "008001";
  string constant SUBTRAHEND_GREATER_THEN_MINUEND = "008002";
  string constant DIVISION_BY_ZERO = "008003";

  
  function mul(
    uint256 _factor1,
    uint256 _factor2
  )
    internal
    pure
    returns (uint256 product)
  {
    
    if (_factor1 == 0)
    {
      return 0;
    }

    product = _factor1 * _factor2;
    require(product / _factor1 == _factor2, OVERFLOW);
  }

  
  function div(
    uint256 _dividend,
    uint256 _divisor
  )
    internal
    pure
    returns (uint256 quotient)
  {
    
    require(_divisor > 0, DIVISION_BY_ZERO);
    quotient = _dividend / _divisor;
  }

  
  function sub(
    uint256 _minuend,
    uint256 _subtrahend
  )
    internal
    pure
    returns (uint256 difference)
  {
    require(_subtrahend <= _minuend, SUBTRAHEND_GREATER_THEN_MINUEND);
    difference = _minuend - _subtrahend;
  }

  
  function add(
    uint256 _addend1,
    uint256 _addend2
  )
    internal
    pure
    returns (uint256 sum)
  {
    sum = _addend1 + _addend2;
    require(sum >= _addend1, OVERFLOW);
  }

 

}





contract ERC20Token {
 
    function totalSupply() external view returns (uint256){}
    function balanceOf(address account) external view returns (uint256){}
    function allowance(address owner, address spender) external view returns (uint256){}
    function transfer(address recipient, uint256 amount) external returns (bool){}
    function approve(address spender, uint256 amount) external returns (bool){}
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool){}
    function decimals()  external view returns (uint8){}
  
}




contract TokenStaking is
  Ownable, ReentrancyGuard
{
    using SafeMath for uint256;
   
   
    modifier onlyOwnerOrManager() {
         _isOwnerOrManager();
         _;
    }
    
    function _isOwnerOrManager() internal view{
        require(
          msg.sender == stakingManager 
          || msg.sender == owner 
            ,
        
          "24"
          );
    }
    
    
    uint32 constant BAD_DEPOSIT_PROFILE_ID = 0;
    
    uint256 contractDay = 5 minutes; //1 days; 5 min for test
    uint256 constant ADJ_CONSTANT = 1e18;
    uint256 constant DAYS_IN_YEAR = 365;
    uint256 constant APY_SCALE = 1e5; // i.e. 1% == 1000, 0.1% == 100
  
    address baseTokenAddress; //token which is staked
      
    struct DepositProfile {
      uint32 id;
      uint256 apy; 
      uint256 minLockTime; //in unix time, i.e. 1 day == 86400
      bool canJoin; //if canJoin == true - users can open  deposits with this profile, otherwise they can't
      uint256 endDate; //after this date reward is zero
    }
   
    /*
      reward calculation logic based on depositProfile.endDate & global contract endDate:

        let rewardDate = now;
        if(endDate && endDate < rewardDate){
        rewardDate = endDate;
        }

        if(depositProfile.endDate && depositProfile.endDate < rewardDate){
        rewardDate = depositProfile.endDate;
        }

    */

    mapping (uint256 => DepositProfile) public depositProfiles;
    uint256 public depositProfilesLength = 0;
  
   
    struct Deposit {
        uint32 depositProfileId; //deposit profile id
        uint256 depositAmount; 
        uint256 depositDate; //unix timestamp
        uint256 accumulatedReward; //used to store reward when we expand deposit or partially withdraw; 
                            //in this case we renew deposit date and store prev. reward in this field
        bool implyLock;
    }
