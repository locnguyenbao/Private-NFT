// scripts/deploy.js
async function main() {
  const [deployer] = await ethers.getSigners();
  
  console.log("Deploying contracts with the account:", deployer.address);

  const PrivateERC721Token = await ethers.getContractFactory("PrivateERC721Token");
  const privateERC721Token = await PrivateERC721Token.deploy();

  console.log("PrivateERC721Token deployed to:", privateERC721Token.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
      console.error(error);
      process.exit(1);
  });
