pragma solidity ^0.5.0 ;


contract lotto{
    
    address payable public  owner ; // 合約發起人
    uint public answer; //猜數字答案
    uint public  price ; //支付費用
    address payable public  winner ; //贏家
    enum State {Start , end} 
    State public state ;

     mapping(address => uint) public counts ; //計算玩家猜次數

    modifier onlyOwner{
        require(msg.sender == owner, "not owner");
        _;
    }
    
    modifier checkState(State _state){
        require(state == _state , "state error'");
        _;
    }
    
    constructor(uint _price)public{
        owner = msg.sender;
        price = _price * 1 ether ;
        state = State.Start;
        answer = uint256(sha256(abi.encodePacked(now))) % 100 ;
    }
    
    function guess(uint _answer) public payable checkState(State.Start) returns(string memory){
        require(owner != msg.sender, "owner cant join");
        require(price == msg.value ," pay error");
        require(_answer<100 , "error");
        counts[msg.sender]= counts[msg.sender] + 1;
        
        if(_answer > answer){
            return "bigger";
        }
        else if(_answer < answer){
             return "smaller";
        }
        
        else{
            winner = msg.sender;
            state = State.end ;
            return "You guess number";
           
        }
    }
    
    function sendMoney() onlyOwner checkState(State.end)public{
        winner.transfer(address(this).balance * 9 /10);
        owner.transfer(address(this).balance);
    }
    
    function getContractBalance() public view returns(uint){
        
        return address(this).balance ;
    }

}
