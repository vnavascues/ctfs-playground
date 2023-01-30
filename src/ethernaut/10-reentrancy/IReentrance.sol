// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IReentrance {
    receive() external payable;

    function balances(address _address) external returns (uint256);

    function donate(address _to) external payable;

    function withdraw(uint256 _amount) external;

    function balanceOf(address _who) external view returns (uint256);
}
