import {atom, useAtom, useAtomValue, useSetAtom} from "jotai"

export interface UnitsAndVehiclesT {
    unit: string;
    vehicles: [];
}

const unitsAndVehicles = atom<UnitsAndVehiclesT[]>([])

export const useUnitsAndVehiclesState = () => useAtomValue(unitsAndVehicles)
export const useUnitsAndVehicles = () => useAtom(unitsAndVehicles)
export const useSetUnitsAndVehicles = () => useSetAtom(unitsAndVehicles)