import hre from "hardhat";

async function main() {
    const TrustChain = await hre.ethers.deployContract("TrustChain");
    await TrustChain.waitForDeployment();

    console.log(`TrustChain deployed to: ${TrustChain.target}`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
