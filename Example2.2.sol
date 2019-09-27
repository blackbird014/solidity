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
	}
}
