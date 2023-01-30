// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IPuzzleWallet {
    /* *** Upgradeable Proxy *** */

    function proposeNewAdmin(address _newAdmin) external;

    function approveNewAdmin(address _expectedAdmin) external;

    function upgradeTo(address _newImplementation) external;

    function pendingAdmin() external view returns (address);

    function admin() external view returns (address);

    /* *** Implementation *** */

    function execute(address to, uint256 value, bytes calldata data) external payable;

    function multicall(bytes[] calldata data) external payable;

    function addToWhitelist(address addr) external;

    function deposit() external payable;

    function init(uint256 _maxBalance) external;

    function setMaxBalance(uint256 _maxBalance) external;

    function balances(address _addr) external view returns (uint256);

    function maxBalance() external view returns (uint256);

    function owner() external view returns (address);

    function whitelisted(address _addr) external view returns (bool);
}
