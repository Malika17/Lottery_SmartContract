//SPDX-LICENSE-IDENTIFIER : GPL-3.0
pragma solidity ^0.8.0;

contract lotteryContract{
    address public manager;
    address payable[] public players;
    address payable public winner;

    constructor(){
        manager = msg.sender;
    }
    function participate() public payable {
        require(msg.value == 1 ether, "please input 1 ether only");
        players.push(payable(msg.sender));

    }
    function getBalance() public view returns(uint){
        require(msg.sender == manager, "only manager can call this function");
        return(address(this).balance);
    }
    function random() internal view returns(uint){
        return(uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length))));

    }
    function pickWinner() public {
        require(msg.sender == manager, "You are not the manager");
        require(players.length >=3, "players are less than 3");
        uint random_number = random();
        uint index = random_number % players.length;
        winner = players[index];
        winner.transfer(getBalance());
        players = new address payable[](0);

    } 
}