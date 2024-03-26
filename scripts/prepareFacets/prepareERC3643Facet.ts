import hre from "hardhat";
import { FacetCutAction, getSelectors } from "../libraries/diamond";

export async function prepareERC3643Facet(contractOwner: string): Promise<any> {
    console.log("Deploying ERC3643Facet");
    const facet = await hre.viem.deployContract("ERC3643Facet", []);
    console.log(`ERC3643Facet deployed: ${facet.address}`);

    const selectors = getSelectors({ abi: facet.abi });
    // const cut = {
    //     action: FacetCutAction.Add,
    //     facetAddress: facet.address,
    //     functionSelectors: selectors,
    // };
    return {
        action: FacetCutAction.Add,
        facetAddress: facet.address, 
        functionSelectors: selectors, 
    };
}