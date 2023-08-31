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

/* profile/profile.html.twig */
class __TwigTemplate_3685c7daa144e552b9eebafc3e80745c extends Template
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "profile/profile.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "profile/profile.html.twig"));

        // line 2
        $this->env->getRuntime("Symfony\\Component\\Form\\FormRenderer")->setTheme((isset($context["profile_form"]) || array_key_exists("profile_form", $context) ? $context["profile_form"] : (function () { throw new RuntimeError('Variable "profile_form" does not exist.', 2, $this->source); })()), [0 => "bootstrap_5_layout.html.twig"], true);
        // line 3
        $this->env->getRuntime("Symfony\\Component\\Form\\FormRenderer")->setTheme((isset($context["password_form"]) || array_key_exists("password_form", $context) ? $context["password_form"] : (function () { throw new RuntimeError('Variable "password_form" does not exist.', 3, $this->source); })()), [0 => "bootstrap_5_layout.html.twig"], true);
        // line 1
        $this->parent = $this->loadTemplate("core/base.html.twig", "profile/profile.html.twig", 1);
        $this->parent->display($context, array_merge($this->blocks, $blocks));
        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

    }

    // line 5
    public function block_body($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "body"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "body"));

        // line 6
        echo "\t<div class=\"row bg-warning pb-5\">
\t\t<div class=\"col-lg-8 mx-auto\">
\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-circle-user me-2\"></i>
\t\t\t\tVotre compte
\t\t\t</p>
\t\t\t<hr class=\"mt-4\">
\t\t\t";
        // line 13
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 13, $this->source); })()), "flashes", [0 => "payment_message"], "method", false, false, false, 13));
        foreach ($context['_seq'] as $context["_key"] => $context["flash"]) {
            // line 14
            echo "\t\t\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center text-dark rounded bg-";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "color", [], "any", false, false, false, 14), "html", null, true);
            echo "\">";
            echo twig_get_attribute($this->env, $this->source, $context["flash"], "content", [], "any", false, false, false, 14);
            echo "</div>
\t\t\t";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['flash'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 16
        echo "\t\t\t";
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 16, $this->source); })()), "flashes", [0 => "profile_modification"], "method", false, false, false, 16));
        foreach ($context['_seq'] as $context["_key"] => $context["flash"]) {
            // line 17
            echo "\t\t\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center bg-dark rounded ";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "color", [], "any", false, false, false, 17), "html", null, true);
            echo "\">";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "content", [], "any", false, false, false, 17), "html", null, true);
            echo "</div>
\t\t\t\t<hr>
\t\t\t";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['flash'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 20
        echo "\t\t\t";
        echo         $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderBlock((isset($context["profile_form"]) || array_key_exists("profile_form", $context) ? $context["profile_form"] : (function () { throw new RuntimeError('Variable "profile_form" does not exist.', 20, $this->source); })()), 'form_start', ["attr" => ["class" => "needs-validation-register", "novalidate" => "novalidate"]]);
        echo "
\t\t\t<div class=\"form-outline mb-4\">
\t\t\t\t<label class=\"form-label\" for=\"activeEmail\">Adresse courriel</label>
\t\t\t\t<input type=\"email\" class=\"form-control\" id=\"activeEmail\" value=\"";
        // line 23
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 23, $this->source); })()), "user", [], "any", false, false, false, 23), "email", [], "any", false, false, false, 23), "html", null, true);
        echo "\" disabled readonly>
\t\t\t</div>
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-6\">
\t\t\t\t\t";
        // line 27
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["profile_form"]) || array_key_exists("profile_form", $context) ? $context["profile_form"] : (function () { throw new RuntimeError('Variable "profile_form" does not exist.', 27, $this->source); })()), "firstName", [], "any", false, false, false, 27), 'row');
        echo "
\t\t\t\t</div>
\t\t\t\t<div class=\"col-6\">
\t\t\t\t\t";
        // line 30
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["profile_form"]) || array_key_exists("profile_form", $context) ? $context["profile_form"] : (function () { throw new RuntimeError('Variable "profile_form" does not exist.', 30, $this->source); })()), "lastName", [], "any", false, false, false, 30), 'row');
        echo "
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-8\">
\t\t\t\t\t";
        // line 35
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["profile_form"]) || array_key_exists("profile_form", $context) ? $context["profile_form"] : (function () { throw new RuntimeError('Variable "profile_form" does not exist.', 35, $this->source); })()), "address", [], "any", false, false, false, 35), 'row');
        echo "
\t\t\t\t</div>
\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t";
        // line 38
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["profile_form"]) || array_key_exists("profile_form", $context) ? $context["profile_form"] : (function () { throw new RuntimeError('Variable "profile_form" does not exist.', 38, $this->source); })()), "city", [], "any", false, false, false, 38), 'row');
        echo "
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-5\">
\t\t\t\t\t";
        // line 43
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["profile_form"]) || array_key_exists("profile_form", $context) ? $context["profile_form"] : (function () { throw new RuntimeError('Variable "profile_form" does not exist.', 43, $this->source); })()), "postalCode", [], "any", false, false, false, 43), 'row');
        echo "
\t\t\t\t</div>
\t\t\t\t<div class=\"col-2\">
\t\t\t\t\t";
        // line 46
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["profile_form"]) || array_key_exists("profile_form", $context) ? $context["profile_form"] : (function () { throw new RuntimeError('Variable "profile_form" does not exist.', 46, $this->source); })()), "province", [], "any", false, false, false, 46), 'row');
        echo "
\t\t\t\t</div>
\t\t\t\t<div class=\"col-5\">
\t\t\t\t\t";
        // line 49
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["profile_form"]) || array_key_exists("profile_form", $context) ? $context["profile_form"] : (function () { throw new RuntimeError('Variable "profile_form" does not exist.', 49, $this->source); })()), "phoneNumber", [], "any", false, false, false, 49), 'row');
        echo "
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"d-flex justify-content-center m-3\">
\t\t\t\t";
        // line 53
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["profile_form"]) || array_key_exists("profile_form", $context) ? $context["profile_form"] : (function () { throw new RuntimeError('Variable "profile_form" does not exist.', 53, $this->source); })()), "save", [], "any", false, false, false, 53), 'row');
        echo "
\t\t\t</div>
\t\t\t";
        // line 55
        echo         $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderBlock((isset($context["profile_form"]) || array_key_exists("profile_form", $context) ? $context["profile_form"] : (function () { throw new RuntimeError('Variable "profile_form" does not exist.', 55, $this->source); })()), 'form_end');
        echo "
\t\t</div>
\t\t<div class=\"col-lg-8 mx-auto\">
\t\t\t<p class=\"h1 text-center mt-5 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-key me-2\"></i>
\t\t\t\tVotre mot de passe
\t\t\t</p>
\t\t\t<hr class=\"mt-4\">
\t\t\t";
        // line 63
        echo         $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderBlock((isset($context["password_form"]) || array_key_exists("password_form", $context) ? $context["password_form"] : (function () { throw new RuntimeError('Variable "password_form" does not exist.', 63, $this->source); })()), 'form_start', ["attr" => ["class" => "needs-validation-register", "novalidate" => "novalidate"]]);
        echo "
\t\t\t";
        // line 64
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["password_form"]) || array_key_exists("password_form", $context) ? $context["password_form"] : (function () { throw new RuntimeError('Variable "password_form" does not exist.', 64, $this->source); })()), "activePassword", [], "any", false, false, false, 64), 'row');
        echo "
\t\t\t";
        // line 65
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["password_form"]) || array_key_exists("password_form", $context) ? $context["password_form"] : (function () { throw new RuntimeError('Variable "password_form" does not exist.', 65, $this->source); })()), "newPassword", [], "any", false, false, false, 65), "first", [], "any", false, false, false, 65), 'row');
        echo "
\t\t\t";
        // line 66
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["password_form"]) || array_key_exists("password_form", $context) ? $context["password_form"] : (function () { throw new RuntimeError('Variable "password_form" does not exist.', 66, $this->source); })()), "newPassword", [], "any", false, false, false, 66), "second", [], "any", false, false, false, 66), 'row');
        echo "
\t\t\t<div class=\"d-flex justify-content-center m-3\">
\t\t\t\t";
        // line 68
        echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["password_form"]) || array_key_exists("password_form", $context) ? $context["password_form"] : (function () { throw new RuntimeError('Variable "password_form" does not exist.', 68, $this->source); })()), "save", [], "any", false, false, false, 68), 'row');
        echo "
\t\t\t</div>
\t\t\t";
        // line 70
        echo         $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderBlock((isset($context["password_form"]) || array_key_exists("password_form", $context) ? $context["password_form"] : (function () { throw new RuntimeError('Variable "password_form" does not exist.', 70, $this->source); })()), 'form_end');
        echo "
\t\t</div>
\t</div>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    // line 75
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

    // line 77
    public function block_javascripts($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        // line 78
        echo "\t<script defer src=\"https://cdn.jsdelivr.net/npm/jquery-mask-plugin@1.14.16/dist/jquery.mask.min.js\"></script>
\t<script defer src=\"";
        // line 79
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("scripts/registerValidation.js"), "html", null, true);
        echo "\"></script>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    public function getTemplateName()
    {
        return "profile/profile.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  260 => 79,  257 => 78,  247 => 77,  229 => 75,  215 => 70,  210 => 68,  205 => 66,  201 => 65,  197 => 64,  193 => 63,  182 => 55,  177 => 53,  170 => 49,  164 => 46,  158 => 43,  150 => 38,  144 => 35,  136 => 30,  130 => 27,  123 => 23,  116 => 20,  104 => 17,  99 => 16,  88 => 14,  84 => 13,  75 => 6,  65 => 5,  54 => 1,  52 => 3,  50 => 2,  37 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("{% extends 'core/base.html.twig' %}
{% form_theme profile_form 'bootstrap_5_layout.html.twig' %}
{% form_theme password_form 'bootstrap_5_layout.html.twig' %}

{% block body %}
\t<div class=\"row bg-warning pb-5\">
\t\t<div class=\"col-lg-8 mx-auto\">
\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-circle-user me-2\"></i>
\t\t\t\tVotre compte
\t\t\t</p>
\t\t\t<hr class=\"mt-4\">
\t\t\t{% for flash in app.flashes('payment_message') %}
\t\t\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center text-dark rounded bg-{{ flash.color }}\">{{ flash.content|raw }}</div>
\t\t\t{% endfor %}
\t\t\t{% for flash in app.flashes('profile_modification') %}
\t\t\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center bg-dark rounded {{ flash.color }}\">{{ flash.content }}</div>
\t\t\t\t<hr>
\t\t\t{% endfor %}
\t\t\t{{ form_start(profile_form, {'attr': {'class': 'needs-validation-register', 'novalidate': 'novalidate' }}) }}
\t\t\t<div class=\"form-outline mb-4\">
\t\t\t\t<label class=\"form-label\" for=\"activeEmail\">Adresse courriel</label>
\t\t\t\t<input type=\"email\" class=\"form-control\" id=\"activeEmail\" value=\"{{ app.user.email }}\" disabled readonly>
\t\t\t</div>
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-6\">
\t\t\t\t\t{{ form_row(profile_form.firstName) }}
\t\t\t\t</div>
\t\t\t\t<div class=\"col-6\">
\t\t\t\t\t{{ form_row(profile_form.lastName) }}
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-8\">
\t\t\t\t\t{{ form_row(profile_form.address) }}
\t\t\t\t</div>
\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t{{ form_row(profile_form.city) }}
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-5\">
\t\t\t\t\t{{ form_row(profile_form.postalCode) }}
\t\t\t\t</div>
\t\t\t\t<div class=\"col-2\">
\t\t\t\t\t{{ form_row(profile_form.province) }}
\t\t\t\t</div>
\t\t\t\t<div class=\"col-5\">
\t\t\t\t\t{{ form_row(profile_form.phoneNumber) }}
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"d-flex justify-content-center m-3\">
\t\t\t\t{{ form_row(profile_form.save) }}
\t\t\t</div>
\t\t\t{{ form_end(profile_form) }}
\t\t</div>
\t\t<div class=\"col-lg-8 mx-auto\">
\t\t\t<p class=\"h1 text-center mt-5 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-key me-2\"></i>
\t\t\t\tVotre mot de passe
\t\t\t</p>
\t\t\t<hr class=\"mt-4\">
\t\t\t{{ form_start(password_form, {'attr': {'class': 'needs-validation-register', 'novalidate': 'novalidate' }}) }}
\t\t\t{{ form_row(password_form.activePassword) }}
\t\t\t{{ form_row(password_form.newPassword.first) }}
\t\t\t{{ form_row(password_form.newPassword.second) }}
\t\t\t<div class=\"d-flex justify-content-center m-3\">
\t\t\t\t{{ form_row(password_form.save) }}
\t\t\t</div>
\t\t\t{{ form_end(password_form) }}
\t\t</div>
\t</div>
{% endblock %}

{% block stylesheets %}{% endblock %}

{% block javascripts %}
\t<script defer src=\"https://cdn.jsdelivr.net/npm/jquery-mask-plugin@1.14.16/dist/jquery.mask.min.js\"></script>
\t<script defer src=\"{{ asset('scripts/registerValidation.js')}}\"></script>
{% endblock %}
", "profile/profile.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\profile\\profile.html.twig");
    }
}
