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

/* page/contact.html.twig */
class __TwigTemplate_072af495924b7f7a23f80d3365b6e33d extends Template
{
    private $source;
    private $macros = [];

    public function __construct(Environment $env)
    {
        parent::__construct($env);

        $this->source = $this->getSourceContext();

        $this->blocks = [
            'stylesheets' => [$this, 'block_stylesheets'],
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "page/contact.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "page/contact.html.twig"));

        $this->parent = $this->loadTemplate("core/base.html.twig", "page/contact.html.twig", 1);
        $this->parent->display($context, array_merge($this->blocks, $blocks));
        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

    }

    // line 4
    public function block_stylesheets($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "stylesheets"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "stylesheets"));

        // line 5
        echo "\t<link rel=\"stylesheet\" href=\"";
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("styles/contact.css"), "html", null, true);
        echo "\">
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    // line 9
    public function block_body($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "body"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "body"));

        // line 10
        echo "\t<div
\t\tclass=\"row\">
\t\t";
        // line 13
        echo "\t\t<div class=\"col-4 d-flex align-items-center\">
\t\t\t<iframe class=\"w-100 h-75 m-1\" src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2782.605157084539!2d-74.00255968416035!3d45.77910272039621!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4ccf2ca45e889b7f%3A0x23b59b4c40094d27!2zQ8OpZ2VwIGRlIFNhaW50LUrDqXLDtG1l!5e0!3m2!1sfr!2sca!4v1672853973967!5m2!1sfr!2sca\" aria-hidden=\"false\" tabindex=\"0\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>
\t\t</div>
\t\t";
        // line 17
        echo "\t\t";
        // line 18
        echo "\t\t<div
\t\t\tclass=\"col-8 bg-warning\">
\t\t\t";
        // line 21
        echo "\t\t\t<div class=\"bg-secondary text-white row py-2 d-flex justify-content-around text-center\">
\t\t\t\t<div class=\"col-3 contactInfo\">
\t\t\t\t\t<i class=\"fas fa-map-location-dot fs-1 mb-2\"></i>
\t\t\t\t\t<h4>Adresse civique :</h4>
\t\t\t\t\t<a href=\"https://goo.gl/maps/CfxcxWHoEjNuYXZ39\" class=\"text-black text-decoration-none\" target=\"_blank\">
\t\t\t\t\t<p>455 rue Fournier, Saint-Jérôme (Québec) J7Y 4V2</p>
\t\t\t\t\t</a>
\t\t\t\t</div>
\t\t\t\t<div class=\"col-3 contactInfo\">
\t\t\t\t\t<i class=\"fas fa-phone-volume fs-1 mb-2\"></i>
\t\t\t\t\t<h4>Numéro de téléphone :</h4>
\t\t\t\t\t<p>
\t\t\t\t\t\t<a href=\"tel:+14508726325\" class=\"text-black text-decoration-none\" target=\"_blank\">+1 (450) 872-MEAL</a>
\t\t\t\t\t\t<br>
\t\t\t\t\t\t<a href=\"tel:8192304560\" class=\"text-black text-decoration-none\">(819) 230-4560</a>
\t\t\t\t\t</p>
\t\t\t\t</div>
\t\t\t\t<div class=\"col-3 contactInfo\">
\t\t\t\t\t<i class=\"fas fa-envelope-open-text fs-1 mb-2\"></i>
\t\t\t\t\t<h4>Adresse courriel :</h4>
\t\t\t\t\t<a class=\"btn btn-floating border border-0\" role=\"button\" href=\"mailto:1875009@cstj.qc.ca\" target=\"_blank\">
\t\t\t\t\t\t1875009@cstj.qc.ca
\t\t\t\t\t</a>
\t\t\t\t</div>
\t\t\t\t<p class=\"text-white mt-5\">Pour toutes les images des produits qui sont disponibles dans le catalogue, elles proviennent de l'une de ces quatre sources :</p>
\t\t\t\t<div class=\"row d-flex justify-content-center align-items-center\">
\t\t\t\t\t<a href=\"https://revolution-nutrition.com/\" class=\"col-3\" target=\"_blank\">
\t\t\t\t\t\t<img src=\"";
        // line 48
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("images/companiesLogos/revolutionNutritionLogo.png"), "html", null, true);
        echo "\" title=\"Revolution Nutrition\" style=\"width: 200px; heigth: 200px\">
\t\t\t\t\t</a>
\t\t\t\t\t<a href=\"https://biosteel.ca/\" class=\"col-3\" target=\"_blank\">
\t\t\t\t\t\t<img src=\"";
        // line 51
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("images/companiesLogos/bioSteelLogo.png"), "html", null, true);
        echo "\" title=\"Bio Steel\" style=\"width: 200px; heigth: 200px\">
\t\t\t\t\t</a>
\t\t\t\t\t<a href=\"https://www.ghostlifestyle.com/\" class=\"col-3\" target=\"_blank\">
\t\t\t\t\t\t<img src=\"";
        // line 54
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("images/companiesLogos/ghostLogo.png"), "html", null, true);
        echo "\" title=\"Ghost\" style=\"width: 200px; heigth: 200px\">
\t\t\t\t\t</a>
\t\t\t\t\t<a href=\"https://ca.myprotein.com/\" class=\"col-3\" target=\"_blank\">
\t\t\t\t\t\t<img src=\"";
        // line 57
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("images/companiesLogos/myProteinLogo.png"), "html", null, true);
        echo "\" title=\"MyProtein™\" style=\"width: 200px; heigth: 200px\">
\t\t\t\t\t</a>
\t\t\t\t</div>
\t\t\t</div>
\t\t\t";
        // line 62
        echo "\t\t\t";
        // line 63
        echo "\t\t\t<div class=\"form-row\">
\t\t\t\t<div class=\"mb-3\">
\t\t\t\t\t<label class=\"form-label\">Sujet</label>
\t\t\t\t\t<input id=\"requestSubject\" type=\"text\" class=\"form-control\" placeholder=\"Sujet ...\" required>
\t\t\t\t</div>
\t\t\t\t";
        // line 68
        if (twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 68, $this->source); })()), "user", [], "any", false, false, false, 68)) {
            // line 69
            echo "\t\t\t\t\t<div class=\"mb-3\">
\t\t\t\t\t\t<label class=\"form-label\">Courriel</label>
\t\t\t\t\t\t<input id\"requestemail\" type=\"text\" class=\"form-control\" value=\"";
            // line 71
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 71, $this->source); })()), "user", [], "any", false, false, false, 71), "email", [], "any", false, false, false, 71), "html", null, true);
            echo "\" required>
\t\t\t\t\t</div>
\t\t\t\t";
        }
        // line 74
        echo "\t\t\t\t<div class=\"mb-3\">
\t\t\t\t\t<label class=\"form-label\">Message</label>
\t\t\t\t\t<textarea id=\"requestBody\" class=\"form-control\" rows=\"3\" placeholder=\"Message ...\" required></textarea>
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"text-center\">
\t\t\t\t<button class=\"btn btn-dark m-3 pt-2 w-50\" id=\"feedbackButton\">
\t\t\t\t\t<h4>
\t\t\t\t\t\tSoumettre la requête<i class=\"fas fa-paper-plane fs-2 m-3\"></i>
\t\t\t\t\t</h4>
\t\t\t\t</button>
\t\t\t</div>
\t\t\t";
        // line 87
        echo "\t\t</div>
\t\t";
        // line 89
        echo "\t</div>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    // line 92
    public function block_javascripts($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        // line 93
        echo "\t<script defer src=\"";
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("scripts/contactPage.js"), "html", null, true);
        echo "\"></script>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    public function getTemplateName()
    {
        return "page/contact.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  221 => 93,  211 => 92,  200 => 89,  197 => 87,  183 => 74,  177 => 71,  173 => 69,  171 => 68,  164 => 63,  162 => 62,  155 => 57,  149 => 54,  143 => 51,  137 => 48,  108 => 21,  104 => 18,  102 => 17,  97 => 13,  93 => 10,  83 => 9,  70 => 5,  60 => 4,  37 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("{% extends 'core/base.html.twig' %}

{# Includes a style sheet #}
{% block stylesheets %}
\t<link rel=\"stylesheet\" href=\"{{ asset('styles/contact.css') }}\">
{% endblock %}
{# Includes a style sheet #}

{% block body %}
\t<div
\t\tclass=\"row\">
\t\t{# Left section (Map) #}
\t\t<div class=\"col-4 d-flex align-items-center\">
\t\t\t<iframe class=\"w-100 h-75 m-1\" src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2782.605157084539!2d-74.00255968416035!3d45.77910272039621!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4ccf2ca45e889b7f%3A0x23b59b4c40094d27!2zQ8OpZ2VwIGRlIFNhaW50LUrDqXLDtG1l!5e0!3m2!1sfr!2sca!4v1672853973967!5m2!1sfr!2sca\" aria-hidden=\"false\" tabindex=\"0\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>
\t\t</div>
\t\t{# Left section (Map) #}
\t\t{# Right section #}
\t\t<div
\t\t\tclass=\"col-8 bg-warning\">
\t\t\t{# Information section #}
\t\t\t<div class=\"bg-secondary text-white row py-2 d-flex justify-content-around text-center\">
\t\t\t\t<div class=\"col-3 contactInfo\">
\t\t\t\t\t<i class=\"fas fa-map-location-dot fs-1 mb-2\"></i>
\t\t\t\t\t<h4>Adresse civique :</h4>
\t\t\t\t\t<a href=\"https://goo.gl/maps/CfxcxWHoEjNuYXZ39\" class=\"text-black text-decoration-none\" target=\"_blank\">
\t\t\t\t\t<p>455 rue Fournier, Saint-Jérôme (Québec) J7Y 4V2</p>
\t\t\t\t\t</a>
\t\t\t\t</div>
\t\t\t\t<div class=\"col-3 contactInfo\">
\t\t\t\t\t<i class=\"fas fa-phone-volume fs-1 mb-2\"></i>
\t\t\t\t\t<h4>Numéro de téléphone :</h4>
\t\t\t\t\t<p>
\t\t\t\t\t\t<a href=\"tel:+14508726325\" class=\"text-black text-decoration-none\" target=\"_blank\">+1 (450) 872-MEAL</a>
\t\t\t\t\t\t<br>
\t\t\t\t\t\t<a href=\"tel:8192304560\" class=\"text-black text-decoration-none\">(819) 230-4560</a>
\t\t\t\t\t</p>
\t\t\t\t</div>
\t\t\t\t<div class=\"col-3 contactInfo\">
\t\t\t\t\t<i class=\"fas fa-envelope-open-text fs-1 mb-2\"></i>
\t\t\t\t\t<h4>Adresse courriel :</h4>
\t\t\t\t\t<a class=\"btn btn-floating border border-0\" role=\"button\" href=\"mailto:1875009@cstj.qc.ca\" target=\"_blank\">
\t\t\t\t\t\t1875009@cstj.qc.ca
\t\t\t\t\t</a>
\t\t\t\t</div>
\t\t\t\t<p class=\"text-white mt-5\">Pour toutes les images des produits qui sont disponibles dans le catalogue, elles proviennent de l'une de ces quatre sources :</p>
\t\t\t\t<div class=\"row d-flex justify-content-center align-items-center\">
\t\t\t\t\t<a href=\"https://revolution-nutrition.com/\" class=\"col-3\" target=\"_blank\">
\t\t\t\t\t\t<img src=\"{{ asset('images/companiesLogos/revolutionNutritionLogo.png') }}\" title=\"Revolution Nutrition\" style=\"width: 200px; heigth: 200px\">
\t\t\t\t\t</a>
\t\t\t\t\t<a href=\"https://biosteel.ca/\" class=\"col-3\" target=\"_blank\">
\t\t\t\t\t\t<img src=\"{{ asset('images/companiesLogos/bioSteelLogo.png') }}\" title=\"Bio Steel\" style=\"width: 200px; heigth: 200px\">
\t\t\t\t\t</a>
\t\t\t\t\t<a href=\"https://www.ghostlifestyle.com/\" class=\"col-3\" target=\"_blank\">
\t\t\t\t\t\t<img src=\"{{ asset('images/companiesLogos/ghostLogo.png') }}\" title=\"Ghost\" style=\"width: 200px; heigth: 200px\">
\t\t\t\t\t</a>
\t\t\t\t\t<a href=\"https://ca.myprotein.com/\" class=\"col-3\" target=\"_blank\">
\t\t\t\t\t\t<img src=\"{{ asset('images/companiesLogos/myProteinLogo.png') }}\" title=\"MyProtein™\" style=\"width: 200px; heigth: 200px\">
\t\t\t\t\t</a>
\t\t\t\t</div>
\t\t\t</div>
\t\t\t{# Information section #}
\t\t\t{# Feedback section #}
\t\t\t<div class=\"form-row\">
\t\t\t\t<div class=\"mb-3\">
\t\t\t\t\t<label class=\"form-label\">Sujet</label>
\t\t\t\t\t<input id=\"requestSubject\" type=\"text\" class=\"form-control\" placeholder=\"Sujet ...\" required>
\t\t\t\t</div>
\t\t\t\t{% if app.user %}
\t\t\t\t\t<div class=\"mb-3\">
\t\t\t\t\t\t<label class=\"form-label\">Courriel</label>
\t\t\t\t\t\t<input id\"requestemail\" type=\"text\" class=\"form-control\" value=\"{{ app.user.email }}\" required>
\t\t\t\t\t</div>
\t\t\t\t{% endif %}
\t\t\t\t<div class=\"mb-3\">
\t\t\t\t\t<label class=\"form-label\">Message</label>
\t\t\t\t\t<textarea id=\"requestBody\" class=\"form-control\" rows=\"3\" placeholder=\"Message ...\" required></textarea>
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<div class=\"text-center\">
\t\t\t\t<button class=\"btn btn-dark m-3 pt-2 w-50\" id=\"feedbackButton\">
\t\t\t\t\t<h4>
\t\t\t\t\t\tSoumettre la requête<i class=\"fas fa-paper-plane fs-2 m-3\"></i>
\t\t\t\t\t</h4>
\t\t\t\t</button>
\t\t\t</div>
\t\t\t{# Feedback section #}
\t\t</div>
\t\t{# Right section #}
\t</div>
{% endblock %}

{% block javascripts %}
\t<script defer src=\"{{ asset('scripts/contactPage.js') }}\"></script>
{% endblock %}
", "page/contact.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\page\\contact.html.twig");
    }
}
