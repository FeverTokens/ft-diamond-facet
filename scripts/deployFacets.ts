import hre from "hardhat";
import { FacetCutAction, getSelectors } from "./libraries/diamond";

export async function deployFacets(contractOwner: string): Promise<any[]> {
    console.log("Deploying facets");
    const FacetNames = ["DiamondLoupeFacet", "OwnershipFacet", "ERC20Facet"];
    const cut: any[] = [];
    for (const FacetName of FacetNames) {
        const facet = await hre.viem.deployContract(FacetName, []);
        console.log(`${FacetName} deployed: ${facet.address}`);

        const selectors = getSelectors({ abi: facet.abi });
        cut.push({
            facetAddress: facet.address,
            action: FacetCutAction.Add,
            functionSelectors: selectors,
        });
    }
    return cut;
}