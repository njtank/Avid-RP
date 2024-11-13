import React, { useEffect, useRef, useState } from "react";
import './Files.scss'
import '../../color_settings.scss'
import TitleBlock from "../../TitleBlock";
import { fetchNui } from "../../../utils/fetchNui";
import { isEnvBrowser } from "../../../utils/misc";
import { useNuiEvent } from "../../../hooks/useNuiEvent";
import VehicleData from "./current/vehicle";
import CitizenData from "./current/citizen";
import { useLocaleState } from "../../../state/locale";
import { debugData } from "../../../utils/debugData";


const Files: React.FC = () => {
    // const [currentResult, setCurrentResult] = useState<any>({
    //     type: "vehicle",
    //     plate: "XYZ 1234",
    //     owner: {
    //         identifier: "wadjiawjdiawd",
    //         firstname: "John",
    //         lastname: "Wood"
    //     },
    //     subowner: {
    //         identifier: "wadjiawjdiawd",
    //         firstname: "John",
    //         lastname: "Wood"
    //     },
    //     model: "Blista",
    //     notes: [
    //         {
    //             time: 1677353352,
    //             note: "awdawdawdawd",
    //             officer: "[01] Chris Frog"
    //         },
    //         {
    //             time: 1677343352,
    //             note: "awdawdawdawd",
    //             officer: "[01] Chris Frog"
    //         },
    //     ]
    // })
    // const [currentResult, setCurrentResult] = useState<any>({
    //     type: "citizen",
    //     identifier: "chawidahiwdnaiwd",
    //     firstname: "John",
    //     lastname: "Wood",
    //     dateofbirth: "03/03/2005",
    //     avatar: null,
    //     sex: "M",
    //     licenses: {
    //         "drive_bike": true,
    //         "drive": false,
    //         "drive_truck": true,
    //         "weapon": false,
    //     },
    //     tags: {
    //         "dangerous": false,
    //         "wanted": true
    //     },
    //     fines: [
    //         {
    //             reason: "Przejazd na czerwonym świetle",
    //             fine: 1500,
    //             date: 1677343352,
    //             officer: "[02] Moj stary"
    //         }
    //     ],
    //     jails: [
    //         {
    //             reason: "Posiadanie broni bez licencji",
    //             fine: 15000,
    //             jail: 150,
    //             date: 1677343352,
    //             officer: "[02] Moj stary"
    //         }
    //     ],
    //     notes: [
    //         {
    //             id: 2,
    //             reason: "poszukiwany za handel narkotykami",
    //             date: 1677343352,
    //             officer: "[01] Michael Birch"
    //         },
    //     ],
    //     vehicles: [
    //         {
    //             model: "blista",
    //             plate: "XYZ 1234",
    //             status: "Poszukiwany"
    //         }
    //     ]
    // })

    const Locale = useLocaleState()

    const [isCitizen, setIsCitizen] = useState<boolean>(true)
    const [results, setResults] = useState<any[]>([])
    const [currentResult, setCurrentResult] = useState<any>(null)
    const search = useRef<HTMLInputElement>(null)
    const [searchCooldown, setCooldown] = useState<boolean>(false)

    const searchClosest = () => {
        if (searchCooldown) return;
        setResults([])
        setCooldown(true)
        setTimeout(() => {
            setCooldown(false)
        }, 2000)

        fetchNui("search", {
            value: null,
            type: isCitizen === true ? "citizen" : "vehicle"
        })
    }


    function searchButton(){
        if (searchCooldown) return;
        if (!search.current) return;
        const value: string = search.current.value
        if (value.length < 1) return;
        setResults([])
        setCooldown(true)
        setTimeout(() => {
            setCooldown(false)
        }, 2000)
        fetchNui("search", {
            value,
            type: isCitizen === true ? "citizen" : "vehicle"
        })
    }

    useEffect(() => {

        const enterClicked = (event: KeyboardEvent) => {
            if (event.key !== 'Enter') return;
            if (document?.activeElement?.id !== 'search') return;
            searchButton()
        }

        window.addEventListener('keyup', enterClicked)

        return () => window.removeEventListener('keyup', enterClicked)
    }, [isCitizen])

    useNuiEvent('searchResults', (data) => {
        setCurrentResult(null)
        setResults(data)
    })

    const setData = async (t: string, identifier: string) => {
        const data = await fetchNui("setData", {type: t, identifier: identifier})
        setCurrentResult(data)
    }

    const refreshData = () => {
        if (!currentResult) return;
        setData(currentResult.type, currentResult.identifier || currentResult.plate)
    }

    React.useEffect(() => {
        const back = () => {
            const tariff = document.getElementById("tariff")
            if (currentResult && currentResult.type && !tariff) {
                setCurrentResult(null)
            }
        }
        window.addEventListener('goBack', back)

        return () => window.removeEventListener('goBack', back)
    })

    

    return (
        <div className="files-container" style={{padding: (currentResult && currentResult.type == "citizen") && "0 36px"}}>
            <div className="files" style={{width: (currentResult && currentResult.type == "citizen") && "1004px"}}>
                {currentResult === null && <>
                
                    <TitleBlock text={Locale['FILES_SEARCHER'] + (isCitizen ? Locale['FILES_SEARCH_FOR_CITIZEN'] : Locale['FILES_SEARCH_FOR_CAR'])}/>
                    <div className="searcher">
                        <input placeholder={Locale['FILES_SEARCHER'] + (isCitizen ? Locale['FILES_SEARCH_FOR_CITIZEN'] : Locale['FILES_SEARCH_FOR_CAR']) + '...'} id="search" ref={search}/>
                        <div className="closest" onClick={searchButton}>
                            {Locale['SEARCH'] || 'Search'}
                        </div>
                        <div className="closest" onClick={() => searchClosest()}>
                            {Locale['FILES_NEAREST'] || 'Nearest'}
                        </div>
                        <div className={"citizen-vehicle " + (isCitizen && 'citizen')} onClick={() => {setIsCitizen(!isCitizen); if (search.current) search.current.value = ""; setResults([]); setCurrentResult(null)}}>
                            <div className="in">
                                {isCitizen ? Locale['FILES_SEARCH_FOR_CITIZEN'] : Locale['FILES_SEARCH_FOR_CAR']}
                            </div>
                        </div>
                    </div>
                    {results.length > 0 && 
                        <>
                            <TitleBlock text={isCitizen ? Locale['FILES_SEARCH_FOR_CITIZEN'] : Locale['FILES_SEARCH_FOR_CAR']}/>
                            <div className="results-container">
                                <div className="results-header">
                                    {isCitizen &&
                                        <>
                                            <span style={{width: "446px"}}>
                                                {Locale['FILES_NAME'] || 'Citizen fullname'}
                                            </span>
                                            <span style={{width: "265px"}}>
                                                {Locale['FILES_BIRTH'] || 'Citizen birthdate'}
                                            </span>
                                        </>
                                    }
                                    {!isCitizen &&
                                        <>
                                            <span style={{width: "219px"}}>
                                                {Locale['FILES_MODEL'] || 'Model'}
                                            </span>
                                            <span style={{width: "223px"}}>
                                                {Locale['FILES_PLATE'] || 'Car plate'}
                                            </span>
                                            <span style={{width: "265px"}}>
                                                {Locale['FILES_OWNER'] || 'Owner'}
                                            </span>
                                        </>
                                    }
                                </div>

                                <div className="results-results">
                                    <table>
                                        {results.map((value, index) => (
                                            <tr key={index} className="results-row" onClick={() => setData(isCitizen ? "citizen" : "vehicle", isCitizen ? value.identifier : value.plate)}>
                                                {isCitizen && <>
                                                    <td style={{width: "446px"}}>
                                                        <span>{value.firstname + " " + value.lastname}</span>
                                                    </td>
                                                    <td style={{width: "265px"}}>
                                                        <span>{value.dateofbirth}</span>
                                                    </td>
                                                </>}
                                                {!isCitizen && <>
                                                    <td style={{width: "219px"}}>
                                                        <span>{value.model}</span>
                                                    </td>
                                                    <td style={{width: "223px"}}>
                                                        <span>{value.plate}</span>
                                                    </td>
                                                    <td style={{width: "265px"}}>
                                                        <span>{value.owner}</span>
                                                    </td>
                                                </>}
                                            </tr>
                                        ))}
                                    </table>
                                </div>
                            </div>
                            
                        </>
                    }

                </>}
                {(currentResult && currentResult.type == "vehicle") && <VehicleData data={currentResult} refresh={refreshData}/>}
                {(currentResult && currentResult.type == "citizen") && <CitizenData data={currentResult} refresh={refreshData}/>}
                
            </div>
        </div>
    )
}

export default Files