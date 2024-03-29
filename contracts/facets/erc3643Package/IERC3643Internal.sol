// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface IERC3643Internal {
    // Enums
    enum AgentRole { Owner, Agent }

    // Structs
    struct Agent {
        address addr;
        AgentRole role;
    }

    struct ComplianceCheck {
        bool isCompliant;
        string reason;
    }

    // Events
    event AgentAdded(address indexed _agent, AgentRole indexed _role);
    event AgentRemoved(address indexed _agent, AgentRole indexed _role);
    event TransferERC3643(address indexed from, address indexed to, uint256 value);
    event TokensFrozen(address indexed user, uint256 amount);
    event TokensUnfrozen(address indexed user, uint256 amount);
    event WalletFrozen(address indexed user);
    event WalletUnfrozen(address indexed user);
    
    
}