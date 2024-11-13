import React, { useEffect, useRef, useState } from "react";
import './Settings.scss'
import '../../color_settings.scss'
import TitleBlock from "../../TitleBlock";
import { fetchNui } from "../../../utils/fetchNui";
import { useNuiEvent } from "../../../hooks/useNuiEvent";
import { useLocaleState } from "../../../state/locale";
import { useLanguageState } from "../../../state/languages";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faSave, faX } from "@fortawesome/free-solid-svg-icons";


const Settings: React.FC = () => {
    const Locale = useLocaleState()

    const [mdtColor, setMDTcolor] = useState<string | null>('#0D141F')
    const [mainColor, setMainColor] = useState<string | null>('#111925')
    const [secondColor, setSecondColor] = useState<string | null>('#0D141F')
    const [thirdColor, setThirdColor] = useState<string | null>('#1E2839')
    const [fourthColor, setFourthColor] = useState<string | null>('#316BFF')
    const [choosedLanguage, setChoosedLanguage] = useState<string | null>()
    const [MDTScale, setMDTScale] = useState<string>("1")
    const languages = useLanguageState()

    useNuiEvent('updateSettings', (data) => {
        document.body.style.setProperty('--mdtColor', data.mdt_color)
        document.body.style.setProperty('--mainColor', data.main_color)
        document.body.style.setProperty('--secondColor', data.second_color)
        document.body.style.setProperty('--thirdColor', data.third_color)
        document.body.style.setProperty('--fourthColor', data.fourth_color)

        const mdt = document.getElementById('mdt-color') as HTMLInputElement
        const main = document.getElementById('main-color') as HTMLInputElement
        const second = document.getElementById('second-color') as HTMLInputElement
        const third = document.getElementById('third-color') as HTMLInputElement
        const fourth = document.getElementById('fourth-color') as HTMLInputElement
        const language = document.getElementById('setting_language') as HTMLSelectElement
        const mdtscale = document.getElementById('range-item') as HTMLInputElement
        const mdtscale2 = document.getElementById('number-item') as HTMLInputElement

        mdt.value = data.mdt_color
        main.value = data.main_color
        second.value = data.second_color
        third.value = data.third_color
        fourth.value = data.fourth_color
        language.value = data.language
        mdtscale.value = data.mdtscale
        mdtscale2.value = data.mdtscale

        setMDTcolor(data.mdt_color)
        setMainColor(data.main_color)
        setSecondColor(data.second_color)
        setThirdColor(data.third_color)
        setFourthColor(data.fourth_color)
        setChoosedLanguage(data.language)
        setMDTScale(data.mdtscale)
    })

    const changeLanguage = () => {
        const selected = document.getElementById('setting_language') as HTMLSelectElement
        const selected_value = selected.value
        setChoosedLanguage(selected_value)
    }

    const changeMDTColor = (color: string) => {
        document.body.style.setProperty('--mdtColor', color)
        setMDTcolor(color)
    }

    const changeMainColor = (color: string) => {
        document.body.style.setProperty('--mainColor', color)
        setMainColor(color)
    }

    const changeSecondColor = (color: string) => {
        document.body.style.setProperty('--secondColor', color)
        setSecondColor(color)
    }

    const changeThirdColor = (color: string) => {
        document.body.style.setProperty('--thirdColor', color)
        setThirdColor(color)
    }

    const changeFourthColor = (color: string) => {
        document.body.style.setProperty('--fourthColor', color)
        setFourthColor(color)
    }

    const changeResizeMDT = (scale: string) => {
        const numberitem = document.getElementById('number-item') as HTMLInputElement
        
        numberitem.value = scale
        setMDTScale(scale)
    }

    const saveSettings = () => {
        fetchNui('saveSettings', {type: 'save', mdtColor, mainColor, secondColor, thirdColor, fourthColor, choosedLanguage, MDTScale})
    }

    const resetSettings = () => {
        document.body.style.setProperty('--mdtColor', '#0D141F')
        document.body.style.setProperty('--mainColor', '#111925')
        document.body.style.setProperty('--secondColor', '#0D141F')
        document.body.style.setProperty('--thirdColor', '#1E2839')
        document.body.style.setProperty('--fourthColor', '#316BFF')

        var mdt = document.getElementById('mdt-color') as HTMLInputElement
        var main = document.getElementById('main-color') as HTMLInputElement
        var second = document.getElementById('second-color') as HTMLInputElement
        var third = document.getElementById('third-color') as HTMLInputElement
        var fourth = document.getElementById('fourth-color') as HTMLInputElement
        const mdtscale = document.getElementById('range-item') as HTMLInputElement
        const mdtscale2 = document.getElementById('number-item') as HTMLInputElement


        mdt.value = '#0D141F'
        main.value = '#111925'
        second.value = '#0D141F'
        third.value = '#1E2839'
        fourth.value = '#316BFF'
        mdtscale.value = "1"
        mdtscale2.value = "1"

        setMDTcolor('#0D141F')
        setMainColor('#111925')
        setSecondColor('#0D141F')
        setThirdColor('#1E2839')
        setFourthColor('#316BFF')
        setMDTScale("1")
        setChoosedLanguage('reset')

        fetchNui('saveSettings', {type: 'reset', mdtColor: '#0D141F', mainColor: '#111925', secondColor: '#0D141F', thirdColor: '#1E2839', fourthColor: '#316BFF', MDTScale: "1", choosedLanguage: 'reset'})
    }


    return (
        <div className="settings-container">
            <div className="settings">
                <TitleBlock text={Locale['SETTINGS']}/>
                <div className="settings-content">
                    <div className="sett-mdt-color">
                        <label htmlFor="mdt-color">{Locale['SETTINGS_MDT_COLOR']}</label>
                        <input id="mdt-color" type="color" defaultValue="#0D141F" onChange={(e) => changeMDTColor(e.target.value)}></input>
                    </div>
                    <div className="sett-main-color">
                        <label htmlFor="main-color">{Locale['SETTINGS_MAIN_COLOR']}</label>
                        <input id="main-color" type="color" defaultValue="#111925" onChange={(e) => changeMainColor(e.target.value)}></input>
                    </div>
                    <div className="sett-second-color">
                        <label htmlFor="second-color">{Locale['SETTINGS_SECOND_COLOR']}</label>
                        <input id="second-color" type="color" defaultValue="#0D141F" onChange={(e) => changeSecondColor(e.target.value)}></input>
                    </div>
                    <div className="sett-third-color">
                        <label htmlFor="third-color">{Locale['SETTINGS_THIRD_COLOR']}</label>
                        <input id="third-color" type="color" defaultValue="#1E2839" onChange={(e) => changeThirdColor(e.target.value)}></input>
                    </div>
                    <div className="sett-fourth-color">
                        <label htmlFor="fourth-color">{Locale['SETTINGS_FOURTH_COLOR']}</label>
                        <input id="fourth-color" type="color" defaultValue="#316BFF" onChange={(e) => changeFourthColor(e.target.value)}></input>
                    </div>
                    <div className="sett-resize">
                        Size of MDT

                        <div className="sett-resize-content">

                            <div className="sett-resize-range">
                                <input type="range" className="range-item" id="range-item" min="0.1" max="1.5" step="0.1" defaultValue={MDTScale} onChange={(e) => changeResizeMDT(e.target.value)}></input>
                            </div>

                            <div className="sett-resize-input">
                                <input type="number" className="number-item" id="number-item" value={MDTScale} disabled></input>
                            </div>
                        </div>
                    </div>

                    <select id="setting_language" onChange={changeLanguage}>
                        {languages.map((value, index) => (
                            <>
                                <option value={value.file_name} selected={(value.selected) ? true : false}>{value.label}</option>
                            </>
                        ))}
                    </select>
                    

                    <div className="sett-buttons">
                        <button className="sett-save" onClick={saveSettings}>{Locale['SETTINGS_SAVE']}</button>  
                        <button className="sett-reset" onClick={resetSettings}>{Locale['SETTINGS_RESET']}</button>  
                    </div>
                </div>
            </div>
        </div>
    )
}

export default Settings