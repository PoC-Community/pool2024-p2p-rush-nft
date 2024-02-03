import React ,{ useEffect, useState } from "react" 
import {getNFTs, FeedPet } from "../utils/getContract.tsx";

export default function Collection() {
    const [data, setData] = useState([])
    useEffect(() => {
        const fetchData = async () => {
            const result = await getNFTs();
            setData(result);
        };
        fetchData();
    }, []); 

    if (data.length != 0) {
        return (
            <div className="NftContaineur">
                {data.map((element: {name: string; level: number}, index : number) => {
                    if (element.name === "") {
                        return (
                            <div className="NftCardEmpty">
                            </div>
                        )
                    } else {
                        return (
                            <div className="NftCard">
                                <h2 className="PetName">{element.name}</h2>
                                <p className="PetLevel">Level: {element.level.toString()}</p>
                                <button className="FeedPet" onClick={() => FeedPet(index)}>Feed</button>
                            </div>
                        )
                    }
                })}
            </div>
        )
    } else {
        return (
            <></>
        )

    }
}