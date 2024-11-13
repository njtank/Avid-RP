import React, { useEffect, useRef, useState } from "react";
import './Houses.scss'
import '../../color_settings.scss'
import TitleBlock from "../../TitleBlock";
import { debugData } from "../../../utils/debugData";
import { fetchNui } from "../../../utils/fetchNui";
import { useNuiEvent } from "../../../hooks/useNuiEvent";
import { useLocaleState } from "../../../state/locale";
import { HousesList } from "../../../types/houses";
import { housesState, housesList } from "../../../state/houses";
import HouseData from "./current/house";

debugData([
    {
        action: 'setHousesList',
        data: [
            {
                label: 'Urzednicza 31',
                name: 'urzednicza_31',
                data: {
                    owned: true,
                    owner: 'Finn Atwater',
                },
                notes: [
                    {
                        id: 1,
                        date: 1903123,
                        reason: 'a',
                        officer: 'b',
                    },
                    {
                        id: 1,
                        date: 1903123,
                        reason: 'a',
                        officer: 'b',
                    },
                    {
                        id: 1,
                        date: 1903123,
                        reason: 'a',
                        officer: 'b',
                    },
                ]
            },
            {
                label: 'Urzednicza 32',
                name: 'urzednicza_32',
                notes: [
                    {
                        id: 1,
                        date: 1903123,
                        reason: 'a',
                        officer: 'b',
                    },
                    {
                        id: 1,
                        date: 1903123,
                        reason: 'a',
                        officer: 'b',
                    },
                    {
                        id: 1,
                        date: 1903123,
                        reason: 'a',
                        officer: 'b',
                    },
                ],
                data: {
                    owned: true,
                    owner: 'Finn Atwater',
                }
            },
            {
                label: 'Urzednicza 33',
                name: 'urzednicza_33',
                notes: [
                    {
                        id: 1,
                        date: 1903123,
                        reason: 'a',
                        officer: 'b',
                    },
                    {
                        id: 1,
                        date: 1903123,
                        reason: 'a',
                        officer: 'b',
                    },
                    {
                        id: 1,
                        date: 1903123,
                        reason: 'a',
                        officer: 'b',
                    },
                ],
                data: {
                    owned: true,
                    owner: 'Finn Atwater',
                }
            },
        ]
    }
])


const Houses: React.FC = () => {
    const Locale = useLocaleState()

    const atomHouses: HousesList[] = housesState()

    const [results, setResults] = useState<any[]>([])
    const [currentResult, setCurrentResult] = useState<any>(null)
    const search = useRef<HTMLInputElement>(null)
    const [searchCooldown, setCooldown] = useState<boolean>(false)
    
    function searchHouse(){
        if (searchCooldown) return;
        if (!search.current) return;
        const value: string = search.current.value
        if (value.length < 1) return;
        
        setResults([])
        setCooldown(true)
        setTimeout(() => {
            setCooldown(false)
        }, 2000)
        fetchNui("housesearch", {value})
    }

    useEffect(() => {
        
        const enterClicked = (event: KeyboardEvent) => {
            if (event.key !== 'Enter') return;
            if (document?.activeElement?.id !== 'searchhouse') return;
            searchHouse()
        }

        window.addEventListener('keyup', enterClicked)

        return () => window.removeEventListener('keyup', enterClicked)
    })

    useNuiEvent('searchHouseResults', (data) => {
        setCurrentResult(null)
        setResults(data)
    })

    const setData = async (houseLabel: string) => {
        const data = await fetchNui("setHouseData", {houseName: houseLabel})
        setCurrentResult(data)
    }

    const refreshData = () => {
        if (!currentResult) return;
        setData(currentResult.name)
    }

    React.useEffect(() => {
        const back = () => {
            const houses = document.getElementById("house_container")
            if (currentResult && currentResult.name && houses) {
                setCurrentResult(null)
            }
        }
        window.addEventListener('goBack', back)

        return () => window.removeEventListener('goBack', back)
    })

    
    

    return (
        <div className="houses-container" id="houses">
            <div className="houses">
                {currentResult === null && <>
                
                    <TitleBlock text={Locale['HOUSES']}/>
                    <div className="searcher">
                        <input placeholder={Locale['SEARCH_FOR_HOUSE']} id="searchhouse" ref={search}/>
                        <div className="search-button" onClick={searchHouse}>{Locale['SEARCH']}</div>
                    </div>
                    {results.length > 0 && 
                        <>
                            <TitleBlock text={Locale['HOUSE_SEARCH_FOR_HOUSE']}/>
                            <div className="results-container">
                                <div className="results-header">
                                    <span style={{width: "711px"}}>
                                        {Locale['HOUSE_LABEL'] || 'House label'}
                                    </span>
                                </div>

                                <div className="results-results">
                                    <table>
                                        {results.map((value, index) => (
                                            <tr key={index} className="results-row" onClick={() => setData(value.name)}>
                                                <td style={{width: "711px"}}>
                                                    <span>{value.label}</span>
                                                </td>
                                            </tr>
                                        ))}
                                    </table>
                                </div>
                            </div>
                            
                        </>
                    }

                </>}
                {currentResult && <HouseData data={currentResult} refresh={refreshData} />}
                
            </div>
        </div>
    )
}

export default Houses