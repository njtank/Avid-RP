export interface HousesList {
    label: string,
    name: string,
    data: {
        owned: boolean;
        owner: string;
    }
    notes: {
        id: number,
        date: number,
        reason: string,
        officer: string,
    }[],
}