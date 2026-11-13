import express from 'express';
import HttpError from 'http-errors';
import paginate from 'express-paginate';
import orderRepository from '../repositories/order.repository.js';

const router = express.Router();

class OrderRoutes {
    constructor() {
        router.get('/', paginate.middleware(10, 30), this.getAll);
        router.get('/:idOrder', this.getOne);
    }

    async getAll(req, res, next) {
        const retrieveOptions = {
            page: req.query.page,
            limit: req.query.limit,
            topping: req.query.topping
        };

        try {
            let [orders, documentsCount] = await orderRepository.retrieveAll(retrieveOptions);

            orders = orders.map(o => {
                o = o.toObject({ getters: false, virtuals: false });
                o = orderRepository.transform(o);
                return o;
            });

            const pageCount = Math.ceil(documentsCount / req.query.limit);
            const hasNextPage = (paginate.hasNextPages(req))(pageCount);
            const pageArray = paginate.getArrayPages(req)(3, pageCount, req.query.page);

            const response = {
                _metadata: {
                    hasNextPage: hasNextPage,
                    page: req.query.page,
                    limit: req.query.limit,
                    skip: req.skip,
                    totalPages: pageCount,
                    totalDocuments: documentsCount
                },
                _links: {
                    first: `/orders?page=1&limit=${req.query.limit}`,
                    prev: pageArray[0].url,
                    self: pageArray[1].url,
                    next: pageArray[2].url,
                    last: `/orders?page=${pageCount}&limit=${req.query.limit}`
                },
                data: orders
            };

            if (req.query.page === 1) {
                delete response._links.prev;
                response._links.self = pageArray[0].url;
                response._links.next = pageArray[1].url;
            }

            if (!hasNextPage) {
                response._links.prev = pageArray[1].url;
                response._links.prev = pageArray[2].url;
                delete response._links.next;
            }

            res.status(200).json(response);

        } catch (err) {
            return next(err);
        }
    }

    async getOne(req, res, next) {
        const retrieveOptions = {};
        const transformOptions = { embed: {} };

        if (req.query.embed && req.query.embed === 'customer') {
            retrieveOptions.customer = true;
            transformOptions.embed.customer = true;
        }

        try {
            const idOrder = req.params.idOrder;
            
            let order = await orderRepository.retrieveById(idOrder, retrieveOptions);

            if (order) {
                order = order.toObject({ getters: false, virtuals: true });
                order = orderRepository.transform(order, transformOptions); //On transforme l'objet selon les paramètres
                res.status(200).json(order);
            } else {
                return next(HttpError.NotFound(`Le order ${idOrder} n'existe pas`));
            }
        } catch (err) {
            return next(err);
        }
    }
}

new OrderRoutes();
export default router;
