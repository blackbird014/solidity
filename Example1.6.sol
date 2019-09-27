pragma solidity >=0.4.22 <0.6.0;

contract SimpleAuction{
    uint maximum;
    uint maxBid;
    address owner;

    struct Bid{
        address addr;
        uint amount;
    }    
    
    Bid[] bids;
    bool closed;
    
    constructor() public {
        owner = msg.sender;
        maxBid = 0;
        maximum = 0;
        closed = false;
    }
    
    function bid() public payable {
        require(!closed, "The auction closed!");
        require(!containsBidder(msg.sender), "This person already bid!");
        require(msg.value > maxBid, "The bid is not high enough");

        bids.push(Bid(msg.sender, msg.value));
        maxBid = msg.value;
        if(bids.length > 0){
                maximum = bids.length - 1;
        }
    }
    
    function decideWinner() public returns(address) {
        require(!closed, "The auction is already closed!");
        require(msg.sender == owner, "Only the owner can close the auction");
        closed = true;
        if(bids.length == 0){
            return address(0);
        } else {
            return bids[maximum].addr;
        }
    }
    
    function getMaximumBid() public view returns(uint) {
        return maxBid;
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