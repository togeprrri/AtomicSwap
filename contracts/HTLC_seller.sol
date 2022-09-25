// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract HTLC_seller {
    bytes32 private secret;
    address public buyer;
    uint256 public timeOut;
    address private seller; 

    modifier onlyIssuer {
        require(msg.sender == seller, "Sender can't do this, only issuer can"); 
        _; 
    }

    constructor (string memory _hash, address _buyer, uint256 _timeLimit) {
        require(secret != 0 || _buyer != address(0) || _timeLimit != 0, "Wrong deployment arguments");
        secret = sha256(abi.encodePacked(_hash));
        buyer = _buyer;
        timeOut = block.timestamp + (_timeLimit * 1 hours);
        seller = msg.sender; 
    }
 
    function claim(bytes32 _secret) external returns(bool) {
       require(secret == _secret, "Wrong secret");
       selfdestruct(payable(buyer));
       return true;
       }

    function refund() onlyIssuer external returns(bool) {
        require(block.timestamp >= timeOut, "It's not time yet");
        selfdestruct(payable(seller));
        return true;
    }

    receive () external payable {
    }
}