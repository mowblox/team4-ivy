import Image from 'next/image'
import { Inter } from 'next/font/google'
import { useMetaMask } from "metamask-react";
import { ethers } from 'ethers';
import ABI from '../donate.json';


const inter = Inter({ subsets: ['latin'] })

export default function Home() {
  const { status, connect, account, chainId, ethereum } = useMetaMask();
  return (
  
    <main
className={`flex min-h-screen flex-col items-center justify-between p-24 ${inter.className}`}
>
{status === "notConnected" && <button onClick={connect}>Connect to MetaMask</button>}
{status === "connecting" && <p>Connecting...</p>}
{status === "connected" && (<h3>You are connected!</h3>)}
{status === "connected" && <form className="flex flex-col gap-4">
<h1>Create Organisation</h1>
<input className="border border-black p-1" type="text" placeholder="Organisation Name" />
<input className="border border-black p-1" type="textarea" placeholder="Organisation Description" />
<input className="border border-black p-1" type="number" placeholder="Donation goal" />
<button>Save</button>
</form>}

</main>
  )
}
