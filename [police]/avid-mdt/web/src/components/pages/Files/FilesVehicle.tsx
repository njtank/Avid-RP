import React, { useEffect, useRef, useState } from "react";
import './Files.scss'
import TitleBlock from "../../TitleBlock";
import { fetchNui } from "../../../utils/fetchNui";
import { isEnvBrowser } from "../../../utils/misc";
import { useNuiEvent } from "../../../hooks/useNuiEvent";
import VehicleData from "./current/vehicle";
import CitizenData from "./current/citizen";
import { useLocaleState } from "../../../state/locale";
import { debugData } from "../../../utils/debugData";


const FilesVehicle: React.FC = () => {
    const Locale = useLocaleState()

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
            type: 'vehicle'
        })
    }

    function searchVehicle(){
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
            type: 'vehicle'
        })
    }

    useEffect(() => {

        const enterClicked = (event: KeyboardEvent) => {
            if (event.key !== 'Enter') return;
            if (document?.activeElement?.id !== 'searchveh') return;
            searchVehicle()
        }

        window.addEventListener('keyup', enterClicked)

        return () => window.removeEventListener('keyup', enterClicked)
    })

    useNuiEvent('searchResults', ({info, type}) => {
        setCurrentResult(null)
        if(type == 'vehicle'){
            setResults(info)
        }
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
                
                    <TitleBlock text={Locale['FILES_SEARCHER'] + (Locale['FILES_SEARCH_FOR_CAR'])}/>
                    <div className="searcher">
                        <input placeholder={Locale['FILES_SEARCHER'] + (Locale['FILES_SEARCH_FOR_CAR']) + '...'} id="searchveh" ref={search}/>
                        <div className="closest" onClick={searchVehicle}>
                            {Locale['SEARCH'] || 'Search'}
                        </div>
                        
                        <div className="closest" onClick={() => searchClosest()}>
                            {Locale['FILES_NEAREST'] || 'Nearest'}
                        </div>
                    </div>
                    {results.length > 0 && 
                        <>
                            <TitleBlock text={Locale['FILES_SEARCH_FOR_CAR']}/>
                            <div className="results-container">
                                <div className="results-header">
                                    <span style={{width: "219px"}}>
                                        {Locale['FILES_MODEL'] || 'Model'}
                                    </span>
                                    <span style={{width: "223px"}}>
                                        {Locale['FILES_PLATE'] || 'Car plate'}
                                    </span>
                                    <span style={{width: "265px"}}>
                                        {Locale['FILES_OWNER'] || 'Owner'}
                                    </span>
                                </div>

                                <div className="results-results">
                                    <table>
                                        {results.map((value, index) => (

                                            <tr key={index} className="results-row" onClick={() => setData("vehicle", value.plate)}>
                                                <td style={{width: "219px"}}>
                                                    <span>{value.model}</span>
                                                </td>
                                                <td style={{width: "223px"}}>
                                                    <span>{value.plate}</span>
                                                </td>
                                                <td style={{width: "265px"}}>
                                                    <span>{value.owner}</span>
                                                </td>
                                            </tr>
                                        ))}
                                    </table>
                                </div>
                            </div>
                            
                        </>
                    }

                </>}
                {currentResult && <VehicleData data={currentResult} refresh={refreshData}/>}
                
            </div>
        </div>
    )
}

export default FilesVehicle