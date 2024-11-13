import { useState } from "react"
import SingleModal from "../../../Modals/SingleModal"
import TitleBlock from "../../../TitleBlock"
import './warrant.scss'
import '../../../color_settings.scss'
import { useLocaleState } from "../../../../state/locale"
import { usePlayerDataState } from "../../../../state/playerData"
import { useBlockSettingsState } from "../../../../state/blocksettings"
import { fetchNui } from "../../../../utils/fetchNui"


const WarrantData: React.FC<{data: any, refresh: () => void}> = ({data, refresh}) => {
    const [imagePreview, setImagePreview] = useState<boolean>(false)
    const Locale = useLocaleState()
    const blockFunctions = useBlockSettingsState()
    const playerData = usePlayerDataState()


    const imagePreviewed = (data: string) => {
        if(data.includes('.png') || data.includes('.jpg') || data.includes('.jpeg') || data.includes('.gif')){
            setImagePreview(true)
            setTimeout(() => {
                const imager = document.getElementById('image_viewer')
                if( imager ){ imager.innerHTML = '<img src="'+data+'">' }
            }, 50);
        } else if (data.includes('.mp4') || data.includes('.mov')){
            setImagePreview(true)
            setTimeout(() => {
                const imager = document.getElementById('image_viewer')
                if( imager ){ imager.innerHTML = '<video src="'+data+'" controls>' }
            }, 50);
        }
    }

    const deleteWarrant = (warrant: string) => {
        fetchNui('deleteWarrant', warrant)
    }
 
    return (
        <>
        {imagePreview && <div className="image-viewer" id="image_viewer" onClick={() => setImagePreview(false)}></div>}

        <div className="warrantcontainer" id="warrantshower">
            <TitleBlock text={Locale['WARRANT_CASE'] + data.id}/>
            <div className="warrant_creator">


                <div className="first_arg">
                    <span>{Locale['WARRANT_TITLE']}</span>
                    <input id="warrant_creator_input_title" type="text" placeholder={Locale['WARRANT_TITLE']+"..."} value={data.title} disabled></input>
                </div>

                <div className="second_arg">
                    <span>{Locale['WARRANT_DESCRIPTION']}</span>
                    <textarea id="warrant_creator_input_description" placeholder={Locale['WARRANT_DESCRIPTION']+"..."} value={data.subtitle} disabled></textarea>
                </div>

                <div className="third_arg">
                    <span>{Locale['WARRANT_OFFICERS_INVOLVED']}</span>
                    <div className="warrant_creator_officers_involved" id="officers_involved2">
                        {data.officer_involved.map((value: any, index: number) => (
                            <div key={index} className="officer_involved"><span>{value}</span></div>
                        ))}
                    </div>
                </div>

                <div className="fourth_arg">
                    <span>{Locale['WARRANT_CITIZEN_INVOLVED']}</span>
                    <div className="warrant_creator_citizen_involved" id="citizens_involved2">
                        {data.citizen_involved.map((value: any, index: number) => (
                            <div key={index} className="citizen_involved"><span>{value}</span></div>
                        ))}
                    </div>
                </div>

                <div className="fifth_arg">
                    <span>{Locale['WARRANT_ATTACHMENTS']}</span>
                    <div className="warrant_creator_images" id="images_included2">
                        {data.images.length < 1 &&
                            <>
                                <img src="https://media.discordapp.net/attachments/1028038548521230368/1136656400534208613/no_image.png" />
                            </>
                        }

                        {data.images.map((value: any, index: number) => (
                            <img key={index} src={value} onClick={() => imagePreviewed(value)}></img>
                            // <div key={index} className="image_button" onClick={() => imagePreviewed(value)}><span>{Locale['WARRANT_ATTACHMENT']+" "+index+" "+Locale['WARRANT_CLICK_TO_PREV']}</span></div>
                        ))}
                    </div>
                </div>

                {(playerData && blockFunctions && blockFunctions.functionAccess >= playerData.job.grade ) &&
                    <div className="delete_btn" onClick={() => deleteWarrant(data.id)}><div className="btn">{Locale['DELETE']}</div></div>
                }
            </div>



        </div>
        </>
    )
}

export default WarrantData