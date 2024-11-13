import { useState } from "react"
import SingleModal from "../../../Modals/SingleModal"
import TitleBlock from "../../../TitleBlock"
import './create_evidence.scss'
import '../../../color_settings.scss'
import { fetchNui } from "../../../../utils/fetchNui"
import { useLocaleState } from "../../../../state/locale"

const CreateEvidence: React.FC<{refresh: () => void}> = ({refresh}) => {
    const [officerInvolved, setModalOfficers] = useState<boolean>(false)
    const [citizenInvolved, setModalCitizen] = useState<boolean>(false)
    const [imagesIncluded, setModalImages] = useState<boolean>(false)
    const [imagePreview, setImagePreview] = useState<boolean>(false)

    const [evidenceTitle, setEvidenceTitle] = useState<string | null>(null);
    const [evidenceDescription, setEvidenceDescription] = useState<string | null>(null);

    const [officerList, setOfficerList] = useState<{ [key: number]: string } | null>(null);
    const [citizenList, setCitizenList] = useState<{ [key: number]: string } | null>(null);
    const [imagesList, setImagesList] = useState<{ [key: number]: string } | null>(null);

    const [officerId, setOfficerId] = useState<number>(1)
    const [citizenId, setCitizenId] = useState<number>(1)
    const [imagesId, setImagesId] = useState<number>(1)

    const Locale = useLocaleState()

    function cancelModal(){
        setModalOfficers(false)
        setModalCitizen(false)
        setModalImages(false)
    }


    const removeOfficer = (type: string, elementid: string, itemId: number) => {
        var elem = document.getElementById(elementid)
        elem?.remove()

        if(type === 'image'){
            setTimeout(() => {
                setImagesList((prevImagesList) => {
                    if (prevImagesList === null) {
                        return null;
                    } else {
                        const updatedImagesList = { ...prevImagesList };
              
                        if (itemId in updatedImagesList) {
                            delete updatedImagesList[itemId];
                        }
              
                        return updatedImagesList;
                    }
                  });
    
                setImagePreview(false)
            }, 10);
        } else if (type == 'officer') {
            setOfficerList((prevOfficer) => {
                if (prevOfficer === null) {
                    return null;
                } else {
                    const updatedOfficerList = { ...prevOfficer };
          
                    if (itemId in updatedOfficerList) {
                        delete updatedOfficerList[itemId];
                    }
          
                    return updatedOfficerList;
                }
              });
        } else if (type == 'citizen') {
            setCitizenList((prevCitizen) => {
                if (prevCitizen === null) {
                    return prevCitizen;
                } else {
                    const updatedCitizenList = { ...prevCitizen };
          
                    if (itemId in updatedCitizenList) {
                        delete updatedCitizenList[itemId];
                    }
          
                    return updatedCitizenList;
                }
              });
        }

    }

    const submitOfficer = (data: string) => {
        setModalOfficers(false)
        setOfficerId(officerId + 1)

        setOfficerList((prevOfficer) => {
            if (prevOfficer === null) {
                return {[officerId]: data};
            } else {
                return {... prevOfficer, [officerId]: data};
            }
        });

        const officerList = document.getElementById('officers_involved')
        const newOfficer = document.createElement("div")
        newOfficer.innerHTML = "<span>"+data+"</span>"
        newOfficer.id = "officer_id="+officerId
        newOfficer.classList.add("officer_involved")

        const removeOfficerButton = document.createElement('span')
        removeOfficerButton.innerHTML = '<i class="fa-regular fa-trash-can"></i>'
        removeOfficerButton.classList.add("removeofficer_button")
        removeOfficerButton.addEventListener('click', (e:Event) => removeOfficer('officer', 'officer_id='+officerId, officerId))
        newOfficer?.appendChild(removeOfficerButton)

        officerList?.appendChild(newOfficer)
    }

    const submitCitizen = (data: string) => {
        setModalCitizen(false)
        setCitizenId(citizenId + 1)



        setCitizenList((prevCitizen) => {
            if (prevCitizen === null) {
                return {[citizenId]: data};
            } else {
                return {... prevCitizen, [citizenId]: data};
            }
        });

        const citizenList = document.getElementById('citizens_involved')
        const newCitizen = document.createElement("div")
        newCitizen.innerHTML = "<span>"+data+"</span>"
        newCitizen.id = "citizen_id="+citizenId
        newCitizen.classList.add("citizen_involved")

        const removeCitizenButton = document.createElement('span')
        removeCitizenButton.innerHTML = '<i class="fa-regular fa-trash-can"></i>'
        removeCitizenButton.classList.add("removecitizen_button")
        removeCitizenButton.addEventListener('click', (e:Event) => removeOfficer('citizen', 'citizen_id='+citizenId, citizenId))
        newCitizen?.appendChild(removeCitizenButton)

        citizenList?.appendChild(newCitizen)
    }

    const imagePreviewed = (data: string) => {
        
        setImagePreview(true)
        setTimeout(() => {
            const imager = document.getElementById('image_viewer')
            if( imager ){ imager.innerHTML = '<img src="'+data+'">' }
        }, 50);
    }

    const videoPreviewed = (data: string) => {
        
        setImagePreview(true)
        setTimeout(() => {
            const imager = document.getElementById('image_viewer')
            if( imager ){ imager.innerHTML = '<video src="'+data+'" controls>' }
        }, 50);
    }

    const submitImage = (data: string) => {
        setModalImages(false)

        if(!data.includes('.png') && !data.includes('.jpg') && !data.includes('.jpeg') && !data.includes('.gif') && !data.includes('.mp4') && !data.includes('.mov')){return;}
        
        setImagesId(imagesId + 1)

        setImagesList((prevImagesList) => {
            if (prevImagesList === null) {
                return {[imagesId]: data};
            } else {
                return {... prevImagesList, [imagesId]: data};
            }
        });
        
        const imagesList = document.getElementById('images_included')
        const newImage = document.createElement('div')
        if(data.includes('.mp4')){
            newImage.addEventListener('click', (e:Event) => videoPreviewed(data))
        } else {
            newImage.addEventListener('click', (e:Event) => imagePreviewed(data))
        }
        newImage.innerHTML = Locale['EVIDENCE_ATTACHMENT']+" "+imagesId+" "+Locale['EVIDENCE_CLICK_TO_PREV']
        newImage.id = "image_id="+imagesId
        newImage.classList.add("image_included")

        const removeImageButton = document.createElement('span')
        removeImageButton.innerHTML = '<i class="fa-regular fa-trash-can"></i>'
        removeImageButton.classList.add("removeimage_button")
        removeImageButton.addEventListener('click', (e:Event) => removeOfficer('image', 'image_id='+imagesId, imagesId))
        newImage?.appendChild(removeImageButton)

        imagesList?.appendChild(newImage)

    }

    const submitEvidence = () => {
        fetchNui('newEvidence', {title: evidenceTitle, description: evidenceDescription, officers: officerList, citizens: citizenList, images: imagesList})
        refresh()
    }

    return (
        <>
            {officerInvolved && <SingleModal label={Locale['EVIDENCE_OFFICERS_INVOLVED']} placeholder={Locale['EVIDENCE_OFFICERS_INVOLVED_SUBTITLE']} onSubmit={submitOfficer} onCancel={cancelModal} submitLabel={Locale['EVIDENCE_MODAL_ADD']}/>}
            {citizenInvolved && <SingleModal label={Locale['EVIDENCE_CITIZEN_INVOLVED']} placeholder={Locale['EVIDENCE_CITIZEN_INVOLVED_SUBTITLE']} onSubmit={submitCitizen} onCancel={cancelModal} submitLabel={Locale['EVIDENCE_MODAL_ADD']}/>}
            {imagesIncluded && <SingleModal label={Locale['EVIDENCE_ATTACHMENTS']} placeholder="https://media.discordapp.net/attachments/.../.../..." onSubmit={submitImage} onCancel={cancelModal} submitLabel={Locale['EVIDENCE_MODAL_ADD']}/>}
            {imagePreview && <div className="image-viewer" id="image_viewer" onClick={() => setImagePreview(false)}></div>}

            <div className="evidencecontainer" id="createevidence">
                <TitleBlock text={Locale['EVIDENCE_CREATE_TITLE']}/>
                <div className="evidence_creator">
                    <div className="first_arg">
                        <span>{Locale['EVIDENCE_TITLE']}</span>
                        <input id="evidence_creator_input_title" type="text" placeholder={Locale['EVIDENCE_TITLE']+"..."} onBlur={(e) => setEvidenceTitle(e.target.value)}></input>
                    </div>

                    <div className="second_arg">
                        <span>{Locale['EVIDENCE_DESCRIPTION']}</span>
                        <textarea id="evidence_creator_input_description" placeholder={Locale['EVIDENCE_DESCRIPTION']+"..."} onBlur={(e) => setEvidenceDescription(e.target.value)}></textarea>
                    </div>

                    <div className="third_arg">
                        <span>{Locale['EVIDENCE_OFFICERS_INVOLVED']}</span>
                        <div className="evidence_creator_officers_involved" id="officers_involved">
                            <div className="add_button_oi add_button_involved" onClick={() => setModalOfficers(true)}>+</div>
                        </div>
                    </div>

                    <div className="fourth_arg">
                        <span>{Locale['EVIDENCE_CITIZEN_INVOLVED']}</span>
                        <div className="evidence_creator_citizen_involved" id="citizens_involved">
                            <div className="add_button_ci add_button_involved" onClick={() => setModalCitizen(true)}>+</div>
                        </div>
                    </div>

                    <div className="fifth_arg">
                        <span>{Locale['EVIDENCE_ATTACHMENTS']}</span>
                        <div className="evidence_creator_images" id="images_included">
                            <div className="add_button_image add_button_involved" onClick={() => setModalImages(true)}>+</div>
                        </div>
                    </div>

                    <div className="buttons">
                        <button className="finish_evidence" onClick={submitEvidence}>{Locale['EVIDENCE_CREATE_SAVE']}</button>
                    </div>
                </div>



            </div>
        </>
    )
}

export default CreateEvidence