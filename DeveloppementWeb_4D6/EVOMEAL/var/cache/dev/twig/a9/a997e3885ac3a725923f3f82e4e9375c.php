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

/* registration/register.html.twig */
class __TwigTemplate_ee830660ea8a64a6cd43a4fe19f26f62 extends Template
{
    private $source;
    private $macros = [];

    public function __construct(Environment $env)
    {
        parent::__construct($env);

        $this->source = $this->getSourceContext();

        $this->blocks = [
            'body' => [$this, 'block_body'],
            'stylesheets' => [$this, 'block_stylesheets'],
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "registration/register.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "registration/register.html.twig"));

        // line 2
        $this->env->getRuntime("Symfony\\Component\\Form\\FormRenderer")->setTheme((isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 2, $this->source); })()), [0 => "bootstrap_5_layout.html.twig"], true);
        // line 1
        $this->parent = $this->loadTemplate("core/base.html.twig", "registration/register.html.twig", 1);
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
        echo "\t<div class=\"row bg-warning\">
\t\t<div class=\"col-lg-8 mx-auto\">
\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-user-plus me-2\"></i>
\t\t\t\tCréer mon compte
\t\t\t</p>
\t\t\t<hr class=\"mt-4\">
\t\t\t";
        // line 12
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 12, $this->source); })()), "flashes", [0 => "register"], "method", false, false, false, 12));
        foreach ($context['_seq'] as $context["_key"] => $context["flash"]) {
            // line 13
            echo "\t\t\t\t<div class=\"alert my-3 ";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "color", [], "any", false, false, false, 13), "html", null, true);
            echo "\">";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "content", [], "any", false, false, false, 13), "html", null, true);
            echo "</div>
\t\t\t";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['flash'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 15
        echo "\t\t\t";
        echo         $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderBlock((isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 15, $this->source); })()), 'form_start', ["attr" => ["class" => "needs-validation-register", "novalidate" => "novalidate"]]);
        echo "
\t\t\t";
        // line 16
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 16, $this->source); })()), "email", [], "any", false, false, false, 16), 'row');
        echo "
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-6\">
\t\t\t\t\t";
        // line 19
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 19, $this->source); })()), "firstName", [], "any", false, false, false, 19), 'row');
        echo "
\t\t\t\t</div>
\t\t\t\t<div class=\"col-6\">
\t\t\t\t\t";
        // line 22
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 22, $this->source); })()), "lastName", [], "any", false, false, false, 22), 'row');
        echo "
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-6\">
\t\t\t\t\t";
        // line 27
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 27, $this->source); })()), "password", [], "any", false, false, false, 27), "first", [], "any", false, false, false, 27), 'row');
        echo "
\t\t\t\t</div>
\t\t\t\t<div class=\"col-6\">
\t\t\t\t\t";
        // line 30
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 30, $this->source); })()), "password", [], "any", false, false, false, 30), "second", [], "any", false, false, false, 30), 'row');
        echo "
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-8\">
\t\t\t\t\t";
        // line 35
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 35, $this->source); })()), "address", [], "any", false, false, false, 35), 'row');
        echo "
\t\t\t\t</div>
\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t";
        // line 38
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 38, $this->source); })()), "city", [], "any", false, false, false, 38), 'row');
        echo "
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-5\">
\t\t\t\t\t";
        // line 43
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 43, $this->source); })()), "postalCode", [], "any", false, false, false, 43), 'row');
        echo "
\t\t\t\t</div>
\t\t\t\t<div class=\"col-2\">
\t\t\t\t\t";
        // line 46
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 46, $this->source); })()), "province", [], "any", false, false, false, 46), 'row');
        echo "
\t\t\t\t</div>
\t\t\t\t<div class=\"col-5\">
\t\t\t\t\t";
        // line 49
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 49, $this->source); })()), "phoneNumber", [], "any", false, false, false, 49), 'row');
        echo "
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"d-flex justify-content-center m-3\">
\t\t\t\t";
        // line 53
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 53, $this->source); })()), "create", [], "any", false, false, false, 53), 'row');
        echo "
\t\t\t</div>
\t\t\t";
        // line 55
        echo         $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderBlock((isset($context["registration_form"]) || array_key_exists("registration_form", $context) ? $context["registration_form"] : (function () { throw new RuntimeError('Variable "registration_form" does not exist.', 55, $this->source); })()), 'form_end');
        echo "
\t\t</div>
\t</div>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    // line 60
    public function block_stylesheets($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "stylesheets"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "stylesheets"));

        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    // line 62
    public function block_javascripts($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        // line 63
        echo "\t<script defer src=\"https://cdn.jsdelivr.net/npm/jquery-mask-plugin@1.14.16/dist/jquery.mask.min.js\"></script>
\t<script defer src=\"";
        // line 64
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("scripts/registerValidation.js"), "html", null, true);
        echo "\"></script>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    public function getTemplateName()
    {
        return "registration/register.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  219 => 64,  216 => 63,  206 => 62,  188 => 60,  174 => 55,  169 => 53,  162 => 49,  156 => 46,  150 => 43,  142 => 38,  136 => 35,  128 => 30,  122 => 27,  114 => 22,  108 => 19,  102 => 16,  97 => 15,  86 => 13,  82 => 12,  73 => 5,  63 => 4,  52 => 1,  50 => 2,  37 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("{% extends 'core/base.html.twig' %}
{% form_theme registration_form 'bootstrap_5_layout.html.twig' %}

{% block body %}
\t<div class=\"row bg-warning\">
\t\t<div class=\"col-lg-8 mx-auto\">
\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-user-plus me-2\"></i>
\t\t\t\tCréer mon compte
\t\t\t</p>
\t\t\t<hr class=\"mt-4\">
\t\t\t{% for flash in app.flashes('register')%}
\t\t\t\t<div class=\"alert my-3 {{ flash.color }}\">{{ flash.content }}</div>
\t\t\t{% endfor %}
\t\t\t{{ form_start(registration_form, {'attr': {'class': 'needs-validation-register', 'novalidate': 'novalidate' }}) }}
\t\t\t{{ form_row(registration_form.email) }}
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-6\">
\t\t\t\t\t{{ form_row(registration_form.firstName) }}
\t\t\t\t</div>
\t\t\t\t<div class=\"col-6\">
\t\t\t\t\t{{ form_row(registration_form.lastName) }}
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-6\">
\t\t\t\t\t{{ form_row(registration_form.password.first) }}
\t\t\t\t</div>
\t\t\t\t<div class=\"col-6\">
\t\t\t\t\t{{ form_row(registration_form.password.second) }}
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-8\">
\t\t\t\t\t{{ form_row(registration_form.address) }}
\t\t\t\t</div>
\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t{{ form_row(registration_form.city) }}
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-5\">
\t\t\t\t\t{{ form_row(registration_form.postalCode) }}
\t\t\t\t</div>
\t\t\t\t<div class=\"col-2\">
\t\t\t\t\t{{ form_row(registration_form.province) }}
\t\t\t\t</div>
\t\t\t\t<div class=\"col-5\">
\t\t\t\t\t{{ form_row(registration_form.phoneNumber) }}
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"d-flex justify-content-center m-3\">
\t\t\t\t{{ form_row(registration_form.create) }}
\t\t\t</div>
\t\t\t{{ form_end(registration_form) }}
\t\t</div>
\t</div>
{% endblock %}

{% block stylesheets %}{% endblock %}

{% block javascripts %}
\t<script defer src=\"https://cdn.jsdelivr.net/npm/jquery-mask-plugin@1.14.16/dist/jquery.mask.min.js\"></script>
\t<script defer src=\"{{ asset('scripts/registerValidation.js')}}\"></script>
{% endblock %}
", "registration/register.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\registration\\register.html.twig");
    }
}
