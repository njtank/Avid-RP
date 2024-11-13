import './Codes.scss'
import '../../color_settings.scss'
import TitleBlock from "../../TitleBlock";
import { useLocaleState } from "../../../state/locale";
import { useCodeListState } from "../../../state/codes";
import { CodeList } from "../../../types/codes";

const Codes: React.FC = () => {
    const Locale = useLocaleState()

    const codes = useCodeListState();


    return (
        <div className="code-container">
            <div className="codes">
                <TitleBlock text={Locale['CODELIST']}/>

                <div className='codes-flexible'>
                    {codes?.map((value: CodeList, index: number) => (
                        <>
                            <div className="code-cat">
                                <div className="code-cat-name">{value.category}</div>
                                <div className="code-cat-line"></div>
                            </div>
                            {value.data.map((value2, index2) => (
                                <>
                                    <div className="code">
                                        <div className="code-name"><span>{value2.name}</span></div>
                                        <div className="code-content">
                                            <div className="code-title">{value2.title}</div>
                                            <div className="code-subtitle">{value2.subtitle}</div>
                                        </div>
                                    </div>
                                </>
                            ))}
                        </>
                    ))}
                </div>
            </div>

        </div>
    )
}



export default Codes

