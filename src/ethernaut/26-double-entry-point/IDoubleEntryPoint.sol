// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { IERC20 } from "@openzeppelin-contracts/token/ERC20/ERC20.sol";
import { DelegateERC20 as IDelegateERC20, Forta } from "ethernaut/26-double-entry-point/DoubleEntryPoint.sol";

interface IDoubleEntryPoint is IDelegateERC20, IERC20 {
    function cryptoVault() external view returns (address);

    function delegatedFrom() external view returns (address);

    function forta() external view returns (Forta);

    function player() external view returns (address);

    /* *** OZ Ownable *** */

    function renounceOwnershop() external;

    function transferOwnership(address newOwner) external;

    function owner() external view returns (address);
}
