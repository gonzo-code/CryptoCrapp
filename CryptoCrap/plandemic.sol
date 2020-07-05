pragma solidity ^0.4.16;

contract Unstoppable {
    uint256 public postPrice;
    struct UnstoppableStatus {
        address author;
        string description;

    }

    //Admin piece/////////////////////////////////////////////////////////
    address constant public boss = 0xDA18eA91417845a89A51973Df41Fd221A294630d;
    //////////////////////////////////////////////////////////////////////
    mapping (address => UnstoppableStatus) private statuses;
    event Log(address author, string text);



    function setPrice(uint256 _postPrice) public {
        require(msg.sender == boss);
        postPrice = _postPrice;
    }

    function setMyStatus (string text) public payable{
        require(msg.value == postPrice,"Amount should be equal to 1 Ether");
        statuses[msg.sender] = UnstoppableStatus(msg.sender, text);
        emit Log(msg.sender, text);
    }

    function getFriendStatus (address friend) public view returns (string) {
        return statuses[friend].description;
    }

    function endSale() public {
        require(msg.sender == boss);
        boss.transfer(address(this).balance);
    }
}
