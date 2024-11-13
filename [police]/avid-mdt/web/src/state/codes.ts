import {atom, useAtom, useAtomValue, useSetAtom} from "jotai";

import { CodeList } from "../types/codes";

const atomCode = atom<CodeList[] | null>(null)

export const useCodeListState = () => useAtomValue(atomCode)
export const useCodeList = () => useAtom(atomCode)
export const useSetCodeList = () => useSetAtom(atomCode)