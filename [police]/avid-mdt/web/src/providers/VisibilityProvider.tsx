import React, {Context, createContext, useContext, useEffect, useState} from "react";
import {useNuiEvent} from "../hooks/useNuiEvent";
import {fetchNui} from "../utils/fetchNui";
import { isEnvBrowser } from "../utils/misc";
import './vp.scss'


const VisibilityCtx = createContext<VisibilityProviderValue | null>(null)

interface VisibilityProviderValue {
  setVisible: (visible: boolean) => void
  visible: boolean
}

interface DispatchNotiff {
  id: string,
  localization: {
      x: number,
      y: number,
      z: number,
  },
  title: string,
  subtitle: string,
  code: string,
  color: string,
  time: string,
  response: number,
}

export const VisibilityProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [visible, setVisible] = useState(false)


  useNuiEvent<boolean>('setVisible', setVisible)


  useNuiEvent<string>('setMDTScale', (data) => {
    const resize = document.getElementById('scaling_div')

    if(resize){
      resize.style.transform = `scale(${data})`
    }
  })

  // if (visible) {
  //   const windowWidth = window.innerWidth
  //   const casualWidth = 1920

  //   let scale = windowWidth / casualWidth

  //   const scaledDiv = document.getElementById('scaling_div')

  //   if (scaledDiv){
  //     scaledDiv.style.transform = `scale(${scale})`
  //   }
  // }

  useNuiEvent<DispatchNotiff>('addScreenNotif', (data) => {
    
    const notif_id = data.id
    const firstDiv = document.createElement('div')
    firstDiv.className = 'DispatchAlert'
    firstDiv.id = notif_id

    if(!data.color){
        data.color = 'rgb(17, 25, 37)'
    }
    
    const colorek = data.color.replace('rgb(', '').replace(')', '').split(',')
    firstDiv.style.backgroundColor = `rgba(${colorek[0]}, ${colorek[1]}, ${colorek[2]}, 0.3)`

    const secondDiv = document.createElement('div')
    secondDiv.className = 'daMainContent'

    const leftSide = document.createElement('div')
    leftSide.className = 'dispatchalert_leftside'

        const reactions = document.createElement('div')
        reactions.className = 'da_reactions'
        reactions.id = `da_reactions_${notif_id}`
        reactions.setAttribute('data-color', data.color)

        const title = document.createElement('span')
            title.className = 'DAtitle'
        const subtitle = document.createElement('span')
            subtitle.className = 'DAsubtitle'

        title.textContent = data.title
        subtitle.textContent = data.subtitle

        leftSide.append(reactions)
        leftSide.append(title)
        leftSide.append(subtitle)
    
    const rightSide = document.createElement('div')
    rightSide.className = 'dispatchalert_rightside'

        const rightSide_timer = document.createElement('div')
        rightSide_timer.className = 'DAtimer'

            const rightSide_time = document.createElement('div')
            rightSide_time.className = 'da_time'
            rightSide_time.textContent = `${new Date().toLocaleString('pl-PL', { hour: '2-digit', minute:'2-digit', second:'2-digit'})}`


        const rightSide_code = document.createElement('div')
        rightSide_code.className = 'DACode'
        rightSide_code.style.backgroundColor = `rgba(${colorek[0]}, ${colorek[1]}, ${colorek[2]}, 0.6)`
        rightSide_code.style.border = `1px solid ${data.color}`
            
            const code_span = document.createElement('span')
            code_span.textContent = data.code    
    



    rightSide_timer.append(rightSide_time)
    rightSide_code.append(code_span)

    rightSide.append(rightSide_timer)
    rightSide.append(rightSide_code)

    secondDiv.append(leftSide)
    secondDiv.append(rightSide)
    
    firstDiv.append(secondDiv)

    const divParent = document.getElementById('DispatchAlertsContentt')

    if(divParent){
      divParent.append(firstDiv)
    }




    setTimeout(() => {
      firstDiv.remove()
    }, 5 * 1000);
  })


  useEffect(() => {
    if (!visible) return;

    const keyHandler = (e: KeyboardEvent) => {
      if (["Escape"].includes(e.code)) {
        if (!isEnvBrowser()) fetchNui("closeUI");
        else setVisible(!visible);
      }
    }

    window.addEventListener("keydown", keyHandler)

    return () => window.removeEventListener("keydown", keyHandler)
  }, [visible])

  return (
    <VisibilityCtx.Provider
      value={{
        visible,
        setVisible
      }}
    >
    <div style={{ visibility: visible ? 'visible' : 'hidden', height: '100%'}} id="scaling_div">
      {children}
    </div>

    <div className="DispatchAlertsContentt" id="DispatchAlertsContentt" style={{ visibility: visible ? 'hidden' : 'visible', height: '100%' }}></div>
  </VisibilityCtx.Provider>)
}

export const useVisibility = () => useContext<VisibilityProviderValue>(VisibilityCtx as Context<VisibilityProviderValue>)
