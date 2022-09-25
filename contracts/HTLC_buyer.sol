// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract HTLC_seller {
    bytes32 private secret;
    address public buyer;
    uint256 public timeOut;
    address private seller;


    modifier onlyIssuer {
        require(msg.sender == buyer, "Sender can't do this, only issuer can"); 
        _; 
    }

    constructor (address _seller, uint256 _timeLimit) {
        require(_seller != address(0) || _timeLimit != 0, "Wrong deployment arguments");
        secret = 0;
        seller = _seller;
        timeOut = block.timestamp + (_timeLimit * 1 hours);
        buyer = msg.sender; 
    }

    function getSecret () external view returns(bytes32){
        require(msg.sender == buyer, "Sender is not buyer");
        return secret;
    }
 
    function claim(string memory _hash) external returns(bool) {
       require(msg.sender == seller, "Sender is not seller");
       secret = sha256(abi.encodePacked(_hash));
       selfdestruct(payable(seller));
       return true;
       }

    function refund() onlyIssuer external returns(bool) {
        require(block.timestamp >= timeOut, "It's not time yet");
        selfdestruct(payable(buyer));
        return true;
    }

    receive () external payable {
    }
}