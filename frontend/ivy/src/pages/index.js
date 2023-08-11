import Image from 'next/image'
import { Inter } from 'next/font/google'
import { useMetaMask } from "metamask-react";
import { ethers } from 'ethers';
import ABI from '../donate.json';
import { useEffect, useState } from 'react';



const inter = Inter({ subsets: ['latin'] })
const CONTRACT_ADDRESS = "0x51D59B6A41000cE33B08715B6dc004722b1e6F47"
const donateContract = new ethers.Contract(CONTRACT_ADDRESS, ABI);


<div style={{ backgroundImage: "https://gencraft.ai/p/BxFMi2" }}>

</div>

export default function Home() {
  const { status, connect, account, chainId, ethereum } = useMetaMask();
  const [name, setName] = useState('');
  const [about, setAbout] = useState('');
  const [goalAmount, setGoalAmount] = useState(0);
  useEffect(() => {
    console.log('status:', status)
  }, [status])
  const handleCreateOrg = async (e) => {
    e.preventDefault();
    const provider = new ethers.BrowserProvider(ethereum);
    const signer = await provider.getSigner();
    donateContract.connect(signer).createOrganization(name, about, goalAmount);
  }
  const handleMakeDon = async (e) => {
    e.preventDefault();
    const provider = new ethers.BrowserProvider(ethereum);
    const signer = await provider.getSigner();
    donateContract.connect(signer).makeDonation;
  }
  return (

    <main
      className={`flex min-h-screen flex-col items-center gap-10 p-24 ${inter.className}`}
    >
      {status === "notConnected" && <button onClick={connect}>Connect to MetaMask</button>}
      {status === "connecting" && <p>Connecting...</p>}
      {status === "connected" && (<h3>You are connected!</h3>)}
      {status === "connected" && <form className="flex flex-col gap-4">
        <h1>Create Organisation</h1>
        <input className="border border-black p-1" type="text" placeholder="Organisation Name" onChange={(e) => setName(e.target.value)} />
        <input className="border border-black p-1" type="textarea" placeholder="Organisation Description" onChange={(e) => setAbout(e.target.value)} />
        <input className="border border-black p-1" type="number" placeholder="Donation goal" onChange={(e) => setGoalAmount(e.target.value)} />
        <button className="bg-blue color-blue justify-center" onClick={handleCreateOrg}>Save</button>
        
      </form>}

    </main>
  )
}   
