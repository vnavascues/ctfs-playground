// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Privacy {
    // NB: added comments with slots
    bool public locked = true; // slot 0: 0:7
    uint256 public ID = block.timestamp; // slot 1
    uint8 private flattening = 10; // slot 2: 0:7
    uint8 private denomination = 255; // slot 2: 8:15
    uint16 private awkwardness = uint16(block.timestamp); // slot 2: 16:31
    bytes32[3] private data; // slot 3, 4 & 5

    constructor(bytes32[3] memory _data) {
        data = _data;
    }

    function unlock(bytes16 _key) public {
        require(_key == bytes16(data[2]));
        locked = false;
    }

    /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
    */
}
