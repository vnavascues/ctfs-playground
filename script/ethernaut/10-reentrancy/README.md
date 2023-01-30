# 10 - Re-entrancy

Level address: `0x573eAaf1C1c2521e671534FAA525fAAf0894eCEb`

Instance address: `0xcBd8220bD38389C7c456B1AbA801CAdB6Bd5BbB6`

ReentranceAttacker address: `0x9942399E0E6A911E8D198b23aCAb1BC7061f3671`

```sh
forge script \
script/ethernaut/10-reentrancy/Reentrance.s.sol \
--fork-url goerli \
-vvvv
```

```sh
forge script \
script/ethernaut/10-reentrancy/Reentrance.s.sol \
--rpc-url goerli \
--broadcast \
-vvvv
```

Initial state:

- 0.009 ether in the contract
