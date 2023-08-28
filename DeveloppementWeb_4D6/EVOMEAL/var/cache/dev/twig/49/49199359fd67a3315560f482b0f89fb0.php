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

/* core/navbar.html.twig */
class __TwigTemplate_b0c1c4ec900d31fc350bf5a863817202 extends Template
{
    private $source;
    private $macros = [];

    public function __construct(Environment $env)
    {
        parent::__construct($env);

        $this->source = $this->getSourceContext();

        $this->parent = false;

        $this->blocks = [
        ];
    }

    protected function doDisplay(array $context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "core/navbar.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "core/navbar.html.twig"));

        // line 3
        echo "
\t<nav
\tclass=\"bg-black navbar navbar-dark row sticky-top\"> ";
        // line 6
        echo "\t<div class=\"col-10 row\">
\t\t<a class=\"col-5 navbar-brand nav-link\" href=\"";
        // line 7
        echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("catalog.route");
        echo "\">
\t\t\t<img src=\"";
        // line 8
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("images/companiesLogos/logo.png"), "html", null, true);
        echo "\" id=\"logoIcon\" title=\"Logo d'EVOMEAL\" alt=\"EVOMEAL\">
\t\t</a>
\t\t";
        // line 10
        if (twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 10, $this->source); })()), "user", [], "any", false, false, false, 10)) {
            // line 11
            echo "\t\t\t<div class=\"col-lg-3 fs-3 fw-bold fst-italic m-3 p-3 text-center bg-dark rounded mx-auto my-auto text-success\">";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 11, $this->source); })()), "user", [], "any", false, false, false, 11), "firstName", [], "any", false, false, false, 11), "html", null, true);
            echo "
\t\t\t\test connecté.</div>
\t\t";
        }
        // line 14
        echo "\t</div>
\t<div
\t\tclass=\"col-2\">
\t\t";
        // line 18
        echo "\t\t<button class=\"bg-transparent border-0 text-white fs-5\" type=\"button\" data-bs-toggle=\"modal\" data-bs-target=\"#connectionModal\">
\t\t\t<i class=\"far fa-user\"></i>
\t\t</button>
\t\t";
        // line 22
        echo "\t\t";
        // line 23
        echo "\t\t<button class=\"bg-transparent border-0\">
\t\t\t<a class=\"text-decoration-none text-white fs-5\" href=\"";
        // line 24
        echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("cart.index");
        echo "\">
\t\t\t\t<i class=\"fa-solid fa-cart-shopping\"></i>
\t\t\t</a>
\t\t\t";
        // line 27
        if (twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 27, $this->source); })()), "user", [], "any", false, false, false, 27)) {
            // line 28
            echo "\t\t\t\t<span class=\"translate-middle badge rounded-pill bg-secondary\">
\t\t\t\t\t";
            // line 29
            echo twig_escape_filter($this->env, (isset($context["cartlength"]) || array_key_exists("cartlength", $context) ? $context["cartlength"] : (function () { throw new RuntimeError('Variable "cartlength" does not exist.', 29, $this->source); })()), "html", null, true);
            echo "
\t\t\t\t</span>
\t\t\t";
        }
        // line 32
        echo "\t\t</button>
\t\t";
        // line 34
        echo "\t\t<button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"offcanvas\" data-bs-target=\"#offcanvasDarkNavbar\" aria-controls=\"offcanvasDarkNavbar\">
\t\t\t<span class=\"navbar-toggler-icon\"></span>
\t\t</button>
\t</div>
\t";
        // line 39
        echo "\t";
        // line 40
        echo "\t<div class=\"offcanvas offcanvas-end text-bg-dark\" tabindex=\"-1\" id=\"offcanvasDarkNavbar\" aria-labelledby=\"offcanvasDarkNavbarLabel\">
\t\t<div class=\"offcanvas-header\">
\t\t\t<button type=\"button\" class=\"btn-close btn-close-white\" data-bs-dismiss=\"offcanvas\" aria-label=\"Close\"></button>
\t\t</div>
\t\t<div class=\"offcanvas-body\">
\t\t\t<ul class=\"navbar-nav justify-content-end flex-grow-1 pe-3\">
\t\t\t\t";
        // line 46
        if (twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 46, $this->source); })()), "user", [], "any", false, false, false, 46)) {
            // line 47
            echo "\t\t\t\t\t";
            // line 48
            echo "\t\t\t\t\t<li>
\t\t\t\t\t\t<div class=\"bg-warning rounded-pill p-2\">
\t\t\t\t\t\t\t<div class=\"row\">
\t\t\t\t\t\t\t\t<a href=\"";
            // line 51
            echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("profile");
            echo "\" class=\"col-2 text-decoration-none\">
\t\t\t\t\t\t\t\t\t<img src=\"https://ui-avatars.com/api/?size=85&name=";
            // line 52
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 52, $this->source); })()), "user", [], "any", false, false, false, 52), "firstName", [], "any", false, false, false, 52), "html", null, true);
            echo "+";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 52, $this->source); })()), "user", [], "any", false, false, false, 52), "lastName", [], "any", false, false, false, 52), "html", null, true);
            echo "&rounded=true&background=000000&color=ffffff\">
\t\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t\t<div class=\"col-8 mx-auto\">
\t\t\t\t\t\t\t\t\t<div class=\"fs-4 text-dark text-center\">
\t\t\t\t\t\t\t\t\t\t<span>
\t\t\t\t\t\t\t\t\t\t\tBonjour
\t\t\t\t\t\t\t\t\t\t\t<a href=\"";
            // line 58
            echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("profile");
            echo "\" class=\"text-decoration-none text-secondary fw-bold\">";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 58, $this->source); })()), "user", [], "any", false, false, false, 58), "firstName", [], "any", false, false, false, 58), "html", null, true);
            echo "</a>
\t\t\t\t\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t\t\t\t\t<a href=\"";
            // line 60
            echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("logout");
            echo "\" class=\"link-secondary ms-2\">Se déconnecter</a>
\t\t\t\t\t\t\t\t\t\t</span>
\t\t\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t</div>
\t\t\t\t\t</li>
\t\t\t\t\t";
            // line 68
            echo "\t\t\t\t\t";
            if ($this->extensions['Symfony\Bridge\Twig\Extension\SecurityExtension']->isGranted("ROLE_ADMIN")) {
                // line 69
                echo "\t\t\t\t\t\t<li class=\"nav-item text-center\">
\t\t\t\t\t\t\t<a class=\"nav-link\" href=\"";
                // line 70
                echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("admin");
                echo "\">
\t\t\t\t\t\t\t\t<i class=\"fas fa-screwdriver-wrench me-2\"></i>Version administrateur<i class=\"fas fa-screwdriver-wrench ms-2\"></i>
\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t</li>
\t\t\t\t\t";
            }
            // line 75
            echo "\t\t\t\t";
        }
        // line 76
        echo "\t\t\t\t<li
\t\t\t\t\tclass=\"pt-5 pb-1\">
\t\t\t\t\t";
        // line 79
        echo "\t\t\t\t\t<form class=\"d-flex\" method=\"POST\" action=\"";
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 79, $this->source); })()), "request", [], "any", false, false, false, 79), "uri", [], "any", false, false, false, 79), "html", null, true);
        echo "\">
\t\t\t\t\t\t<input name=\"search_field\" class=\"form-control me-2\" type=\"search\" placeholder=\"Recherche\" aria-label=\"Search\">
\t\t\t\t\t\t<button class=\"btn btn-outline-secondary text-white border-light\" type=\"submit\">
\t\t\t\t\t\t\t<i class=\"fas fa-magnifying-glass\"></i>
\t\t\t\t\t\t</button>
\t\t\t\t\t</form>
\t\t\t\t\t";
        // line 86
        echo "\t\t\t\t</li>
\t\t\t\t<li>
\t\t\t\t\t<a href=\"";
        // line 88
        echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("contact.route");
        echo "\" class=\"text-decoration-none text-white fs-3 ms-2\">Nous contacter
\t\t\t\t\t</a>
\t\t\t\t</li>
\t\t\t\t<li>
\t\t\t\t\t<button class=\"btn btn-transparent text-white fs-3 border border-0\" data-bs-toggle=\"collapse\" href=\"#categories\">
\t\t\t\t\t\tMagasinez
\t\t\t\t\t\t<i class=\"fas fa-caret-down text-secondary fs-6 ms-2\"></i>
\t\t\t\t\t</button>
\t\t\t\t\t<div class=\"collapse\" id=\"categories\">
\t\t\t\t\t\t<h5 class=\"fs-4 mt-1 ms-4\">Catégories</h5>
\t\t\t\t\t\t<hr>
\t\t\t\t\t\t<a href=\"";
        // line 99
        echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("catalog.route");
        echo "\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white fs-5 ms-5\">
\t\t\t\t\t\t\tToutes les catégories</a>
\t\t\t\t\t\t<hr>
\t\t\t\t\t\t<div class=\"ms-5\">
\t\t\t\t\t\t\t";
        // line 103
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable((isset($context["categories"]) || array_key_exists("categories", $context) ? $context["categories"] : (function () { throw new RuntimeError('Variable "categories" does not exist.', 103, $this->source); })()));
        foreach ($context['_seq'] as $context["_key"] => $context["categoryName"]) {
            // line 104
            echo "\t\t\t\t\t\t\t\t<ul>
\t\t\t\t\t\t\t\t\t<a href=\"";
            // line 105
            echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("catalog.route", ["categoryName" => twig_get_attribute($this->env, $this->source, $context["categoryName"], "idCategory", [], "any", false, false, false, 105)]), "html", null, true);
            echo "\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white fs-6\">
\t\t\t\t\t\t\t\t\t\t";
            // line 106
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["categoryName"], "categoryName", [], "any", false, false, false, 106), "html", null, true);
            echo "
\t\t\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t\t</ul>
\t\t\t\t\t\t\t";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['categoryName'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 110
        echo "\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t</li>
\t\t\t\t<li>
\t\t\t\t\t";
        // line 114
        if (twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 114, $this->source); })()), "user", [], "any", false, false, false, 114)) {
            // line 115
            echo "\t\t\t\t\t\t<button class=\"btn btn-transparent text-white fs-3 border border-0\" data-bs-toggle=\"collapse\" href=\"#account\">
\t\t\t\t\t\t\tVotre dossier
\t\t\t\t\t\t\t<i class=\"fas fa-caret-down text-secondary fs-6 ms-2\"></i>
\t\t\t\t\t\t</button>
\t\t\t\t\t\t<div class=\"collapse\" id=\"account\">
\t\t\t\t\t\t\t<a href=\"";
            // line 120
            echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("profile");
            echo "\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white ms-2\">Mon compte</a>
\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t<a href=\"";
            // line 122
            echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("profile.orders");
            echo "\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white ms-2\">Mes commandes</a>
\t\t\t\t\t\t</div>
\t\t\t\t\t";
        }
        // line 125
        echo "\t\t\t\t</li>
\t\t\t\t";
        // line 126
        if ($this->extensions['Symfony\Bridge\Twig\Extension\SecurityExtension']->isGranted("ROLE_ADMIN")) {
            // line 127
            echo "\t\t\t\t\t<li>
\t\t\t\t\t\t<button class=\"btn btn-transparent text-white fs-3 border border-0\" data-bs-toggle=\"collapse\" href=\"#administrator\">
\t\t\t\t\t\t\tAdministrateur
\t\t\t\t\t\t\t<i class=\"fas fa-caret-down text-secondary fs-6 ms-2\"></i>
\t\t\t\t\t\t</button>
\t\t\t\t\t\t<div class=\"collapse\" id=\"administrator\">
\t\t\t\t\t\t\t<h6 class=\"text-secondary ms-4\">Categories</h6>
\t\t\t\t\t\t\t<a href=\"";
            // line 134
            echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("admin.categories");
            echo "\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white ms-5\">
\t\t\t\t\t\t\t\tLister, ajouter et modifier
\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t<h6 class=\"text-secondary ms-4 mt-1\">Produits</h6>
\t\t\t\t\t\t\t<a href=\"";
            // line 139
            echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("admin.products");
            echo "\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white ms-5\">
\t\t\t\t\t\t\t\tLister, ajouter et modifier
\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t<h6 class=\"text-secondary ms-4 mt-1\">Commandes</h6>
\t\t\t\t\t\t\t<a href=\"";
            // line 144
            echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("admin.orders");
            echo "\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white ms-5\">
\t\t\t\t\t\t\t\tLister, ajouter et modifier
\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t</div>
\t\t\t\t\t</li>
\t\t\t\t";
        }
        // line 150
        echo "\t\t\t</ul>
\t\t</div>
\t</div>
\t";
        // line 154
        echo "</nav>

";
        // line 157
        echo "<div class=\"modal fade\" id=\"connectionModal\" tabindex=\"-1\">
\t<div class=\"modal-dialog\">
\t\t<div class=\"modal-content bg-warning text-center\">
\t\t\t<h3 class=\"mt-3\">Se connecter</h3>
\t\t\t<hr>
\t\t\t<div class=\"modal-body\">
\t\t\t\t<form action=\"";
        // line 163
        echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("login");
        echo "\" method=\"post\">
\t\t\t\t\t<div class=\"input-group mb-3\">
\t\t\t\t\t\t<span class=\"input-group-text\">
\t\t\t\t\t\t\t<i class=\"fas fa-at\"></i>
\t\t\t\t\t\t</span>
\t\t\t\t\t\t<input name=\"_username\" id=\"username\" class=\"form-control\" type=\"email\" value=\"";
        // line 168
        echo twig_escape_filter($this->env, (isset($context["last_email"]) || array_key_exists("last_email", $context) ? $context["last_email"] : (function () { throw new RuntimeError('Variable "last_email" does not exist.', 168, $this->source); })()), "html", null, true);
        echo "\" placeholder=\"Veuillez insérer votre adresse courriel.\" required>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"input-group mb-3\">
\t\t\t\t\t\t<span class=\"input-group-text\">
\t\t\t\t\t\t\t<i class=\"fas fa-lock\"></i>
\t\t\t\t\t\t</span>
\t\t\t\t\t\t<input name=\"_password\" id=\"password\" class=\"form-control\" type=\"password\" placeholder=\"Veuillez insérer votre mot de passe.\" required>
\t\t\t\t\t</div>
\t\t\t\t\t<input type=\"hidden\" name=\"_target_path\" value=\"";
        // line 176
        echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("catalog.route");
        echo "\">
\t\t\t\t\t<input type=\"hidden\" name=\"_csrf_token\" value=\"";
        // line 177
        echo twig_escape_filter($this->env, $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderCsrfToken("authenticate"), "html", null, true);
        echo "\">
\t\t\t\t\t<button type=\"submit\" class=\"btn btn-dark fs-4 ps-3 pe-3\">Se connecter<i class=\"fas fa-unlock-keyhole ms-2\"></i>
\t\t\t\t\t</button>
\t\t\t\t</form>
\t\t\t</div>
\t\t\t<p>Pas encore de compte?<a href=\"";
        // line 182
        echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("register");
        echo "\" class=\"text-decoration-none text-dark fw-bold fs-5 ms-2\">S'inscrire</a>
\t\t\t</p>
\t\t</div>
\t</div>
</div>
";
        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

    }

    public function getTemplateName()
    {
        return "core/navbar.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  350 => 182,  342 => 177,  338 => 176,  327 => 168,  319 => 163,  311 => 157,  307 => 154,  302 => 150,  293 => 144,  285 => 139,  277 => 134,  268 => 127,  266 => 126,  263 => 125,  257 => 122,  252 => 120,  245 => 115,  243 => 114,  237 => 110,  227 => 106,  223 => 105,  220 => 104,  216 => 103,  209 => 99,  195 => 88,  191 => 86,  181 => 79,  177 => 76,  174 => 75,  166 => 70,  163 => 69,  160 => 68,  150 => 60,  143 => 58,  132 => 52,  128 => 51,  123 => 48,  121 => 47,  119 => 46,  111 => 40,  109 => 39,  103 => 34,  100 => 32,  94 => 29,  91 => 28,  89 => 27,  83 => 24,  80 => 23,  78 => 22,  73 => 18,  68 => 14,  61 => 11,  59 => 10,  54 => 8,  50 => 7,  47 => 6,  43 => 3,);
    }

    public function getSourceContext()
    {
        return new Source("{# Yannick - Correction #10 #}
{# I remove the TM's #}

\t<nav
\tclass=\"bg-black navbar navbar-dark row sticky-top\"> {# Incanvas section #}
\t<div class=\"col-10 row\">
\t\t<a class=\"col-5 navbar-brand nav-link\" href=\"{{ path('catalog.route') }}\">
\t\t\t<img src=\"{{ asset('images/companiesLogos/logo.png') }}\" id=\"logoIcon\" title=\"Logo d'EVOMEAL\" alt=\"EVOMEAL\">
\t\t</a>
\t\t{% if app.user %}
\t\t\t<div class=\"col-lg-3 fs-3 fw-bold fst-italic m-3 p-3 text-center bg-dark rounded mx-auto my-auto text-success\">{{ app.user.firstName }}
\t\t\t\test connecté.</div>
\t\t{% endif %}
\t</div>
\t<div
\t\tclass=\"col-2\">
\t\t{# Account button #}
\t\t<button class=\"bg-transparent border-0 text-white fs-5\" type=\"button\" data-bs-toggle=\"modal\" data-bs-target=\"#connectionModal\">
\t\t\t<i class=\"far fa-user\"></i>
\t\t</button>
\t\t{# Account button #}
\t\t{# Cart button #}
\t\t<button class=\"bg-transparent border-0\">
\t\t\t<a class=\"text-decoration-none text-white fs-5\" href=\"{{ path('cart.index') }}\">
\t\t\t\t<i class=\"fa-solid fa-cart-shopping\"></i>
\t\t\t</a>
\t\t\t{% if app.user %}
\t\t\t\t<span class=\"translate-middle badge rounded-pill bg-secondary\">
\t\t\t\t\t{{ cartlength }}
\t\t\t\t</span>
\t\t\t{% endif %}
\t\t</button>
\t\t{# Cart button #}
\t\t<button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"offcanvas\" data-bs-target=\"#offcanvasDarkNavbar\" aria-controls=\"offcanvasDarkNavbar\">
\t\t\t<span class=\"navbar-toggler-icon\"></span>
\t\t</button>
\t</div>
\t{# Incanvas section #}
\t{# Offcanvas section #}
\t<div class=\"offcanvas offcanvas-end text-bg-dark\" tabindex=\"-1\" id=\"offcanvasDarkNavbar\" aria-labelledby=\"offcanvasDarkNavbarLabel\">
\t\t<div class=\"offcanvas-header\">
\t\t\t<button type=\"button\" class=\"btn-close btn-close-white\" data-bs-dismiss=\"offcanvas\" aria-label=\"Close\"></button>
\t\t</div>
\t\t<div class=\"offcanvas-body\">
\t\t\t<ul class=\"navbar-nav justify-content-end flex-grow-1 pe-3\">
\t\t\t\t{% if app.user %}
\t\t\t\t\t{# Connected as ... #}
\t\t\t\t\t<li>
\t\t\t\t\t\t<div class=\"bg-warning rounded-pill p-2\">
\t\t\t\t\t\t\t<div class=\"row\">
\t\t\t\t\t\t\t\t<a href=\"{{ path('profile') }}\" class=\"col-2 text-decoration-none\">
\t\t\t\t\t\t\t\t\t<img src=\"https://ui-avatars.com/api/?size=85&name={{ app.user.firstName }}+{{ app.user.lastName }}&rounded=true&background=000000&color=ffffff\">
\t\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t\t<div class=\"col-8 mx-auto\">
\t\t\t\t\t\t\t\t\t<div class=\"fs-4 text-dark text-center\">
\t\t\t\t\t\t\t\t\t\t<span>
\t\t\t\t\t\t\t\t\t\t\tBonjour
\t\t\t\t\t\t\t\t\t\t\t<a href=\"{{ path('profile') }}\" class=\"text-decoration-none text-secondary fw-bold\">{{ app.user.firstName }}</a>
\t\t\t\t\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t\t\t\t\t<a href=\"{{ path('logout') }}\" class=\"link-secondary ms-2\">Se déconnecter</a>
\t\t\t\t\t\t\t\t\t\t</span>
\t\t\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t</div>
\t\t\t\t\t</li>
\t\t\t\t\t{# Connected as ... #}
\t\t\t\t\t{% if is_granted(\"ROLE_ADMIN\") %}
\t\t\t\t\t\t<li class=\"nav-item text-center\">
\t\t\t\t\t\t\t<a class=\"nav-link\" href=\"{{ path('admin') }}\">
\t\t\t\t\t\t\t\t<i class=\"fas fa-screwdriver-wrench me-2\"></i>Version administrateur<i class=\"fas fa-screwdriver-wrench ms-2\"></i>
\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t</li>
\t\t\t\t\t{% endif %}
\t\t\t\t{% endif %}
\t\t\t\t<li
\t\t\t\t\tclass=\"pt-5 pb-1\">
\t\t\t\t\t{# Search bar #}
\t\t\t\t\t<form class=\"d-flex\" method=\"POST\" action=\"{{ app.request.uri }}\">
\t\t\t\t\t\t<input name=\"search_field\" class=\"form-control me-2\" type=\"search\" placeholder=\"Recherche\" aria-label=\"Search\">
\t\t\t\t\t\t<button class=\"btn btn-outline-secondary text-white border-light\" type=\"submit\">
\t\t\t\t\t\t\t<i class=\"fas fa-magnifying-glass\"></i>
\t\t\t\t\t\t</button>
\t\t\t\t\t</form>
\t\t\t\t\t{# Search bar #}
\t\t\t\t</li>
\t\t\t\t<li>
\t\t\t\t\t<a href=\"{{ path('contact.route') }}\" class=\"text-decoration-none text-white fs-3 ms-2\">Nous contacter
\t\t\t\t\t</a>
\t\t\t\t</li>
\t\t\t\t<li>
\t\t\t\t\t<button class=\"btn btn-transparent text-white fs-3 border border-0\" data-bs-toggle=\"collapse\" href=\"#categories\">
\t\t\t\t\t\tMagasinez
\t\t\t\t\t\t<i class=\"fas fa-caret-down text-secondary fs-6 ms-2\"></i>
\t\t\t\t\t</button>
\t\t\t\t\t<div class=\"collapse\" id=\"categories\">
\t\t\t\t\t\t<h5 class=\"fs-4 mt-1 ms-4\">Catégories</h5>
\t\t\t\t\t\t<hr>
\t\t\t\t\t\t<a href=\"{{ path('catalog.route') }}\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white fs-5 ms-5\">
\t\t\t\t\t\t\tToutes les catégories</a>
\t\t\t\t\t\t<hr>
\t\t\t\t\t\t<div class=\"ms-5\">
\t\t\t\t\t\t\t{% for categoryName in categories %}
\t\t\t\t\t\t\t\t<ul>
\t\t\t\t\t\t\t\t\t<a href=\"{{ path('catalog.route', { categoryName: categoryName.idCategory }) }}\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white fs-6\">
\t\t\t\t\t\t\t\t\t\t{{ categoryName.categoryName }}
\t\t\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t\t</ul>
\t\t\t\t\t\t\t{% endfor %}
\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t</li>
\t\t\t\t<li>
\t\t\t\t\t{% if app.user %}
\t\t\t\t\t\t<button class=\"btn btn-transparent text-white fs-3 border border-0\" data-bs-toggle=\"collapse\" href=\"#account\">
\t\t\t\t\t\t\tVotre dossier
\t\t\t\t\t\t\t<i class=\"fas fa-caret-down text-secondary fs-6 ms-2\"></i>
\t\t\t\t\t\t</button>
\t\t\t\t\t\t<div class=\"collapse\" id=\"account\">
\t\t\t\t\t\t\t<a href=\"{{ path('profile') }}\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white ms-2\">Mon compte</a>
\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t<a href=\"{{ path('profile.orders') }}\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white ms-2\">Mes commandes</a>
\t\t\t\t\t\t</div>
\t\t\t\t\t{% endif %}
\t\t\t\t</li>
\t\t\t\t{% if is_granted(\"ROLE_ADMIN\") %}
\t\t\t\t\t<li>
\t\t\t\t\t\t<button class=\"btn btn-transparent text-white fs-3 border border-0\" data-bs-toggle=\"collapse\" href=\"#administrator\">
\t\t\t\t\t\t\tAdministrateur
\t\t\t\t\t\t\t<i class=\"fas fa-caret-down text-secondary fs-6 ms-2\"></i>
\t\t\t\t\t\t</button>
\t\t\t\t\t\t<div class=\"collapse\" id=\"administrator\">
\t\t\t\t\t\t\t<h6 class=\"text-secondary ms-4\">Categories</h6>
\t\t\t\t\t\t\t<a href=\"{{ path('admin.categories') }}\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white ms-5\">
\t\t\t\t\t\t\t\tLister, ajouter et modifier
\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t<h6 class=\"text-secondary ms-4 mt-1\">Produits</h6>
\t\t\t\t\t\t\t<a href=\"{{ path('admin.products') }}\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white ms-5\">
\t\t\t\t\t\t\t\tLister, ajouter et modifier
\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t<h6 class=\"text-secondary ms-4 mt-1\">Commandes</h6>
\t\t\t\t\t\t\t<a href=\"{{ path('admin.orders') }}\" class=\"btn btn-outline-secondary border-0 text-decoration-none text-white ms-5\">
\t\t\t\t\t\t\t\tLister, ajouter et modifier
\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t</div>
\t\t\t\t\t</li>
\t\t\t\t{% endif %}
\t\t\t</ul>
\t\t</div>
\t</div>
\t{# Offcanvas section #}
</nav>

{# Login modal #}
<div class=\"modal fade\" id=\"connectionModal\" tabindex=\"-1\">
\t<div class=\"modal-dialog\">
\t\t<div class=\"modal-content bg-warning text-center\">
\t\t\t<h3 class=\"mt-3\">Se connecter</h3>
\t\t\t<hr>
\t\t\t<div class=\"modal-body\">
\t\t\t\t<form action=\"{{ path('login') }}\" method=\"post\">
\t\t\t\t\t<div class=\"input-group mb-3\">
\t\t\t\t\t\t<span class=\"input-group-text\">
\t\t\t\t\t\t\t<i class=\"fas fa-at\"></i>
\t\t\t\t\t\t</span>
\t\t\t\t\t\t<input name=\"_username\" id=\"username\" class=\"form-control\" type=\"email\" value=\"{{ last_email }}\" placeholder=\"Veuillez insérer votre adresse courriel.\" required>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"input-group mb-3\">
\t\t\t\t\t\t<span class=\"input-group-text\">
\t\t\t\t\t\t\t<i class=\"fas fa-lock\"></i>
\t\t\t\t\t\t</span>
\t\t\t\t\t\t<input name=\"_password\" id=\"password\" class=\"form-control\" type=\"password\" placeholder=\"Veuillez insérer votre mot de passe.\" required>
\t\t\t\t\t</div>
\t\t\t\t\t<input type=\"hidden\" name=\"_target_path\" value=\"{{ path('catalog.route') }}\">
\t\t\t\t\t<input type=\"hidden\" name=\"_csrf_token\" value=\"{{ csrf_token('authenticate') }}\">
\t\t\t\t\t<button type=\"submit\" class=\"btn btn-dark fs-4 ps-3 pe-3\">Se connecter<i class=\"fas fa-unlock-keyhole ms-2\"></i>
\t\t\t\t\t</button>
\t\t\t\t</form>
\t\t\t</div>
\t\t\t<p>Pas encore de compte?<a href=\"{{ path('register') }}\" class=\"text-decoration-none text-dark fw-bold fs-5 ms-2\">S'inscrire</a>
\t\t\t</p>
\t\t</div>
\t</div>
</div>
{# Login modal #}
", "core/navbar.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\core\\navbar.html.twig");
    }
}
