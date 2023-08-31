<?php

use Twig\Environment;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Extension\SandboxExtension;
use Twig\Markup;
use Twig\Sandbox\SecurityError;
use Twig\Sandbox\SecurityNotAllowedTagError;
use Twig\Sandbox\SecurityNotAllowedFilterError;
use Twig\Sandbox\SecurityNotAllowedFunctionError;
use Twig\Source;
use Twig\Template;

/* order/orderPreview.html.twig */
class __TwigTemplate_1962a564782d221a6db617a84402f809 extends Template
{
    private $source;
    private $macros = [];

    public function __construct(Environment $env)
    {
        parent::__construct($env);

        $this->source = $this->getSourceContext();

        $this->blocks = [
            'body' => [$this, 'block_body'],
        ];
    }

    protected function doGetParent(array $context)
    {
        // line 1
        return "core/base.html.twig";
    }

    protected function doDisplay(array $context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "order/orderPreview.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "order/orderPreview.html.twig"));

        $this->parent = $this->loadTemplate("core/base.html.twig", "order/orderPreview.html.twig", 1);
        $this->parent->display($context, array_merge($this->blocks, $blocks));
        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

    }

    // line 3
    public function block_body($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "body"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "body"));

        // line 4
        echo "\t<section class=\"row bg-warning\">
\t\t<p class=\"h1 text-center mt-4 mb-4\">
\t\t\t<i class=\"fas fa-cart-flatbed-suitcase me-1\"></i>
\t\t\tRéviser votre commande
\t\t</p>
\t\t<hr class=\"mb-4\">
\t\t<div class=\"col-8 bg-warning mb-5\">
\t\t\t<div>
\t\t\t\t<p class=\"h3 text-center mt-3\">
\t\t\t\t\t<i class=\"fas fa-address-book me-1\"></i>
\t\t\t\t\tVotre adresse de livraison
\t\t\t\t</p>
\t\t\t\t<div class=\"col-8 fs-5 text-center bg-dark text-white rounded mx-auto py-3\">
\t\t\t\t\t<span class=\"fs-2 fw-bold\">
\t\t\t\t\t\t";
        // line 18
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 18, $this->source); })()), "user", [], "any", false, false, false, 18), "firstName", [], "any", false, false, false, 18), "html", null, true);
        echo "
\t\t\t\t\t\t";
        // line 19
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 19, $this->source); })()), "user", [], "any", false, false, false, 19), "lastName", [], "any", false, false, false, 19), "html", null, true);
        echo "
\t\t\t\t\t</span>
\t\t\t\t\t<br>
\t\t\t\t\t<span>
\t\t\t\t\t\t";
        // line 23
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 23, $this->source); })()), "user", [], "any", false, false, false, 23), "address", [], "any", false, false, false, 23), "html", null, true);
        echo "
\t\t\t\t\t</span>
\t\t\t\t\t<br>
\t\t\t\t\t<span>
\t\t\t\t\t\t";
        // line 27
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 27, $this->source); })()), "user", [], "any", false, false, false, 27), "city", [], "any", false, false, false, 27), "html", null, true);
        echo ",
\t\t\t\t\t\t";
        // line 28
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 28, $this->source); })()), "user", [], "any", false, false, false, 28), "province", [], "any", false, false, false, 28), "html", null, true);
        echo "
\t\t\t\t\t\t<br>
\t\t\t\t\t\t";
        // line 30
        echo twig_escape_filter($this->env, twig_slice($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 30, $this->source); })()), "user", [], "any", false, false, false, 30), "postalCode", [], "any", false, false, false, 30), 0, 3), "html", null, true);
        echo "
\t\t\t\t\t\t";
        // line 31
        echo twig_escape_filter($this->env, twig_slice($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 31, $this->source); })()), "user", [], "any", false, false, false, 31), "postalCode", [], "any", false, false, false, 31), 3, null), "html", null, true);
        echo "
\t\t\t\t\t</span>
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"mt-5\">
\t\t\t\t<p class=\"h3 text-center\">
\t\t\t\t\t<i class=\"fas fa-basket-shopping me-1\"></i>
\t\t\t\t\tVotre commande
\t\t\t\t</p>
\t\t\t\t<div class=\"row m-3\">
\t\t\t\t\t<div class=\"card text-center\">
\t\t\t\t\t\t<table class=\"table table-hover align-middle\">
\t\t\t\t\t\t\t<thead>
\t\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Visuel</th>
\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Nom</th>
\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Quantité</th>
\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Prix unitaire</th>
\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Total</th>
\t\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t\t</thead>
\t\t\t\t\t\t\t<tbody>
\t\t\t\t\t\t\t\t";
        // line 53
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["orderlist"]) || array_key_exists("orderlist", $context) ? $context["orderlist"] : (function () { throw new RuntimeError('Variable "orderlist" does not exist.', 53, $this->source); })()), "purchases", [], "any", false, false, false, 53));
        foreach ($context['_seq'] as $context["_key"] => $context["purchase"]) {
            // line 54
            echo "\t\t\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t<img src=\"";
            // line 56
            echo twig_escape_filter($this->env, $this->extensions['App\Twig\ConditionalAssetExtension']->asset_if(twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, $context["purchase"], "product", [], "any", false, false, false, 56), "imagePath", [], "any", false, false, false, 56), "images/products/imageNotAvailable.png"), "html", null, true);
            echo "\" class=\"card-img-top\" style=\"width: 100px; height: 100px\" alt=\"Produit\">
\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t<h5>";
            // line 59
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, $context["purchase"], "product", [], "any", false, false, false, 59), "name", [], "any", false, false, false, 59), "html", null, true);
            echo "</h5>
\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t<h5>";
            // line 62
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["purchase"], "quantity", [], "any", false, false, false, 62), "html", null, true);
            echo "</h5>
\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t<h5>";
            // line 65
            echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, $context["purchase"], "product", [], "any", false, false, false, 65), "price", [], "any", false, false, false, 65), 2, ",", ""), "html", null, true);
            echo "
\t\t\t\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t<h5>";
            // line 69
            echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, $context["purchase"], "price", [], "any", false, false, false, 69), 2, ",", ""), "html", null, true);
            echo "
\t\t\t\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t\t\t";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['purchase'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 74
        echo "\t\t\t\t\t\t\t</tbody>
\t\t\t\t\t\t</table>
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t</div>
\t\t</div>
\t\t<div class=\"col-4 bg-light rounded-top\">
\t\t\t<p class=\"h3 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-file-invoice me-1\"></i>
\t\t\t\tSommaire
\t\t\t\t<div class=\"row fs-5 mx-2\">
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>Sous-Total</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">";
        // line 88
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["orderlist"]) || array_key_exists("orderlist", $context) ? $context["orderlist"] : (function () { throw new RuntimeError('Variable "orderlist" does not exist.', 88, $this->source); })()), "getSubtotal", [], "method", false, false, false, 88), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>TPS</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">";
        // line 96
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["orderlist"]) || array_key_exists("orderlist", $context) ? $context["orderlist"] : (function () { throw new RuntimeError('Variable "orderlist" does not exist.', 96, $this->source); })()), "getGST", [], "method", false, false, false, 96), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>TVQ</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">";
        // line 104
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["orderlist"]) || array_key_exists("orderlist", $context) ? $context["orderlist"] : (function () { throw new RuntimeError('Variable "orderlist" does not exist.', 104, $this->source); })()), "getQST", [], "method", false, false, false, 104), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>Frais de Livraison</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">";
        // line 112
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["orderlist"]) || array_key_exists("orderlist", $context) ? $context["orderlist"] : (function () { throw new RuntimeError('Variable "orderlist" does not exist.', 112, $this->source); })()), "getShippingCost", [], "method", false, false, false, 112), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>Côut total</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">";
        // line 120
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["orderlist"]) || array_key_exists("orderlist", $context) ? $context["orderlist"] : (function () { throw new RuntimeError('Variable "orderlist" does not exist.', 120, $this->source); })()), "getTotal", [], "method", false, false, false, 120), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"text-center my-5\">
\t\t\t\t\t\t<a href=\"";
        // line 126
        echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("checkout");
        echo "\" class=\"btn btn-warning fs-5\">
\t\t\t\t\t\t\t<i class=\"fa-brands fa-cc-stripe me-2\"></i>
\t\t\t\t\t\t\t<span class=\"mx-3\">Payer</span>
\t\t\t\t\t\t\t<span class=\"mx-3\">|</span>
\t\t\t\t\t\t\t<span class=\"mx-3 fw-bold\">";
        // line 130
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["orderlist"]) || array_key_exists("orderlist", $context) ? $context["orderlist"] : (function () { throw new RuntimeError('Variable "orderlist" does not exist.', 130, $this->source); })()), "getTotal", [], "method", false, false, false, 130), 2, ",", ""), "html", null, true);
        echo "</span>
\t\t\t\t\t\t</a>
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t</p>
\t\t</div>
\t</section>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    public function getTemplateName()
    {
        return "order/orderPreview.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  260 => 130,  253 => 126,  244 => 120,  233 => 112,  222 => 104,  211 => 96,  200 => 88,  184 => 74,  173 => 69,  166 => 65,  160 => 62,  154 => 59,  148 => 56,  144 => 54,  140 => 53,  115 => 31,  111 => 30,  106 => 28,  102 => 27,  95 => 23,  88 => 19,  84 => 18,  68 => 4,  58 => 3,  35 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("{% extends 'core/base.html.twig' %}

{% block body %}
\t<section class=\"row bg-warning\">
\t\t<p class=\"h1 text-center mt-4 mb-4\">
\t\t\t<i class=\"fas fa-cart-flatbed-suitcase me-1\"></i>
\t\t\tRéviser votre commande
\t\t</p>
\t\t<hr class=\"mb-4\">
\t\t<div class=\"col-8 bg-warning mb-5\">
\t\t\t<div>
\t\t\t\t<p class=\"h3 text-center mt-3\">
\t\t\t\t\t<i class=\"fas fa-address-book me-1\"></i>
\t\t\t\t\tVotre adresse de livraison
\t\t\t\t</p>
\t\t\t\t<div class=\"col-8 fs-5 text-center bg-dark text-white rounded mx-auto py-3\">
\t\t\t\t\t<span class=\"fs-2 fw-bold\">
\t\t\t\t\t\t{{ app.user.firstName }}
\t\t\t\t\t\t{{ app.user.lastName }}
\t\t\t\t\t</span>
\t\t\t\t\t<br>
\t\t\t\t\t<span>
\t\t\t\t\t\t{{ app.user.address }}
\t\t\t\t\t</span>
\t\t\t\t\t<br>
\t\t\t\t\t<span>
\t\t\t\t\t\t{{ app.user.city }},
\t\t\t\t\t\t{{ app.user.province }}
\t\t\t\t\t\t<br>
\t\t\t\t\t\t{{ app.user.postalCode[:3] }}
\t\t\t\t\t\t{{ app.user.postalCode[3:] }}
\t\t\t\t\t</span>
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"mt-5\">
\t\t\t\t<p class=\"h3 text-center\">
\t\t\t\t\t<i class=\"fas fa-basket-shopping me-1\"></i>
\t\t\t\t\tVotre commande
\t\t\t\t</p>
\t\t\t\t<div class=\"row m-3\">
\t\t\t\t\t<div class=\"card text-center\">
\t\t\t\t\t\t<table class=\"table table-hover align-middle\">
\t\t\t\t\t\t\t<thead>
\t\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Visuel</th>
\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Nom</th>
\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Quantité</th>
\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Prix unitaire</th>
\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Total</th>
\t\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t\t</thead>
\t\t\t\t\t\t\t<tbody>
\t\t\t\t\t\t\t\t{% for purchase in orderlist.purchases %}
\t\t\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t<img src=\"{{ asset_if(purchase.product.imagePath, 'images/products/imageNotAvailable.png') }}\" class=\"card-img-top\" style=\"width: 100px; height: 100px\" alt=\"Produit\">
\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t<h5>{{ purchase.product.name }}</h5>
\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t<h5>{{ purchase.quantity }}</h5>
\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t<h5>{{ purchase.product.price|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t<h5>{{ purchase.price|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t\t\t{% endfor %}
\t\t\t\t\t\t\t</tbody>
\t\t\t\t\t\t</table>
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t</div>
\t\t</div>
\t\t<div class=\"col-4 bg-light rounded-top\">
\t\t\t<p class=\"h3 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-file-invoice me-1\"></i>
\t\t\t\tSommaire
\t\t\t\t<div class=\"row fs-5 mx-2\">
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>Sous-Total</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">{{ orderlist.getSubtotal()|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>TPS</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">{{ orderlist.getGST()|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>TVQ</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">{{ orderlist.getQST()|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>Frais de Livraison</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">{{ orderlist.getShippingCost()|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>Côut total</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">{{ orderlist.getTotal()|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"text-center my-5\">
\t\t\t\t\t\t<a href=\"{{ path('checkout') }}\" class=\"btn btn-warning fs-5\">
\t\t\t\t\t\t\t<i class=\"fa-brands fa-cc-stripe me-2\"></i>
\t\t\t\t\t\t\t<span class=\"mx-3\">Payer</span>
\t\t\t\t\t\t\t<span class=\"mx-3\">|</span>
\t\t\t\t\t\t\t<span class=\"mx-3 fw-bold\">{{ orderlist.getTotal()|number_format(2,',','') }}</span>
\t\t\t\t\t\t</a>
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t</p>
\t\t</div>
\t</section>
{% endblock %}
", "order/orderPreview.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\order\\orderPreview.html.twig");
    }
}
