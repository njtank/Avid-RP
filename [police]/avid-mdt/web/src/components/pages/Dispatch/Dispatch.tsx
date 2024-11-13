import React, { useState } from "react";
import "./Dispatch.scss"
import "../../color_settings.scss"
import "../../Modals/Modal.scss"
import TitleBlock from "../../TitleBlock";
import { useNuiEvent } from "../../../hooks/useNuiEvent";
import { usePoliceListState } from "../../../state/policeList";
import { debugData } from "../../../utils/debugData";
import { usePlayerDataState } from "../../../state/playerData";
import { fetchNui } from "../../../utils/fetchNui";
import { faRotateRight, faX } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import SingleModal from "../../Modals/SingleModal";
import ConfirmModal from "../../Modals/ConfirmModal";
import { useUnitsAndVehiclesState } from "../../../state/unitsAndVehicles";
import { useSetAtom } from "jotai";

import Napadowa1 from "./Zakladki/n1/napadowa1";
import Napadowa2 from "./Zakladki/n2/napadowa2";
import Napadowa3 from "./Zakladki/n3/napadowa3";

import Konwojowa from "./Zakladki/k/Konwojowa";
import { useLocaleState } from "../../../state/locale";


interface Officer {
    firstname: string,
    lastname: string,
    badge: string,
    id: number
}
interface Patrol {
    status: string,
    vehicle: string,
    unit: string,
    officers: Officer[]
}

interface Status {
    pwc: string,
    apwc: string,
    cityStatus: {
        label: string,
        color: string,
        textColor?: string
    }
}

debugData([
    {
        action: 'setCurrentPatrol',
        data: 0
    }
])

debugData([
    {
        action: 'setDispatch',
        data: [
            {
                status: "-",
                vehicle: "Dodge Ram",
                unit: "BOY",
                officers: [
                    {
                        firstname: "Michael",
                        lastname: "Dustus",
                        badge: "[01]"
                    }
                ]
            },
            {
                status: "-",
                vehicle: "Ford Crown Victoria",
                unit: "ADAM",
                officers: [
                    {
                        firstname: "Vito",
                        lastname: "Giuseppe",
                        badge: "[01]",
                        id: 3
                    },
                    {
                        firstname: "Daniel",
                        lastname: "Martinez",
                        badge: "[02]",
                        id: 2
                    },
                    {
                        firstname: "John",
                        lastname: "Arthur",
                        badge: "[03]",
                        id: 1
                    },
                ]
            },
        ]
    },
    {
        action: 'setS4',
        data: [
            {
                firstname: 'Aiden',
                lastname: 'McClarke',
                badge: '[997]',
                id: 4
            },
        ]
    }
])

const Dispatch:React.FC = () => {
    const Locale = useLocaleState()

    const policeList = usePoliceListState()

    const playerData = usePlayerDataState()

    const [currentPatrol, setCurrentPatrol] = useState<number | null>(null)

    const [reload, setReload] = useState<boolean>(false)

    const [patrolsData, setPatrolsData] = useState<Patrol[]>([])

    const [statusData, setStatusData] = useState<Status>({
        pwc: "",
        apwc: "",
        cityStatus: {
            label: "Zielony",
            color: "#92FF3C",
            textColor: "black"
        }
    })

    const [s4, setS4] = useState<Officer[]>([])

    const [href, setHref] = useState<string>('dispatch')

    const reloadData = () => {
        setReload(!reload)
    }

    useNuiEvent<Patrol[]>('setDispatch', (data) => {
        setPatrolsData(data)
    })

    useNuiEvent<Status>('setStatusData', (data) => {
        setStatusData(data)
    })

    useNuiEvent<Officer[]>('setS4', (data) => {
        setS4(data)
    })

    useNuiEvent<number | null>('setCurrentPatrol', (data) => {
        if (data == undefined) {
            setCurrentPatrol(null)
        } else {
            setCurrentPatrol(data)
        }
    })

    const setPWC = (self: boolean) => {
        let pwc: string = ""
        if (self && playerData) {
            pwc = playerData.badge + " " + playerData.firstname + " " + playerData.lastname
        }
        fetchNui('setPWC', {pwc})
    }

    const setAPWC = (self: boolean) => {
        let apwc: string = ""
        if (self && playerData) {
            apwc = playerData.badge + " " + playerData.firstname + " " + playerData.lastname
        }
        fetchNui('setAPWC', {apwc})
    }

    const clearDispatch = () => {
        fetchNui("clearDispatch", {})
    }

    const leavePatrol = () => {
        if (currentPatrol == null) return;
        fetchNui("leavePatrol", {index: currentPatrol + 1})
    }

    const [changeStatus, setChangeStatus] = useState<boolean>(false)

    const cancelStatus = () => {
        setChangeStatus(false)
    }

    const submitStatus = (data: string) => {
        setChangeStatus(false)
        if (!data) return;
        if (currentPatrol === null) return;
        fetchNui("changePatrolStatus", {index: currentPatrol + 1, status: data})
    }

    const [joinModal, setJoinModal] = useState<boolean>(false)
    const [clickedPatrol, setClickedPatrol] = useState<number | null>(null)

    const unitsAndVehicles = useUnitsAndVehiclesState()

    const cancelJoin = () => {
        setClickedPatrol(null)
        setJoinModal(false)
    }

    const submitJoin = async () => {
        const data = Number(clickedPatrol)
        setClickedPatrol(null)
        setJoinModal(false)
        if (currentPatrol !== null) {
            await fetchNui("leavePatrol", {index: currentPatrol + 1})
        }
        fetchNui("joinPatrol", {index: data + 1})
    }

    const [editModal, setEditModal] = useState<boolean>(false)
    const [editedUnit, setEditedUnit] = useState<string | null>(null)
    const [editedVehicle, setEditedVehicle] = useState<string | null>(null)

    const submitEdit = (unit: string, vehicle: string) => {
        setEditModal(false)
        if (!editedUnit && !editedVehicle) return;
        if (currentPatrol !== null && editedUnit == patrolsData[currentPatrol].unit && editedVehicle == patrolsData[currentPatrol].vehicle) {
            setEditedUnit(null)
            setEditedVehicle(null)
            return
        };
        if (currentPatrol === null) {
            fetchNui("createPatrol", {unit: editedUnit, vehicle: editedVehicle})
        } else {
            fetchNui("editPatrol", {index: currentPatrol + 1,unit: editedUnit, vehicle: editedVehicle})
        }

    }

    const cancelEdit = () => {
        setEditModal(false)
        setEditedUnit(null)
        setEditedVehicle(null)
    }

    const onChangeEdit = (t: string, value: string) => {
        if (t == 'unit') {
            setEditedUnit(value)
        } else if (t == 'vehicle') {
            setEditedVehicle(value)
        }
    }

    const changeZakladka = (value: string) => {
        var el2 = document.querySelector('.zakladka-selected')
        el2?.classList.remove('zakladka-selected')


        var el = document.querySelector('.'+value)
        el?.classList.add('zakladka-selected')

        var x = value

        if(x == 'dispatch2'){
            x = 'dispatch'
        } else if (x == 'napadowa-1' || x == 'napadowa-2' || x == 'napadowa-3'){
            x = x.replace('-', '')
        }

        setHref(x)

    }

    return (
        <>
            {changeStatus && <SingleModal label={Locale['DISPATCH_JOIN_PATROL_TITLE']} placeholder={Locale['DISPATCH_JOIN_PATROL_TEXT']} submitLabel={Locale['DISPATCH_JOIN_PATROL_JOIN']} onCancel={cancelStatus} onSubmit={submitStatus} />}
            {joinModal && <ConfirmModal label={Locale['DISPATCH_JOIN_PATROL_TITLE']} text={Locale['DISPATCH_JOIN_PATROL_TEXT2'] + (clickedPatrol !== null && clickedPatrol + 1) + "?"} submitLabel={Locale['DISPATCH_JOIN_PATROL_JOIN']} cancelLabel={Locale['DISPATCH_JOIN_PATROL_CANCEL']} onSubmit={submitJoin} onCancel={cancelJoin} />}
            {editModal && <>
                <div className="background" onClick={() => cancelEdit()}></div>
                <div className="modal-container">
                    <div className="modal-header">
                        <div className="modal-label">
                            {Locale['DISPATCH_PATROL_INFO']}
                        </div>
                        <div className="modal-close" onClick={() => cancelEdit()}>
                            <FontAwesomeIcon icon={faX}/>
                        </div>
                    </div>
                    <div className="modal-content">
                        <div className="dispatch-modal">
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
                    </div>
                    <div className="modal-footer">
                        <div className="btn" onClick={() => submitEdit("a", "a")}>
                            {Locale['DISPATCH_SAVE_PATROL']}
                        </div>
                    </div>
                </div>
            </>}
            <div className="buttons-zakladki">
                <button className="dispatch2 zakladka-selected" onClick={() => changeZakladka('dispatch2')}>{Locale['DISPATCH']}</button>
                <button className="napadowa-1" onClick={() => changeZakladka('napadowa-1')}>{Locale['DISPATCH_ACTION1']}</button>
                <button className="napadowa-2" onClick={() => changeZakladka('napadowa-2')}>{Locale['DISPATCH_ACTION2']}</button>
                <button className="napadowa-3" onClick={() => changeZakladka('napadowa-3')}>{Locale['DISPATCH_ACTION3']}</button>
                <button className="konwoj" onClick={() => changeZakladka('konwoj')}>{Locale['DISPATCH_CONVOY']}</button>
            </div>

            {<div style={{display: href == 'napadowa1' ? "block" : "none"}}>
                <Napadowa1></Napadowa1>
            </div>}

            {<div style={{display: href == 'napadowa2' ? "block" : "none"}}>
                <Napadowa2></Napadowa2>
            </div>}

            {<div style={{display: href == 'napadowa3' ? "block" : "none"}}>
                <Napadowa3></Napadowa3>
            </div>}


            {<div style={{display: href == 'konwoj' ? "block" : "none"}}>
                <Konwojowa></Konwojowa>
            </div>}

            
            <div className="dispatch-container" style={{display: href == 'dispatch' ? "block" : "none"}}>
                <div className="dispatch">
                    <TitleBlock text={Locale['DISPATCH']}/>


                    <div className="dispatch-header">

                        <div style={{width: "265px"}}>
                            <div className="header-title">
                                {Locale['DISPATCH_TOWN_STATUS']}
                            </div>
                            <div className="header-content" style={{backgroundColor: statusData.cityStatus.color, color: statusData.cityStatus.textColor}}>
                                {statusData.cityStatus.label}
                            </div>
                        </div>

                        <div style={{width: "230px"}}>
                            <div className="header-title pwc">
                                <div className="pwc-button" onClick={() => setPWC(true)}>
                                    {Locale['DISPATCH_PWC_TAKE']}
                                </div>
                                <span>{Locale['DISPATCH_PWC']}</span>
                                <div className="pwc-button" onClick={() => setPWC(false)}>
                                    {Locale['DISPATCH_PWC_RESET']}
                                </div>
                            </div>
                            <div className="header-content">
                                {statusData.pwc != "" ? statusData.pwc : Locale['DISPATCH_PWC_UNKNOWN']}
                            </div>
                        </div>
                        <div style={{width: "230px"}}>
                            <div className="header-title pwc">
                                <div className="pwc-button" onClick={() => setAPWC(true)}>
                                    {Locale['DISPATCH_PWC_TAKE']}
                                </div>
                                <span>{Locale['DISPATCH_APWC']}</span>
                                <div className="pwc-button" onClick={() => setAPWC(false)}>
                                    {Locale['DISPATCH_PWC_RESET']}
                                </div>
                            </div>
                            <div className="header-content">
                                {statusData.apwc != "" ? statusData.apwc : Locale['DISPATCH_PWC_UNKNOWN']}
                            </div>
                        </div>

                        <div style={{width: "90px"}}>
                            <div className="header-title">
                                {Locale['DISPATCH_ON_DUTY']}
                            </div>
                            <div className="header-content">
                                {policeList.length}
                            </div>
                        </div>

                        <div style={{width: "90px"}}>
                            <div className="header-title">
                                {Locale['DISPATCH_PATROLS_NUMBER']}
                            </div>
                            <div className="header-content">
                                {patrolsData.length}
                            </div>
                        </div>

                    </div>

                    <div className="dispatch-container2">
                        <div className="patrols-container">
                            <header>
                                <span>{Locale['DISPATCH_PU']}</span>
                                {(statusData.pwc == (playerData?.badge + " " + playerData?.firstname + " " + playerData?.lastname) || statusData.apwc == (playerData?.badge + " " + playerData?.firstname + " " + playerData?.lastname)) && <span className="refresh" onClick={() => clearDispatch()}><FontAwesomeIcon icon={faRotateRight}/> {Locale['CLEAR_DISPATCH']}</span>}
                            </header>
                            {patrolsData.map((value, index) => (
                                <div className="patrol" key={index} onClick={() => {
                                    if (index == currentPatrol) return;
                                    setClickedPatrol(index);
                                    setJoinModal(true)
                                }}>
                                    <div className="pu-index">
                                        PU {index + 1}
                                    </div>
                                    <div className="badges">
                                        {value.officers.map((officer, ofIndex) => (
                                            <span key={ofIndex}>
                                                {officer.badge}
                                            </span>
                                        ))}
                                    </div>
                                    <div className="names">
                                        {value.officers.map((officer, ofIndex) => (
                                            <span key={ofIndex}>
                                                {officer.firstname} {officer.lastname}
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
                                <header>
                                    {Locale['STATUS_S4']}
                                </header>
                                <div className="s4-scroll">
                                    {s4.map((value, index) => (
                                        <div key={index}>
                                            {value.badge} {value.firstname} {value.lastname}
                                        </div>
                                    ))}
                                </div>
                            </div>
                            <div className="patrols-self">
                                {currentPatrol === null && <>
                                    <div className="create-patrol" onClick={() => {
                                        setEditModal(true)
                                        setEditedUnit(null)
                                        setEditedVehicle(null)
                                    }}>
                                        {Locale['DISPATCH_CREATE_PATROL']}
                                    </div>
                                </>}
                                {currentPatrol !== null && <>
                                    <div className="line">
                                        <div className="btn" onClick={() => leavePatrol()}>
                                            {Locale['DISPATCH_LEAVE_PATROL']}
                                        </div>
                                        <div className="btn" onClick={() => {
                                            setEditModal(true)
                                            setEditedUnit(patrolsData[currentPatrol]?.unit)
                                            setEditedVehicle(patrolsData[currentPatrol]?.vehicle)
                                        }}>
                                            {Locale['DISPATCH_EDIT_PATROL']}
                                        </div>
                                    </div>
                                    <div className="line">
                                        <div className="patrol-data">
                                            {patrolsData[currentPatrol]?.unit}
                                        </div>
                                        <div className="patrol-data">
                                            {patrolsData[currentPatrol]?.vehicle}
                                        </div>
                                    </div>
                                    <div className="line">
                                        <div className="status" onClick={() => setChangeStatus(true)}>
                                            {Locale['DISPATCH_CHANGE_PATROL_STATUS']}
                                        </div>
                                    </div>
                                </>}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>

    )
}


interface DispatchNotif {
    id: string,
    localization: {
        x: number,
        y: number,
        z: number,
    },
    title: string,
    subtitle: string,
    code: string,
    color: string,
    time: string,
    response: number,
}

interface ReactionNotif {
    badge: string,
    alert: string,
    response: number,
}

const CasualDispatch:React.FC = () => {
    const Locale = useLocaleState()

    useNuiEvent<DispatchNotif>('addNotif', (data) => {

        const notif_id = data.id
        const firstDiv = document.createElement('div')
        firstDiv.className = 'DispatchAlert'
        firstDiv.id = notif_id

        if(!data.color){
            data.color = 'rgb(17, 25, 37)'
        }
        
        const colorek = data.color.replace('rgb(', '').replace(')', '').split(',')
        firstDiv.style.backgroundColor = `rgba(${colorek[0]}, ${colorek[1]}, ${colorek[2]}, 0.3)`

        

        

        const secondDiv = document.createElement('div')
        secondDiv.className = 'daMainContent'
    
        const leftSide = document.createElement('div')
        leftSide.className = 'dispatchalert_leftside'

            const reactions = document.createElement('div')
            reactions.className = 'da_reactions'
            reactions.id = `da_reactions_${notif_id}`
            reactions.setAttribute('data-color', data.color)

            const title = document.createElement('span')
                title.className = 'DAtitle'
            const subtitle = document.createElement('span')
                subtitle.className = 'DAsubtitle'

            title.textContent = data.title
            subtitle.textContent = data.subtitle

            leftSide.append(reactions)
            leftSide.append(title)
            leftSide.append(subtitle)
        
        const rightSide = document.createElement('div')
        rightSide.className = 'dispatchalert_rightside'

            const rightSide_timer = document.createElement('div')
            rightSide_timer.className = 'DAtimer'

                const rightSide_time = document.createElement('div')
                rightSide_time.className = 'da_time'
                rightSide_time.textContent = `${new Date().toLocaleString('pl-PL', { hour: '2-digit', minute:'2-digit', second:'2-digit'})}`

                const rightSide_remove = document.createElement('div')
                rightSide_remove.className = 'da_remove'
                rightSide_remove.innerHTML = '<i class="fa-regular fa-trash-can"></i>'
                rightSide_remove.addEventListener('click', (e:Event) => removeAlert(data.id))


            const rightSide_code = document.createElement('div')
            rightSide_code.className = 'DACode'
            rightSide_code.style.backgroundColor = `rgba(${colorek[0]}, ${colorek[1]}, ${colorek[2]}, 0.6)`
            rightSide_code.style.border = `1px solid ${data.color}`
                
                const code_span = document.createElement('span')
                code_span.textContent = data.code    
        

            const rightSide_react = document.createElement('div');
                rightSide_react.className = 'DAReact'
                rightSide_react.style.backgroundColor = `rgba(${colorek[0]}, ${colorek[1]}, ${colorek[2]}, 0.6)`
                rightSide_react.style.border = `1px solid ${data.color}`
            
                const reactions_number = document.createElement('span');
                    reactions_number.id = `reactions_number_${data.id}`
                    reactions_number.textContent = `${getNumberOfReactions(data.id)}/${data.response}`

        const buttons = document.createElement('div')
        buttons.className = 'DAButtons'
            const addReactionBTN = document.createElement('button')
                addReactionBTN.className = 'DAbtn'
                addReactionBTN.innerHTML = Locale['DISPATCH_REACT'] // ! LOCALE
                addReactionBTN.addEventListener('click', (e:Event) => addReaction(data.id))
                addReactionBTN.style.backgroundColor = `rgba(${colorek[0]}, ${colorek[1]}, ${colorek[2]}, 0.6)`
                addReactionBTN.style.border = `1px solid ${data.color}`

            const addLocalizationBTN = document.createElement('button')
                addLocalizationBTN.className = 'DAbtn'
                addLocalizationBTN.innerHTML = Locale['DISPATCH_LOCALIZATION'] // ! LOCALE
                addLocalizationBTN.addEventListener('click', (e:Event) => setLocalization(data.localization.x, data.localization.y))
                addLocalizationBTN.style.backgroundColor = `rgba(${colorek[0]}, ${colorek[1]}, ${colorek[2]}, 0.6)`
                addLocalizationBTN.style.border = `1px solid ${data.color}`




        rightSide_timer.append(rightSide_time)
        rightSide_timer.append(rightSide_remove)
        rightSide_code.append(code_span)
        rightSide_react.append(reactions_number)

        rightSide.append(rightSide_timer)
        rightSide.append(rightSide_code)
        rightSide.append(rightSide_react)

        buttons.append(addLocalizationBTN)
        buttons.append(addReactionBTN)

        secondDiv.append(leftSide)
        secondDiv.append(rightSide)
        
        firstDiv.append(secondDiv)
        firstDiv.append(buttons)

        const divParent = document.getElementById('DispatchAlertsContent')
        divParent?.append(firstDiv)

        if (divParent){
            divParent.scrollTop = divParent.scrollHeight;
        }

        if(data.response <= 0){
            addReactionBTN.remove()
            rightSide_react.remove()
            reactions_number.remove()
        }
    })

    const getNumberOfReactions = (alert: string) => {
        var reac = document.getElementById('da_reactions_'+alert) as HTMLDivElement

        let count = 0
        if(reac){
            count = reac.childElementCount
        }

        return count
    }

    const removeAlert = (alert: string) => {
        var adiv = document.getElementById(alert) as HTMLDivElement
        adiv.remove()
    }

    const addReaction = (alert: string) => {
        fetchNui('addReactionn', alert)
    }

    useNuiEvent<ReactionNotif>('addDNReaction', (data) => {
        var badge = data.badge
        if((data.badge).includes('[') && (data.badge).includes(']')){
            badge = (data.badge).replace('[', '').replace(']', '')
        }

        var id = document.getElementById(`da_reactions_${data.alert}`) as HTMLDivElement
        var color = document.getElementById(`da_reactions_${data.alert}`)?.getAttribute('data-color')

        const newDiv = document.createElement('div')
        const newSpan = document.createElement('span')
        newDiv.className = `dareaction`
        newDiv.id = `badge_${badge}`
        if(color){
            const colorek = color.replace('rgb(', '').replace(')', '').split(',')
        
            newDiv.style.backgroundColor = `rgba(${colorek[0]}, ${colorek[1]}, ${colorek[2]}, 0.6)`
            newDiv.style.border = `1px solid ${color}`
        }

        newDiv.append(newSpan)
        
        newSpan.textContent = badge

        
        id.append(newDiv)

        setTimeout(() => {
            const reactionNumber = document.getElementById(`reactions_number_${data.alert}`)
            if (reactionNumber){
                reactionNumber.textContent = `${getNumberOfReactions(data.alert)}/${data.response}`
            }
        }, 300);
    })

    const setLocalization = (x: number, y: number) => {
        fetchNui('setLocalization', {x, y})
    }
    
    return (
        <>
            <TitleBlock text="Dispatch Alerts" />
            <div className="DispatchAlertsContainer">
                <div className="DispatchAlertsContent" id="DispatchAlertsContent"></div>
            </div>
        </>

    )
}

export {Dispatch, CasualDispatch}