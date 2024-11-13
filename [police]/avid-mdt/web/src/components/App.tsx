import React, { useState } from 'react';
import './App.scss'
import './color_settings.scss'
import {debugData} from "../utils/debugData";
import { useNuiEvent } from '../hooks/useNuiEvent';
import { fetchNui } from '../utils/fetchNui';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faChevronLeft, faChevronRight, faX, faSearch } from '@fortawesome/free-solid-svg-icons'

import NavBar from './NavBar';
import Home from './pages/Home/Home';
import Files from './pages/Files/Files';
import FilesCitizen from './pages/Files/FilesCitizen';
import FilesVehicle from './pages/Files/FilesVehicle';
import Annoucements from './pages/Annoucements/Annoucements'
import PoliceList from './pages/PoliceList/PoliceList';
import Notes from './pages/Notes/Notes';
import { Dispatch, CasualDispatch } from './pages/Dispatch/Dispatch';
import Houses from './pages/Houses/Houses';
import Codes from './pages/Codes/Codes';
import Warrants from './pages/Warrants/Warrants';
import Evidences from './pages/Evidences/Evidences';


import Settings from './pages/Settings/Settings';

import PlayerData from '../types/playerData';
import { useSetPlayerData } from '../state/playerData';
import { useLocale, useLocaleState } from '../state/locale';
import { useAnnoucements } from '../state/annoucements';
import { Annoucement } from '../types/annoucements';
import { usePoliceList } from '../state/policeList';
import { PoliceMan } from '../types/police';
import { useSetNotes } from '../state/notes';
import { TariffT } from '../types/tariff';
import { CodeList } from '../types/codes';
import { useSetTariff } from '../state/tariff';
import { useSetUnitsAndVehicles } from '../state/unitsAndVehicles';
import { useSetCodeList } from '../state/codes';
import { housesList } from '../state/houses';
import { HousesList } from '../types/houses';
import { useWarrantList, useWarrantSet } from '../state/warrants';
import { Warrant } from '../types/warrants';
import { useEvidencesList } from '../state/evidences';
import { Evidence } from '../types/evidences';
import { setLanguageList, useLanguageList } from '../state/languages';
import { Languages } from '../types/languages';
import { setBlockSettings } from '../state/blocksettings';
import BlockSettings from '../types/blocksettings';
import { unstable_renderSubtreeIntoContainer } from 'react-dom';
import { UnitsAndVehiclesT } from '../state/unitsAndVehicles'


// This will set the NUI to visible if we are
// developing in browser



debugData([
  {
    action: 'setVisible',
    data: true,
  }
])

debugData([
  {
    action: 'init',
    data: {
      locale: {
        ['UI_TABLET_NAME']: 'Police-MDT.com',
        ['MAIN_PAGE_TITLE']: 'Homepage',
        ['FILES_PAGE_TITLE']: 'Files',
        ['ANNOUCEMENTS_PAGE_TITLE']: 'Announcements',
        ['POLICE_PAGE_TITLE']: 'Police List',
        ['DISPATCH_PAGE_TITLE']: 'Dispatch',
        ['POLICE_PAGE_HOUSES']: 'House List',
        ['POLICE_PAGE_CODES']: 'Radio Codes',
        ['POLICE_PAGE_WARRANTS']: 'Warrants',
        ['JOB_TITLE']: 'LSPD',
        ['MDT_TITLE']: 'MDT LSPD',
        ['MDT_DESC']: 'In MDT you can check citizens, vehicles and perform minor activities.',
        ['SETTINGS']: 'Settings',
        ['LOGOUT']: 'Logout',
        ['NO_NEARBY_PERSON']: 'No nearby person!',
        ['NO_NEARBY_VEHICLE']: 'No nearby vehicle!',
        ['STATUS_AVAILABLE']: 'Available',
        ['STATUS_NOAVAILABLE']: 'Unavailable',
        ['STATUS_S2']: 'Status 2',
        ['STATUS_S5']: 'Status 5',
        ['STATUS_S4']: 'Status 4',
        ['STATUS_S8']: 'Status 8',
        ['BACK']: 'Previous page',
        ['DISPATCH_ON_DUTY']: 'On Duty',
        ['CLEAR_DISPATCH']: 'Clear dispatch',
        ['YES']: 'YES',
        ['NO']: 'NO',
    
        ['ANNOUNCEMENT_TITLE']: 'Announcement Title',
        ['ANNOUNCEMENT_CONTENT']: 'Announcement content',
        ['ADD_ANNOUNCEMENT']: 'Add announcement',
        ['REMOVE_ANNOUNCEMENT']: 'Remove announcement',
        ['CONFIRM_ANNOUNCEMENT']: 'Confirm',
    
        ['FILES_SEARCHER']: 'Search for ',
        ['FILES_SEARCH_FOR_CITIZEN']: 'citizen',
        ['FILES_SEARCH_FOR_CAR']: 'car',
        ['FILES_SEARCH_FOR_CAR2']: 'Vehicle',
        ['FILES_NEAREST']: 'Nearest',
        ['FILES_NAME']: 'Fullname',
        ['FILES_SEX']: 'Sex',
        ['FILES_BIRTH']: 'Birthdate',
        ['FILES_LICENSES']: 'Licenses',
        ['FILES_SEX_MALE']: 'Male',
        ['FILES_SEX_FEMALE']: 'Female',
        ['FILES_LICENSES_MOTOR']: 'A',
        ['FILES_LICENSES_CAR']: 'B',
        ['FILES_LICENSES_TRUCK']: 'C',
        ['FILES_MODEL']: 'Model',
        ['FILES_PLATE']: 'Car plate',
        ['FILES_OWNER']: 'Owner',
        ['FILES_CAR_STATUS']: 'Status',
        ['FILES_COOWNER']: 'Co-Owner',
        ['FILES_DATE']: 'Date',
        ['FILES_NOTE']: 'Note',
        ['FILES_ADD_NOTE']: 'Add note',
        ['FILES_CONFIRM_NOTE']: 'Confirm',
        ['FILES_NOTE_DELETE']: 'Delete note',
        ['FILES_NOTE_DELETE_CANCEL']: 'Cancel',
        ['FILES_NOTE_DELETE_MESSAGE']: 'Are you sure you want to delete this note?',
        ['FILES_NOTE_CONTENT']: 'Note content',
        ['FILES_LAST_FINES']: 'Last fines',
        ['FILES_LAST_JAIL']: 'Last jail',
        ['FILES_LAST_NOTES']: 'Last notes',
        ['FILES_VEHICLES']: 'Vehicles',
        ['FILES_PERSONAL_DATA']: 'Personal informations',
        ['FILES_WANTED']: 'WANTED',
        ['FILES_ADD_FINE']: 'Add fine',
        ['FILES_FINES']: 'Fines',
        ['FILES_JAIL']: 'Jail',
        ['FILES_NOTES']: 'Notes',
        ['FILES_REASON']: 'Reason',
    
        ['TARIF_CUSTOM_CHARGE']: 'Custom charge',
        ['TARIF_SAVE_CHARGE']: 'Submit charge',
        ['TARIF_CHARGE']: 'Charge',
        ['TARIF_JAIL']: 'Jail',
        ['TARIF_FINE']: 'Fine',
        ['TARIF_ISSUING_FINES']: 'Issuing fines',
        ['TARIF_CURRENCY']: "$",
        ['TARIF_FINE_SUMMARY']: 'Fine summary',
        ['TARIF_DATE']: 'Date',
        ['TARIF_OFFICER']: 'Officer',
        
        ['HOME_PERSONAL_DATA']: 'Personal data',
        ['HOME_DUTY_STATUS']: 'Duty status',
        
        ['HOME_LAST_CIT_NOTES']: 'Last citizens notes',
        ['HOME_NOTE_DATE']: 'Date',
        ['HOME_NOTE_REASON']: 'Reason',
        ['HOME_NOTE_OFFICER']: 'Officer',
    
        ['HOME_LAST_VEH_NOTES']: 'Last vehicles notes',
        ['HOME_CAR_MODEL']: 'Model',
        ['HOME_CAR_OWNER']: 'Owner',
        ['HOME_CAR_PLATE']: 'Plate',
    
        ['NOTEPAD']: 'Notepad',
        ['NOTEPAD_SEARCH']: 'Search for notes...',
        ['NOTEPAD_NOTE_TITLE']: 'Note title',
        ['NOTEPAD_NOTE_CONTENT']: 'Note content',
        ['NOTEPAD_NOTE_ALL_NOTES']: 'All notes',
        ['NOTEPAD_NOTE_ADD_NOTE']: 'Add note',
        ['NOTEPAD_NOTE_ADD_NOTE_CONFIRM']: 'Confirm',
    
        ['NOTEPAD_NOTE_REMOVE_TITLE']: 'Remove note',
        ['NOTEPAD_NOTE_REMOVE_TEXT']: 'Are you sure you want to delete this note?',
        ['NOTEPAD_NOTE_REMOVE_CONFIRM']: 'Confirm',
        ['NOTEPAD_NOTE_REMOVE_CANCEL']: 'Cancel',
    
        ['POLICELIST']: 'Police List',
        ['POLICELIST_BADGE']: 'Badge',
        ['POLICELIST_OFFICER']: 'Officer',
        ['POLICELIST_GRADE']: 'Grade',
        ['POLICELIST_STATUS']: 'Status',
        ['POLICELIST_ACTIONS']: 'Actions',
        ['POLICELIST_KICK_FROM_DUTY']: 'Kick from duty',
    
        // HOUSES
        ['HOUSES']: 'House List',
        ['SEARCH_FOR_HOUSE']: 'Search for house...',
        ['HOUSE_LABEL']: 'House Label',
        ['HOUSE_SEARCH_FOR_HOUSE']: 'House',

        ['HOUSE_DATA']: 'HOUSE INFORMATIONS',
        ['HOUSE_OWNER']: 'Owner',
        ['HOUSE_OWNED']: 'Owned',
        ['HOUSE_NAME']: 'House name',
        
        // CODE LIST
        ['CODELIST']: 'Code List',
        
        
        // SETTINGS
        ['BACKGROUND_COLOR']: 'Background color',
        ['MAIN_CONTAINER_COLOR']: 'Main container color',
        ['HEADER_COLOR']: 'Header color',
        ['IMPORTANT_TEXT_COLOR']: 'Important text color',
        
        ['RESET_SETTINGS']: 'Reset settings',
        
        // WARRANTS
        ['WARRANTS']: 'Warrants',
        ['SEARCH_FOR_WARRANTS']: 'Search warrants...',
        ['CREATE_WARRANT']: 'Create',
        ['WARRANTS_SEARCHED_DATA']: 'Warrants list',
        ['WARRANT_TITLE']: 'Title',
        ['WARRANT_DESCRIPTION']: 'Description',
        ['WARRANT_CREATOR']: 'Creator',
        ['WARRANT_OFFICERS_INVOLVED']: 'Officers involved',
        ['WARRANT_CITIZEN_INVOLVED']: 'Citizen involved',
        ['WARRANT_ATTACHMENTS']: 'Attachments included',

        ['WARRANT_CASE']: 'WARRANT NUMBER ',

        ['WARRANT_CREATE_TITLE']: 'WARRANT CREATOR',
        ['WARRANT_CREATE_SAVE']: "Save",
        ['WARRANT_OFFICERS_INVOLVED_SUBTITLE']: 'Name and badge of officer',
        ['WARRANT_CITIZEN_INVOLVED_SUBTITLE']: 'Citizen fullname',
        ['WARRANT_MODAL_ADD']: 'Add',

        ['WARRANT_ATTACHMENT']: 'ATTACHMENT',
        ['WARRANT_CLICK_TO_PREV']: '(CLICK TO PREVIEW)',

        
        ['SEARCH']: 'Search',
        // ^ BUTTON


        // SETTINGS
        ['SETTINGS_MAIN_COLOR']: 'Background color',
        ['SETTINGS_SECOND_COLOR']: 'Container color',
        ['SETTINGS_THIRD_COLOR']: 'Headline color',
        ['SETTINGS_FOURTH_COLOR']: 'Important text color',
        ['SETTINGS_SAVE']: 'Save settings',
        ['SETTINGS_RESET']: 'Reset settings',



        ['DISPATCH_CREATE_PATROL']: 'Create patrol',
        ['DISPATCH_LEAVE_PATROL']: 'Leave patrol',
        ['DISPATCH_EDIT_PATROL']: 'Edit',
        ['DISPATCH_CHANGE_PATROL_STATUS']: 'Change status',
        ['DISPATCH_CUSTOM_STATUS_TITLE']: 'Custom status',
        ['DISPATCH_CUSTOM_STATUS_CONTENT']: 'Status...',
        ['DISPATCH_CUSTOM_STATUS_CONFIRM']: 'Confirm',
    
        ['DISPATCH_JOIN_PATROL_TITLE']: 'Join patrol?',
        ['DISPATCH_JOIN_PATROL_TEXT']: 'You sure you want to join this patrol',
        ['DISPATCH_JOIN_PATROL_TEXT2']: 'You sure you want to join to PU ',
        ['DISPATCH_JOIN_PATROL_JOIN']: 'Join',    
        ['DISPATCH_JOIN_PATROL_CANCEL']: 'Cancel',
    
        ['DISPATCH_PATROL_INFO']: 'Patrol info',
        ['DISPATCH_CHOOSE_UNIT']: 'Choose unit',
        ['DISPATCH_CHOOSE_CAR']: 'Choose vehicle',
        ['DISPATCH_SAVE_PATROL']: 'Save patrol',
    
        ['DISPATCH']: 'Dispatch',
        ['DISPATCH_CONVOY']: 'Convoy',
        ['DISPATCH_ACTION1']: 'Action 1',
        ['DISPATCH_ACTION2']: 'Action 2',
        ['DISPATCH_ACTION3']: 'Action 3',
    
        ['DISPATCH_TOWN_STATUS']: 'Risk level',
    
        ['DISPATCH_PWC']: 'PWC',
        ['DISPATCH_APWC']: 'APWC',
        ['DISPATCH_PWC_TAKE']: 'Take', 
        ['DISPATCH_PWC_RESET']: 'Reset',
        ['DISPATCH_PWC_UNKNOWN']: 'Unknown',
        
        ['DISPATCH_ON_DUTY_NUMBER']: 'On duty',
        ['DISPATCH_PATROLS_NUMBER']: 'Patrols',
    
        ['DISPATCH_PU']: 'Patrol unit',
    
        ['INFORMATION_CHASE_UNIT']: 'Chase Unit Information',
        ['INFORMATION_CONVOY_UNIT']: 'Convoy Unit Information',
        ['CHOOSE_UNIT']: 'Choose unit',
        ['CHOOSE_CAR']: 'Choose vehicle',
        ['DELETE_CONVOY_UNIT']: 'Delete convoy unit?',
        ['DELETE_CHASE_UNIT']: 'Delete chase unit?',
        ['OFFICER']: 'Officer',
        ['CANCEL']: 'Cancel',
        ['DELETE']: 'Delete',
        ['NOTE']: 'Note',
        ['NOTES']: 'Notes',
        ['SAVE_UNIT']: 'Save unit',
        ['ROADTYPE']: 'Road type',
        ['TAKE_CONTROL']: 'Take control',
        ['RESET']: 'Reset',
        ['UNITS']: 'Units',
        ['UNIT']: 'Unit',
        ['TASKS_NOTE']: 'Attacker Requests (Completed by SV/NEGO)',
        ['HEIST_NOTE']: 'Heist Notes (Completed by SV/NEGO)',
        ['CLEAR_PAGE']: 'Clear Assault',
        ['CLEAR_UNITS']: 'Clear units',
        ['DETAINED_COUNT']: 'Number of detainees...',
        ['DETAINED_COUNT_2']: 'Number of detainees... (Completed by SV/NEGO)',
        ['CHASED']: 'Detained',
        ['SUPERVISIOR']: 'SV',
        ['HEIST_OBJECT']: 'Facility',
        ['HEIST_PLACE_NOTE']: 'Heist Facility...',
        ['HEIST_PLACE']: 'Heist Facility (Completed by SV/NEGO)',
        ['REQUESTS']: 'REQUESTS',
        ['STOPPED']: 'STOPPED',
        ['SWAT']: 'SWAT',
        ['NEGO']: 'NEGOTIATOR',
        ['NONE']: 'NONE',
        ['ROAD_POINT']: 'Transport route...',
        ['ROAD_NOTE']: 'Transport route... (SV/NEGO)',
        ['CREATE_UNIT']: 'Create Unit',
        ['HEIST_NOTES']: 'Notes about action',
        ['HEIST_DEMANDS']: 'The demands of the suspects',
    
        ['CANT_FIND_DUTY']: 'Cant find an officer!',
        ['KICK_DUTY']: 'Officer: %s %s has been kicked off duty!',
        ['KICK_DUTY_PLAYER']: 'You have been ejected from duty by %s %s if you believe this to be an error, please contact High Command',
    
        ['JAIL_POLICEMAN']: 'You have issued a sentence to [%s] %s %s for %s $ and %s months',
        ['JAIL_PLAYER']: 'You received a sentence from [%s] %s %s for %s$ and %s months',
    
        ['FINE_POLICEMAN']: 'You issued a fine to [%s] %s %s for %s $',
        ['FINE_PLAYER']: 'You received a fine from [%s] %s %s on %s $',
    
        ['BLACK_CODE']: '^0The Los Santos Police Department announces the implementation of a [BLACK] threat level in the city. ^7Any suspicious individuals will be detained and identified. We kindly ask for cooperation and to stay at home!',
        ['RED_CODE']: '^0The Los Santos Police Department announces the implementation of a ^1[RED] threat level in the city. ^7We kindly ask for cooperation and to stay at home!',
        ['ORANGE_CODE']: '^0The Los Santos Police Department announces the implementation of an ^3[ORANGE] threat level in the city. ^7We kindly ask for cooperation and to stay at home!',
        ['GREEN_CODE']: '^0The Los Santos Police Department announces the implementation of a ^2[GREEN] threat level in the city. ^7Thank you for your cooperation!'
      },
      // units: [
      //   'ADAM',
      //   'BOY',
      //   'MARY',
      //   'TASK',
      // ],
      vehicles: [
        {
          unit: 'ADAM',
          vehicles: [
            'chuj1',
            'chuj2',
            'chuj3',
          ]
        },
        {
          unit: 'BOY',
          vehicles: [
            'chuj4',
            'chuj5',
            'chuj6',
          ]
        },
      ],

      codes: [
        {
          category: 'Main',
          data: [
            {
              name: '10-30',
              title: 'Kutas',
              subtitle: 'kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2'
            },
            {
              name: '10-30',
              title: 'Kutas',
              subtitle: 'kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2'
            },
            {
              name: '10-30',
              title: 'Kutas',
              subtitle: 'kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2'
            },
            {
              name: '10-30',
              title: 'Kutas',
              subtitle: 'kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2'
            },
          ]
        },
        {
          category: 'Main2',
          data: [
            {
              name: '10-30',
              title: 'Kutas',
              subtitle: 'kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2'
            },
            {
              name: '10-30',
              title: 'Kutas',
              subtitle: 'kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2'
            },
            {
              name: '10-30',
              title: 'Kutas',
              subtitle: 'kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2'
            },
            {
              name: '10-30',
              title: 'Kutas',
              subtitle: 'kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2 kutasek2'
            },
          ]
        },
      ],

      tariff: [
        {
          label: 'Wykroczenia drogowe',
          data: [
            {
              label: 'Przekroczenie prędkości',
              fine: 15000,
              jail: 0
            },
            {
              label: 'Jazda bez prawa jazdy',
              fine: 20000,
              jail: 0
            },
          ]
        },
        {
          label: 'Kradzieże i rabunki',
          data: [
            {
              label: 'Napad na sklep',
              fine: 25000,
              jail: 15
            },
            {
              label: 'Napad na jubileraDAWDAWDWADADAWDAWDAWDjubileraDAWDAWDWADADAWDAWDAWDjubileraDAWDAWDWADADAWDAWDAWD',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
            {
              label: 'Napad na jubilera',
              fine: 50000,
              jail: 30
            },
          ]
        }
      ]
    }
  }
])

debugData([
  {
    action: 'setPlayerData',
    data: {
      firstname: 'Chris',
      lastname: 'Frog',
      badge: '[01]',
      dutyTime: '00:00:00',
      job: {
        name: 'police',
        grade: 14,
        label: 'LSPD',
        grade_label: 'Chief of Police',
        onDuty: true
      }
    }
  }
])


export const secondHref = {
  shref: '',
}
export let filesShower = false

const App: React.FC = () => {

  const setPlayerData = useSetPlayerData()
  const [Locale, setLocale] = useLocale()
  const [localeSetted, setLocaleSetted] = useState<boolean>(false)
  const setTariff = useSetTariff()
  const setCodeList = useSetCodeList()
  const setUnitsAndVehicles = useSetUnitsAndVehicles()
  const setLanguagesList = setLanguageList()
  const setSettings = setBlockSettings()
  
  const [href, setHref] = useState<string>("home")


  useNuiEvent<{
    locale: { [key: string]: string };
  }>('changeLanguage', ({locale}) => {
    setLocaleSetted(false)
    const tempLocale = Locale
    for (const name in locale) {
      tempLocale[name] = locale[name]
    }
    setLocale(tempLocale)
    setLocaleSetted(true)
    
  })

  useNuiEvent<{
    locale: { [key: string]: string };
  }>('changeLanguage1', ({locale}) => {
    setLocaleSetted(false)
    const tempLocale = Locale
    for (const name in locale) {
      tempLocale[name] = locale[name]
    }
    setLocale(tempLocale)
    setLocaleSetted(true)
    fetchNui("restartUI")
    
  })


  useNuiEvent<{
locale: { [key: string]: string };
      languages: Languages[];
      tariff: TariffT[];
      vehicles: UnitsAndVehiclesT[]
      codes: CodeList[];
      files: boolean;
    }>('init', ({ locale, languages, tariff, vehicles, codes, files }) => {
    setTariff(tariff)
    setCodeList(codes)
    setLanguagesList(languages)
    setUnitsAndVehicles(vehicles)

    filesShower = files
    const tempLocale = Locale
    for (const name in locale) {
      tempLocale[name] = locale[name]
    }

    setLocale(tempLocale)
    setLocaleSetted(true)
    
  });

  useNuiEvent<PlayerData>('setPlayerData', (data) => {
    setPlayerData(data)
  })

  useNuiEvent<BlockSettings>('setBlockSettings', (data) => {
    setSettings(data)
  })

  const [annoucements, setAnnoucements] = useAnnoucements()
  useNuiEvent<Annoucement[]>('setAnnoucements', (data) => {
    setAnnoucements(data)
  })
  useNuiEvent<Annoucement>('addAnnoucement', (data) => {
    const tempAnnoun = annoucements
    tempAnnoun.push(data)
    setAnnoucements(tempAnnoun)
  })

  const [houses, setHouses] = housesList()
  useNuiEvent<HousesList[]>('setHousesList', (data) => {
    setHouses(data)
  })
  
  const [warrant, setWarrant] = useWarrantList()
  useNuiEvent<Warrant[]>('setWarrants', (data) => {
    setWarrant(data)
  })

  const [evidence, setEvidence] = useEvidencesList()
  useNuiEvent<Evidence[]>('setEvidences', (data) => {
    setEvidence(data)
  })


  const setNotes = useSetNotes()
  useNuiEvent<Annoucement[]>('setNotes', (data) => {
    setNotes(data)
  })

  const [policeList, setPoliceList] = usePoliceList()
  useNuiEvent<PoliceMan[]>('setPoliceList', (data) => {
    setPoliceList(data)
  })

  if (!localeSetted) {
    fetchNui('uiLoaded', {});
  }

  const closeUI = () => {
    fetchNui("closeUI")
  }

  const event = new Event("goBack");

  const goBack = () => {
    dispatchEvent(event)
  }

  return (
    <div className="kariee_container">

      {/* </div> */}
      <div className="mdt-container">
        <div className='speakers'>
          <div className='circle'>

          </div>
          <div className='rectangle'>
            
          </div>
          <div className='circle'>
            
          </div>
        </div>
        <div className='mdt-screen'>
          <div className='mdt-topbar'>
            <div className='icons' onClick={() => goBack()} style={{cursor: "pointer"}}>
              <FontAwesomeIcon icon={faChevronLeft}/>
              <span style={{marginLeft: '10px', fontSize: '12px'}}>{Locale['BACK']}</span>
              {/* <FontAwesomeIcon icon={faChevronRight}/> */}
            </div>
            <div className='href'>
              <div  style={{display: 'flex', justifyContent: 'center', width: '100%'}}>
                www.<span>{Locale['UI_TABLET_NAME'] || 'Police-MDT.com'}</span>/{href}/<span id="second_href"></span>
              </div>
              <div className='search-icon'>
                <FontAwesomeIcon icon={faSearch}/>
              </div>
            </div>
            <div className='icons' onClick={() => closeUI()} style={{cursor: "pointer"}}>
              <FontAwesomeIcon icon={faX}/>
            </div>
          </div>
          <div className='mdt-page'>
            <NavBar href={href} setHref={setHref}/>

            {<div style={{display: href == "home" ? "block" : "none"}}>
              <Home setHref={setHref}/>
            </div>}

            {<div style={{display: href == "files" ? "block" : "none"}}> 
              <Files/>
            </div>}
    
            {<div style={{display: href == "FilesCitizen" ? "block" : "none"}}> 
              <FilesCitizen/>
            </div>}

            {<div style={{display: href == "FilesVehicle" ? "block" : "none"}}> 
              <FilesVehicle/>
            </div>}

            {<div style={{display: href == "annoucements" ? "block" : "none"}}>
              <Annoucements/>
            </div>}

            {<div style={{display: href == "policelist" ? "block" : "none"}}>
              <PoliceList/>
            </div>}

            {<div style={{display: href == "dispatch" ? "block" : "none"}}>
              <Dispatch/>
            </div>}

            {<div style={{display: href == "notifdispatch" ? "block" : "none"}}>
              <CasualDispatch/>
            </div>}

            {<div style={{display: href == "houses" ? "block" : "none"}}>
              <Houses/>
            </div>}

            {<div style={{display: href == "codes" ? "block" : "none"}}>
              <Codes/>
            </div>}

            {<div style={{display: href == "warrants" ? "block" : "none"}}>
              <Warrants/>
            </div>}

            {<div style={{display: href == "evidences" ? "block" : "none"}}>
              <Evidences/>
            </div>}

            {<div style={{display: href == "settings" ? "block" : "none"}}>
              <Settings/>
            </div>}

            {<div style={{display: href == "notes" ? "block" : "none"}}>
              <Notes/>
            </div>}

          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
