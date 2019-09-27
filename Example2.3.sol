pragma solidity >=0.4.22 <0.6.0;

contract Lottery {
	struct V{
		uint g;
		bool w;
		address payable s;
	}

	V[] values;

	uint public tot = 0;
	address payable public owner ;

	constructor() public{
		owner = msg.sender;
	}

	function addGuess(uint guess) external payable{
		require(msg.value == 2 ether, "Registration costs 2 ETH!");

		tot += 2;
		values.push(V(guess, false, msg.sender));
	}

	function getParticipant(uint index) public view returns(address, uint, bool){
		return (values[index].s, values[index].g, values[index].w);
	}

	function getParticipants() public view returns(uint){
		return values.length;
	}

	function decideWinners() public payable {
		require(msg.sender == owner, "Only the owner can start the lottery");
		require(msg.value == 1 ether * (tot/2), "Not enough ETH to start this function!");

		for(uint i = 0; i < values.length; i++) {
		if(values[i].g == 7){
				values[i].w = true;
				if(tot > 3){
					values[i].s.transfer(3 ether);
					tot -= 3;
				}
			}
			values[i].g = 0;
		}
		owner.transfer(1 ether * tot);
		tot = 0;
	}
}
