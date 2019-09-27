pragma solidity >=0.4.22 <0.6.0;

contract SimpleAuction{
    uint maximum;

    struct Bid{
        address addr;
        uint amount;
    }    
    
    Bid[] bids;
    
    bool closed;
    
    constructor() public {
        maximum = 0;
        closed = false;
    }
    
    function bid(uint amount) public {
        require(!closed, "The auction closed!");
        require(!containsBidder(msg.sender), "This person already bid!");
       
        if(bids.length > 0){
            if(bids[maximum].amount < amount){
                bids.push(Bid(msg.sender, amount));
                maximum = bids.length - 1;
            }
        } else {
            bids.push(Bid(msg.sender, amount));
        }
    }
    
    function decideWinner() public returns(address) {
        closed = true;
        if(bids.length == 0){
            return address(0);
        } else {
            return bids[maximum].addr;
        }
    }
    
    function getMaximumBid() public view returns(uint) {
        if(bids.length > 0){
            return bids[maximum].amount;
        } else {
            return 0;
        }
    }
    
    function getWinner() public view returns(address){
        require(closed, "The auction is still open!");
        require(bids.length > 0, "No one bid");

        return bids[maximum].addr;
    }

    function containsBidder(address addr) private view returns(bool){
        for(uint i = 0; i < bids.length; i++){
            if(bids[i].addr == addr){
                return true;
            }
        }
        return false;
    }
}