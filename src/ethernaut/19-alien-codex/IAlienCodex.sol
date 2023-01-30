// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IAlienCodex {
    function make_contact() external;

    function record(bytes32 _content) external;

    function retract() external;

    function revise(uint256 i, bytes32 _content) external;

    function codex() external view returns (bytes32[] memory);

    function contact() external view returns (bool);

    /* *** OZ Ownable *** */

    function renounceOwnershop() external;

    function transferOwnership(address newOwner) external;

    function owner() external view returns (address);
}
