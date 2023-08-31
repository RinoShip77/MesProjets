<?php

/**
 * This file has been auto-generated
 * by the Symfony Routing Component.
 */

return [
    false, // $matchHost
    [ // $staticRoutes
        '/_profiler' => [[['_route' => '_profiler_home', '_controller' => 'web_profiler.controller.profiler::homeAction'], null, null, null, true, false, null]],
        '/_profiler/search' => [[['_route' => '_profiler_search', '_controller' => 'web_profiler.controller.profiler::searchAction'], null, null, null, false, false, null]],
        '/_profiler/search_bar' => [[['_route' => '_profiler_search_bar', '_controller' => 'web_profiler.controller.profiler::searchBarAction'], null, null, null, false, false, null]],
        '/_profiler/phpinfo' => [[['_route' => '_profiler_phpinfo', '_controller' => 'web_profiler.controller.profiler::phpinfoAction'], null, null, null, false, false, null]],
        '/_profiler/xdebug' => [[['_route' => '_profiler_xdebug', '_controller' => 'web_profiler.controller.profiler::xdebugAction'], null, null, null, false, false, null]],
        '/_profiler/open' => [[['_route' => '_profiler_open_file', '_controller' => 'web_profiler.controller.profiler::openAction'], null, null, null, false, false, null]],
        '/admin' => [[['_route' => 'admin', '_controller' => 'App\\Controller\\AdminController::admin'], null, null, null, false, false, null]],
        '/admin/categories' => [[['_route' => 'admin.categories', '_controller' => 'App\\Controller\\AdminController::adminCategories'], null, null, null, false, false, null]],
        '/admin/products' => [[['_route' => 'admin.products', '_controller' => 'App\\Controller\\AdminController::adminProducts'], null, null, null, false, false, null]],
        '/admin/product' => [[['_route' => 'admin.add.product', '_controller' => 'App\\Controller\\AdminController::adminAddProduct'], null, null, null, false, false, null]],
        '/admin/orders' => [[['_route' => 'admin.orders', '_controller' => 'App\\Controller\\AdminController::adminOrders'], null, null, null, false, false, null]],
        '/cart' => [[['_route' => 'cart.index', '_controller' => 'App\\Controller\\CartController::index'], null, null, null, false, false, null]],
        '/cart/update' => [[['_route' => 'cart.update', '_controller' => 'App\\Controller\\CartController::updateCart'], null, ['POST' => 0], null, false, false, null]],
        '/' => [[['_route' => 'catalog.route', '_controller' => 'App\\Controller\\CatalogController::indexRoute'], null, null, null, false, false, null]],
        '/error' => [[['_route' => 'error', '_controller' => 'App\\Controller\\ErrorController::error'], null, null, null, false, false, null]],
        '/orders' => [[['_route' => 'order.preview', '_controller' => 'App\\Controller\\OrderController::orderPreview'], null, null, null, false, false, null]],
        '/orders/checkout' => [[['_route' => 'checkout', '_controller' => 'App\\Controller\\OrderController::checkout'], null, null, null, false, false, null]],
        '/orders/checkout/success' => [[['_route' => 'checkout.success', '_controller' => 'App\\Controller\\OrderController::checkoutSuccess'], null, null, null, false, false, null]],
        '/orders/checkout/error' => [[['_route' => 'checkout.error', '_controller' => 'App\\Controller\\OrderController::checkoutCancel'], null, null, null, false, false, null]],
        '/contact' => [[['_route' => 'contact.route', '_controller' => 'App\\Controller\\PageController::contactRoute'], null, null, null, false, false, null]],
        '/user/profile' => [[['_route' => 'profile', '_controller' => 'App\\Controller\\ProfileController::profile'], null, null, null, false, false, null]],
        '/user/orders' => [[['_route' => 'profile.orders', '_controller' => 'App\\Controller\\ProfileController::orders'], null, null, null, false, false, null]],
        '/login' => [[['_route' => 'login', '_controller' => 'App\\Controller\\ProfileController::login'], null, null, null, false, false, null]],
        '/logout' => [[['_route' => 'logout', '_controller' => 'App\\Controller\\ProfileController::logout'], null, null, null, false, false, null]],
        '/register' => [[['_route' => 'register', '_controller' => 'App\\Controller\\RegistrationController::register'], null, null, null, false, false, null]],
    ],
    [ // $regexpList
        0 => '{^(?'
                .'|/_(?'
                    .'|error/(\\d+)(?:\\.([^/]++))?(*:38)'
                    .'|wdt/([^/]++)(*:57)'
                    .'|profiler/([^/]++)(?'
                        .'|/(?'
                            .'|search/results(*:102)'
                            .'|router(*:116)'
                            .'|exception(?'
                                .'|(*:136)'
                                .'|\\.css(*:149)'
                            .')'
                        .')'
                        .'|(*:159)'
                    .')'
                .')'
                .'|/admin/product/([^/]++)(*:192)'
                .'|/cart/(?'
                    .'|add/([^/]++)(*:221)'
                    .'|delete/([^/]++)(*:244)'
                .')'
                .'|/products/([^/]++)(*:271)'
                .'|/orders/([^/]++)(*:295)'
            .')/?$}sDu',
    ],
    [ // $dynamicRoutes
        38 => [[['_route' => '_preview_error', '_controller' => 'error_controller::preview', '_format' => 'html'], ['code', '_format'], null, null, false, true, null]],
        57 => [[['_route' => '_wdt', '_controller' => 'web_profiler.controller.profiler::toolbarAction'], ['token'], null, null, false, true, null]],
        102 => [[['_route' => '_profiler_search_results', '_controller' => 'web_profiler.controller.profiler::searchResultsAction'], ['token'], null, null, false, false, null]],
        116 => [[['_route' => '_profiler_router', '_controller' => 'web_profiler.controller.router::panelAction'], ['token'], null, null, false, false, null]],
        136 => [[['_route' => '_profiler_exception', '_controller' => 'web_profiler.controller.exception_panel::body'], ['token'], null, null, false, false, null]],
        149 => [[['_route' => '_profiler_exception_css', '_controller' => 'web_profiler.controller.exception_panel::stylesheet'], ['token'], null, null, false, false, null]],
        159 => [[['_route' => '_profiler', '_controller' => 'web_profiler.controller.profiler::panelAction'], ['token'], null, null, false, true, null]],
        192 => [[['_route' => 'admin.modify.product', '_controller' => 'App\\Controller\\AdminController::adminModifyProduct'], ['idProduct'], null, null, false, true, null]],
        221 => [[['_route' => 'cart.add', '_controller' => 'App\\Controller\\CartController::addPurchase'], ['idProduct'], ['POST' => 0], null, false, true, null]],
        244 => [[['_route' => 'cart.delete', '_controller' => 'App\\Controller\\CartController::deletePurchase'], ['idProduct'], null, null, false, true, null]],
        271 => [[['_route' => 'product_modal', '_controller' => 'App\\Controller\\CatalogController::infoProduct'], ['idProduct'], null, null, false, true, null]],
        295 => [
            [['_route' => 'order.confirmation', '_controller' => 'App\\Controller\\OrderController::orderConfirmation'], ['idOrder'], ['GET' => 0, 'POST' => 1], null, false, true, null],
            [null, null, null, null, false, false, 0],
        ],
    ],
    null, // $checkCondition
];
