// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DegenToken is ERC20 {

    string public tokenName = "DEGEN";
    string public tokenSymbol = "DGN";
    mapping (address => string[]) purchases;
    address public owner;


    constructor() ERC20(tokenName, tokenSymbol){
        _mint(msg.sender, 10000);
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Only the owner can mint tokens!");
        _;
    }

    function mintTokens(address _receiver, uint256 _tokens) public onlyOwner{
        require(_receiver != address(0), "This address isn't valid");
        require(_tokens > 0, "Negative token minting not allowed");
        _mint(_receiver, _tokens);
    }

    function buyItems() public pure returns(string memory) {
        return "1. CHOU SKIN [800 DGN] 2. AULUS SKIN [600 DGN] 3. LING SKIN [250 DGN] 4. MYTHICAL GLORY OUTFIT [175 DGN]";
    }

    function redeemTokens(uint _ch) external{
        require(_ch <= 4,"Option selected is incorrect!");

        if(_ch == 1){
            require(balanceOf(msg.sender)>=800, "Oops, Not enough tokens.");
            _burn(msg.sender, 800);
            purchases[msg.sender].push("CHOU SKIN");
        }

        else if(_ch ==2){
            require(balanceOf(msg.sender) >= 600, "Not enough tokens.");
            _burn(msg.sender, 600);
            purchases[msg.sender].push("AULUS SKIN");
        }

        else if(_ch == 3){
            require(balanceOf(msg.sender) >= 250, "Not enough tokens.");
            _burn(msg.sender, 250);
            purchases[msg.sender].push("LING SKIN");
        }

        else{
            require(balanceOf(msg.sender) >= 175, "Not enough tokens.");
            _burn(msg.sender, 175);
            purchases[msg.sender].push("MYTHICAL GLORY OUTFIT");
        }

    }

    function myPurchases() public view returns (string[] memory, uint256){
        uint256 length = purchases[msg.sender].length;
        require(length > 0, "No purchases for this address");
        return (purchases[msg.sender], length);
    }

    function transferTokens(address _reciever, uint _tokens) external{
        require(balanceOf(msg.sender) >= _tokens, "Insufficient balance in wallet.");
        transfer(_reciever, _tokens);
    }

    function checkTokenBalance() external view returns(uint){
        return balanceOf(msg.sender);
    }

    function burnTokens(uint _tokens) external{
        require(balanceOf(msg.sender)>= _tokens, "Insufficient tokens!");
        _burn(msg.sender, _tokens);
    }

}
