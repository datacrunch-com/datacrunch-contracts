// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface ICrunchStakingView {
    function totalStakedOf(address addr) external view returns (uint256);

    function totalRewardOf(address addr) external view returns (uint256);

    function contractBalance() external view returns (uint256);
}

contract CrunchStakingRewardViewer is Context, IERC20, IERC20Metadata {
    IERC20Metadata public crunch;
    ICrunchStakingView public staking;

    constructor(IERC20Metadata _crunch, ICrunchStakingView _staking) {
        crunch = _crunch;
        staking = _staking;

        /* make etherscan detect this contract as an ERC20 token */
        emit Transfer(address(0), address(0), 0);
    }

    function name() external pure override returns (string memory) {
        return "Crunch Staking Token";
    }

    function symbol() external pure override returns (string memory) {
        return "sCRUNCH";
    }

    function decimals() external view override returns (uint8) {
        return crunch.decimals();
    }

    function totalSupply() external view override returns (uint256) {
        return staking.contractBalance();
    }

    function balanceOf(address account)
        external
        view
        override
        returns (uint256)
    {
        uint256 staked = staking.totalStakedOf(account);
        uint256 reward = staking.totalRewardOf(account);

        return staked + reward;
    }

    function transfer(address, uint256)
        external
        override
        disabled
        returns (bool)
    {}

    function allowance(address, address)
        external
        pure
        override
        disabled
        returns (uint256)
    {}

    function approve(address, uint256)
        external
        override
        disabled
        returns (bool)
    {}

    function transferFrom(
        address,
        address,
        uint256
    ) external override disabled returns (bool) {}

    modifier disabled() {
        _;
        revert("not callable");
    }
}
