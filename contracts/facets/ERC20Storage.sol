// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ERC20Storage {

    struct Layout {
        string _name;
        string _symbol;
        uint8 _decimal;
        uint256 _totalSupply;

        mapping(address => uint256) _balances;
        mapping(address => mapping(address => uint256)) _allowances;

        address _owner;
    }

    bytes32 constant STORAGE_SLOT = keccak256(abi.encode(uint256(keccak256("ERC20.storage.ERC20")) - 1)) & ~bytes32(uint256(0xff));

    function layout() internal pure returns (Layout storage l) {
        bytes32 slot = STORAGE_SLOT;
        assembly {
            l.slot := slot
        }
    }
}