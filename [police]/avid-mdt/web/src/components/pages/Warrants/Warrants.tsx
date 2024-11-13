import React, { useEffect, useRef, useState } from "react";
import './Warrants.scss'
import '../../color_settings.scss'
import TitleBlock from "../../TitleBlock";
import { fetchNui } from "../../../utils/fetchNui";
import { useNuiEvent } from "../../../hooks/useNuiEvent";
import { useLocaleState } from "../../../state/locale";
import { debugData } from "../../../utils/debugData";
import { useWarrantState } from "../../../state/warrants";
import { Warrant } from "../../../types/warrants";
import CreateWarrant from "./create/create_warrant";
import WarrantData from "./current/warrant";

debugData([
    {
        action: 'setWarrants',
        data: [
            {
                id: 1,
                title: 'XD',
                subtitle: 'XD',
                creator: 'XD',
                citizen_involved: [],
                cop_involved: [],
                images: [],
            },
            {
                id: 2,
                title: 'XD',
                subtitle: 'XD',
                creator: 'XD',
                citizen_involved: [],
                cop_involved: [],
                images: [],
            },
            {
                id: 3,
                title: 'XD',
                subtitle: 'XD',
                creator: 'XD',
                citizen_involved: [],
                cop_involved: [],
                images: [],
            },
        ]
    }
])

const Warrants: React.FC = () => {
    const Locale = useLocaleState()

    const [results, setResults] = useState<any[]>([])
    const [currentResult, setCurrentResult] = useState<any>(null)
    const search = useRef<HTMLInputElement>(null)
    const [searchCooldown, setCooldown] = useState<boolean>(false)
    const [creatingWarrant, setCreatingWarrant] = useState<boolean>(false)

    const warrant: Warrant[] = useWarrantState()
    var href = document.getElementById('second_href') as HTMLSpanElement
    
    function searchWarrant(){
        if (searchCooldown) return;
        if (!search.current) return;
        const value: string = search.current.value
        if (value.length < 1) {setResults([]); return}

        
        setCooldown(true)
        setTimeout(() => {
            setCooldown(false)
        }, 2000)
        console.log('?')
        fetchNui("searchWarrants", {value})
    }
    
    useEffect(() => {
        const enterClicked = (event: KeyboardEvent) => {
            if (event.key !== 'Enter') return;
            if (document?.activeElement?.id !== 'searchwarrant') return;
            searchWarrant()
        }

        window.addEventListener('keyup', enterClicked)
        return () => window.removeEventListener('keyup', enterClicked)
    })

    useNuiEvent('warrantSearchResults', (data) => {
        setCurrentResult(null)
        setResults(data)
        href.textContent = ''
    })

    useNuiEvent('closeWarrant', () => {
        setCurrentResult(null)
    })


    const setData = async (id: number) => {
        const data = await fetchNui("setWarrantData", id)
        setCurrentResult(data)
    }

    // TODO
    const refreshData = () => {
        if (!currentResult) { fetchNui("updateWarrants"); setCreatingWarrant(false);  } else setData(currentResult.id)
        href.textContent = ''
    }

    React.useEffect(() => {
        const back = () => {
            const cWarrant = document.getElementById("createwarrant")
            const sWarrant = document.getElementById("warrantshower")
            if (creatingWarrant && cWarrant) {
                setCreatingWarrant(false)
                href.textContent = ''
            } else if(currentResult && currentResult.id && sWarrant){
                setCurrentResult(null)
                href.textContent = ''
            }
        }
        window.addEventListener('goBack', back)

        return () => window.removeEventListener('goBack', back)
    })


    return (
        <div className="files-container">
            <div className="files">
                {currentResult === null && <>
                    {!creatingWarrant && 
                        <>
                            <TitleBlock text={Locale['WARRANTS']}/>
                            <div className="searcher">
                                <input placeholder={Locale['SEARCH_FOR_WARRANTS']} id="searchwarrant" ref={search}/>
                                <div className="search-button" onClick={searchWarrant}>{Locale['SEARCH']}</div>
                                <div className="create-button" onClick={() => {setCreatingWarrant(true); href.textContent = 'create'}}>{Locale['CREATE_WARRANT']}</div>
                            </div>
                            {results && results.length > 0 && 
                                <>
                                    <TitleBlock text={Locale['WARRANTS_SEARCHED_DATA']}/>
                                    <div className="results-container">
                                        <div className="results-header">
                                            <span style={{width: "446px"}}>
                                                {Locale['WARRANT_TITLE'] || 'Title'}
                                            </span>
                                            <span style={{width: "265px"}}>
                                                {Locale['WARRANT_CREATOR'] || 'Creator'}
                                            </span>
                                        </div>

                                        <div className="results-results">
                                            <table>
                                                {results.map((value, index) => (
                                                    <tr key={index} className="results-row" onClick={() => setData(value.id)}>
                                                        <td style={{width: "446px"}}>
                                                            <span>{value.title}</span>
                                                        </td>
                                                        <td style={{width: "265px"}}>
                                                            <span>{value.creator}</span>
                                                        </td>
                                                    </tr>
                                                ))}
                                            </table>
                                        </div>
                                    </div>
                                    
                                </>
                            }
                        </>
                    }

                    {creatingWarrant && <CreateWarrant refresh={refreshData}/>}
                </>}

                {(currentResult && !creatingWarrant) && <WarrantData data={currentResult} refresh={refreshData} />}
            </div>
        </div>
    )
}

export default Warrants