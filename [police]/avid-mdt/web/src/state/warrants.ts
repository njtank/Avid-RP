import {atom, useAtom, useAtomValue, useSetAtom} from "jotai";

import { Warrant } from "../types/warrants";

const warrant = atom<Warrant[]>([])

export const useWarrantState = () => useAtomValue(warrant)
export const useWarrantList = () => useAtom(warrant)
export const useWarrantSet = () => useSetAtom(warrant)