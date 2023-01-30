// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface ISimpleToken {
    // collect ether in return for tokens
    receive() external payable;

    // allow transfers of tokens
    function transfer(address _to, uint256 _amount) external;

    // clean up after ourselves
    function destroy(address payable _to) external;

    function balances(address _address) external view returns (uint256);

    function name() external view returns (string memory);
}
