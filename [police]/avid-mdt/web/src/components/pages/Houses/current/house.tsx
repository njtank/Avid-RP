import React, { useState } from "react";
import { fetchNui } from "../../../../utils/fetchNui";
import TitleBlock from "../../../TitleBlock";
import "./house.scss"
import '../../../color_settings.scss'
import SingleModal from "../../../Modals/SingleModal";
import DeleteModal from "../../../Modals/DeleteModal";
import { useLocaleState } from "../../../../state/locale";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faX, faCheck } from '@fortawesome/free-solid-svg-icons'

const HouseData: React.FC<{data: any, refresh: () => void}> = ({data, refresh}) => {
    const Locale = useLocaleState()
    
    const [deleteModal, setDeleteModal] = useState<boolean>(false)
    const [modal, setModal] = useState<boolean>(false)

    const onSubmit = async (note: string) => {
        setModal(false)
        await fetchNui("addHouseNote", {identifier: data.name, note: note})
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

    const DataBlock: React.FC<{text: any | React.ReactNode}> = ({text}) => {
        return (
            <div className="data-text">
                {text}
            </div>
        )
    }

    const [clickedNote, setClickedNote] = useState<any>(null)

    const deleteNote = async (n: any) => {
        setClickedNote(null)
        setDeleteModal(false)
        if (!n) return;
        await fetchNui('deleteHouseNote', {identifier: data.name, id: n})
        setTimeout(() => {
            refresh()
        }, 500)
    }
    
    return (<>
        {modal && <SingleModal label={Locale['FILES_ADD_NOTE']} onSubmit={onSubmit} onCancel={onCancel} placeholder={Locale['FILES_NOTE_CONTENT']} submitLabel={Locale['FILES_CONFIRM_NOTE']} />}
        {deleteModal && <DeleteModal label={Locale['FILES_NOTE_DELETE']} onSubmit={deleteNote} onCancel={() => {setDeleteModal(false); setClickedNote(null)}} text={Locale['FILES_NOTE_DELETE_MESSAGE']} submitLabel={Locale['FILES_NOTE_DELETE']} cancelLabel={Locale['FILES_NOTE_DELETE_CANCEL']} extraData={clickedNote}/>}
            <TitleBlock text={Locale['HOUSE_DATA']}/>
            <div className="data-container" id="house_container">
                <div className="data-block">
                    <div className="img">
                        <img src={"https://media.discordapp.net/attachments/1028038548521230368/1136656944120217661/house.png"}/>
                    </div>
                    <div className="data">
                        <SmallTitleBlock text={Locale['HOUSE_NAME']}/>
                        <DataBlock text={data.label}/>
                        <SmallTitleBlock text={Locale['HOUSE_OWNED']}/>
                        {/* <DataBlock2 text={data.data.owned ? <FontAwesomeIcon icon={faCheck}/> : <FontAwesomeIcon icon={faX}/>}/> */}
                        <DataBlock text={data.data.owned ? '✅' : '❌'}/>
                        <SmallTitleBlock text={Locale['HOUSE_OWNER']}/>
                        <DataBlock text={data.data.owner == '' ? Locale['HOUSE_OWNER_UNKNOWN'] : data.data.owner}/>
                    </div>
                </div>
            </div>
            <TitleBlock text={Locale['FILES_NOTES']}/>
            <div className="table-table">
                <div className="table-container">
                    <div className="table-header">
                        <span style={{width: "125px"}}>
                            {Locale['FILES_DATE']}
                        </span>
                        <span style={{width: "494px"}}>
                            {Locale['FILES_NOTE']}
                        </span>
                        <span style={{width: "125px"}}>
                            {Locale['TARIF_OFFICER']}
                        </span>
                    </div>
                    <div className="table-results">
                        <table>
                            {data.notes.map((value: any, index: number) => (
                                <tr key={index} className="table-row" onClick={() => {
                                    setDeleteModal(true)
                                    setClickedNote(value.id)
                                }}>
                                    <td style={{width: "125px"}}>
                                        <span>{new Date(value.date * 1000).toLocaleString('pl-PL', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute:'2-digit', second:'2-digit'})}</span>
                                    </td>
                                    <td style={{width: "694px"}}>
                                        <span>{value.reason}</span>
                                    </td>
                                    <td style={{width: "125px"}}>
                                        <span>{value.officer}</span>
                                    </td>
                                </tr>
                            ))}
                        </table>
                    </div>
                    <div className="buttons">
                        <div className="btn" onClick={() => setModal(true)}>
                            {Locale['FILES_ADD_NOTE']}
                        </div>                        
                    </div>
                </div>
            </div>
        
    </>)
}

export default HouseData