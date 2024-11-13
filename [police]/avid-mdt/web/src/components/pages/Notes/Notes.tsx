import React, {useEffect, useRef, useState} from "react";
import "./Notes.scss"
import '../../color_settings.scss'
import { debugData } from "../../../utils/debugData";
import TitleBlock from "../../TitleBlock";
import { useNotes } from "../../../state/notes";
import { Annoucement } from "../../../types/annoucements";
import { fetchNui } from "../../../utils/fetchNui";
import DoubleModal from "../../Modals/DoubleModal";
import DeleteModal from "../../Modals/DeleteModal";
import { useLocaleState } from "../../../state/locale";

debugData([
    {
        action: 'setNotes',
        data: [
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 1
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 2
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 3
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 4
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 5
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 6
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 7
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 8
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 9
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 10
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 11
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 12
            },
            {
                annid: 13,
                title: "tresc",
                content: "Text Text Text Text Text Text Text",
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 14
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 15
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 16
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 17
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 18
            },
            {
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 19
            },
        ]
    }
])

const Notes: React.FC = () => {
    const Locale = useLocaleState()

    const [modal, setModal] = useState<boolean>(false)
    const [searchedNotes, setSearchedNotes] = useState<Annoucement[]>([])
    const [notes, setNotes] = useNotes()
    const search = useRef<HTMLInputElement>(null)
    const [deleteModal, setDeleteModal] = useState<boolean>(false)
    const [clickedNote, setClickedNote] = useState<any>(null)

    useEffect(() => {
        if (search.current && search.current.value && search.current.value.length > 0) {
            const value: string = search.current.value.toLocaleLowerCase()
            const newNotes = notes.filter((e: Annoucement) => {
                return e.title.toLocaleLowerCase().includes(value) || e.content.toLocaleLowerCase().includes(value)
            })
            setSearchedNotes(newNotes)
        } else {
            setSearchedNotes(notes)
        }
    }, [notes])

    const updateNotes = () => {
        if (search.current && search.current.value && search.current.value.length > 0) {
            const value: string = search.current.value.toLocaleLowerCase()
            const newNotes = notes.filter((e: Annoucement) => {
                return e.title.toLocaleLowerCase().includes(value) || e.content.toLocaleLowerCase().includes(value)
            })
            setSearchedNotes(newNotes)
        } else {
            setSearchedNotes(notes)
        }
    }

    const onSubmit = (title: string, content: string) => {
        setModal(false)
        fetchNui('addNote', {title, content})
    }

    const onCancel = () => {
        setModal(false)
    }

    const deleteNote = (data: any) => {
        var x = clickedNote
        setClickedNote(null)
        setDeleteModal(false)
        fetchNui('deleteNote', {annid: data})  
    }

    return (
        <>
            {modal && <DoubleModal label={Locale['NOTEPAD_NOTE_ADD_NOTE']} onSubmit={onSubmit} onCancel={onCancel} firstPlaceholder={Locale['NOTEPAD_NOTE_TITLE']} secondPlaceholder={Locale['NOTEPAD_NOTE_CONTENT']} submitLabel={Locale['NOTEPAD_NOTE_ADD_NOTE_CONFIRM']} />}
            {deleteModal && <DeleteModal label={Locale['NOTEPAD_NOTE_REMOVE_TITLE']} onSubmit={deleteNote} onCancel={() => {setDeleteModal(false); setClickedNote(null)}} text={Locale['NOTEPAD_NOTE_REMOVE_TEXT']} submitLabel={Locale['NOTEPAD_NOTE_REMOVE_CONFIRM']} cancelLabel={Locale['NOTEPAD_NOTE_REMOVE_CANCEL']} extraData={clickedNote}/>}
            <div className="notes-container">
                <div className="notes">
                    <TitleBlock text={Locale['NOTEPAD']}/>
                    <input className="search-container" placeholder={Locale['NOTEPAD_SEARCH']} ref={search} onInput={() => updateNotes()} />
                    <div className="container">
                        <div className="notes-header">
                            <span style={{width: "265px"}}>
                                {Locale['NOTEPAD_NOTE_TITLE']}
                            </span>
                            <span style={{width: "636px"}}>
                                {Locale['NOTEPAD_NOTE_CONTENT']}
                            </span>
                        </div>

                        <div className="notes-results">
                            <table>
                                {searchedNotes.map((value, index) => (
                                    <tr key={index} className="notes-row" onClick={() => {setDeleteModal(true); setClickedNote(value.annid)}}>
                                        <td style={{width: "265px"}}>
                                            <span>{value.title}</span>
                                        </td>
                                        <td style={{width: "636px"}}>
                                            <span>{value.content}</span>
                                        </td>
                                    </tr>
                                ))}
                            </table>
                        </div>

                        <div className="buttons">
                            <div className="btn" onClick={() => setModal(true)}>
                                {Locale['NOTEPAD_NOTE_ADD_NOTE']}
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </>
    )
}

export default Notes