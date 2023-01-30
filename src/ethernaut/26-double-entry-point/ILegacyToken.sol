// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { IERC20 } from "@openzeppelin-contracts/token/ERC20/ERC20.sol";
import { DelegateERC20 as IDelegateERC20 } from "ethernaut/26-double-entry-point/DoubleEntryPoint.sol";

interface ILegacyToken is IERC20 {
    function delegateToNewContract(IDelegateERC20 newContract) external;

    function delegate() external view returns (IDelegateERC20);

    /* *** OZ Ownable *** */

    function renounceOwnershop() external;

    function transferOwnership(address newOwner) external;

    function owner() external view returns (address);
}
