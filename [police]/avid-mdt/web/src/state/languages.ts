import {atom, useAtom, useAtomValue, useSetAtom} from "jotai";

import { Languages } from "../types/languages";

const languages = atom<Languages[]>([])

export const useLanguageState = () => useAtomValue(languages)
export const useLanguageList = () => useAtom(languages)
export const setLanguageList = () => useSetAtom(languages)