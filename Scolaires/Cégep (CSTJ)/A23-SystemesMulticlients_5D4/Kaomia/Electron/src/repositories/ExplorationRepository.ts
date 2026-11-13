import { inject } from "vue";
import { AxiosStatic } from 'axios';
import { ExplorerRepository } from "./ExplorerRepository";

export class ExplorationRepository extends ExplorerRepository {
    axios = inject('axios') as AxiosStatic;

    public async retrieveAll(href: string | null, token: string | null) {
        try {
            const response = await this.axios.get(`${href}/explorations`, { headers: { 'Authorization': `Bearer ${token}` } });

            if (response.status === 200) {
                return response.data;
            }
        } catch (error: any) {
            if (error.response.status === 401) {
                this.refreshToken(sessionStorage.getItem('refreshToken'));
                this.retrieveAll(href, sessionStorage.getItem('token'));
            } else {
                throw error;
            }
        }
    }
}