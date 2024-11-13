import {atom, useAtom, useAtomValue, useSetAtom} from "jotai";

import { HousesList } from "../types/houses";

const atomHouses = atom<HousesList[]>([])

export const housesState = () => useAtomValue(atomHouses)
export const housesList = () => useAtom(atomHouses)
export const setHousesList = () => useSetAtom(atomHouses)