// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract HTLC {
    string public version;
    bytes32 public digest;
    address public destination;
    uint public timeOut;
    address private issuer; 

    modifier onlyIssuer {
        require(msg.sender == issuer, "Sender can't do this, only issuer can"); 
        _; 
    }

    constructor (bytes32 _hash, address _dest, uint256 _timeLimit) {
        require(digest != 0 || _dest != address(0) || _timeLimit != 0, "Wrong deployment arguments");
        digest = _hash;
        destination = _dest;
        timeOut = block.timestamp + (_timeLimit * 1 hours);
        issuer = msg.sender; 
    }
 
    function claim(string memory _hash) external returns(bool result) {
       require(digest == keccak256(abi.encodePacked(_hash)), "Wrong hash");
       selfdestruct(payable(destination));
       return true;
       }

    function refund() onlyIssuer external returns(bool result) {
        require(block.timestamp >= timeOut, "It's not time yet");
        selfdestruct(payable(issuer));
        return true;
    }

    receive () external payable {
    }
}