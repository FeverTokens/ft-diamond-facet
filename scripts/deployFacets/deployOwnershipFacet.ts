import hre from "hardhat";
import { FacetCutAction, getSelectors } from "../libraries/diamond";

export async function deployOwnershipFacet(contractOwner: string): Promise<any> {
    console.log("Deploying OwnershipFacet");
    const facet = await hre.viem.deployContract("OwnershipFacet", []);
    console.log(`OwnershipFacet deployed: ${facet.address}`);

    const selectors = getSelectors({ abi: facet.abi });
    const cut = {
        action: FacetCutAction.Add,
        facetAddress: facet.address,
        functionSelectors: selectors,
    };
    return cut;
}