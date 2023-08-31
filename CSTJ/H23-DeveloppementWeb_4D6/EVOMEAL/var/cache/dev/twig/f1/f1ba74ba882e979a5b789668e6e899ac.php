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

/* profile/profileOrders.html.twig */
class __TwigTemplate_cef4a0231e0c4d87677dde13cffe14dc extends Template
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "profile/profileOrders.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "profile/profileOrders.html.twig"));

        $this->parent = $this->loadTemplate("core/base.html.twig", "profile/profileOrders.html.twig", 1);
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
        echo "\t<section>
\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t<i class=\"fas fa-arrow-down-short-wide me-1\"></i>
\t\t\tVos commandes
\t\t</p>
\t\t<hr class=\"mt-4\">
\t\t";
        // line 10
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 10, $this->source); })()), "flashes", [0 => "profile_orders_message"], "method", false, false, false, 10));
        foreach ($context['_seq'] as $context["_key"] => $context["flash"]) {
            // line 11
            echo "\t\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center text-dark rounded bg-";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "color", [], "any", false, false, false, 11), "html", null, true);
            echo "\">";
            echo twig_get_attribute($this->env, $this->source, $context["flash"], "content", [], "any", false, false, false, 11);
            echo "</div>
\t\t";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['flash'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 13
        echo "\t\t";
        if ((twig_length_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 13, $this->source); })()), "user", [], "any", false, false, false, 13), "orders", [], "any", false, false, false, 13)) > 0)) {
            // line 14
            echo "\t\t\t<div class=\"m-3 text-center\">
\t\t\t\t<table class=\"table table-hover align-middle\">
\t\t\t\t\t<thead class=\"bg-dark text-white\">
\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t<th scope=\"col\">Numéro de la commande</th>
\t\t\t\t\t\t\t<th scope=\"col\">Date</th>
\t\t\t\t\t\t\t<th scope=\"col\">Total</th>
\t\t\t\t\t\t\t<th scope=\"col\">Opération</th>
\t\t\t\t\t\t</tr>
\t\t\t\t\t</thead>
\t\t\t\t\t<tbody class=\"bg-warning\">
\t\t\t\t\t\t";
            // line 25
            $context['_parent'] = $context;
            $context['_seq'] = twig_ensure_traversable(twig_reverse_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 25, $this->source); })()), "user", [], "any", false, false, false, 25), "orders", [], "any", false, false, false, 25)));
            foreach ($context['_seq'] as $context["_key"] => $context["order"]) {
                // line 26
                echo "\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>";
                // line 28
                echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["order"], "idOrder", [], "any", false, false, false, 28), "html", null, true);
                echo "</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>";
                // line 31
                echo twig_escape_filter($this->env, twig_date_format_filter($this->env, twig_get_attribute($this->env, $this->source, $context["order"], "orderDate", [], "any", false, false, false, 31), "Y-m-d H:i:s", "America/Toronto"), "html", null, true);
                echo "</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>";
                // line 34
                echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, $context["order"], "calculateTotal", [], "method", false, false, false, 34), 2, ",", ""), "html", null, true);
                echo "
\t\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<a href=\"";
                // line 38
                echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("order.confirmation", ["idOrder" => twig_get_attribute($this->env, $this->source, $context["order"], "idOrder", [], "any", false, false, false, 38)]), "html", null, true);
                echo "\" class=\"text-decoration-none text-black\" title=\"Voir les détails de la commande\">
\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-eye\"></i>
\t\t\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t";
            }
            $_parent = $context['_parent'];
            unset($context['_seq'], $context['_iterated'], $context['_key'], $context['order'], $context['_parent'], $context['loop']);
            $context = array_intersect_key($context, $_parent) + $_parent;
            // line 44
            echo "\t\t\t\t\t</tbody>
\t\t\t\t</table>
\t\t\t</div>
\t\t";
        } else {
            // line 48
            echo "\t\t\t<p class=\"display-6 mt-4 text-center text-warning bg-dark rounded m-3 p-3\" id=\"txtRaleway\">Vous n'avez aucune commande.</p>
\t\t\t<hr class=\"mb-4\">
\t\t";
        }
        // line 51
        echo "\t</section>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    public function getTemplateName()
    {
        return "profile/profileOrders.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  157 => 51,  152 => 48,  146 => 44,  134 => 38,  127 => 34,  121 => 31,  115 => 28,  111 => 26,  107 => 25,  94 => 14,  91 => 13,  80 => 11,  76 => 10,  68 => 4,  58 => 3,  35 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("{% extends 'core/base.html.twig' %}

{% block body %}
\t<section>
\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t<i class=\"fas fa-arrow-down-short-wide me-1\"></i>
\t\t\tVos commandes
\t\t</p>
\t\t<hr class=\"mt-4\">
\t\t{% for flash in app.flashes('profile_orders_message') %}
\t\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center text-dark rounded bg-{{ flash.color }}\">{{ flash.content|raw }}</div>
\t\t{% endfor %}
\t\t{% if app.user.orders|length > 0 %}
\t\t\t<div class=\"m-3 text-center\">
\t\t\t\t<table class=\"table table-hover align-middle\">
\t\t\t\t\t<thead class=\"bg-dark text-white\">
\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t<th scope=\"col\">Numéro de la commande</th>
\t\t\t\t\t\t\t<th scope=\"col\">Date</th>
\t\t\t\t\t\t\t<th scope=\"col\">Total</th>
\t\t\t\t\t\t\t<th scope=\"col\">Opération</th>
\t\t\t\t\t\t</tr>
\t\t\t\t\t</thead>
\t\t\t\t\t<tbody class=\"bg-warning\">
\t\t\t\t\t\t{% for order in app.user.orders|reverse %}
\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>{{ order.idOrder }}</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>{{ order.orderDate|date('Y-m-d H:i:s', 'America/Toronto') }}</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>{{ order.calculateTotal()|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<a href=\"{{ path('order.confirmation', { idOrder: order.idOrder }) }}\" class=\"text-decoration-none text-black\" title=\"Voir les détails de la commande\">
\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-eye\"></i>
\t\t\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t{% endfor %}
\t\t\t\t\t</tbody>
\t\t\t\t</table>
\t\t\t</div>
\t\t{% else %}
\t\t\t<p class=\"display-6 mt-4 text-center text-warning bg-dark rounded m-3 p-3\" id=\"txtRaleway\">Vous n'avez aucune commande.</p>
\t\t\t<hr class=\"mb-4\">
\t\t{% endif %}
\t</section>
{% endblock %}
", "profile/profileOrders.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\profile\\profileOrders.html.twig");
    }
}
