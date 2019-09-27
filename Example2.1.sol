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
