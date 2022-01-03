// SPDX-License-Identifier: MIT

// https://polygonscan.com/tx/0x9ec416b3c2cb5b4a7aa00e84cb0965781cd980e399d43f9fa7cecf97cc4000bb

pragma solidity ^0.8.2;

import "@openzeppelin/contracts-upgradeable@4.4.1/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.4.1/token/ERC20/extensions/ERC20SnapshotUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.4.1/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.4.1/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.4.1/token/ERC20/extensions/draft-ERC20PermitUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.4.1/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable@4.4.1/proxy/utils/UUPSUpgradeable.sol";

contract WenDAO is Initializable, ERC20Upgradeable, ERC20SnapshotUpgradeable, OwnableUpgradeable, PausableUpgradeable, ERC20PermitUpgradeable, UUPSUpgradeable {
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

    function initialize() initializer public {
        __ERC20_init("wenDAO", "wen");
        __ERC20Snapshot_init();
        __Ownable_init();
        __Pausable_init();
        __ERC20Permit_init("wenDAO");
        __UUPSUpgradeable_init();

        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function snapshot() public onlyOwner {
        _snapshot();
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override(ERC20Upgradeable, ERC20SnapshotUpgradeable)
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}
}
