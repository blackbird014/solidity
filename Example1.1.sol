pragma solidity >=0.4.22 <0.6.0;

contract SimpleAuction{
    uint maximum;

    struct Bid{
        string name;
        uint amount;
    }    
    
    Bid[] bids;
    
    bool closed;
    
    constructor() public {
        maximum = 0;
        closed = false;
    }
    
    function bid(string memory name, uint amount) public {
        if(!closed && !containsBidder(name)){
            if(bids.length > 0){
                if(bids[maximum].amount < amount){
                    bids.push(Bid(name, amount));
                            maximum = bids.length - 1;
                }
            } else {
                bids.push(Bid(name, amount));
            }
        }
    }
    
    function decideWinner() public returns(string memory) {
        if(!closed){
            closed = true;
            if(bids.length == 0){
                return "";
            } else {
                return bids[maximum].name;
            }
        }
    }
    
    function getMaximumBid() public view returns(uint) {
        if(bids.length > 0){
            return bids[maximum].amount;
        } else {
            return 0;
        }
    }
    
    function getWinner() public view returns(string memory){
        if(closed && bids.length > 0){
            return bids[maximum].name;
        } else {
            return "";
        }
    }

    function containsBidder(string memory name) private view returns(bool){
        for(uint i = 0; i < bids.length; i++){
            if(keccak256(abi.encodePacked(bids[i].name)) == keccak256(abi.encodePacked(name))){
                return true;
            }
        }
        return false;
    }
}