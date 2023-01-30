// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IDexTwo {
    function setTokens(address _token1, address _token2) external;

    function addLiquidity(address token_address, uint256 amount) external;

    function swap(address from, address to, uint256 amount) external;

    function approve(address spender, uint256 amount) external;

    function balanceOf(address token, address account) external view returns (uint256);

    function getSwapPrice(address from, address to, uint256 amount) external view returns (uint256);

    function token1() external view returns (address);

    function token2() external view returns (address);

    /* *** OZ Ownable *** */

    function renounceOwnershop() external;

    function transferOwnership(address newOwner) external;

    function owner() external view returns (address);
}
