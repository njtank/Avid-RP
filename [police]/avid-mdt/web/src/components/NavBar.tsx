import React, { Dispatch, SetStateAction, useState } from "react";
import './Navbar.scss'
import './color_settings.scss'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faHome, faFolderOpen, faBullhorn, faHandcuffs, faCircleInfo, faHotel, faHandPaper, faWalkieTalkie, faCar, faPerson, faCamera, faMoneyBillWave, faBlackboard } from '@fortawesome/free-solid-svg-icons'
import { fetchNui } from "../utils/fetchNui";
import { useLocaleState } from "../state/locale";
import { filesShower } from "./App";
import { usePlayerDataState } from "../state/playerData";
import { useBlockSettingsState } from "../state/blocksettings";


interface navElement {
    icon: any,
    title: string,
    subtitle: string,
    href: string
}

const NavBar: React.FC<{href: string, setHref: Dispatch<SetStateAction<string>>}> = ({href, setHref}) => {
    const Locale = useLocaleState()
    let navigations: navElement[] = []
    const [showSettings, setShowSettings] = useState<boolean>(true)
    const playerData = usePlayerDataState()
    const blockSettings = useBlockSettingsState()

    if((blockSettings?.blockSettings == true) && (typeof(playerData?.job.grade) == 'number') && (blockSettings?.blockSettingsGrade > playerData?.job.grade)){
        if(showSettings == true){
            setShowSettings(false)
        }
    } else {
        if(showSettings == false){
            setShowSettings(true)
        }
    }

    navigations.push({
        icon: faHome,
        title: Locale['MAIN_PAGE_TITLE'] || 'Home',
        subtitle: Locale['MAIN_PAGE_DESC'] || '',
        href: 'home'
    })

    navigations.push({
        icon: faBullhorn,
        title: Locale['ANNOUCEMENTS_PAGE_TITLE'] || 'Annoucements',
        subtitle: Locale['ANNOUCEMENTS_PAGE_DESC'] || '',
        href: 'annoucements'
    })

    if(filesShower){
        navigations.push({
            icon: faFolderOpen,
            title: Locale['FILES_PAGE_TITLE'] || 'Files',
            subtitle: Locale['FILES_PAGE_DESC'] || '',
            href: 'files'
        })
    } else {
        navigations.push({
            icon: faPerson,
            title: Locale['CITIZEN_FILE'] || 'Citizen file',
            subtitle: Locale['FILES_PAGE_DESC'] || '',
            href: 'FilesCitizen'
        })
        navigations.push({
            icon: faCar,
            title: Locale['VEHICLES_FILE'] || 'Vehicles file',
            subtitle: Locale['FILES_PAGE_DESC'] || '',
            href: 'FilesVehicle'
        })
    }

    navigations.push({
        icon: faHandcuffs,
        title: Locale['POLICE_PAGE_TITLE'] || 'Police List',
        subtitle: Locale['POLICE_PAGE_DESC'] || '',
        href: 'policelist'
    })
    
    navigations.push({
        icon: faHotel,
        title: Locale['POLICE_PAGE_HOUSES'] || 'House List',
        subtitle: '',
        href: 'houses'
    })

    navigations.push({
        icon: faWalkieTalkie,
        title: Locale['POLICE_PAGE_CODES'] || 'Radio Codes',
        subtitle: '',
        href: 'codes'
    })

    navigations.push({
        icon: faHandPaper,
        title: Locale['POLICE_PAGE_WARRANTS'] || 'Warrants',
        subtitle: '',
        href: 'warrants'
    })

    navigations.push({
        icon: faCamera,
        title: Locale['EVIDENCES'] || 'Evidences',
        subtitle: '',
        href: 'evidences'
    })

    if(blockSettings?.notifDispatch && blockSettings?.qfDispatch){
        navigations.push({
            icon: faCircleInfo,
            title: Locale['DISPATCH_PAGE_TITLE1'] || 'Notifications',
            subtitle: '',
            href: 'notifdispatch'
        })

        navigations.push({
            icon: faCircleInfo,
            title: Locale['DISPATCH_PAGE_TITLE2'] || 'Dispatch',
            subtitle: '',
            href: 'dispatch'
        })
    } else {
        if(blockSettings?.notifDispatch){
            navigations.push({
                icon: faCircleInfo,
                title: Locale['DISPATCH_PAGE_TITLE'] || 'Dispatch',
                subtitle: '',
                href: 'notifdispatch'
            })
        } else if(blockSettings?.qfDispatch) {
            navigations.push({
                icon: faCircleInfo,
                title: Locale['DISPATCH_PAGE_TITLE'] || 'Dispatch',
                subtitle: '',
                href: 'dispatch'
            })
        } else if(blockSettings?.cdDispatch) {
            navigations.push({
                icon: faCircleInfo,
                title: Locale['DISPATCH_PAGE_TITLE'] || 'Dispatch',
                subtitle: '',
                href: 'dispatch'
            })
        }
    }

    const closeUI = () => {
        fetchNui("closeUI")
    }

    var aaa = document.getElementById('second_href') as HTMLSpanElement

    const NavigationButton: React.FC<{data: navElement}> = ({data}) => {
        return (
            <div className={"navbar-button " + (data.href == href ? 'selected' : '')} onClick={() => {setHref(data.href); aaa.textContent = ''}}>
                <div className="navbar-icon">
                    <FontAwesomeIcon icon={data.icon}/>
                </div>
                <div className="navbar-desc">
                    <p className="navbar-title">{data.title}</p>
                    {/* <p className="navbar-subtitle">{data.subtitle}</p> */}
                </div>
            </div>
        )
    }

    return (
        <div className="navbar">
            <div className="logo">
                <div className="logo-title">
                    <p style={{color: '#316BFF'}}>{Locale['JOB_TITLE'] || 'POLICE'}</p>
                    <p>{Locale['MDT_TITLE'] || 'MDT LSPD'}</p>
                </div>
                <div className="logo-rectangle">

                </div>
                <div className="logo-subtitle">
                    {Locale['MDT_DESC'] || ''}
                </div>
            </div>

            <div className="navigation">
                {navigations.map((value, index) => (
                    <NavigationButton key={index} data={value}/>
                ))}
            </div>
            <div className="nav-footer">
                    {(showSettings == true) ?
                        <>
                            <button onClick={() =>  setHref("settings")}>
                                {Locale['SETTINGS'] || 'Settings'}
                            </button>
                        </>

                        :

                        <>
                            <button style={{opacity: 0.0}}>
                                {Locale['SETTINGS'] || 'Settings'}
                            </button>
                        </>

                    }

                <button onClick={() => setHref("notes")}>
                    {Locale['NOTEPAD'] || 'Notepad'}
                </button>
                <button className="long" onClick={() => closeUI()}>
                    {Locale['LOGOUT'] || 'Logout'}
                </button>
            </div>
        </div>
    )
}

export default NavBar