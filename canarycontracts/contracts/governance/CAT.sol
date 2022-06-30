// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract CAT is ERC20Votes {
  address canary;
  constructor(address _canary) ERC20("CanaryToken", "CAT") ERC20Permit("CanaryToken") {
    canary = _canary;
  }

  // The functions below are overrides required by Solidity.

  function _afterTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal override(ERC20Votes) {
    super._afterTokenTransfer(from, to, amount);
  }

  function mint(address _platform, uint256 _amount) external{
    require(msg.sender == canary, "only canary protocol");
    _mint(_platform, _amount);
  }

  function burn(address _platform, uint256 _amount) external{
    require(msg.sender == canary, "only canary protocol");
    _burn(_platform, _amount);
  }

  function _mint(address to, uint256 amount) internal override(ERC20Votes) {
    super._mint(to, amount);
  }

  function _burn(address account, uint256 amount) internal override(ERC20Votes) {
    super._burn(account, amount);
  }
}