import { Explorer } from "./Explorer";

export interface Leaderboard {
  top25: Explorer[],
  you: Explorer
}