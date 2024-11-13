import React, { useState } from "react";
import { fetchNui } from "../../../../utils/fetchNui";
import TitleBlock from "../../../TitleBlock";
import "./citizen.scss"
import '../../../color_settings.scss'
import "../../../Modals/Modal.scss"
import SingleModal from "../../../Modals/SingleModal";
import Tariff from "../tariff/tariff";
import DeleteModal from "../../../Modals/DeleteModal";
import { useLocaleState } from "../../../../state/locale";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faSave, faX } from "@fortawesome/free-solid-svg-icons";


const CitizenData: React.FC<{data: any, refresh: () => void}> = ({data, refresh}) => {
    const Locale = useLocaleState()
    
    const [deleteModal, setDeleteModal] = useState<boolean>(false)
    const [selectedTable, selectTable] = useState<string>("fines")
    const [tariffVisibile, setTariffVisible] = useState<boolean>(false);
    const [editProfile, setProfileModal] = useState<boolean>(false)
    

    const setWanted = (wanted: boolean) => {
        var p = document.querySelector('.citizen_poszukiwany') as HTMLStyleElement
        if(wanted){
            p.style.opacity = '1.0'
        } else {
            p.style.opacity = '0.0'
        }
        fetchNui("setSearchedPlayer", {searched: wanted, identifier: data.identifier})
    }

    const changePicture = () => {
        const picture_id = document.getElementById('input_picture_avatar') as HTMLInputElement
        const picture = picture_id.value
        picture_id.value = ''

        const picture_div = document.getElementById('citizen_picture')

        if(!picture.includes('.png') && !picture.includes('.jpg') && !picture.includes('.jpeg') && !picture.includes('.gif')){return;}

        if (picture_div) {
            picture_div.innerHTML = `<img src="${picture}">`
            fetchNui("setAvatarPicture", {picutre: picture, identifier: data.identifier})
        }

    }


    React.useEffect(() => {
        const back = () => {
            if (!tariffVisibile) return;
            setTariffVisible(false)
        }

        window.addEventListener('goBack', back)

        return () => window.removeEventListener('goBack', back)
    })

    const texts: {[key: string]: string} = {
        fines: Locale['FILES_LAST_FINES'],
        jails: Locale['FILES_LAST_JAIL'],
        notes: Locale['FILES_LAST_NOTES'],
        vehicles: Locale['FILES_VEHICLES']
    }

    const [modal, setModal] = useState<boolean>(false)

    const onSubmit = async (note: string) => {
        setModal(false)
        await fetchNui("addCitizenNote", {identifier: data.identifier, note: note})
        refresh()
    }

    const onCancel = () => {
        setModal(false)
    }

    const SmallTitleBlock: React.FC<{text: string}> = ({text}) => {
        return (
            <div className="title-container" style={{margin: 0}}>
                <div className="title-text" style={{fontSize: "11px"}}>
                    {text}
                </div>
            <div className="title-line"></div>
            </div>
        )
    }

    const DataBlock: React.FC<{text: string | React.ReactNode}> = ({text}) => {
        return (
            <div className="citizen_data-text">
                {text}
            </div>
        )
    }

    const [clickedNote, setClickedNote] = useState<any>(null)

    const deleteNote = async (n: any) => {
        setClickedNote(null)
        setDeleteModal(false)
        if (!n) return;
        await fetchNui('deleteCitizenNote', {identifier: data.identifier, id: n})
        setTimeout(() => {
            refresh()
        }, 500)
    }
    
    const showEditProfile = (show: boolean) => {
        setProfileModal(show)
    }
    return (<>
        {modal && <SingleModal label={Locale['FILES_ADD_NOTE']} onSubmit={onSubmit} onCancel={onCancel} placeholder={Locale['FILES_NOTE_CONTENT']} submitLabel={Locale['FILES_CONFIRM_NOTE']} />}
        {deleteModal && <DeleteModal label={Locale['FILES_NOTE_DELETE']} onSubmit={deleteNote} onCancel={() => {setDeleteModal(false); setClickedNote(null)}} text={Locale['FILES_NOTE_DELETE_MESSAGE']} submitLabel={Locale['FILES_NOTE_DELETE']} cancelLabel={Locale['FILES_NOTE_DELETE_CANCEL']} extraData={clickedNote}/>}
        {tariffVisibile && <Tariff data={data}/>}
        {editProfile && <>
            <div className="background" onClick={() => showEditProfile(false)}></div>
            <div className="modal-container">
                <div className="modal-header">
                    <div className="modal-label">
                        {Locale['FILES_EDIT_PROFILE']+' - '+data.firstname + " " + data.lastname}
                    </div>
                    <div className="modal-close" onClick={() => showEditProfile(false)}>
                        <FontAwesomeIcon icon={faX}/>
                    </div>
                </div>

                <div className="modal_content">
                    <div className="searched_edit_profile">
                        <div className="annoucements-checkbox-idea" id="annoucements-checkbox-idea">
                            <input type="checkbox" className="checkbox-input" id={"checkbox"} defaultChecked={data.mdt_searched} onChange={(e) => setWanted(e.target.checked)} />
                            <label htmlFor={"checkbox"}>
                                <span className="checkbox"></span>
                            </label>
                        </div>
                        <div>{Locale['FILES_EDIT_PROFILE_SEARCHED']}</div>
                    </div>

                    <div className="profile_picture_edit_profile">
                        <span>{Locale['FILES_EDIT_PROFILE_AVATAR']}</span>
                        <div className="input-side">
                            <input type="text" id="input_picture_avatar" placeholder="https://media.discordapp.net/attachments/999330473924907141/1127547795943989289/avid-mdt.png"></input>
                            <div className="edit_profile-save" onClick={changePicture}>
                                <FontAwesomeIcon icon={faSave}/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>}
        {!tariffVisibile && <>
            <TitleBlock text={Locale['FILES_PERSONAL_DATA']}/>
            <div className="citizen_data-container">
                <div className="citizen_data-block">
                    <div className="citizen_img">
                        <div className="citizen_poszukiwany" style={{opacity: data.mdt_searched ? '1.0' : '0.0'}}><span>{Locale['FILES_WANTED']}</span></div>
                        <div className="citizen_picture" id="citizen_picture"><img src={data.mdt_picture ? data.mdt_picture : "https://media.discordapp.net/attachments/1028038548521230368/1136656400911712308/tablet_avatar2.png"}/></div>
                    </div>
                    <div className="citizen_data">
                        <SmallTitleBlock text={Locale['FILES_NAME']}/>
                        <DataBlock text={data.firstname + " " + data.lastname}/>
                        <SmallTitleBlock text={Locale['FILES_SEX']}/>
                        <DataBlock text={data.sex == "m" ? Locale['FILES_SEX_MALE'] : Locale['FILES_SEX_FEMALE']}/>
                        <SmallTitleBlock text={Locale['FILES_BIRTH']}/>
                        <DataBlock text={data.dateofbirth}/>
                        <SmallTitleBlock text={Locale['FILES_PHONENUMBER']}/>
                        <DataBlock text={data.phone}/>
                        <SmallTitleBlock text={Locale['FILES_LICENSES']}/>
                        <DataBlock text={
                            <>
                                <div className={data.licenses.drive_bike && "citizen_selected"}>
                                    {Locale['FILES_LICENSES_MOTOR']}
                                </div>
                                <div className={data.licenses.drive && "citizen_selected"}>
                                    {Locale['FILES_LICENSES_CAR']}
                                </div>
                                <div className={data.licenses.drive_truck && "citizen_selected"}>
                                    {Locale['FILES_LICENSES_TRUCK']}
                                </div>
                                <div className={data.licenses.weapon && "citizen_selected"}>
                                    <i className="fa-solid fa-gun"></i>
                                </div>
                            </>
                        }/>
                    </div>
                </div>
                <div className="citizen_data-buttons">
                    <div className="citizen_btn" onClick={() => setTariffVisible(true)}>
                        {Locale['FILES_ADD_FINE']}
                    </div>
                    <div className="citizen_btn" onClick={() => showEditProfile(true)}>
                        {Locale['FILES_EDIT_PROFILE']}
                    </div>
                    <div className="citizen_btn" style={{opacity: 0.0}}>

                    </div>
                    <div className={"citizen_btn " + (selectedTable == 'fines' && "citizen_selected")} onClick={() => selectTable("fines")}>
                        {Locale['FILES_FINES']}
                    </div>
                    <div className={"citizen_btn " + (selectedTable == 'jails' && "citizen_selected")} onClick={() => selectTable("jails")}>
                        {Locale['FILES_JAIL']}
                    </div>
                    <div className={"citizen_btn " + (selectedTable == 'notes' && "citizen_selected")} onClick={() => selectTable("notes")}>
                        {Locale['FILES_NOTES']}
                    </div>
                    <div className={"citizen_btn " + (selectedTable == 'vehicles' && "citizen_selected")} onClick={() => selectTable("vehicles")}>
                        {Locale['FILES_VEHICLES']}
                    </div>
                </div>
            </div>
            <TitleBlock text={texts[selectedTable]}/>
            <div className="citizen_table-table">
                <div className="citizen_table-container">
                    <div className="citizen_table-header">
                        {selectedTable == 'fines' && <>
                            <span style={{width: "565px"}}>
                                {Locale['FILES_REASON']}
                            </span>
                            <span style={{width: "125px"}}>
                                {Locale['FILES_DATE']}
                            </span>
                            <span style={{width: "125px"}}>
                                {Locale['TARIF_FINE']}
                            </span>
                            <span style={{width: "125px"}}>
                                {Locale['TARIF_OFFICER']}
                            </span>
                        </>}
                        {selectedTable == 'jails' && <>
                            <span style={{width: "459px"}}>
                                {Locale['FILES_REASON']}
                            </span>
                            <span style={{width: "125px"}}>
                                {Locale['FILES_DATE']}
                            </span>
                            <span style={{width: "125px"}}>
                                {Locale['TARIF_JAIL']}
                            </span>
                            <span style={{width: "102px"}}>
                                {Locale['TARIF_FINE']}
                            </span>
                            <span style={{width: "125px"}}>
                                {Locale['TARIF_OFFICER']}
                            </span>
                        </>}
                        {selectedTable == 'notes' && <>
                            <span style={{width: "125px"}}>
                                {Locale['FILES_DATE']}
                            </span>
                            <span style={{width: "694px"}}>
                                {Locale['FILES_NOTE']}
                            </span>
                            <span style={{width: "125px"}}>
                                {Locale['TARIF_OFFICER']}
                            </span>
                        </>}
                        {selectedTable == 'vehicles' && <>
                            <span style={{width: "309px"}}>
                                {Locale['FILES_MODEL']}
                            </span>
                            <span style={{width: "326px"}}>
                                {Locale['FILES_PLATE']}
                            </span>
                            <span style={{width: "309px"}}>
                                {Locale['FILES_CAR_STATUS']}
                            </span>
                        </>}
                    </div>
                    <div className="citizen_table-results">
                        <table>
                            {data[selectedTable].map((value: any, index: number) => (
                                <tr key={index} className="citizen_table-row" onClick={() => {
                                    if (selectedTable !== 'notes') return;
                                    setDeleteModal(true)
                                    setClickedNote(value.id)
                                }}>
                                    {selectedTable == 'fines' && <>
                                        <td style={{width: "565px"}}>
                                            <span>{value.reason}</span>
                                        </td>
                                        <td style={{width: "125px"}}>
                                            <span>{new Date(value.date * 1000).toLocaleString('pl-PL', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute:'2-digit', second:'2-digit'})}</span>
                                        </td>
                                        <td style={{width: "125px"}}>
                                            <span>{(value.fine).toLocaleString("en-US")} {Locale['TARIF_CURRENCY']}</span>
                                        </td>
                                        <td style={{width: "125px"}}>
                                            <span>{value.officer}</span>
                                        </td>
                                    </>}
                                    {selectedTable == 'jails' && <>
                                        <td style={{width: "459px"}}>
                                            <span>{value.reason}</span>
                                        </td>
                                        <td style={{width: "125px"}}>
                                            <span>{new Date(value.date * 1000).toLocaleString('pl-PL', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute:'2-digit', second:'2-digit'})}</span>
                                        </td>
                                        <td style={{width: "125px"}}>
                                            <span>{value.jail}</span>
                                        </td>
                                        <td style={{width: "102px"}}>
                                            <span>{(value.fine).toLocaleString("en-US")} {Locale['TARIF_CURRENCY']}</span>
                                        </td>
                                        <td style={{width: "125px"}}>
                                            <span>{value.officer}</span>
                                        </td>
                                    </>}
                                    {selectedTable == 'notes' && <>
                                        <td style={{width: "125px"}}>
                                            <span>{new Date(value.date * 1000).toLocaleString('pl-PL', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute:'2-digit', second:'2-digit'})}</span>
                                        </td>
                                        <td style={{width: "694px"}}>
                                            <span>{value.reason}</span>
                                        </td>
                                        <td style={{width: "125px"}}>
                                            <span>{value.officer}</span>
                                        </td>
                                    </>}
                                    {selectedTable == 'vehicles' && <>
                                        <td style={{width: "309px"}}>
                                            <span>{value.model}</span>
                                        </td>
                                        <td style={{width: "326px"}}>
                                            <span>{value.plate}</span>
                                        </td>
                                        <td style={{width: "309px"}}>
                                            <span>{value.status}</span>
                                        </td>
                                    </>}
                                </tr>
                            ))}
                        </table>
                    </div>
                    <div className="citizen_buttons">
                        {selectedTable == 'notes' && 
                            <div className="citizen_btn" onClick={() => setModal(true)}>
                                {Locale['FILES_ADD_NOTE']}
                            </div>
                        }
                        
                    </div>
                </div>
            </div>
        </>}
        
    </>)
}

export default CitizenData