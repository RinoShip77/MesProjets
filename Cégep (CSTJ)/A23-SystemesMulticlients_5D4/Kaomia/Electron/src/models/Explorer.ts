import { Ally } from "./Ally";
import { Element } from "./Element";
import { Exploration } from "./Exploration";

export interface Explorer {
    inventory: {
        inox: number,
        elements: Element[]
    },
    email: string,
    username: string,
    name: string,
    surname: string,
    createdAt: Date,
    updatedAt: Date,
    location: string,
    href: string,
    allies: Ally[],
    explorations: Exploration[]
}