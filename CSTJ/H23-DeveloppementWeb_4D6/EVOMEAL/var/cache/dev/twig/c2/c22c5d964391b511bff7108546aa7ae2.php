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

/* admin/category/categories.html.twig */
class __TwigTemplate_01395f1c09e64171776ee9d15011b70c extends Template
{
    private $source;
    private $macros = [];

    public function __construct(Environment $env)
    {
        parent::__construct($env);

        $this->source = $this->getSourceContext();

        $this->blocks = [
            'body' => [$this, 'block_body'],
            'javascripts' => [$this, 'block_javascripts'],
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "admin/category/categories.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "admin/category/categories.html.twig"));

        // line 2
        $this->env->getRuntime("Symfony\\Component\\Form\\FormRenderer")->setTheme((isset($context["category_form"]) || array_key_exists("category_form", $context) ? $context["category_form"] : (function () { throw new RuntimeError('Variable "category_form" does not exist.', 2, $this->source); })()), [0 => "bootstrap_5_layout.html.twig"], true);
        // line 1
        $this->parent = $this->loadTemplate("core/base.html.twig", "admin/category/categories.html.twig", 1);
        $this->parent->display($context, array_merge($this->blocks, $blocks));
        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

    }

    // line 4
    public function block_body($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "body"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "body"));

        // line 5
        echo "\t";
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 5, $this->source); })()), "flashes", [0 => "categories_update"], "method", false, false, false, 5));
        foreach ($context['_seq'] as $context["_key"] => $context["flash"]) {
            // line 6
            echo "\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center bg-dark rounded ";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "color", [], "any", false, false, false, 6), "html", null, true);
            echo "\">";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "content", [], "any", false, false, false, 6), "html", null, true);
            echo "</div>
\t";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['flash'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 8
        echo "\t<section>
\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t<i class=\"fas fa-list-check me-1\"></i>
\t\t\tToutes les catégories
\t\t</p>
\t\t<hr class=\"mt-4\">
\t\t<div class=\"mx-auto py-5 w-75\">
\t\t\t";
        // line 15
        if ((twig_length_filter($this->env, (isset($context["categories"]) || array_key_exists("categories", $context) ? $context["categories"] : (function () { throw new RuntimeError('Variable "categories" does not exist.', 15, $this->source); })())) > 0)) {
            // line 16
            echo "\t\t\t\t";
            echo             $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderBlock((isset($context["category_form"]) || array_key_exists("category_form", $context) ? $context["category_form"] : (function () { throw new RuntimeError('Variable "category_form" does not exist.', 16, $this->source); })()), 'form_start');
            echo "
\t\t\t\t<div class=\"row\">
\t\t\t\t\t<ul class=\"categories list-unstyled\" data-index=\"";
            // line 18
            (((twig_length_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["category_form"]) || array_key_exists("category_form", $context) ? $context["category_form"] : (function () { throw new RuntimeError('Variable "category_form" does not exist.', 18, $this->source); })()), "categories", [], "any", false, false, false, 18)) > 0)) ? (print (twig_escape_filter($this->env, (twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, twig_last($this->env, twig_get_attribute($this->env, $this->source, (isset($context["category_form"]) || array_key_exists("category_form", $context) ? $context["category_form"] : (function () { throw new RuntimeError('Variable "category_form" does not exist.', 18, $this->source); })()), "categories", [], "any", false, false, false, 18)), "vars", [], "any", false, false, false, 18), "name", [], "any", false, false, false, 18) + 1), "html", null, true))) : (print (0)));
            echo "\" data-prototype=\"";
            echo twig_escape_filter($this->env, $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["category_form"]) || array_key_exists("category_form", $context) ? $context["category_form"] : (function () { throw new RuntimeError('Variable "category_form" does not exist.', 18, $this->source); })()), "categories", [], "any", false, false, false, 18), "vars", [], "any", false, false, false, 18), "prototype", [], "any", false, false, false, 18), 'widget'), "html_attr");
            echo "\">
\t\t\t\t\t\t";
            // line 19
            $context['_parent'] = $context;
            $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["category_form"]) || array_key_exists("category_form", $context) ? $context["category_form"] : (function () { throw new RuntimeError('Variable "category_form" does not exist.', 19, $this->source); })()), "categories", [], "any", false, false, false, 19));
            foreach ($context['_seq'] as $context["_key"] => $context["category"]) {
                // line 20
                echo "\t\t\t\t\t\t\t<li>";
                echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, $context["category"], "categoryName", [], "any", false, false, false, 20), 'row');
                echo "
\t\t\t\t\t\t\t";
            }
            $_parent = $context['_parent'];
            unset($context['_seq'], $context['_iterated'], $context['_key'], $context['category'], $context['_parent'], $context['loop']);
            $context = array_intersect_key($context, $_parent) + $_parent;
            // line 22
            echo "\t\t\t\t\t\t</ul>
\t\t\t\t\t</div>

\t\t\t\t\t<div class=\"d-flex justify-content-around m-3\">
\t\t\t\t\t\t<button type=\"button\" class=\"add_category_link btn btn-warning my-2\" data-collection-holder-class=\"categories\">
\t\t\t\t\t\t\t<i class=\"fas fa-plus me-2\"></i>Ajouter une catégorie</button>
\t\t\t\t\t\t";
            // line 28
            echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["category_form"]) || array_key_exists("category_form", $context) ? $context["category_form"] : (function () { throw new RuntimeError('Variable "category_form" does not exist.', 28, $this->source); })()), "save", [], "any", false, false, false, 28), 'row');
            echo "
\t\t\t\t\t</div>

\t\t\t\t\t";
            // line 31
            echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock((isset($context["category_form"]) || array_key_exists("category_form", $context) ? $context["category_form"] : (function () { throw new RuntimeError('Variable "category_form" does not exist.', 31, $this->source); })()), 'rest');
            echo "
\t\t\t\t\t";
            // line 32
            echo             $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderBlock((isset($context["category_form"]) || array_key_exists("category_form", $context) ? $context["category_form"] : (function () { throw new RuntimeError('Variable "category_form" does not exist.', 32, $this->source); })()), 'form_end');
            echo "
\t\t\t\t";
        } else {
            // line 34
            echo "\t\t\t\t\t<p class=\"display-6 mt-4 text-center text-warning bg-dark rounded m-3 p-3\" id=\"txtRaleway\">L'application n'a aucune catégorie.</p>
\t\t\t\t\t<hr class=\"mb-4\">
\t\t\t\t";
        }
        // line 37
        echo "\t\t\t</div>
\t\t</section>
\t";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    // line 41
    public function block_javascripts($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        // line 42
        echo "\t\t<script defer src=\"";
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("scripts/admin.categories.js"), "html", null, true);
        echo "\"></script>
\t";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    public function getTemplateName()
    {
        return "admin/category/categories.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  174 => 42,  164 => 41,  152 => 37,  147 => 34,  142 => 32,  138 => 31,  132 => 28,  124 => 22,  115 => 20,  111 => 19,  105 => 18,  99 => 16,  97 => 15,  88 => 8,  77 => 6,  72 => 5,  62 => 4,  51 => 1,  49 => 2,  36 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("{% extends 'core/base.html.twig' %}
{% form_theme category_form 'bootstrap_5_layout.html.twig' %}

{% block body %}
\t{% for flash in app.flashes('categories_update') %}
\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center bg-dark rounded {{ flash.color }}\">{{ flash.content }}</div>
\t{% endfor %}
\t<section>
\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t<i class=\"fas fa-list-check me-1\"></i>
\t\t\tToutes les catégories
\t\t</p>
\t\t<hr class=\"mt-4\">
\t\t<div class=\"mx-auto py-5 w-75\">
\t\t\t{% if categories|length > 0 %}
\t\t\t\t{{ form_start(category_form) }}
\t\t\t\t<div class=\"row\">
\t\t\t\t\t<ul class=\"categories list-unstyled\" data-index=\"{{ category_form.categories|length > 0 ? category_form.categories|last.vars.name + 1 : 0 }}\" data-prototype=\"{{ form_widget(category_form.categories.vars.prototype)|e('html_attr') }}\">
\t\t\t\t\t\t{% for category in category_form.categories %}
\t\t\t\t\t\t\t<li>{{ form_row(category.categoryName) }}
\t\t\t\t\t\t\t{% endfor %}
\t\t\t\t\t\t</ul>
\t\t\t\t\t</div>

\t\t\t\t\t<div class=\"d-flex justify-content-around m-3\">
\t\t\t\t\t\t<button type=\"button\" class=\"add_category_link btn btn-warning my-2\" data-collection-holder-class=\"categories\">
\t\t\t\t\t\t\t<i class=\"fas fa-plus me-2\"></i>Ajouter une catégorie</button>
\t\t\t\t\t\t{{ form_row(category_form.save) }}
\t\t\t\t\t</div>

\t\t\t\t\t{{ form_rest(category_form) }}
\t\t\t\t\t{{ form_end(category_form) }}
\t\t\t\t{% else %}
\t\t\t\t\t<p class=\"display-6 mt-4 text-center text-warning bg-dark rounded m-3 p-3\" id=\"txtRaleway\">L'application n'a aucune catégorie.</p>
\t\t\t\t\t<hr class=\"mb-4\">
\t\t\t\t{% endif %}
\t\t\t</div>
\t\t</section>
\t{% endblock %}

\t{% block javascripts %}
\t\t<script defer src=\"{{ asset('scripts/admin.categories.js') }}\"></script>
\t{% endblock %}
", "admin/category/categories.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\admin\\category\\categories.html.twig");
    }
}
