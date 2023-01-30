// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { IERC20 } from "@openzeppelin-contracts/token/ERC20/ERC20.sol";

interface ICryptoVault {
    function setUnderlying(address latestToken) external;

    function sweepToken(IERC20 token) external;

    function sweptTokensRecipient() external view returns (address);

    function underlying() external view returns (IERC20);
}
