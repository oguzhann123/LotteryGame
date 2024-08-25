// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


contract Lottery{
    // entities =  owner, players,  and winner 

    address public owner;
    address payable[] public players;
    address payable public winner;


    constructor() {
      owner= msg.sender;
    }

    function participate() public payable {
        
        require(msg.value== 100 wei," you don't have enough ether");
        players.push(payable (msg.sender));
    }

    function getBalance() public view returns (uint){
        require(msg.sender==owner,"you are not the Owner!");
          return  address(this).balance;
    }

    function random()internal view returns(uint) {
     return uint  ( keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }

    function selectWinner() public{  
        require(owner==msg.sender,"you are not the Owner");
        require(players.length>=2,"Players are less than '2' ");
      uint who = random();
     uint index = who%players.length;
          winner=players[index];
          winner.transfer(getBalance());
          players = new address payable[] (0); // this  will intiliaze the players array back
    }
}