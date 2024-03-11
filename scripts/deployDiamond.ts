import hre from "hardhat";
import { readFileSync } from 'fs';
import { join } from 'path';
import { encodeFunctionData } from 'viem';


export async function deployDiamond( cut: any[]): Promise<void> {
    
    const accounts = await hre.viem.getWalletClients();
    const contractOwner = accounts[0].account.address;
    // deploy DiamondCutFacet
    const diamondCutFacet = await hre.viem.deployContract("DiamondCutFacet", []);
    console.log("DiamondCutFacet deployed:", diamondCutFacet.address);

    // deploy DiamondInit
    const diamondInit = await hre.viem.deployContract("DiamondInit", []);
    console.log("DiamondInit deployed:", diamondInit.address);

    // deploy Diamond and Mint using delegatecall in the Diamond.sol constructor
    const Diamond = await hre.viem.deployContract("Diamond", [
        contractOwner,
        diamondCutFacet.address,
        "Adams Cass",
        "YAS",
        cut[2].facetAddress, // Assuming this is the ERC20Facet address
        "0xe4476Ca098Fa209ea457c390BB24A8cfe90FCac4", // Replaced placeholder with actual value
    ]);
    console.log("Diamond deployed:", Diamond.address);

    // upgrade diamond with facets
    console.log("Diamond Cut:", cut);

    // Assuming you have the ABI for the IDiamondCut contract
    const artifactPath = join(__dirname, '../artifacts/contracts/IDiamondCut.sol/IDiamondCut.json');
    const artifact = JSON.parse(readFileSync(artifactPath, 'utf8'));
    const diamondCutAbi = artifact.abi;

    // Create a contract instance using the wallet client
    const walletClient = await hre.viem.getWalletClient(contractOwner);

    const functionCall = encodeFunctionData({
        abi: diamondInit.abi,
        functionName: "init",
    });

    // Upgrade diamond with facets using writeContract
    const diamondCutRequest = {
        address: Diamond.address,
        abi: diamondCutAbi,
        functionName: 'diamondCut',
        args: [cut, diamondInit.address, functionCall],
        account: contractOwner,
    };
    const diamondCutTxHash = await walletClient.writeContract(diamondCutRequest);
    console.log("Diamond cut tx: ", diamondCutTxHash);

    // Get the ERC20Facet contract instance using writeContract
    const erc20FacetRequest = {
        address: Diamond.address,
        abi: diamondCutAbi, // Assuming the ERC20Facet ABI is the same as the DiamondCut ABI
        functionName: 'ERC20Facet', 
        args: [],
        account: contractOwner,
    };
    const erc20FacetTxHash = await walletClient.writeContract(erc20FacetRequest);
    console.log("ERC20Facet contract instance tx: ", erc20FacetTxHash);
}