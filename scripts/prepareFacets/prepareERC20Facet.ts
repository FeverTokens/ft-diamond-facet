import hre from "hardhat";
import { FacetCutAction, getSelectors } from "../libraries/diamond";

export async function prepareERC20Facet(contractOwner: string): Promise<any> {
    console.log("Deploying ERC20Facet");
    const facet = await hre.viem.deployContract("ERC20Facet", []);
    console.log(`ERC20Facet deployed: ${facet.address}`);

    const selectors = getSelectors({ abi: facet.abi });
    const cut = {
        action: FacetCutAction.Add,
        facetAddress: facet.address,
        functionSelectors: selectors,
    };
    return cut;
}