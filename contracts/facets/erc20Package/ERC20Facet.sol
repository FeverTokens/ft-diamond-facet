// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "./IERC20.sol";
import "./ERC20Internal.sol";

contract ERC20Facet is IERC20, ERC20Internal {

    function initialize(string memory tokenName, string memory tokenSymbol) public {
        // Set token details
        ERC20Internal._setTokenDetails(tokenName, tokenSymbol);
        // Mint tokens
        // ERC20Internal._mint(contractOwner, tokenSupply);
    }

    function totalSupply() public view override returns (uint256) {
        return ERC20Internal._totalSupply();
    }

    function balanceOf(address account) public view override returns (uint256) {
        return ERC20Internal._balanceOf(account);
    }

    function transferERC20(address to, uint256 amount) public override returns (bool) {
        ERC20Internal._transferERC20(msg.sender, to, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return ERC20Internal._allowance(owner, spender);
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        ERC20Internal._approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        ERC20Internal._transferERC20(from, to, amount);
        ERC20Internal._approve(from, msg.sender, ERC20Internal._allowance(from, msg.sender) - amount);
        return true;
    }

    function mintERC20(address account, uint256 amount) public {
        ERC20Internal._mintERC20(account, amount);
    }


    
}