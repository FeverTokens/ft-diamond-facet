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
    event TransferComplianceCheck(address indexed _from, address indexed _to, uint256 _amount, bool _isCompliant);
    event RecoveryAddressSet(address indexed _agent, address indexed _newRecoveryAddress);
    event RecoveryInitiated(address indexed _lostWallet, address indexed _newWallet);
    event TransferERC3643(address indexed from, address indexed to, uint256 value);
    event TokensFrozen(address indexed user, uint256 amount);
    event TokensUnfrozen(address indexed user, uint256 amount);
    event WalletFrozen(address indexed user);
    event WalletUnfrozen(address indexed user);
    event TokensRecovered(address indexed lostWallet, address indexed newWallet, uint256 amount);
    event TokenRecovered(address indexed token, address indexed recipient, uint256 amount);
    event TokenStaked(address indexed user, uint256 amount);
    event TokenUnstaked(address indexed user, uint256 amount);
    event TokenSold(address indexed seller, uint256 amount);
    event TokenSwapped(address indexed user, uint256 amount);
    
    // Functions
    // function addAgent(address agent) external;
    // function removeAgent(address agent) external;
    // function freezeTokens(address user, uint256 amount) external;
    // function unfreezeTokens(address user, uint256 amount) external;
    // function freezeWallet(address user) external;
    // function unfreezeWallet(address user) external;
    // function transfer(address recipient, uint256 amount) external returns (bool);
    // function batchTransfer(address[] calldata recipients, uint256[] calldata amounts) external;
    // function recoverTokens(address lostWallet, address newWallet, uint256 amount) external;
    // function recoverTokens(address token, uint256 amount) external;
    // function stake(uint256 amount) external;
    // function unstake(uint256 amount) external;
    // function sellTokens(uint256 amount) external;
    // function swapTokens(address token, uint256 amount) external;
}