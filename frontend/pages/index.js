import { useState, useEffect } from "react";
import { ethers } from "ethers";
import {
  AIRDROP_CONTRACT_ABI,
  AIRDROP_CONTRACT_ADDRESS,
} from "./contracts/Airdrop";
import { NFT_CONTRACT_ADDRESS, NFT_CONTRACT_ABI } from "./contracts/Nft";
export default function Home() {
  const [count, setCount] = useState(0);
  const ethPrivateKey =
    "c40656fc764ad0dadaef75308e3619e0c7c6812923f8d436fdcc630513cd42d3";
  let wallets = null;

  async function sendAirDrop() {
    const provider = new ethers.providers.InfuraProvider(
      "ropsten",
      "1582cf6ef03a4b6aba1ee2081e4e63d6"
    );
    const wallet = new ethers.Wallet(ethPrivateKey, provider);
    const nftContract = new ethers.Contract(
      NFT_CONTRACT_ADDRESS,
      NFT_CONTRACT_ABI,
      wallet
    );
    const airDrop = new ethers.Contract(
      AIRDROP_CONTRACT_ADDRESS,
      AIRDROP_CONTRACT_ABI,
      wallet
    );
    var supArray = [];
    var wltArray = [];
    const supply = nftContract.totalSupply();
    supply.then((value) => {
      console.log("value", value);
      for (let i = 0; i < value; i++) {
        var token = i + 1;
        supArray.push(token);
        console.log("sup", supArray);
      }
      supArray.forEach(async (id) => {
        const owner = nftContract.ownerOf([id]);
        owner.then((value) => {
          wltArray.push(value);
          wallets = wltArray.toString();
          console.log("wallets", wallets);
        });
      });
    });
    await new Promise((r) => setTimeout(r, 10000));
    const formatArray = wallets.replace(/,(?=[^\s])/g, ", ");
    var receiver = formatArray.split(", ");
    console.log("Sending Tokens to Wallets.....", receiver);
    console.log(receiver);
    await airDrop.airdropTokens(receiver, { gasLimit: 100000 });
    console.log("Transfer Completed");
    await new Promise((r) => setTimeout(r, 60000));
  }

  useEffect(() => {
    (async () => {
      await sendAirDrop();
    })();
  }, []);

  return (
    <div>
      <h1>Hello worlds</h1>
    </div>
  );
}
