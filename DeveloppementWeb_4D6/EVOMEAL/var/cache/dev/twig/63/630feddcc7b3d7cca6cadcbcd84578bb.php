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

/* profile/login.html.twig */
class __TwigTemplate_cfb2ab376fd5ae7abb7b5147896d3e65 extends Template
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "profile/login.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "profile/login.html.twig"));

        $this->parent = $this->loadTemplate("core/base.html.twig", "profile/login.html.twig", 1);
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
        echo "\t<div class=\"row bg-warning pb-5\">
\t\t<div class=\"col-8 mx-auto\">
\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-right-to-bracket me-2\"></i>
\t\t\t\tConnexion
\t\t\t</p>
\t\t\t<hr class=\"mt-4\">
\t\t\t";
        // line 11
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 11, $this->source); })()), "flashes", [0 => "login_message"], "method", false, false, false, 11));
        foreach ($context['_seq'] as $context["_key"] => $context["flash"]) {
            // line 12
            echo "\t\t\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center bg-dark rounded ";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "color", [], "any", false, false, false, 12), "html", null, true);
            echo "\">";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "content", [], "any", false, false, false, 12), "html", null, true);
            echo "</div>
\t\t\t\t<hr>
\t\t\t";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['flash'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 15
        echo "\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-5 me-5\">
\t\t\t\t\t<img src=\"";
        // line 17
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("images/companiesLogos/myLogo.png"), "html", null, true);
        echo "\" id=\"logoIcon\" title=\"Logo d'EVOMEAL\" alt=\"EVOMEAL\">
\t\t\t\t</div>
\t\t\t\t<div class=\"col-5 text-center my-auto ms-5\">
\t\t\t\t\t<form action=\"";
        // line 20
        echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("login");
        echo "\" method=\"post\">
\t\t\t\t\t\t<div class=\"input-group mb-3\">
\t\t\t\t\t\t\t<span class=\"input-group-text\">
\t\t\t\t\t\t\t\t<i class=\"fas fa-at\"></i>
\t\t\t\t\t\t\t</span>
\t\t\t\t\t\t\t<input name=\"_username\" id=\"username\" class=\"form-control\" type=\"email\" value=\"";
        // line 25
        echo twig_escape_filter($this->env, (isset($context["last_email"]) || array_key_exists("last_email", $context) ? $context["last_email"] : (function () { throw new RuntimeError('Variable "last_email" does not exist.', 25, $this->source); })()), "html", null, true);
        echo "\" placeholder=\"Veuillez insérer votre adresse courriel.\" required>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"input-group mb-3\">
\t\t\t\t\t\t\t<span class=\"input-group-text\">
\t\t\t\t\t\t\t\t<i class=\"fas fa-lock\"></i>
\t\t\t\t\t\t\t</span>
\t\t\t\t\t\t\t<input name=\"_password\" id=\"password\" class=\"form-control\" type=\"password\" placeholder=\"Veuillez insérer votre mot de passe.\" required>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<input type=\"hidden\" name=\"_target_path\" value=\"";
        // line 33
        echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("catalog.route");
        echo "\">
\t\t\t\t\t\t<input type=\"hidden\" name=\"_csrf_token\" value=\"";
        // line 34
        echo twig_escape_filter($this->env, $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderCsrfToken("authenticate"), "html", null, true);
        echo "\">
\t\t\t\t\t\t<button type=\"submit\" class=\"btn btn-dark fs-4 mt-3 ps-3 pe-3\">Se connecter<i class=\"fas fa-lock-open ms-3\"></i>
\t\t\t\t\t\t</button>
\t\t\t\t\t</form>
\t\t\t\t\t<p>Pas encore de compte?<a href=\"";
        // line 38
        echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("register");
        echo "\" class=\"text-decoration-none text-dark fw-bold fs-5 ms-2\">S'inscrire</a>
\t\t\t\t\t</p>
\t\t\t\t</div>
\t\t\t</div>
\t\t</div>
\t</div>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    public function getTemplateName()
    {
        return "profile/login.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  133 => 38,  126 => 34,  122 => 33,  111 => 25,  103 => 20,  97 => 17,  93 => 15,  81 => 12,  77 => 11,  68 => 4,  58 => 3,  35 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("{% extends 'core/base.html.twig' %}

{% block body %}
\t<div class=\"row bg-warning pb-5\">
\t\t<div class=\"col-8 mx-auto\">
\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-right-to-bracket me-2\"></i>
\t\t\t\tConnexion
\t\t\t</p>
\t\t\t<hr class=\"mt-4\">
\t\t\t{% for flash in app.flashes('login_message') %}
\t\t\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center bg-dark rounded {{ flash.color }}\">{{ flash.content }}</div>
\t\t\t\t<hr>
\t\t\t{% endfor %}
\t\t\t<div class=\"row\">
\t\t\t\t<div class=\"col-5 me-5\">
\t\t\t\t\t<img src=\"{{ asset('images/companiesLogos/myLogo.png') }}\" id=\"logoIcon\" title=\"Logo d'EVOMEAL\" alt=\"EVOMEAL\">
\t\t\t\t</div>
\t\t\t\t<div class=\"col-5 text-center my-auto ms-5\">
\t\t\t\t\t<form action=\"{{ path('login') }}\" method=\"post\">
\t\t\t\t\t\t<div class=\"input-group mb-3\">
\t\t\t\t\t\t\t<span class=\"input-group-text\">
\t\t\t\t\t\t\t\t<i class=\"fas fa-at\"></i>
\t\t\t\t\t\t\t</span>
\t\t\t\t\t\t\t<input name=\"_username\" id=\"username\" class=\"form-control\" type=\"email\" value=\"{{ last_email }}\" placeholder=\"Veuillez insérer votre adresse courriel.\" required>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"input-group mb-3\">
\t\t\t\t\t\t\t<span class=\"input-group-text\">
\t\t\t\t\t\t\t\t<i class=\"fas fa-lock\"></i>
\t\t\t\t\t\t\t</span>
\t\t\t\t\t\t\t<input name=\"_password\" id=\"password\" class=\"form-control\" type=\"password\" placeholder=\"Veuillez insérer votre mot de passe.\" required>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<input type=\"hidden\" name=\"_target_path\" value=\"{{ path('catalog.route') }}\">
\t\t\t\t\t\t<input type=\"hidden\" name=\"_csrf_token\" value=\"{{ csrf_token('authenticate') }}\">
\t\t\t\t\t\t<button type=\"submit\" class=\"btn btn-dark fs-4 mt-3 ps-3 pe-3\">Se connecter<i class=\"fas fa-lock-open ms-3\"></i>
\t\t\t\t\t\t</button>
\t\t\t\t\t</form>
\t\t\t\t\t<p>Pas encore de compte?<a href=\"{{ path('register') }}\" class=\"text-decoration-none text-dark fw-bold fs-5 ms-2\">S'inscrire</a>
\t\t\t\t\t</p>
\t\t\t\t</div>
\t\t\t</div>
\t\t</div>
\t</div>
{% endblock %}
", "profile/login.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\profile\\login.html.twig");
    }
}
