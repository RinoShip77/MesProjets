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

/* cart/cart.html.twig */
class __TwigTemplate_98548766abcd42f4bba1a486b1a24bb5 extends Template
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "cart/cart.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "cart/cart.html.twig"));

        $this->parent = $this->loadTemplate("core/base.html.twig", "cart/cart.html.twig", 1);
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
        echo "\t<section class=\"row\">
\t\t<div class=\"col-8 bg-warning\">
\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-cart-shopping me-1\"></i>
\t\t\t\tVotre panier
\t\t\t</p>
\t\t\t<hr class=\"mt-4\">
\t\t\t";
        // line 11
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 11, $this->source); })()), "flashes", [0 => "payment_message"], "method", false, false, false, 11));
        foreach ($context['_seq'] as $context["_key"] => $context["flash"]) {
            // line 12
            echo "\t\t\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center text-dark rounded bg-";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "color", [], "any", false, false, false, 12), "html", null, true);
            echo "\">";
            echo twig_get_attribute($this->env, $this->source, $context["flash"], "content", [], "any", false, false, false, 12);
            echo "</div>
\t\t\t";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['flash'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 14
        echo "\t\t\t";
        if ((twig_length_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["purchaselist"]) || array_key_exists("purchaselist", $context) ? $context["purchaselist"] : (function () { throw new RuntimeError('Variable "purchaselist" does not exist.', 14, $this->source); })()), "purchases", [], "any", false, false, false, 14)) > 0)) {
            // line 15
            echo "\t\t\t\t";
            $context['_parent'] = $context;
            $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 15, $this->source); })()), "flashes", [0 => "cart_message"], "method", false, false, false, 15));
            foreach ($context['_seq'] as $context["_key"] => $context["flash"]) {
                // line 16
                echo "\t\t\t\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center bg-dark rounded ";
                echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "color", [], "any", false, false, false, 16), "html", null, true);
                echo "\">";
                echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "content", [], "any", false, false, false, 16), "html", null, true);
                echo "</div>
\t\t\t\t";
            }
            $_parent = $context['_parent'];
            unset($context['_seq'], $context['_iterated'], $context['_key'], $context['flash'], $context['_parent'], $context['loop']);
            $context = array_intersect_key($context, $_parent) + $_parent;
            // line 18
            echo "\t\t\t\t<form action=\"";
            echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("cart.update");
            echo "\" method=\"POST\">
\t\t\t\t\t<div class=\"row m-3\">
\t\t\t\t\t\t<div class=\"card text-center\">
\t\t\t\t\t\t\t<table class=\"table table-hover align-middle\">
\t\t\t\t\t\t\t\t<thead>
\t\t\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Visuel</th>
\t\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Nom</th>
\t\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Quantité</th>
\t\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Prix unitaire</th>
\t\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Total</th>
\t\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Opération</th>
\t\t\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t\t\t</thead>
\t\t\t\t\t\t\t\t<tbody>
\t\t\t\t\t\t\t\t\t";
            // line 33
            $context['_parent'] = $context;
            $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["purchaselist"]) || array_key_exists("purchaselist", $context) ? $context["purchaselist"] : (function () { throw new RuntimeError('Variable "purchaselist" does not exist.', 33, $this->source); })()), "purchases", [], "any", false, false, false, 33));
            foreach ($context['_seq'] as $context["key"] => $context["purchase"]) {
                // line 34
                echo "\t\t\t\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t\t<img src=\"";
                // line 36
                echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, $context["purchase"], "product", [], "any", false, false, false, 36), "imagePath", [], "any", false, false, false, 36), "html", null, true);
                echo "\" class=\"card-img-top\" style=\"width: 100px; height: 100px\" alt=\"Produit\">
\t\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t\t<h5>";
                // line 39
                echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, $context["purchase"], "product", [], "any", false, false, false, 39), "name", [], "any", false, false, false, 39), "html", null, true);
                echo "</h5>
\t\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t\t<input name=\"";
                // line 42
                echo twig_escape_filter($this->env, (("inpQuantity[" . $context["key"]) . "]"), "html", null, true);
                echo "\" value=\"";
                echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["purchase"], "quantity", [], "any", false, false, false, 42), "html", null, true);
                echo "\" min=\"0\" class=\"rounded bg-dark text-white text-center fs-3 w-25\" type=\"number\" class=\"form-control\" placeholder=\"1\" required>
\t\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t\t<h5>";
                // line 45
                echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, $context["purchase"], "product", [], "any", false, false, false, 45), "price", [], "any", false, false, false, 45), 2, ",", ""), "html", null, true);
                echo "
\t\t\t\t\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t\t<h5>";
                // line 49
                echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, $context["purchase"], "price", [], "any", false, false, false, 49), 2, ",", ""), "html", null, true);
                echo "
\t\t\t\t\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t\t<a href=\"";
                // line 53
                echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("cart.delete", ["idProduct" => $context["key"]]), "html", null, true);
                echo "\" class=\"text-decoration-none text-black my-2\" title=\"Retirer de votre panier\">
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-trash\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t\t\t\t";
            }
            $_parent = $context['_parent'];
            unset($context['_seq'], $context['_iterated'], $context['key'], $context['purchase'], $context['_parent'], $context['loop']);
            $context = array_intersect_key($context, $_parent) + $_parent;
            // line 59
            echo "\t\t\t\t\t\t\t\t</tbody>
\t\t\t\t\t\t\t</table>
\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"d-flex flex-row justify-content-md-center my-2 mb-5\">
\t\t\t\t\t\t<button name=\"action\" value=\"update\" type=\"submit\" class=\"btn btn-dark col-4 mx-3\">
\t\t\t\t\t\t\t<i class=\"fas fa-arrows-rotate me-2\"></i>Mettre à jour le panier</button>
\t\t\t\t\t\t<button name=\"action\" value=\"empty\" type=\"submit\" class=\"btn btn-dark col-4 mx-3\">
\t\t\t\t\t\t\t<i class=\"fas fa-trash-can me-2\"></i>Vider le panier</button>
\t\t\t\t\t</div>
\t\t\t\t</form>
\t\t\t";
        } else {
            // line 71
            echo "\t\t\t\t<p class=\"display-6 mt-4 text-center text-white bg-dark rounded m-3 p-3\" id=\"txtRaleway\">Votre panier est vide.</p>
\t\t\t\t<hr class=\"mb-4\">
\t\t\t";
        }
        // line 74
        echo "\t\t</div>
\t\t<div class=\"col-4\">
\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-dollar-sign me-1\"></i>
\t\t\t\tSommaire
\t\t\t\t<div class=\"row fs-5 mx-2\">
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>Sous-Total</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">";
        // line 83
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["purchaselist"]) || array_key_exists("purchaselist", $context) ? $context["purchaselist"] : (function () { throw new RuntimeError('Variable "purchaselist" does not exist.', 83, $this->source); })()), "getSubtotal", [], "method", false, false, false, 83), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>TPS</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">";
        // line 91
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["purchaselist"]) || array_key_exists("purchaselist", $context) ? $context["purchaselist"] : (function () { throw new RuntimeError('Variable "purchaselist" does not exist.', 91, $this->source); })()), "getGST", [], "method", false, false, false, 91), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>TVQ</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">";
        // line 99
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["purchaselist"]) || array_key_exists("purchaselist", $context) ? $context["purchaselist"] : (function () { throw new RuntimeError('Variable "purchaselist" does not exist.', 99, $this->source); })()), "getQST", [], "method", false, false, false, 99), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>Frais de Livraison</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">";
        // line 107
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["purchaselist"]) || array_key_exists("purchaselist", $context) ? $context["purchaselist"] : (function () { throw new RuntimeError('Variable "purchaselist" does not exist.', 107, $this->source); })()), "getShippingCost", [], "method", false, false, false, 107), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>Côut total</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">";
        // line 115
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["purchaselist"]) || array_key_exists("purchaselist", $context) ? $context["purchaselist"] : (function () { throw new RuntimeError('Variable "purchaselist" does not exist.', 115, $this->source); })()), "getTotal", [], "method", false, false, false, 115), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"text-center my-5\">
\t\t\t\t\t\t<a href=\"";
        // line 121
        echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("order.preview");
        echo "\" class=\"btn btn-warning fs-5\">
\t\t\t\t\t\t\t<i class=\"fas fa-money-bill-wave me-2\"></i>Passer à la caisse
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
        return "cart/cart.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  267 => 121,  258 => 115,  247 => 107,  236 => 99,  225 => 91,  214 => 83,  203 => 74,  198 => 71,  184 => 59,  172 => 53,  165 => 49,  158 => 45,  150 => 42,  144 => 39,  138 => 36,  134 => 34,  130 => 33,  111 => 18,  100 => 16,  95 => 15,  92 => 14,  81 => 12,  77 => 11,  68 => 4,  58 => 3,  35 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("{% extends 'core/base.html.twig' %}

{% block body %}
\t<section class=\"row\">
\t\t<div class=\"col-8 bg-warning\">
\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-cart-shopping me-1\"></i>
\t\t\t\tVotre panier
\t\t\t</p>
\t\t\t<hr class=\"mt-4\">
\t\t\t{% for flash in app.flashes('payment_message') %}
\t\t\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center text-dark rounded bg-{{ flash.color }}\">{{ flash.content|raw }}</div>
\t\t\t{% endfor %}
\t\t\t{% if purchaselist.purchases|length > 0 %}
\t\t\t\t{% for flash in app.flashes('cart_message') %}
\t\t\t\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center bg-dark rounded {{ flash.color }}\">{{ flash.content }}</div>
\t\t\t\t{% endfor %}
\t\t\t\t<form action=\"{{ path('cart.update') }}\" method=\"POST\">
\t\t\t\t\t<div class=\"row m-3\">
\t\t\t\t\t\t<div class=\"card text-center\">
\t\t\t\t\t\t\t<table class=\"table table-hover align-middle\">
\t\t\t\t\t\t\t\t<thead>
\t\t\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Visuel</th>
\t\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Nom</th>
\t\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Quantité</th>
\t\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Prix unitaire</th>
\t\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Total</th>
\t\t\t\t\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Opération</th>
\t\t\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t\t\t</thead>
\t\t\t\t\t\t\t\t<tbody>
\t\t\t\t\t\t\t\t\t{% for key, purchase in purchaselist.purchases %}
\t\t\t\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t\t<img src=\"{{ purchase.product.imagePath }}\" class=\"card-img-top\" style=\"width: 100px; height: 100px\" alt=\"Produit\">
\t\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t\t<h5>{{ purchase.product.name }}</h5>
\t\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t\t<input name=\"{{ 'inpQuantity[' ~ key ~ ']' }}\" value=\"{{ purchase.quantity }}\" min=\"0\" class=\"rounded bg-dark text-white text-center fs-3 w-25\" type=\"number\" class=\"form-control\" placeholder=\"1\" required>
\t\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t\t<h5>{{ purchase.product.price|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t\t<h5>{{ purchase.price|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t\t<a href=\"{{ path('cart.delete', { idProduct: key }) }}\" class=\"text-decoration-none text-black my-2\" title=\"Retirer de votre panier\">
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-trash\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t\t\t\t{% endfor %}
\t\t\t\t\t\t\t\t</tbody>
\t\t\t\t\t\t\t</table>
\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"d-flex flex-row justify-content-md-center my-2 mb-5\">
\t\t\t\t\t\t<button name=\"action\" value=\"update\" type=\"submit\" class=\"btn btn-dark col-4 mx-3\">
\t\t\t\t\t\t\t<i class=\"fas fa-arrows-rotate me-2\"></i>Mettre à jour le panier</button>
\t\t\t\t\t\t<button name=\"action\" value=\"empty\" type=\"submit\" class=\"btn btn-dark col-4 mx-3\">
\t\t\t\t\t\t\t<i class=\"fas fa-trash-can me-2\"></i>Vider le panier</button>
\t\t\t\t\t</div>
\t\t\t\t</form>
\t\t\t{% else %}
\t\t\t\t<p class=\"display-6 mt-4 text-center text-white bg-dark rounded m-3 p-3\" id=\"txtRaleway\">Votre panier est vide.</p>
\t\t\t\t<hr class=\"mb-4\">
\t\t\t{% endif %}
\t\t</div>
\t\t<div class=\"col-4\">
\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-dollar-sign me-1\"></i>
\t\t\t\tSommaire
\t\t\t\t<div class=\"row fs-5 mx-2\">
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>Sous-Total</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">{{ purchaselist.getSubtotal()|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>TPS</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">{{ purchaselist.getGST()|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>TVQ</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">{{ purchaselist.getQST()|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>Frais de Livraison</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">{{ purchaselist.getShippingCost()|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"my-1\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p>Côut total</p>
\t\t\t\t\t\t\t<p class=\"fw-bolder fs-4\">{{ purchaselist.getTotal()|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<hr>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"text-center my-5\">
\t\t\t\t\t\t<a href=\"{{ path('order.preview') }}\" class=\"btn btn-warning fs-5\">
\t\t\t\t\t\t\t<i class=\"fas fa-money-bill-wave me-2\"></i>Passer à la caisse
\t\t\t\t\t\t</a>
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t</p>
\t\t</div>
\t</section>
{% endblock %}
", "cart/cart.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\cart\\cart.html.twig");
    }
}
