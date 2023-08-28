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

/* order/orderConfirmation.html.twig */
class __TwigTemplate_9f7aaf7e11409875631dc622ca48f2f6 extends Template
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "order/orderConfirmation.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "order/orderConfirmation.html.twig"));

        $this->parent = $this->loadTemplate("core/base.html.twig", "order/orderConfirmation.html.twig", 1);
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
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 4, $this->source); })()), "flashes", [0 => "order_status"], "method", false, false, false, 4));
        foreach ($context['_seq'] as $context["_key"] => $context["flash"]) {
            // line 5
            echo "\t\t<div class=\"fs-3 fst-italic m-3 p-3 text-center bg-dark rounded ";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "color", [], "any", false, false, false, 5), "html", null, true);
            echo "\">";
            echo twig_get_attribute($this->env, $this->source, $context["flash"], "content", [], "any", false, false, false, 5);
            echo "</div>
\t";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['flash'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 7
        echo "\t<div class=\"d-flex justify-content-between fs-1 fw-bold my-5 px-5\">
\t\t<p>
\t\t\tDétails de la commande numéro
\t\t\t";
        // line 10
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 10, $this->source); })()), "idOrder", [], "any", false, false, false, 10), "html", null, true);
        echo "
\t\t</p>
\t\t<p>
\t\t\t";
        // line 13
        if ($this->extensions['Symfony\Bridge\Twig\Extension\SecurityExtension']->isGranted("ROLE_ADMIN")) {
            // line 14
            echo "\t\t\t\t<form action=\"";
            echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("order.confirmation", ["idOrder" => twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 14, $this->source); })()), "idOrder", [], "any", false, false, false, 14)]), "html", null, true);
            echo "\" method=\"POST\" id=\"orderStatusForm\">
\t\t\t\t\t<select name=\"select\" class=\"form-select fs-1\" id=\"orderStatusSelect\">
\t\t\t\t\t\t<option value='P' ";
            // line 16
            if ((twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 16, $this->source); })()), "status", [], "any", false, false, false, 16) == "P")) {
                echo " selected ";
            }
            echo ">En préparation</option>
\t\t\t\t\t\t<option value='S' ";
            // line 17
            if ((twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 17, $this->source); })()), "status", [], "any", false, false, false, 17) == "S")) {
                echo " selected ";
            }
            echo ">Envoyée</option>
\t\t\t\t\t\t<option value='T' ";
            // line 18
            if ((twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 18, $this->source); })()), "status", [], "any", false, false, false, 18) == "T")) {
                echo " selected ";
            }
            echo ">En transit</option>
\t\t\t\t\t\t<option value='D' ";
            // line 19
            if ((twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 19, $this->source); })()), "status", [], "any", false, false, false, 19) == "D")) {
                echo " selected ";
            }
            echo ">Livrée</option>
\t\t\t\t\t</select>
\t\t\t\t</form>
\t\t\t";
        }
        // line 23
        echo "\t\t</p>
\t</div>
\t<div class=\"mx-auto\">
\t\t";
        // line 26
        if (twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 26, $this->source); })()), "status", [], "any", false, false, false, 26)) {
            // line 27
            echo "\t\t\t<div class=\"bg-light rounded text-center m-2 p-3\">
\t\t\t\t";
            // line 28
            if ((twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 28, $this->source); })()), "status", [], "any", false, false, false, 28) == "P")) {
                // line 29
                echo "\t\t\t\t\t<div class=\"row\">
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>En préparation
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-danger fas fa-circle-xmark\"></i><br>Envoyée
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-danger fas fa-circle-xmark\"></i><br>En transit
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-danger fas fa-circle-xmark\"></i><br>Livrée
\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"progress\">
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-danger progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-danger progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-danger progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t</div>
\t\t\t\t";
            }
            // line 50
            echo "\t\t\t\t";
            if ((twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 50, $this->source); })()), "status", [], "any", false, false, false, 50) == "S")) {
                // line 51
                echo "\t\t\t\t\t<div class=\"row\">
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>En préparation
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>Envoyée
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-danger fas fa-circle-xmark\"></i><br>En transit
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-danger fas fa-circle-xmark\"></i><br>Livrée
\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"progress\">
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-danger progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-danger progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t</div>
\t\t\t\t";
            }
            // line 72
            echo "\t\t\t\t";
            if ((twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 72, $this->source); })()), "status", [], "any", false, false, false, 72) == "T")) {
                // line 73
                echo "\t\t\t\t\t<div class=\"row\">
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>En préparation
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>Envoyée
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>En transit
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-danger fas fa-circle-xmark\"></i><br>Livrée
\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"progress\">
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-danger progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t</div>
\t\t\t\t";
            }
            // line 94
            echo "\t\t\t\t";
            if ((twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 94, $this->source); })()), "status", [], "any", false, false, false, 94) == "D")) {
                // line 95
                echo "\t\t\t\t\t<div class=\"row\">
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>En préparation
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>Envoyée
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>En transit
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>Livrée
\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"progress\">
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t</div>
\t\t\t\t";
            }
            // line 116
            echo "\t\t\t</div>
\t\t";
        }
        // line 118
        echo "\t\t<div class=\"my-5\">
\t\t\t<div class=\"mx-auto row\">
\t\t\t\t<div class=\"col-5 bg-light rounded text-center\">
\t\t\t\t\t<div class=\"row fs-5\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\">Numéro de la commande</p>
\t\t\t\t\t\t\t<p>";
        // line 124
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 124, $this->source); })()), "idOrder", [], "any", false, false, false, 124), "html", null, true);
        echo "</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\">Nombre de produits</p>
\t\t\t\t\t\t\t<p>";
        // line 128
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 128, $this->source); })()), "calculateProducts", [], "method", false, false, false, 128), "html", null, true);
        echo "
\t\t\t\t\t\t\t\tproduits</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\">Date de la commande</p>
\t\t\t\t\t\t\t<p>";
        // line 133
        echo twig_escape_filter($this->env, twig_date_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 133, $this->source); })()), "orderDate", [], "any", false, false, false, 133), "Y-m-d H:i:s", "America/Toronto"), "html", null, true);
        echo "</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t";
        // line 135
        if ((twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 135, $this->source); })()), "status", [], "any", false, false, false, 135) == "D")) {
            // line 136
            echo "\t\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t\t<p class=\"fw-bolder\">Date de la livraison</p>
\t\t\t\t\t\t\t\t<p>";
            // line 138
            echo twig_escape_filter($this->env, twig_date_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 138, $this->source); })()), "deliveryDate", [], "any", false, false, false, 138), "Y-m-d H:i:s", "America/Toronto"), "html", null, true);
            echo "</p>
\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t";
        } else {
            // line 141
            echo "\t\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t\t<p class=\"fw-bolder\">Date de la livraison</p>
\t\t\t\t\t\t\t\t<p>Prochainement</p>
\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t";
        }
        // line 146
        echo "\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<div class=\"col-2 bg-light rounded text-center mx-1\">
\t\t\t\t\t<p class=\"fs-5 text-center\">
\t\t\t\t\t\t<i class=\"fas fa-address-book me-1\"></i>
\t\t\t\t\t\tVotre adresse de livraison
\t\t\t\t\t</p>
\t\t\t\t\t<div class=\"text-center bg-warning rounded mx-auto p-2\">
\t\t\t\t\t\t<span class=\"fs-5 fw-bold\">
\t\t\t\t\t\t\t";
        // line 155
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 155, $this->source); })()), "user", [], "any", false, false, false, 155), "firstName", [], "any", false, false, false, 155), "html", null, true);
        echo "
\t\t\t\t\t\t\t";
        // line 156
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 156, $this->source); })()), "user", [], "any", false, false, false, 156), "lastName", [], "any", false, false, false, 156), "html", null, true);
        echo "
\t\t\t\t\t\t</span>
\t\t\t\t\t\t<br>
\t\t\t\t\t\t<span>
\t\t\t\t\t\t\t";
        // line 160
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 160, $this->source); })()), "user", [], "any", false, false, false, 160), "address", [], "any", false, false, false, 160), "html", null, true);
        echo "
\t\t\t\t\t\t</span>
\t\t\t\t\t\t<br>
\t\t\t\t\t\t<span>
\t\t\t\t\t\t\t";
        // line 164
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 164, $this->source); })()), "user", [], "any", false, false, false, 164), "city", [], "any", false, false, false, 164), "html", null, true);
        echo ",
\t\t\t\t\t\t\t";
        // line 165
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 165, $this->source); })()), "user", [], "any", false, false, false, 165), "province", [], "any", false, false, false, 165), "html", null, true);
        echo "
\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t";
        // line 167
        echo twig_escape_filter($this->env, twig_slice($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 167, $this->source); })()), "user", [], "any", false, false, false, 167), "postalCode", [], "any", false, false, false, 167), 0, 3), "html", null, true);
        echo "
\t\t\t\t\t\t\t";
        // line 168
        echo twig_escape_filter($this->env, twig_slice($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 168, $this->source); })()), "user", [], "any", false, false, false, 168), "postalCode", [], "any", false, false, false, 168), 3, null), "html", null, true);
        echo "
\t\t\t\t\t\t</span>
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<div class=\"col-4 bg-light rounded text-center\">
\t\t\t\t\t<div class=\"row fs-5\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\">Sous-Total</p>
\t\t\t\t\t\t\t<p>";
        // line 176
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 176, $this->source); })()), "calculateInvoice", [], "method", false, false, false, 176), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\">Rabais</p>
\t\t\t\t\t\t\t<p>0,00 \$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\" class=\"fw-bolder\">Frais de Livraison</p>
\t\t\t\t\t\t\t<p>";
        // line 185
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 185, $this->source); })()), "shippingCost", [], "any", false, false, false, 185), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\">Côut total (avec taxes)</p>
\t\t\t\t\t\t\t<p>";
        // line 190
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 190, $this->source); })()), "calculateTotal", [], "method", false, false, false, 190), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t</div>
\t\t</div>
\t\t<div>
\t\t\t<table class=\"table table-hover align-middle\">
\t\t\t\t<thead class=\"rounded\">
\t\t\t\t\t<tr class=\"bg-warning\">
\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Visuel</th>
\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Nom</th>
\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Quantité</th>
\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Prix unitaire</th>
\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Total</th>
\t\t\t\t\t</tr>
\t\t\t\t</thead>
\t\t\t\t<tbody>
\t\t\t\t\t";
        // line 209
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["order"]) || array_key_exists("order", $context) ? $context["order"] : (function () { throw new RuntimeError('Variable "order" does not exist.', 209, $this->source); })()), "purchases", [], "any", false, false, false, 209));
        foreach ($context['_seq'] as $context["_key"] => $context["purchase"]) {
            // line 210
            echo "\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t<img src=\"";
            // line 212
            echo twig_escape_filter($this->env, $this->extensions['App\Twig\ConditionalAssetExtension']->asset_if(twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, $context["purchase"], "product", [], "any", false, false, false, 212), "imagePath", [], "any", false, false, false, 212), "images/products/imageNotAvailable.png"), "html", null, true);
            echo "\" class=\"card-img-top\" style=\"width: 100px; height: 100px\" alt=\"Produit\">
\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t<h5>";
            // line 215
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, $context["purchase"], "product", [], "any", false, false, false, 215), "name", [], "any", false, false, false, 215), "html", null, true);
            echo "</h5>
\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t<h5>";
            // line 218
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["purchase"], "quantity", [], "any", false, false, false, 218), "html", null, true);
            echo "</h5>
\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t<h5>";
            // line 221
            echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, $context["purchase"], "product", [], "any", false, false, false, 221), "price", [], "any", false, false, false, 221), 2, ",", ""), "html", null, true);
            echo "
\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t<h5>";
            // line 225
            echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, $context["purchase"], "price", [], "any", false, false, false, 225), 2, ",", ""), "html", null, true);
            echo "
\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t</tr>
\t\t\t\t\t";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['purchase'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 230
        echo "\t\t\t\t</tbody>
\t\t\t</table>
\t\t</div>
\t</div>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    // line 236
    public function block_javascripts($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        // line 237
        echo "\t<script defer src=\"";
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("scripts/admin.orderConfirmation.js"), "html", null, true);
        echo "\"></script>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    public function getTemplateName()
    {
        return "order/orderConfirmation.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  458 => 237,  448 => 236,  434 => 230,  423 => 225,  416 => 221,  410 => 218,  404 => 215,  398 => 212,  394 => 210,  390 => 209,  368 => 190,  360 => 185,  348 => 176,  337 => 168,  333 => 167,  328 => 165,  324 => 164,  317 => 160,  310 => 156,  306 => 155,  295 => 146,  288 => 141,  282 => 138,  278 => 136,  276 => 135,  271 => 133,  263 => 128,  256 => 124,  248 => 118,  244 => 116,  221 => 95,  218 => 94,  195 => 73,  192 => 72,  169 => 51,  166 => 50,  143 => 29,  141 => 28,  138 => 27,  136 => 26,  131 => 23,  122 => 19,  116 => 18,  110 => 17,  104 => 16,  98 => 14,  96 => 13,  90 => 10,  85 => 7,  74 => 5,  69 => 4,  59 => 3,  36 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("{% extends 'core/base.html.twig' %}

{% block body %}
\t{% for flash in app.flashes('order_status') %}
\t\t<div class=\"fs-3 fst-italic m-3 p-3 text-center bg-dark rounded {{ flash.color }}\">{{ flash.content|raw }}</div>
\t{% endfor %}
\t<div class=\"d-flex justify-content-between fs-1 fw-bold my-5 px-5\">
\t\t<p>
\t\t\tDétails de la commande numéro
\t\t\t{{ order.idOrder }}
\t\t</p>
\t\t<p>
\t\t\t{% if is_granted(\"ROLE_ADMIN\") %}
\t\t\t\t<form action=\"{{ path('order.confirmation', { idOrder: order.idOrder }) }}\" method=\"POST\" id=\"orderStatusForm\">
\t\t\t\t\t<select name=\"select\" class=\"form-select fs-1\" id=\"orderStatusSelect\">
\t\t\t\t\t\t<option value='P' {% if order.status == 'P' %} selected {% endif %}>En préparation</option>
\t\t\t\t\t\t<option value='S' {% if order.status == 'S' %} selected {% endif %}>Envoyée</option>
\t\t\t\t\t\t<option value='T' {% if order.status == 'T' %} selected {% endif %}>En transit</option>
\t\t\t\t\t\t<option value='D' {% if order.status == 'D' %} selected {% endif %}>Livrée</option>
\t\t\t\t\t</select>
\t\t\t\t</form>
\t\t\t{% endif %}
\t\t</p>
\t</div>
\t<div class=\"mx-auto\">
\t\t{% if order.status %}
\t\t\t<div class=\"bg-light rounded text-center m-2 p-3\">
\t\t\t\t{% if order.status == 'P' %}
\t\t\t\t\t<div class=\"row\">
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>En préparation
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-danger fas fa-circle-xmark\"></i><br>Envoyée
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-danger fas fa-circle-xmark\"></i><br>En transit
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-danger fas fa-circle-xmark\"></i><br>Livrée
\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"progress\">
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-danger progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-danger progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-danger progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t</div>
\t\t\t\t{% endif %}
\t\t\t\t{% if order.status == 'S' %}
\t\t\t\t\t<div class=\"row\">
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>En préparation
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>Envoyée
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-danger fas fa-circle-xmark\"></i><br>En transit
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-danger fas fa-circle-xmark\"></i><br>Livrée
\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"progress\">
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-danger progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-danger progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t</div>
\t\t\t\t{% endif %}
\t\t\t\t{% if order.status == 'T' %}
\t\t\t\t\t<div class=\"row\">
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>En préparation
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>Envoyée
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>En transit
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-danger fas fa-circle-xmark\"></i><br>Livrée
\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"progress\">
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-danger progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t</div>
\t\t\t\t{% endif %}
\t\t\t\t{% if order.status == 'D' %}
\t\t\t\t\t<div class=\"row\">
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>En préparation
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>Envoyée
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>En transit
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"col-3 fs-4\">
\t\t\t\t\t\t\t<i class=\"fs-1 text-success fas fa-circle-check\"></i><br>Livrée
\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"progress\">
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t\t<div class=\"bg-success progress-bar progress-bar-striped progress-bar-animated\" style=\"width: 25%\"></div>
\t\t\t\t\t</div>
\t\t\t\t{% endif %}
\t\t\t</div>
\t\t{% endif %}
\t\t<div class=\"my-5\">
\t\t\t<div class=\"mx-auto row\">
\t\t\t\t<div class=\"col-5 bg-light rounded text-center\">
\t\t\t\t\t<div class=\"row fs-5\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\">Numéro de la commande</p>
\t\t\t\t\t\t\t<p>{{ order.idOrder }}</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\">Nombre de produits</p>
\t\t\t\t\t\t\t<p>{{ order.calculateProducts() }}
\t\t\t\t\t\t\t\tproduits</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\">Date de la commande</p>
\t\t\t\t\t\t\t<p>{{ order.orderDate|date('Y-m-d H:i:s', 'America/Toronto') }}</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t{% if order.status == 'D' %}
\t\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t\t<p class=\"fw-bolder\">Date de la livraison</p>
\t\t\t\t\t\t\t\t<p>{{ order.deliveryDate|date('Y-m-d H:i:s', 'America/Toronto') }}</p>
\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t{% else %}
\t\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t\t<p class=\"fw-bolder\">Date de la livraison</p>
\t\t\t\t\t\t\t\t<p>Prochainement</p>
\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<div class=\"col-2 bg-light rounded text-center mx-1\">
\t\t\t\t\t<p class=\"fs-5 text-center\">
\t\t\t\t\t\t<i class=\"fas fa-address-book me-1\"></i>
\t\t\t\t\t\tVotre adresse de livraison
\t\t\t\t\t</p>
\t\t\t\t\t<div class=\"text-center bg-warning rounded mx-auto p-2\">
\t\t\t\t\t\t<span class=\"fs-5 fw-bold\">
\t\t\t\t\t\t\t{{ app.user.firstName }}
\t\t\t\t\t\t\t{{ app.user.lastName }}
\t\t\t\t\t\t</span>
\t\t\t\t\t\t<br>
\t\t\t\t\t\t<span>
\t\t\t\t\t\t\t{{ app.user.address }}
\t\t\t\t\t\t</span>
\t\t\t\t\t\t<br>
\t\t\t\t\t\t<span>
\t\t\t\t\t\t\t{{ app.user.city }},
\t\t\t\t\t\t\t{{ app.user.province }}
\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t{{ app.user.postalCode[:3] }}
\t\t\t\t\t\t\t{{ app.user.postalCode[3:] }}
\t\t\t\t\t\t</span>
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<div class=\"col-4 bg-light rounded text-center\">
\t\t\t\t\t<div class=\"row fs-5\">
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\">Sous-Total</p>
\t\t\t\t\t\t\t<p>{{ order.calculateInvoice()|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\">Rabais</p>
\t\t\t\t\t\t\t<p>0,00 \$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\" class=\"fw-bolder\">Frais de Livraison</p>
\t\t\t\t\t\t\t<p>{{ order.shippingCost|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t<div class=\"d-flex justify-content-between\">
\t\t\t\t\t\t\t<p class=\"fw-bolder\">Côut total (avec taxes)</p>
\t\t\t\t\t\t\t<p>{{ order.calculateTotal()|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</p>
\t\t\t\t\t\t</div>
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t</div>
\t\t</div>
\t\t<div>
\t\t\t<table class=\"table table-hover align-middle\">
\t\t\t\t<thead class=\"rounded\">
\t\t\t\t\t<tr class=\"bg-warning\">
\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Visuel</th>
\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Nom</th>
\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Quantité</th>
\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Prix unitaire</th>
\t\t\t\t\t\t<th class=\"h5\" scope=\"col\">Total</th>
\t\t\t\t\t</tr>
\t\t\t\t</thead>
\t\t\t\t<tbody>
\t\t\t\t\t{% for purchase in order.purchases %}
\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t<img src=\"{{ asset_if(purchase.product.imagePath, 'images/products/imageNotAvailable.png') }}\" class=\"card-img-top\" style=\"width: 100px; height: 100px\" alt=\"Produit\">
\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t<h5>{{ purchase.product.name }}</h5>
\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t<h5>{{ purchase.quantity }}</h5>
\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t<h5>{{ purchase.product.price|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t<h5>{{ purchase.price|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\t\$</h5>
\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t</tr>
\t\t\t\t\t{% endfor %}
\t\t\t\t</tbody>
\t\t\t</table>
\t\t</div>
\t</div>
{% endblock %}

{% block javascripts %}
\t<script defer src=\"{{ asset('scripts/admin.orderConfirmation.js')}}\"></script>
{% endblock %}
", "order/orderConfirmation.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\order\\orderConfirmation.html.twig");
    }
}
