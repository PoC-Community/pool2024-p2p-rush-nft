import {formatEther} from 'viem';
import {walletClient, publicClient} from './utils/createWallet'
import {mint} from './utils/getContract'
import 'viem/window';

export let Account = '';
export let Balance = '';

const connect = async () => {
    if (walletClient) {
        const [address] = await walletClient.requestAddresses();

        Account = address;
    }
    if (publicClient) {
        const balance = await publicClient.getBalance({ 
            address: '0xB9B2f6Ee02F444c1ed96A5757393FE8e341687A9',
        })
        Balance = formatEther(balance);
    }
};
