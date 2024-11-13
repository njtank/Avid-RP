import React, {useRef} from "react";
import "./Modal.scss"
import "../color_settings.scss"
import { SingleModalT } from "../../types/modal";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faX } from "@fortawesome/free-solid-svg-icons";

const SingleModal: React.FC<SingleModalT> = ({label, onSubmit, onCancel, placeholder, submitLabel}) => {
    
    const firstRef = useRef<HTMLTextAreaElement>(null)

    const submit = () => {
        if (!firstRef.current) return;
        const firstValue: string = firstRef.current.value
        if (!firstValue) return;
        onSubmit(firstValue)
        firstRef.current.value = ""
    }
    
    function tabPrevent(){
        const textarea = document.getElementById('modal-textarea') as HTMLInputElement
        textarea.focus()
    }

    return (
        <>
            <div className="background" onClick={() => onCancel()}></div>
            <div className="modal-container">
                <div className="modal-header">
                    <div className="modal-label">
                        {label}
                    </div>
                    <div className="modal-close" onClick={() => onCancel()}>
                        <FontAwesomeIcon icon={faX}/>
                    </div>
                </div>
                <div className="modal-content">
                    <textarea placeholder={placeholder} id="modal-textarea" ref={firstRef} onBlur={tabPrevent}>
                        
                    </textarea>
                </div>
                <div className="modal-footer">
                    <div className="btn" onClick={() => submit()}>
                        {submitLabel}
                    </div>
                </div>
            </div>
        </>
    )
}

export default SingleModal