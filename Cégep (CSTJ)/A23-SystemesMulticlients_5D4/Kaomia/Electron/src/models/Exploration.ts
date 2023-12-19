import { Element } from "./Element"

export interface Exploration {
  vault: {
    inox: number,
    elements: Element[]
  }
  explorationDate: Date,
  destination: string,
  affinity: string,
  href: string
}