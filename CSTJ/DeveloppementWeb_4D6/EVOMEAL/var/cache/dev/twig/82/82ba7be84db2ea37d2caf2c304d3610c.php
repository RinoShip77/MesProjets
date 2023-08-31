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

/* admin/product/products.html.twig */
class __TwigTemplate_4335db42099c504feefcfff9365f2437 extends Template
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "admin/product/products.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "admin/product/products.html.twig"));

        $this->parent = $this->loadTemplate("core/base.html.twig", "admin/product/products.html.twig", 1);
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
\t\t\t<i class=\"fas fa-list-check me-1\"></i>
\t\t\tTouts les produits
\t\t</p>
\t\t<hr class=\"mt-4\">
\t\t";
        // line 10
        if ((twig_length_filter($this->env, (isset($context["products"]) || array_key_exists("products", $context) ? $context["products"] : (function () { throw new RuntimeError('Variable "products" does not exist.', 10, $this->source); })())) > 0)) {
            // line 11
            echo "\t\t\t<div class=\"m-3 text-center\">
\t\t\t\t<a href=\"";
            // line 12
            echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("admin.add.product");
            echo "\" class=\"btn btn-dark text-decoration-none text-white mb-3\" title=\"Ajouter un nouveau produit\">
\t\t\t\t\t<i class=\"fas fa-plus me-2\"></i>Ajouter un produit
\t\t\t\t</a>
\t\t\t\t<table class=\"table table-hover align-middle\">
\t\t\t\t\t<thead class=\"bg-warning\">
\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t<th scope=\"col\">Numéro du produit</th>
\t\t\t\t\t\t\t<th scope=\"col\">Nom</th>
\t\t\t\t\t\t\t<th scope=\"col\">Catégorie</th>
\t\t\t\t\t\t\t<th scope=\"col\">Prix</th>
\t\t\t\t\t\t\t<th scope=\"col\">Opération</th>
\t\t\t\t\t\t</tr>
\t\t\t\t\t</thead>
\t\t\t\t\t<tbody>
\t\t\t\t\t\t";
            // line 26
            $context['_parent'] = $context;
            $context['_seq'] = twig_ensure_traversable((isset($context["products"]) || array_key_exists("products", $context) ? $context["products"] : (function () { throw new RuntimeError('Variable "products" does not exist.', 26, $this->source); })()));
            foreach ($context['_seq'] as $context["_key"] => $context["product"]) {
                // line 27
                echo "\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>";
                // line 29
                echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["product"], "idProduct", [], "any", false, false, false, 29), "html", null, true);
                echo "</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>";
                // line 32
                echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["product"], "name", [], "any", false, false, false, 32), "html", null, true);
                echo "</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>";
                // line 35
                echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, $context["product"], "categoryName", [], "any", false, false, false, 35), "categoryName", [], "any", false, false, false, 35), "html", null, true);
                echo "</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>";
                // line 38
                echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, $context["product"], "price", [], "any", false, false, false, 38), 2, ",", ""), "html", null, true);
                echo "
\t\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<a href=\"";
                // line 42
                echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("admin.modify.product", ["idProduct" => twig_get_attribute($this->env, $this->source, $context["product"], "idProduct", [], "any", false, false, false, 42)]), "html", null, true);
                echo "\" class=\"text-decoration-none text-black\" title=\"Modifier ce produit\">
\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-pen-to-square\"></i>
\t\t\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t";
            }
            $_parent = $context['_parent'];
            unset($context['_seq'], $context['_iterated'], $context['_key'], $context['product'], $context['_parent'], $context['loop']);
            $context = array_intersect_key($context, $_parent) + $_parent;
            // line 48
            echo "\t\t\t\t\t</tbody>
\t\t\t\t</table>
\t\t\t</div>
\t\t";
        } else {
            // line 52
            echo "\t\t\t<p class=\"display-6 mt-4 text-center text-warning bg-dark rounded m-3 p-3\" id=\"txtRaleway\">L'application n'a aucun produit.</p>
\t\t\t<hr class=\"mb-4\">
\t\t";
        }
        // line 55
        echo "\t</section>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    public function getTemplateName()
    {
        return "admin/product/products.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  154 => 55,  149 => 52,  143 => 48,  131 => 42,  124 => 38,  118 => 35,  112 => 32,  106 => 29,  102 => 27,  98 => 26,  81 => 12,  78 => 11,  76 => 10,  68 => 4,  58 => 3,  35 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("{% extends 'core/base.html.twig' %}

{% block body %}
\t<section>
\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t<i class=\"fas fa-list-check me-1\"></i>
\t\t\tTouts les produits
\t\t</p>
\t\t<hr class=\"mt-4\">
\t\t{% if products|length > 0 %}
\t\t\t<div class=\"m-3 text-center\">
\t\t\t\t<a href=\"{{ path('admin.add.product') }}\" class=\"btn btn-dark text-decoration-none text-white mb-3\" title=\"Ajouter un nouveau produit\">
\t\t\t\t\t<i class=\"fas fa-plus me-2\"></i>Ajouter un produit
\t\t\t\t</a>
\t\t\t\t<table class=\"table table-hover align-middle\">
\t\t\t\t\t<thead class=\"bg-warning\">
\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t<th scope=\"col\">Numéro du produit</th>
\t\t\t\t\t\t\t<th scope=\"col\">Nom</th>
\t\t\t\t\t\t\t<th scope=\"col\">Catégorie</th>
\t\t\t\t\t\t\t<th scope=\"col\">Prix</th>
\t\t\t\t\t\t\t<th scope=\"col\">Opération</th>
\t\t\t\t\t\t</tr>
\t\t\t\t\t</thead>
\t\t\t\t\t<tbody>
\t\t\t\t\t\t{% for product in products %}
\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>{{ product.idProduct }}</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>{{ product.name }}</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>{{ product.categoryName.categoryName }}</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<h5>{{ product.price|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<a href=\"{{ path('admin.modify.product', { idProduct: product.idProduct }) }}\" class=\"text-decoration-none text-black\" title=\"Modifier ce produit\">
\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-pen-to-square\"></i>
\t\t\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t{% endfor %}
\t\t\t\t\t</tbody>
\t\t\t\t</table>
\t\t\t</div>
\t\t{% else %}
\t\t\t<p class=\"display-6 mt-4 text-center text-warning bg-dark rounded m-3 p-3\" id=\"txtRaleway\">L'application n'a aucun produit.</p>
\t\t\t<hr class=\"mb-4\">
\t\t{% endif %}
\t</section>
{% endblock %}
", "admin/product/products.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\admin\\product\\products.html.twig");
    }
}
