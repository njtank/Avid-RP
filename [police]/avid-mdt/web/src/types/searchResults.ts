export interface CitizenData {
    firstname: string,
    lastname: string,
    dateofbirth: string,
    identifier: string,
    sex: string,
    mdt_picture: string,
    mdt_searched: boolean,
    job: {
        name: string,
        grade: number,
        grade_label: string,
        label: string
    },
    licenses: string[],
}

export interface VehicleData {
    plate: string,
    owner: string,
    ownerIdentifier: string,
    model: string
}