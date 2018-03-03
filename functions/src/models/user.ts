export interface User {
    userUid: string;
    email: string;
    first_name: string;
    last_name: string;
    mobile_no: string;
    company: string;
}

export interface LegacyUser {
    email: string;
    password: string;
    first_name: string;
    last_name: string;
    mobile_no: string;
    address: string;
    city: string;
    postal_code: string;
    company: string;
}