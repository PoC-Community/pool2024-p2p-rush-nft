import React from "react";
import { mint, getNFTs, getPet } from "../utils/getContract.tsx";
import Collection from "../Component/Collection.tsx";

export default function Home()
{
    return (
    <div id="home">
        <h1>Home</h1>
        <button onClick={() => mint()}>Create Pet</button>
        <button onClick={() => getNFTs()}>get Pets</button>
        <button onClick={() => getPet()}>get Pet</button>
        <Collection />
    </div>
    )
}