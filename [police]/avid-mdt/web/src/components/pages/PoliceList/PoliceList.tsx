import React from "react";
import { usePoliceListState } from "../../../state/policeList";
import { debugData } from "../../../utils/debugData";
import "./PoliceList.scss"
import '../../color_settings.scss'
import TitleBlock from "../../TitleBlock";
import { usePlayerDataState } from "../../../state/playerData";
import { fetchNui } from "../../../utils/fetchNui";
import { useLocaleState } from "../../../state/locale";
import { useBlockSettingsState } from "../../../state/blocksettings";


debugData([
    {
        action: 'setPoliceList',
        data: [

            {
                id: 1,
                badge: "[01]",
                firstname: "Chris",
                lastname: "Frog",
                status: "Dostępny",
                user_grade: "Szef Policji",
            },
        ]
    }
])

const PoliceList: React.FC = () => {
    const Locale = useLocaleState()

    const policeList = usePoliceListState()
    const playerData = usePlayerDataState()
    const blockFunctions = useBlockSettingsState()


    const kickFromDuty = (id: number) => {
        fetchNui('kickFromDuty', {id})
    }

    return (
        <div className="policelist-container">
            <div className="policelist">
                <TitleBlock text={Locale['POLICELIST']}/>
                {(playerData && blockFunctions && playerData.job.grade >= blockFunctions.functionAccess ) ?
                    <>
                        <div className="container">
                            <div className="policelist-header">
                                <span style={{width: "150px"}}>
                                    {Locale['POLICELIST_BADGE']}
                                </span>
                                <span style={{width: "350px"}}>
                                    {Locale['POLICELIST_OFFICER']}
                                </span>
                                <span style={{width: "215px"}}>
                                    {Locale['POLICELIST_GRADE']}
                                </span>
                                <span style={{width: "182px"}}>
                                    {Locale['POLICELIST_STATUS']}
                                </span>
                            </div>

                            <div className="policelist-results">
                                <table>
                                    {policeList.map((value, index) => (
                                        <tr key={index} className="policelist-row">
                                            <td style={{width: "150px"}}>
                                                <span>{value.badge}</span>
                                            </td>
                                            <td style={{width: "350px"}}>
                                                <span>{value.firstname + " " + value.lastname}</span>
                                            </td>
                                            <td style={{width: "215px"}}>
                                                <span>{value.user_grade}</span>
                                            </td>
                                            <td style={{width: "182px"}}>
                                                <span>{value.status}</span>
                                            </td>
                                        </tr>
                                    ))}
                                </table>
                            </div>

                        </div>
                    </>

                    :

                    <>
                        <div className="container">
                            <div className="policelist-header">
                                <span style={{width: "150px"}}>
                                    {Locale['POLICELIST_BADGE']}
                                </span>
                                <span style={{width: "250px"}}>
                                    {Locale['POLICELIST_OFFICER']}
                                </span>
                                <span style={{width: "215px"}}>
                                    {Locale['POLICELIST_GRADE']}
                                </span>
                                <span style={{width: "170px"}}>
                                    {Locale['POLICELIST_STATUS']}
                                </span>
                                <span style={{width: "100px"}}>
                                    {Locale['POLICELIST_ACTIONS']}
                                </span>
                            </div>

                            <div className="policelist-results">
                                <table>
                                    {policeList.map((value, index) => (
                                        <tr key={index} className="policelist-row">
                                            <td style={{width: "150px"}}>
                                                <span>{value.badge}</span>
                                            </td>
                                            <td style={{width: "250px"}}>
                                                <span>{value.firstname + " " + value.lastname}</span>
                                            </td>
                                            <td style={{width: "215px"}}>
                                                <span>{value.user_grade}</span>
                                            </td>
                                            <td style={{width: "170px"}}>
                                                <span>{value.status}</span>
                                            </td>
                                            <td className="kick_player" style={{width: "100px"}} onClick={() => kickFromDuty(value.id)}>
                                                <div>{Locale['POLICELIST_KICK_FROM_DUTY']}</div>
                                            </td>
                                        </tr>
                                    ))}
                                </table>
                            </div>
                        </div>
                    </>
                }
            </div>
        </div>
    )
}

export default PoliceList