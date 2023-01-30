## 20. Denial

Level address: `0xD0a78dB26AA59694f5Cb536B50ef2fa00155C488`

Instance address: `0xBde13de7d1E2A93b21C7CA210b0D3c91703E9980`

```sh
forge script \
script/ethernaut/20-denial/Denial.s.sol \
--fork-url goerli \
-vvvv
```

```sh
forge script \
script/ethernaut/20-denial/Denial.s.sol \
--rpc-url goerli \
--broadcast \
-vvvv
```

Initial state:

- `contractBalance()`: `1000000000000000` -> 0.001 ether
- `partner()`: `0x0000000000000000000000000000000000000000` (Zero address)
- `owner()`: `0x0000000000000000000000000000000000000A9e`
