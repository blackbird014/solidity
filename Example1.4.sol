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
    
    function bid() public payable {
        require(!closed, "The auction closed!");
        require(!containsBidder(msg.sender), "This person already bid!");

        if(bids.length > 0){
            if(bids[maximum].amount < msg.value){
                bids.push(Bid(msg.sender, msg.value));
                maximum = bids.length - 1;
            }
        } else {
            bids.push(Bid(msg.sender, msg.value));
        }
    }
    
    function decideWinner() public returns(address) {
        require(!closed, "The auction is already closed!");
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