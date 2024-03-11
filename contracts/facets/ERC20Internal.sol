// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20Internal.sol";
import "./ERC20Storage.sol";

abstract contract ERC20Internal is IERC20Internal {
    using ERC20Storage for ERC20Storage.Layout;


    function _totalSupply() public view returns (uint256) {
        ERC20Storage.Layout storage l = ERC20Storage.layout();
        return l._totalSupply;
    }

    function _balanceOf(address account) public view returns (uint256) {
        ERC20Storage.Layout storage l = ERC20Storage.layout();
        return l._balances[account];
    }

    function _allowance(address owner, address spender) public view returns (uint256) {
        ERC20Storage.Layout storage l = ERC20Storage.layout();
        return l._allowances[owner][spender];
    }
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        ERC20Storage.Layout storage l = ERC20Storage.layout();
        uint256 fromBalance = l._balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            l._balances[from] = fromBalance - amount;
            l._balances[to] += amount;
        }

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        ERC20Storage.Layout storage l = ERC20Storage.layout();
        l._totalSupply += amount;
        unchecked {
            l._balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        ERC20Storage.Layout storage l = ERC20Storage.layout();
        uint256 accountBalance = l._balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            l._balances[account] = accountBalance - amount;
            l._totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        ERC20Storage.Layout storage l = ERC20Storage.layout();
        l._allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    function _setTokenDetails(string memory name, string memory symbol) internal virtual {
        ERC20Storage.Layout storage l = ERC20Storage.layout();
        l._name = name;
        l._symbol = symbol;
        
    }

    function _transferFrom(address sender, address recipient, uint256 amount) internal virtual returns (bool) {
        _transfer(sender, recipient, amount);
        uint256 currentAllowance = _allowance(sender, _msgSender());
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        _approve(sender, _msgSender(), currentAllowance - amount);
        return true;
    }

     // Helper function to get the caller of the function
     function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}