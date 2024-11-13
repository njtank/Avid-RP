import React, { useState } from "react";
import "./Konwojowa.scss"
import "../../../../color_settings.scss"
import "../../../../Modals/Modal.scss"
import TitleBlock from "../../../../TitleBlock";
import { useNuiEvent } from "../../../../../hooks/useNuiEvent";
import { usePoliceListState } from "../../../../../state/policeList";
import { debugData } from "../../../../../utils/debugData";
import { usePlayerDataState } from "../../../../../state/playerData";
import { fetchNui } from "../../../../../utils/fetchNui";
import { faAdd, faRotateRight, faX } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import SingleModal from "../../../../Modals/SingleModal";
import ConfirmModal from "../../../../Modals/ConfirmModal";
import { useUnitsAndVehiclesState } from "../../../../../state/unitsAndVehicles";
import { useLocaleState } from "../../../../../state/locale";

interface Officer {
    id: string;
    name: string;
}
interface Patrol {
    status: string,
    vehicle: string,
    unit: string,
    patrolUnit: string,
    officers: Officer[]
}

interface Status {
    sv: string
}

interface zatrzymaniData {
    zatrzymani: number
}

interface trasaData {
    trasa: string
}

debugData([
    {
        action: 'setKonwojowa',
        data: [
            {
                status: "-",
                vehicle: "Dodge Ram",
                unit: "BOY",
                officers: [
                    {
                        name: '[01] Chris Frog'
                    }
                ]
            },
            {
                status: "JEBAĆ PIS I",
                vehicle: "Ford Crown Victoria",
                unit: "ADAM",
                officers: [
                    {
                        name: '[01] Chris Frog',
                        id: 3
                    },
                    {
                        name: '[02] Chris Frog',
                        id: 2
                    },
                    {
                        name: '[03] Chris Frog',
                        id: 1
                    },
                ]
            },
        ]
    },
    {
        action: 'setPrzydzial',
        data: [
            {
                name: '[997] Aiden Kutas',
                id: 4
            },
        ]
    }
])

const Konwojowa:React.FC = () => {
    const Locale = useLocaleState()

    const playerData = usePlayerDataState()

    const [patrolsData, setPatrolsData] = useState<Patrol[]>([])

    const [statusData, setStatusData] = useState<Status>({
        sv: "",
    })

    const [przydzial, setPrzydzial] = useState<Officer[]>([])

    const [zatrzymaniText, setZatrzymaniText] = useState<zatrzymaniData>({
        zatrzymani: 0,
    })

    const [trasaText, setTrasaText] = useState<trasaData>({
        trasa: "",
    })

    useNuiEvent<Patrol[]>('setKonwojowa', (data) => {
        setPatrolsData(data)
    })

    useNuiEvent<Status>('setStatusData', (data) => {
        setStatusData(data)
    })

    useNuiEvent<Officer[]>('setPrzydzial', (data) => {
        setPrzydzial(data)
    })

    useNuiEvent<Status>('setKonwojowaSV', (data) => {
        setStatusData(data)
    })

    useNuiEvent<zatrzymaniData>('setKonwojowaZatrzymani', (data) => {
        if((statusData.sv == (playerData?.badge + " " + playerData?.firstname + " " + playerData?.lastname))){
            var n = document.getElementById('newZatrzymani') as HTMLInputElement

            var x = data.zatrzymani
            n.value = x.toString()
        }
        setZatrzymaniText(data)
    })

    useNuiEvent<trasaData>('setKonwojowaTrasa', (data) => {
        if((statusData.sv == (playerData?.badge + " " + playerData?.firstname + " " + playerData?.lastname))){
            var n = document.getElementById('newTrasa') as HTMLInputElement
            n.value = data.trasa
        }
        setTrasaText(data)
    })




    const setSV = (self: boolean) => {
        let sv: string = ""
        if (self && playerData) {
            sv = playerData.badge + " " + playerData.firstname + " " + playerData.lastname
        }
        fetchNui('setNapadowaSV', {zakladkaType: 'konwojowa', sv: sv})
    }

    const clearkonwojowa = () => {
        fetchNui("clearNapadowa", {zakladkaType: 'konwojowa'})
    }

    const removePatrol = () => {
        if (clickedPatrol == null) return;
        setRemoveModal(false)
        fetchNui("removeUnit", {zakladkaType: 'konwojowa', index: clickedPatrol + 1})
        setClickedPatrol(null)
        setClickedPatrolUnit(null)
    }

    const [removeModal, setRemoveModal] = useState<boolean>(false)
    const [clickedPatrol, setClickedPatrol] = useState<number | null>(null)

    const unitsAndVehicles = useUnitsAndVehiclesState()

    const [editModal, setEditModal] = useState<boolean>(false)
    const [editedUnit, setEditedUnit] = useState<string | null>(null)
    const [editedVehicle, setEditedVehicle] = useState<string | null>(null)

    const [editedOfficer1, setEditedOfficer1] = useState<string | null>(null)
    const [editedOfficer2, setEditedOfficer2] = useState<string | null>(null)
    const [editedOfficer3, setEditedOfficer3] = useState<string | null>(null)
    const [editedOfficer4, setEditedOfficer4] = useState<string | null>(null)
    const [editedOfficer5, setEditedOfficer5] = useState<string | null>(null)
    const [patrolUnit, setPatrolUnit] = useState<string | null>(null)
    const [clickedPatrolUnit, setClickedPatrolUnit] = useState<string | null>(null)

    const submitEdit = () => {
        setEditModal(false)
        if (!editedUnit && !editedVehicle && !editedOfficer1) return;
        
        var pu = 'U0'
        if (patrolUnit){
            pu = patrolUnit
        }


        if(editedOfficer1 != '' && editedOfficer2 != '' && editedOfficer3 != '' && editedOfficer4 != '' && editedOfficer5 != ''){
            if (clickedPatrol === null) {
                var officers = {
                    officer1: editedOfficer1,
                    officer2: editedOfficer2,
                    officer3: editedOfficer3,
                    officer4: editedOfficer4,
                    officer5: editedOfficer5,
                }
                fetchNui("createUnit", {zakladkaType: 'konwojowa', unit: editedUnit, vehicle: editedVehicle, officers: officers, patrolUnit: pu})
            } else {
                var officers = {
                    officer1: editedOfficer1,
                    officer2: editedOfficer2,
                    officer3: editedOfficer3,
                    officer4: editedOfficer4,
                    officer5: editedOfficer5,
                }
                fetchNui("editUnit", {zakladkaType: 'konwojowa', index: clickedPatrol + 1, unit: editedUnit, vehicle: editedVehicle, officers: officers, patrolUnit: pu})
            }
        }
        setClickedPatrolUnit(null)
    }

    const cancelEdit = () => {
        setEditModal(false)
        setEditedUnit(null)
        setEditedVehicle(null)
        setEditedOfficer1(null)
        setEditedOfficer2(null)
        setEditedOfficer3(null)
        setEditedOfficer4(null)
        setEditedOfficer5(null)
        setClickedPatrolUnit(null)
    }

    const onChangeEdit = (t: string, value: string) => {
        if (t == 'unit') {
            setEditedUnit(value)
        } else if (t == 'vehicle') {
            setEditedVehicle(value)
        } else if (t == 'officer1' && (value != '' || value != undefined)){
            setEditedOfficer1(value)
        } else if (t == 'officer2' && (value != '' || value != undefined)){
            setEditedOfficer2(value)
        } else if (t == 'officer3' && (value != '' || value != undefined)){
            setEditedOfficer3(value)
        } else if (t == 'officer4' && (value != '' || value != undefined)){
            setEditedOfficer4(value)
        } else if (t == 'officer5' && (value != '' || value != undefined)){
            setEditedOfficer5(value)
        } else if (t == 'patrolUnit'){
            setPatrolUnit(value)
        }
    }

    const ZatrzymaniChange = (z: string) => {
        fetchNui("updateZatrzymani", {text: z})
    }

    const TrasaChange = (z: string) => {
        fetchNui("updateRabunekAkcyjna", {zakladkaType: 'konwojowa', text: z})
    }

    const addSwatUser = () => {
        fetchNui("addSWAT")
    }

    const removePrzydzial = (id: string) => {
        fetchNui('removePrydzial', {id})
    }

    const getOfficersInAkcyjna = () => {
        var patrols = 0
        var x = patrolsData
        for(var i = 0; i < x.length; i++){
            patrols += x[i].officers.length
        }
        
        return patrols
    }

    return (
        <>
            {removeModal && <ConfirmModal label={Locale['DELETE_CONVOY_UNIT']} text={"Czy na pewno chcesz usunąć " + (clickedPatrolUnit !== null && clickedPatrolUnit) + "?"} submitLabel={Locale['DELETE']} cancelLabel={Locale['CANCEL']} onSubmit={removePatrol} onCancel={() => setRemoveModal(false)} />}
            {editModal && <>
                <div className="background" onClick={() => cancelEdit()}></div>
                <div className="modal-container">
                    <div className="modal-header">
                        <div className="modal-label">
                            {Locale['INFORMATION_CONVOY_UNIT']}
                        </div>
                        <div className="modal-close" onClick={() => cancelEdit()}>
                            <FontAwesomeIcon icon={faX}/>
                        </div>
                    </div>
                    <div className="modal-content">
                        <input type="text" placeholder={Locale['OFFICER']} defaultValue={(editedOfficer1 != null && typeof(editedOfficer1) == 'string') ? editedOfficer1 : ''} onBlur={(e) => onChangeEdit('officer1', e.target.value)}></input>
                        <input type="text" placeholder={Locale['OFFICER']} defaultValue={(editedOfficer2 != null && typeof(editedOfficer2) == 'string') ? editedOfficer2 : ''} onBlur={(e) => onChangeEdit('officer2', e.target.value)}></input>
                        <input type="text" placeholder={Locale['OFFICER']} defaultValue={(editedOfficer3 != null && typeof(editedOfficer3) == 'string') ? editedOfficer3 : ''} onBlur={(e) => onChangeEdit('officer3', e.target.value)}></input>
                        <input type="text" placeholder={Locale['OFFICER']} defaultValue={(editedOfficer4 != null && typeof(editedOfficer4) == 'string') ? editedOfficer4 : ''} onBlur={(e) => onChangeEdit('officer4', e.target.value)}></input>
                        <input type="text" placeholder={Locale['OFFICER']} defaultValue={(editedOfficer5 != null && typeof(editedOfficer5) == 'string') ? editedOfficer5 : ''} onBlur={(e) => onChangeEdit('officer5', e.target.value)}></input>
                        <div className="napadowa-modal">
                            <select defaultValue={(editedUnit != null && typeof(editedUnit) == 'string') ? editedUnit : ''} onChange={(e) => onChangeEdit('unit', e.target.value)}>
                                <option value={'-'}>{Locale['DISPATCH_CHOOSE_UNIT']}</option>
                                {unitsAndVehicles.map((value, index) => (
                                    <option key={index} value={value.unit}>{value.unit}</option>
                                ))}
                            </select>


                            
                            
                            <select defaultValue={(editedVehicle != null && typeof(editedVehicle) == 'string') ? editedVehicle : ''} onChange={(e) => onChangeEdit('vehicle', e.target.value)}>
                                <option>{Locale['DISPATCH_CHOOSE_CAR']}</option>
                                {unitsAndVehicles.map((value, index) => (
                                    <>
                                        {value.unit == editedUnit && value.vehicles.map((value2, index2) => (
                                            <option key={index2} value={value2}>
                                                {value2}
                                            </option>
                                        ))}
                                    </>
                                ))}
                            </select>
                        </div>
                        <div className="napadowa-modal">
                        <input type="text" placeholder={Locale['NOTE']}></input>
                            <select defaultValue={(patrolUnit != null && typeof(patrolUnit) == 'string') ? patrolUnit : ''} onChange={(e) => onChangeEdit('patrolUnit', e.target.value)}>
                                <option>U0</option>
                                <option>U1</option>
                                <option>U2</option>
                                <option>U3</option>
                                <option>U4</option>
                                <option>U5</option>
                                <option>U6</option>
                                <option>U7</option>
                                <option>U8</option>
                                <option>U9</option>
                                <option>U10</option>
                                <option>{Locale['STOPPED']}</option>
                            </select>

                        </div>
                    </div>
                    <div className="modal-footer">
                        <div className="btn" onClick={() => submitEdit()}>
                            {Locale['SAVE_UNIT']}
                        </div>
                    </div>
                </div>
            </>}
            <div className="konwojowa-container">
                <div className="konwojowa">
                    <TitleBlock text="konwojowa"/>

                    <div className="konwojowa-header">

                        <div style={{width: "225px"}}>
                            <div className="header-title">
                                {Locale['ROADTYPE']}
                            </div>
                            <div className="header-content" style={{color: 'rgba(255, 255, 255, 0.6)'}}>
                                {(statusData.sv == (playerData?.badge + " " + playerData?.firstname + " " + playerData?.lastname)) ? <input className="trasa-content" id="newTrasa" type="text" placeholder= {Locale['ROAD_POINT']} onBlur={event => TrasaChange(event.target.value)}></input> : <input className="trasa-content" type="text" placeholder={Locale['ROAD_NOTE']} value={trasaText.trasa} disabled></input>}                                
                            </div>
                        </div>

                        <div style={{width: "240px"}}>
                            <div className="header-title pwc">
                                <div className="pwc-button" onClick={() => setSV(true)}>
                                    {Locale['TAKE_CONTROL']}
                                </div>
                                <span>{Locale['SUPERVISIOR']}</span>
                                <div className="pwc-button" onClick={() => setSV(false)}>
                                    {Locale['RESET']}
                                </div>
                            </div>
                            <div className="header-content">
                                {statusData.sv != '' ? statusData.sv : Locale['NONE']}
                            </div>
                        </div>

                        <div style={{width: "150px"}}>
                            <div className="header-title">
                                {Locale['UNITS']}
                            </div>
                            <div className="header-content">
                                {patrolsData.length}
                            </div>
                        </div>

                        <div style={{width: "150px"}}>
                            <div className="header-title">
                                {Locale['UNITS']}
                            </div>
                            <div className="header-content">
                                {getOfficersInAkcyjna()}
                            </div>
                        </div>
                        <div style={{width: "150px"}}>
                            <div className="header-title">
                                {Locale['CHASED']}
                            </div>
                            <div className="header-content">
                                {(statusData.sv == (playerData?.badge + " " + playerData?.firstname + " " + playerData?.lastname)) ? <input className="zatrzymani-data" id="newZatrzymani" type="number" placeholder={Locale['DETAINED_COUNT']} onBlur={event => ZatrzymaniChange(event.target.value)}></input> : <input className="zatrzymani-data" type="number" placeholder={Locale['DETAINED_COUNT_2']} value={zatrzymaniText.zatrzymani} disabled></input>}                                
                            </div>
                        </div>
                    </div>

                    <div className="konwojowa-container2">
                        <div className="patrols-container">
                            <header>
                                <span>{Locale['UNIT']}</span>
                                {(statusData.sv == (playerData?.badge + " " + playerData?.firstname + " " + playerData?.lastname)) && <span className="refresh" onClick={() => clearkonwojowa()}><FontAwesomeIcon icon={faRotateRight}/>  {Locale['CLEAR_UNITS']}</span>}
                            </header>
                            
                            {patrolsData.map((value, index) => (
                                <div className="patrol" key={index} onContextMenu={() => {
                                    setRemoveModal(true);
                                    setClickedPatrol(index);
                                    setClickedPatrolUnit(value.patrolUnit)
                                    return;
                                }} onClick={() => {
                                    setClickedPatrol(index);
                                    setClickedPatrolUnit(value.patrolUnit)
                                    setEditedUnit(value.unit)
                                    setEditedVehicle(value.vehicle)
                                    setPatrolUnit(value.patrolUnit)
                                    setEditedOfficer1(null)
                                    setEditedOfficer2(null)
                                    setEditedOfficer3(null)
                                    setEditedOfficer4(null)
                                    setEditedOfficer5(null)
                                    
                                    for(var i = 0; i < (value.officers).length; i++){
                                        var g = i + 1

                                        if (g == 1){
                                            setEditedOfficer1(value.officers[i].name)
                                        } else if (g == 2){
                                            setEditedOfficer2(value.officers[i].name)
                                        } else if (g == 3){
                                            setEditedOfficer3(value.officers[i].name)
                                        } else if (g == 4){
                                            setEditedOfficer4(value.officers[i].name)
                                        } else if (g == 5){
                                            setEditedOfficer5(value.officers[i].name)
                                        }
                                    }
                                    setEditModal(true);
                                }}>
                                    <div className="pu-index">
                                        {value.patrolUnit}
                                    </div>
                                    <div className="names">
                                        {value.officers.map((officer, ofIndex) => (
                                            <span key={ofIndex}>
                                                {officer.name}
                                            </span>
                                        ))}
                                    </div>
                                    <div className="unit">
                                        {value.unit}
                                    </div>
                                    <div className="vehicle">
                                        {value.vehicle}
                                    </div>
                                    <div className="status">
                                        <span>
                                            {value.status}
                                        </span>
                                    </div>
                                </div>
                            ))}
                        </div>
                        <div className="patrols-right">
                            <div className="patrols-s4">
                                <div className="patrolsprzydzial">
                                    <header>
                                        {Locale['SWAT']}
                                    </header>
                                    <div className="przydzial-button" onClick={addSwatUser}>
                                        <FontAwesomeIcon icon={faAdd}/>
                                    </div>
                                </div>
                            
                                <div className="s4-scroll">
                                    {przydzial.map((value, index) => (
                                        <div key={index} onClick={() => removePrzydzial(value.id)}>
                                            {value.name}
                                        </div>
                                    ))}
                                </div>
                            </div>
                            <div className="patrols-self">
                                <div className="create-patrol" onClick={() => {setEditModal(true); setEditedOfficer1(null); setEditedOfficer2(null); setEditedOfficer3(null); setEditedOfficer4(null); setEditedOfficer5(null); setClickedPatrol(null); setEditedUnit(null); setEditedVehicle(null); setPatrolUnit('U0')}}>{Locale['CREATE_UNIT']}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>

    )
}

export default Konwojowa