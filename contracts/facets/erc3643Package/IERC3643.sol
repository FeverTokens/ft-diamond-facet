// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "./IERC3643Internal.sol";

interface IERC3643 is IERC3643Internal {
    // Agent Management
    function addAgent(address _agent) external; // Adds an agent to the system
    function removeAgent(address _agent) external; // Removes an agent from the system
    function isAgent(address _agent) external view returns (bool); // Checks if an address is an agent
    // function setRecoveryAddress(address _newRecoveryAddress) external; // Sets the recovery address for an agent

    // Identity Verification
    function isVerified(address _userAddress) external view returns (bool); // Checks if a user's identity is verified

    // Token Transfers
    function transferERC3643Token(address _to, uint256 _amount) external ; // Transfers tokens to another address
    function forcedTransfer(address _from, address _to, uint256 _amount) external ; // Forced transfer of tokens from one address to another

    // // Token Management
    function mintERC3643(address _to, uint256 _amount) external; // Mints new tokens and assigns them to an address
    function burnERC3643(address _userAddress, uint256 _amount) external; // Burns tokens from an address
    function freezeTokens(address user, uint256 amount) external; // Freezes a specified amount of tokens for a user
    function unfreezeTokens(address user, uint256 amount) external; // Unfreezes a specified amount of tokens for a user
    function freezeWallet(address user) external; // Freezes the wallet of a user, preventing transfers
    function unfreezeWallet(address user) external; // Unfreezes the wallet of a user, allowing transfers

    // // Recovery System
    // // function recover(address _lostWallet, address _newWallet) external; // Recovers tokens from a lost wallet to a new wallet
    function recoverTokens(address lostWallet, address newWallet, uint256 amount) external; // Recovers a specific amount of tokens from a lost wallet to a new wallet
    function recoverTokensFromContract(address token, uint256 amount) external; // Recovers tokens from a contract to the owner

    // // Token Staking
    function stake(uint256 amount) external; // Stakes a specified amount of tokens
    function unstake(uint256 amount) external; // Unstakes a specified amount of tokens

    // // Token Selling and Swapping
    function sellTokens(uint256 amount) external; // Sells a specified amount of tokens
    function swapTokens(address token, uint256 amount) external; // Swaps tokens with another contract
}


