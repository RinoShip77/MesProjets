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

/* admin/admin.html.twig */
class __TwigTemplate_840c2491b968b7fc58dae0c0e4e9e99f extends Template
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "admin/admin.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "admin/admin.html.twig"));

        $this->parent = $this->loadTemplate("core/base.html.twig", "admin/admin.html.twig", 1);
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
        echo "\t";
        if ($this->extensions['Symfony\Bridge\Twig\Extension\SecurityExtension']->isGranted("ROLE_ADMIN")) {
            // line 5
            echo "\t\t<div class=\"row text-center mt-4\">
\t\t\t<h1 class=\"w-100\">
\t\t\t\t<i class=\"fas fa-user-gear me-2\"></i>Compte administrateur
\t\t\t</h1>
\t\t\t<div class=\"row mb-2 mt-5\">
\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t<h2 class=\"text-muted\">Catégories</h2>
\t\t\t\t\t<a href=\"";
            // line 12
            echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("admin.categories");
            echo "\" class=\"btn btn-outline-warning border-0 text-decoration-none m-3\">
\t\t\t\t\t\t<i class=\"display-1 fas fa-sitemap me-2\"></i>
\t\t\t\t\t</a>
\t\t\t\t</div>
\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t<h2 class=\"text-muted\">Produits</h2>
\t\t\t\t\t<a href=\"";
            // line 18
            echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("admin.products");
            echo "\" class=\"btn btn-outline-warning border-0 text-decoration-none m-3\">
\t\t\t\t\t\t<i class=\"display-1 fas fa-boxes-packing me-2\"></i>
\t\t\t\t\t</a>
\t\t\t\t</div>
\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t<h2 class=\"text-muted\">Commandes</h2>
\t\t\t\t\t<a href=\"";
            // line 24
            echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("admin.orders");
            echo "\" class=\"btn btn-outline-warning border-0 text-decoration-none m-3\">
\t\t\t\t\t\t<i class=\"display-1 fas fa-truck-ramp-box me-2\"></i>
\t\t\t\t\t</a>
\t\t\t\t</div>
\t\t\t</div>
\t\t</div>
\t";
        }
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    public function getTemplateName()
    {
        return "admin/admin.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  98 => 24,  89 => 18,  80 => 12,  71 => 5,  68 => 4,  58 => 3,  35 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("{% extends 'core/base.html.twig' %}

{% block body %}
\t{% if is_granted(\"ROLE_ADMIN\") %}
\t\t<div class=\"row text-center mt-4\">
\t\t\t<h1 class=\"w-100\">
\t\t\t\t<i class=\"fas fa-user-gear me-2\"></i>Compte administrateur
\t\t\t</h1>
\t\t\t<div class=\"row mb-2 mt-5\">
\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t<h2 class=\"text-muted\">Catégories</h2>
\t\t\t\t\t<a href=\"{{ path('admin.categories') }}\" class=\"btn btn-outline-warning border-0 text-decoration-none m-3\">
\t\t\t\t\t\t<i class=\"display-1 fas fa-sitemap me-2\"></i>
\t\t\t\t\t</a>
\t\t\t\t</div>
\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t<h2 class=\"text-muted\">Produits</h2>
\t\t\t\t\t<a href=\"{{ path('admin.products') }}\" class=\"btn btn-outline-warning border-0 text-decoration-none m-3\">
\t\t\t\t\t\t<i class=\"display-1 fas fa-boxes-packing me-2\"></i>
\t\t\t\t\t</a>
\t\t\t\t</div>
\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t<h2 class=\"text-muted\">Commandes</h2>
\t\t\t\t\t<a href=\"{{ path('admin.orders') }}\" class=\"btn btn-outline-warning border-0 text-decoration-none m-3\">
\t\t\t\t\t\t<i class=\"display-1 fas fa-truck-ramp-box me-2\"></i>
\t\t\t\t\t</a>
\t\t\t\t</div>
\t\t\t</div>
\t\t</div>
\t{% endif %}
{% endblock %}
", "admin/admin.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\admin\\admin.html.twig");
    }
}
