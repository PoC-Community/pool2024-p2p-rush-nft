import { getContract } from 'viem'
import {ContratAddress} from '../conf.tsx'
import { publicClient, walletClient } from './createWallet.tsx'
import {Abi} from './NftAbi.tsx'

export async function mint() {
    const [account] = await walletClient.requestAddresses();
    const { request } = await publicClient.simulateContract({
        address: ContratAddress,
        abi: Abi,
        functionName: 'mint',
        account,
        args: ["name"],
      })
      const hash = await walletClient.writeContract(request)
}

export async function FeedPet(index : number) {
    const [account] = await walletClient.requestAddresses();
    const { request } = await publicClient.simulateContract({
        address: ContratAddress,
        abi: Abi,
        functionName: 'feedMe',
        account,
        args: [index],
      })
      const hash = await walletClient.writeContract(request)
}

export async function getNFTs() {
    const data = await publicClient.readContract({
        address: ContratAddress,
        abi: Abi,
        functionName: 'getAllNFTs',
        args: []
      })
      return data
}

export async function getPet() {
    const data = await publicClient.readContract({
        address: ContratAddress,
        abi: Abi,
        functionName: 'getMyPet',
        args: [3]
    })
    return data;
}