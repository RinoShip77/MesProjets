export interface Ally {
  stats: {
    life: number,
    speed: number,
    power: number,
    shield: number
  },
  crypto: {
    hash: string,
    signature: string
  },
  name: string,
  affinity: string,
  essence: number,
  books: string[],
  kernel: string[],
  uuid: string,
  archiveIndex: number,
  href: string,
  asset: string,
  createdAt: Date,
  updateAt: Date,
  expireAt: Date,
  explorer: string
}