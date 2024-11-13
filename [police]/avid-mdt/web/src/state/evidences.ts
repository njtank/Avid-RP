import {atom, useAtom, useAtomValue, useSetAtom} from "jotai";

import { Evidence } from "../types/evidences";

const evidence = atom<Evidence[]>([])

export const useEvidencesState = () => useAtomValue(evidence)
export const useEvidencesList = () => useAtom(evidence)
export const useEvidencesSet = () => useSetAtom(evidence)