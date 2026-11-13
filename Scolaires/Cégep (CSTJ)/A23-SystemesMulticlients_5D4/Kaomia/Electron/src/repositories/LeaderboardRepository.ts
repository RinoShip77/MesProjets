import { inject } from "vue";
import { AxiosStatic } from 'axios';
import { ExplorerRepository } from "./ExplorerRepository";

export class LeaderboardRepository extends ExplorerRepository {
  axios = inject('axios') as AxiosStatic;

  public async retrieveAll(href: string | null, order: string, token: string | null) {
    try {
      let res = await this.axios.get(`${href}/leaderboards/${order}`, { headers: { 'Authorization': `Bearer ${token}` } });

      if (res.status === 200) {
        return res.data;
      }
    } catch (error: any) {
      if (error.response.status === 401) {
        this.refreshToken(sessionStorage.getItem('refreshToken'));
        this.retrieveAll(href, order, sessionStorage.getItem('token'));
      } else {
        throw error;
      }
    }
  }
}