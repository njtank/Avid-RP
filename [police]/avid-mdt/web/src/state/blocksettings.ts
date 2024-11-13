import {atom, useAtom, useAtomValue, useSetAtom} from "jotai";

import BlockSettings from "../types/blocksettings";

const bsettings = atom<BlockSettings | null>(null)

export const useBlockSettingsState = () => useAtomValue(bsettings)
export const useBlockSettings = () => useAtom(bsettings)
export const setBlockSettings = () => useSetAtom(bsettings)