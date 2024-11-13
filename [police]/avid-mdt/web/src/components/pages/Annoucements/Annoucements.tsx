import React, { useState } from "react";
import { useAnnoucementsState } from "../../../state/annoucements";
import { Annoucement } from "../../../types/annoucements";
import { debugData } from "../../../utils/debugData";
import TitleBlock from "../../TitleBlock";
import DoubleModal from "../../Modals/DoubleModal";
import './Annoucements.scss'
import '../../color_settings.scss'
import { fetchNui } from "../../../utils/fetchNui";
import { usePlayerDataState } from "../../../state/playerData";
import { useLocaleState } from "../../../state/locale";
import { useBlockSettings, useBlockSettingsState } from "../../../state/blocksettings";

debugData([
    {
        action: 'setAnnoucements',
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
                title: "Tytuł",
                content: "Text Text Text Text Text Text Text",
                annid: 13
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

const Annoucements: React.FC = () => {
    const playerData = usePlayerDataState()

    const annoucements: Annoucement[] = useAnnoucementsState()
    const [modal, setModal] = useState<boolean>(false)

    const Locale = useLocaleState()
    const blockFunctions = useBlockSettingsState()

    const onSubmit = (title: string, content: string) => {
        setModal(false)
        fetchNui('addAnnoucement', {title, content})
    }

    const onCancel = () => {
        setModal(false)
    }

    const removeAnno = () => {
        var test = document.getElementById("annoucements-checkbox-idea");
        var dick = test?.classList.contains('showed');

        if(dick){
            document.querySelectorAll('.annoucements-checkbox-idea').forEach(function(el) {
                var element = el as HTMLInputElement
                element.style.display = 'none';
            });

            test?.classList.remove('showed');
            var button = document.getElementById('confirm-button') as HTMLInputElement;
            button.style.display = 'none';
        } else {
            document.querySelectorAll('.annoucements-checkbox-idea').forEach(function(el) {
                var element = el as HTMLInputElement
                element.style.display = 'block';
            });
            test?.classList.add('showed')
            var button = document.getElementById('confirm-button') as HTMLInputElement;
            button.style.display = 'flex';
            

        }
    }

    const confirmRemoveAnno = () => {
        removeAnno()
        document.querySelectorAll('.checkbox-input').forEach(function(el) {
            var element = el as HTMLInputElement
            if(element.checked){
                var ret = element.id.replace('checkbox','');
                fetchNui('removeAnn', {ret})
            }
        })
    }

    return (
        <>
            {modal && <DoubleModal label={Locale['ADD_ANNOUNCEMENT'] || "Add announcement"} onSubmit={onSubmit} onCancel={onCancel} firstPlaceholder={Locale['ANNOUNCEMENT_TITLE'] || "Announcement title"} secondPlaceholder={Locale['ANNOUNCEMENT_CONTENT'] || "Announcement content"} submitLabel={Locale['ANNOUNCEMENT_SUBMIT'] || "Submit"} />}
            <div className="annoucements-container">
                <div className="annoucements">
                    <TitleBlock text={Locale['ANNOUNCEMENT'] || "Announcement"}/>
                    <div className="container">
                        <div className="annoucements-header">
                            <span style={{width: "265px"}}>
                                {Locale['ANNOUNCEMENT_TITLE'] || "Announcement title"}
                            </span>
                            <span style={{width: "636px"}}>
                                {Locale['ANNOUNCEMENT_CONTENT'] || "Announcement content"}
                            </span>
                        </div>

                        <div className="annoucements-results">
                            <table>
                                {annoucements.map((value, index) => (
                                    <tr key={index} className="annoucements-row" id={'row-'+value.annid}>
                                        <div className="annoucements-checkbox-idea" id="annoucements-checkbox-idea">
                                            <input type="checkbox" className="checkbox-input" id={"checkbox"+value.annid} />
                                            <label htmlFor={"checkbox"+value.annid}>
                                                <span className="checkbox"></span>
                                            </label>
                                        </div>
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
                            {(playerData && blockFunctions && blockFunctions.functionAccess >= playerData.job.grade ) && <div className="remove-btn" id="confirm-button" onClick={() => confirmRemoveAnno()}>{Locale['CONFIRM_ANNOUNCEMENT'] || 'Confirm'}</div>}
                            {(playerData && blockFunctions && blockFunctions.functionAccess >= playerData.job.grade ) && <div className="remove-btn" onClick={() => removeAnno()}>{Locale['REMOVE_ANNOUNCEMENT'] || 'Add announcement'}</div>}
                            {(playerData && blockFunctions && blockFunctions.functionAccess >= playerData.job.grade ) && <div className="btn" onClick={() => setModal(true)}>{Locale['ADD_ANNOUNCEMENT'] || 'Add announcement'}</div>}
                        </div>

                    </div>
                </div>
            </div>
        </>
        
    )
}

export default Annoucements