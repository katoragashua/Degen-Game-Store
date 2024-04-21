import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const LockModule = buildModule("LockModule", (m) => {

  const degenToken = m.contract("DegenToken");

  return { degenToken };
});

export default LockModule;
