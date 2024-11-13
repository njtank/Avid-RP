import React, { useState } from "react";
import { fetchNui } from "../../../../utils/fetchNui";
import SingleModal from "../../../Modals/SingleModal";
import DeleteModal from "../../../Modals/DeleteModal";
import TitleBlock from "../../../TitleBlock";
import "./vehicle.scss"
import '../../../color_settings.scss'
import { useLocaleState } from "../../../../state/locale";


const VehicleData: React.FC<{data: any, refresh: () => void}> = ({data, refresh}) => {
    const Locale = useLocaleState()

    const [modal, setModal] = useState<boolean>(false)
    const [deleteModal, setDeleteModal] = useState<boolean>(false)
    const [clickedNote, setClickedNote] = useState<any>(null)

    const onSubmit = async (note: string) => {
        setModal(false)
        await fetchNui("addVehicleNote", {plate: data.plate, note: note})
        refresh()
    }

    const onCancel = () => {
        setModal(false)
    }

    const deleteNote = async (n: any) => {
        setClickedNote(null)
        setDeleteModal(false)
        if (!n) return;
        await fetchNui('deleteVehicleNote', {plate: data.plate, id: n})
        setTimeout(() => {
            refresh()
        }, 500)
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
            <div className="data-text">
                {text}
            </div>
        )
    }

    return (
        <>
            {modal && <SingleModal label={Locale['FILES_ADD_NOTE']} onSubmit={onSubmit} onCancel={onCancel} placeholder={Locale['FILES_NOTE_CONTENT']} submitLabel={Locale['FILES_CONFIRM_NOTE']} />}
            {deleteModal && <DeleteModal label={Locale['FILES_NOTE_DELETE']} onSubmit={deleteNote} onCancel={() => {setDeleteModal(false); setClickedNote(null)}} text={Locale['FILES_NOTE_DELETE_MESSAGE']} submitLabel={Locale['FILES_NOTE_DELETE']} cancelLabel={Locale['FILES_NOTE_DELETE_CANCEL']} extraData={clickedNote}/>}
            <TitleBlock text={Locale['FILES_SEARCH_FOR_CAR2']}/>
            <div className="info-container">
                <div>
                    <div className="data-block-veh">
                        <div className="img-veh">
                            <img src={"https://media.discordapp.net/attachments/1028038548521230368/1136656943897923744/car.png"}/>
                        </div>
                        <div className="data-veh">
                            <SmallTitleBlock text={Locale['FILES_MODEL']}/>
                            <DataBlock text={data.model}/>
                            <SmallTitleBlock text={Locale['FILES_PLATE']}/>
                            <DataBlock text={data.plate}/>
                            <SmallTitleBlock text={Locale['FILES_OWNER']}/>
                            <DataBlock text={data.owner.firstname + ' ' + data.owner.lastname}/>
                        </div>
                    </div>
                </div>
            </div>
            <div className="vehicle-notes">
                <div className="container">
                    <div className="vehicle-notes-header">
                        <span style={{width: "104px"}}>
                            {Locale['FILES_DATE']}
                        </span>
                        <span style={{width: "488px"}}>
                            {Locale['FILES_NOTE']}
                        </span>
                        <span style={{width: "111px"}}>
                            {Locale['TARIF_OFFICER']}
                        </span>
                    </div>

                    <div className="vehicle-notes-results">
                        <table>
                            {data.notes.map((value: any, index: number) => (
                                <tr key={index} className="vehicle-notes-row" onClick={() => {setDeleteModal(true); setClickedNote(value.id)}}>
                                    <td style={{width: "104px"}}>
                                        <span>{new Date(value.date * 1000).toLocaleString('pl-PL', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute:'2-digit', second:'2-digit'})}</span>
                                    </td>
                                    <td style={{width: "488px"}}>
                                        <span>{value.note}</span>
                                    </td>
                                    <td style={{width: "111px"}}>
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
        </>
    )
}

export default VehicleData