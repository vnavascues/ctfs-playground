// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IInstance {
    function authenticate(string memory passkey) external;

    function getCleared() external view returns (bool);

    function infoNum() external view returns (uint8);

    function password() external view returns (string memory);

    function theMethodName() external view returns (string memory);

    function info() external pure returns (string memory);

    function info1() external pure returns (string memory);

    function info2(string memory param) external pure returns (string memory);

    function info42() external pure returns (string memory);

    function method7123949() external pure returns (string memory);
}
