import React, { useEffect, useRef, useState } from "react";
import './Evidences.scss'
import '../../color_settings.scss'
import TitleBlock from "../../TitleBlock";
import { fetchNui } from "../../../utils/fetchNui";
import { useNuiEvent } from "../../../hooks/useNuiEvent";
import { useLocaleState } from "../../../state/locale";
import { debugData } from "../../../utils/debugData";
import { Evidence } from "../../../types/evidences";
import CreateEvidence from "./create/create_evidence";
import EvidenceData from "./current/evidence";
import { useEvidencesState } from "../../../state/evidences";

debugData([
    {
        action: 'setEvidences',
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

const Evidences: React.FC = () => {
    const Locale = useLocaleState()

    const [results, setResults] = useState<any[]>([])
    const [currentResult, setCurrentResult] = useState<any>(null)
    const search = useRef<HTMLInputElement>(null)
    const [searchCooldown, setCooldown] = useState<boolean>(false)
    const [creatingEvidence, setCreatingEvidence] = useState<boolean>(false)

    const evidence: Evidence[] = useEvidencesState()
    var href = document.getElementById('second_href') as HTMLSpanElement
    
    function searchEvidence(){
        if (searchCooldown) return;
        if (!search.current) return;
        const value: string = search.current.value
        if (value.length < 1) {setResults([]); return}

        
        setCooldown(true)
        setTimeout(() => {
            setCooldown(false)
        }, 2000)
        fetchNui("searchEvidences", {value})
    }
    
    useEffect(() => {
        const enterClicked = (event: KeyboardEvent) => {
            if (event.key !== 'Enter') return;
            if (document?.activeElement?.id !== 'searchevidence') return;
            searchEvidence()
        }

        window.addEventListener('keyup', enterClicked)
        return () => window.removeEventListener('keyup', enterClicked)
    })

    useNuiEvent('evidenceSearchResults', (data) => {
        setCurrentResult(null)
        setResults(data)
        href.textContent = ''
    })


    const setData = async (id: number) => {
        const data = await fetchNui("setEvidenceData", id)
        setCurrentResult(data)
    }

    useNuiEvent('closeEvidence', () => {
        setCurrentResult(null)
    })

    // TODO
    const refreshData = () => {
        if (!currentResult) { fetchNui("updateEvidences"); setCreatingEvidence(false); } else setData(currentResult.id)
        href.textContent = ''
    }

    React.useEffect(() => {
        const back = () => {
            const cEvidence = document.getElementById("createevidence")
            const sEvidence = document.getElementById("evidenceshower")
            if (creatingEvidence && cEvidence) {
                setCreatingEvidence(false)
                href.textContent = ''
            } else if(currentResult && currentResult.id && sEvidence){
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
                    {!creatingEvidence && 
                        <>
                            <TitleBlock text={Locale['EVIDENCES']}/>
                            <div className="searcher">
                                <input placeholder={Locale['SEARCH_FOR_EVIDENCES']} id="searchevidence" ref={search}/>
                                <div className="search-button" onClick={searchEvidence}>{Locale['SEARCH']}</div>
                                <div className="create-button" onClick={() => {setCreatingEvidence(true); href.textContent = 'create'}}>{Locale['CREATE_EVIDENCE']}</div>
                            </div>
                            {results && results.length > 0 && 
                                <>
                                    <TitleBlock text={Locale['EVIDENCES_SEARCHED_DATA']}/>
                                    <div className="results-container">
                                        <div className="results-header">
                                            <span style={{width: "446px"}}>
                                                {Locale['EVIDENCE_TITLE'] || 'Title'}
                                            </span>
                                            <span style={{width: "265px"}}>
                                                {Locale['EVIDENCE_CREATOR'] || 'Creator'}
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

                    {creatingEvidence && <CreateEvidence refresh={refreshData}/>}
                </>}

                {(currentResult && !creatingEvidence) && <EvidenceData data={currentResult} refresh={refreshData} />}
            </div>
        </div>
    )
}

export default Evidences