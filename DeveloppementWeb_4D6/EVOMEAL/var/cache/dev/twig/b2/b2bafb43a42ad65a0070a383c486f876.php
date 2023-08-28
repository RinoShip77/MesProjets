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

/* catalog/catalog.html.twig */
class __TwigTemplate_1b4633f442366fb83ff5e3105b6f0d0c extends Template
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "catalog/catalog.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "catalog/catalog.html.twig"));

        $this->parent = $this->loadTemplate("core/base.html.twig", "catalog/catalog.html.twig", 1);
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
        // line 5
        echo "\t<div
\t\tclass=\"row bg-dark\">
\t\t";
        // line 8
        echo "\t\t<div class=\"col-7 text-white my-1\">
\t\t\t<h1 class=\"display-5 text-warning\" style=\"letter-spacing: 1rem; margin-top: -2px; margin-bottom: -2px; margin-left: 4.5em; font-family: 'Raleway', sans-serif\">
\t\t\t\tIN</h1>
\t\t\t<h1 class=\"display-5 text-warning\" style=\"letter-spacing: 1rem; margin-top: -2px; margin-bottom: -2px; margin-left: 5em; font-family: 'Raleway', sans-serif\">
\t\t\t\tCORPORE</h1>
\t\t\t<h1 class=\"display-5 text-warning\" style=\"letter-spacing: 1rem; margin-top: -2px; margin-bottom: -2px; margin-left: 5.5em; font-family: 'Raleway', sans-serif\">
\t\t\t\tSANO</h1>
\t\t\t<h1 class=\"display-5 text-warning\" style=\"letter-spacing: 1rem; margin-top: -2px; margin-bottom: -2px; margin-left: 6em; font-family: 'Raleway', sans-serif;\">
\t\t\t\tIN</h1>
\t\t\t<h1 class=\"display-5 text-warning\" style=\"letter-spacing: 1rem; margin-top: -2px; margin-bottom: -2px; margin-left: 6.5em; font-family: 'Raleway', sans-serif\">
\t\t\t\tMENTE</h1>
\t\t\t<h1 class=\"display-5 text-warning\" style=\"letter-spacing: 1rem; margin-top: -2px; margin-bottom: -2px; margin-left: 7em; font-family: 'Raleway', sans-serif\">
\t\t\t\tSANA</h1>
\t\t</div>
\t\t";
        // line 23
        echo "\t\t";
        // line 24
        echo "\t\t<div class=\"col-5\" id=\"divCarousel\">
\t\t\t<div id=\"carousel\" class=\"carousel slide w-50\" data-bs-ride=\"true\">
\t\t\t\t<div class=\"carousel-indicators\">
\t\t\t\t\t<button type=\"button\" data-bs-target=\"#carousel\" data-bs-slide-to=\"0\" class=\"active\" aria-current=\"true\" aria-label=\"Slide 1\"></button>
\t\t\t\t\t<button type=\"button\" data-bs-target=\"#carousel\" data-bs-slide-to=\"1\" aria-label=\"Slide 2\"></button>
\t\t\t\t\t<button type=\"button\" data-bs-target=\"#carousel\" data-bs-slide-to=\"2\" aria-label=\"Slide 3\"></button>
\t\t\t\t\t<button type=\"button\" data-bs-target=\"#carousel\" data-bs-slide-to=\"3\" aria-label=\"Slide 4\"></button>
\t\t\t\t\t<button type=\"button\" data-bs-target=\"#carousel\" data-bs-slide-to=\"4\" aria-label=\"Slide 5\"></button>
\t\t\t\t</div>
\t\t\t\t<div class=\"carousel-inner\">
\t\t\t\t\t<div class=\"carousel-item active\">
\t\t\t\t\t\t<img src=\"";
        // line 35
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("images/products/proteinPowderRevolutionNutritionHighWhey.png"), "html", null, true);
        echo "\" class=\"w-100\">
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"carousel-item\">
\t\t\t\t\t\t<img src=\"";
        // line 38
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("images/products/preWorkoutRevolutionNutritionPlayer.png"), "html", null, true);
        echo "\" class=\"w-100\">
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"carousel-item\">
\t\t\t\t\t\t<img src=\"";
        // line 41
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("images/products/hydratationMixRevolutionNutritionBCAASplash.png"), "html", null, true);
        echo "\" class=\"w-100\">
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"carousel-item\">
\t\t\t\t\t\t<img src=\"";
        // line 44
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("images/products/healthAndWellbeingRevolutionNutritionIsolateSplash.png"), "html", null, true);
        echo "\" class=\"w-100\">
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"carousel-item\">
\t\t\t\t\t\t<img src=\"";
        // line 47
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("images/products/weightControlRevolutionNutritionAminoBurn.png"), "html", null, true);
        echo "\" class=\"w-100\">
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t</div>
\t\t</div>
\t\t";
        // line 53
        echo "\t</div>
\t";
        // line 55
        echo "
\t";
        // line 57
        echo "\t<section
\t\tclass=\"row\">
\t\t";
        // line 60
        echo "\t\t<div class=\"col-4 bg-warning pt-3\">
\t\t\t<div class=\"text-dark fw-bold fs-1\">
\t\t\t\tMagasinez
\t\t\t</div>
\t\t\t<span class=\"fs-2 mt-1 ms-4\">Catégories</span>
\t\t\t<hr>
\t\t\t<a href=\"";
        // line 66
        echo $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("catalog.route");
        echo "\" class=\"btn btn-outline-dark border-0 text-decoration-none fs-4 ms-5\">
\t\t\t\t<i class=\"fas fa-filter-circle-xmark me-1\"></i>Toutes les catégories</a>
\t\t\t<hr>
\t\t\t<div class=\"ms-5\">
\t\t\t\t<ul class=\"list-unstyled ms-5\">
\t\t\t\t\t";
        // line 71
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable((isset($context["categories"]) || array_key_exists("categories", $context) ? $context["categories"] : (function () { throw new RuntimeError('Variable "categories" does not exist.', 71, $this->source); })()));
        foreach ($context['_seq'] as $context["_key"] => $context["category"]) {
            // line 72
            echo "\t\t\t\t\t\t<a href=\"";
            echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("catalog.route", ["categories" => twig_get_attribute($this->env, $this->source, $context["category"], "idCategory", [], "any", false, false, false, 72)]), "html", null, true);
            echo "\" class=\"text-decoration-none text-black fs-5\">
\t\t\t\t\t\t\t<li class=\"my-4\">
\t\t\t\t\t\t\t\t<input class=\"form-check-input\" type=\"checkbox\" ";
            // line 74
            if ((twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 74, $this->source); })()), "request", [], "any", false, false, false, 74), "query", [], "any", false, false, false, 74), "get", [0 => "categories"], "method", false, false, false, 74) == twig_get_attribute($this->env, $this->source, $context["category"], "idCategory", [], "any", false, false, false, 74))) {
                echo " checked ";
            }
            echo ">
\t\t\t\t\t\t\t\t<span class=\"ms-3\">
\t\t\t\t\t\t\t\t\t";
            // line 76
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["category"], "categoryName", [], "any", false, false, false, 76), "html", null, true);
            echo "
\t\t\t\t\t\t\t\t\t[";
            // line 77
            echo twig_escape_filter($this->env, twig_length_filter($this->env, twig_get_attribute($this->env, $this->source, $context["category"], "products", [], "any", false, false, false, 77)), "html", null, true);
            echo "]
\t\t\t\t\t\t\t\t</span>
\t\t\t\t\t\t\t</li>
\t\t\t\t\t\t</a>
\t\t\t\t\t";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['category'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 82
        echo "\t\t\t\t</ul>
\t\t\t</div>
\t\t</div>
\t\t";
        // line 86
        echo "\t\t";
        // line 87
        echo "\t\t<div class=\"col-8 overflow-auto bg-white mx-auto\" style=\"height: 1000px\">
\t\t\t";
        // line 88
        if ((twig_length_filter($this->env, (isset($context["products"]) || array_key_exists("products", $context) ? $context["products"] : (function () { throw new RuntimeError('Variable "products" does not exist.', 88, $this->source); })())) > 0)) {
            // line 89
            echo "\t\t\t\t<div class=\"row row-cols-xxl-4 row-cols-xl-3 row-cols-lg-2 row-cols-md-1 row-cols-sm-1 g-2 my-3\">
\t\t\t\t\t";
            // line 90
            $context['_parent'] = $context;
            $context['_seq'] = twig_ensure_traversable((isset($context["products"]) || array_key_exists("products", $context) ? $context["products"] : (function () { throw new RuntimeError('Variable "products" does not exist.', 90, $this->source); })()));
            foreach ($context['_seq'] as $context["key"] => $context["product"]) {
                // line 91
                echo "\t\t\t\t\t\t";
                // line 92
                echo "\t\t\t\t\t\t<div class=\"col\">
\t\t\t\t\t\t\t<div class=\"card text-center border border-3 border-secondary w-100\">
\t\t\t\t\t\t\t\t<form action=\"";
                // line 94
                echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("cart.add", ["idProduct" => twig_get_attribute($this->env, $this->source, $context["product"], "idProduct", [], "any", false, false, false, 94)]), "html", null, true);
                echo "\" method=\"POST\">
\t\t\t\t\t\t\t\t\t<div id=\"viewProduct\">
\t\t\t\t\t\t\t\t\t\t<a class=\"product-modal text-decoration-none\" href=\"";
                // line 96
                echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("product_modal", ["idProduct" => twig_get_attribute($this->env, $this->source, $context["product"], "idProduct", [], "any", false, false, false, 96)]), "html", null, true);
                echo "\">
\t\t\t\t\t\t\t\t\t\t\t<img name=\"imgProductImage\" src=\"";
                // line 97
                echo twig_escape_filter($this->env, $this->extensions['App\Twig\ConditionalAssetExtension']->asset_if(twig_get_attribute($this->env, $this->source, $context["product"], "imagePath", [], "any", false, false, false, 97), "images/products/imageNotAvailable.png"), "html", null, true);
                echo "\" style=\"width: 175px; height: 150px\" alt=\"Produit\">
\t\t\t\t\t\t\t\t\t\t\t<div class=\"card-body text-black\">
\t\t\t\t\t\t\t\t\t\t\t\t<span name=\"txtPoductName\" class=\"card-title fw-bold text-nowrap\">";
                // line 99
                echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["product"], "name", [], "any", false, false, false, 99), "html", null, true);
                echo "</span>
\t\t\t\t\t\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t\t\t\t\t\t<span name=\"txtProductPrice\" class=\"card-text\">";
                // line 101
                echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, $context["product"], "price", [], "any", false, false, false, 101), 2, ",", ""), "html", null, true);
                echo "
\t\t\t\t\t\t\t\t\t\t\t\t\t\$</span>
\t\t\t\t\t\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t\t\t\t\t\t";
                // line 104
                if ((twig_get_attribute($this->env, $this->source, $context["product"], "rating", [], "any", false, false, false, 104) == 0)) {
                    // line 105
                    echo "\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t";
                }
                // line 111
                echo "\t\t\t\t\t\t\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, $context["product"], "rating", [], "any", false, false, false, 111) == 0.5)) {
                    // line 112
                    echo "\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t";
                }
                // line 118
                echo "\t\t\t\t\t\t\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, $context["product"], "rating", [], "any", false, false, false, 118) == 1)) {
                    // line 119
                    echo "\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t";
                }
                // line 125
                echo "\t\t\t\t\t\t\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, $context["product"], "rating", [], "any", false, false, false, 125) == 1.5)) {
                    // line 126
                    echo "\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t";
                }
                // line 132
                echo "\t\t\t\t\t\t\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, $context["product"], "rating", [], "any", false, false, false, 132) == 2)) {
                    // line 133
                    echo "\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t";
                }
                // line 139
                echo "\t\t\t\t\t\t\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, $context["product"], "rating", [], "any", false, false, false, 139) == 2.5)) {
                    // line 140
                    echo "\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t";
                }
                // line 146
                echo "\t\t\t\t\t\t\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, $context["product"], "rating", [], "any", false, false, false, 146) == 3)) {
                    // line 147
                    echo "\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t";
                }
                // line 153
                echo "\t\t\t\t\t\t\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, $context["product"], "rating", [], "any", false, false, false, 153) == 3.5)) {
                    // line 154
                    echo "\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t";
                }
                // line 160
                echo "\t\t\t\t\t\t\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, $context["product"], "rating", [], "any", false, false, false, 160) == 4)) {
                    // line 161
                    echo "\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t";
                }
                // line 167
                echo "\t\t\t\t\t\t\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, $context["product"], "rating", [], "any", false, false, false, 167) == 4.5)) {
                    // line 168
                    echo "\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t";
                }
                // line 174
                echo "\t\t\t\t\t\t\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, $context["product"], "rating", [], "any", false, false, false, 174) == 5)) {
                    // line 175
                    echo "\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t";
                }
                // line 181
                echo "\t\t\t\t\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t\t\t\t<div class=\"card-footer border-0 bg-transparent\">
\t\t\t\t\t\t\t\t\t\t<button type=\"submit\" id=\"addToCartBtn\" class=\"m-2 p-2\">Ajouter au panier</button>
\t\t\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t\t\t</form>
\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t";
                // line 191
                echo "\t\t\t\t\t";
            }
            $_parent = $context['_parent'];
            unset($context['_seq'], $context['_iterated'], $context['key'], $context['product'], $context['_parent'], $context['loop']);
            $context = array_intersect_key($context, $_parent) + $_parent;
            // line 192
            echo "\t\t\t\t</div>
\t\t\t";
        } else {
            // line 194
            echo "\t\t\t\t<p class=\"display-6 mt-4\" id=\"txtRaleway\">Aucun produit dans cette catégorie.</p>
\t\t\t";
        }
        // line 196
        echo "\t\t</div>
\t\t";
        // line 198
        echo "\t</section>
\t";
        // line 200
        echo "
\t";
        // line 202
        echo "\t<div class=\"modal fade\" id=\"product-modal\" tabindex=\"-1\">
\t\t<div class=\"modal-dialog modal-dialog-centered\">
\t\t\t<div
\t\t\t\tid=\"product-modal-content\" class=\"modal-content\">";
        // line 206
        echo "\t\t\t</div>
\t\t</div>
\t</div>
\t";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    // line 213
    public function block_stylesheets($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "stylesheets"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "stylesheets"));

        // line 214
        echo "\t<link rel=\"stylesheet\" href=\"";
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("styles/catalog.css"), "html", null, true);
        echo "\">
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    // line 218
    public function block_javascripts($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        // line 219
        echo "\t<script defer src=\"";
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("scripts/modal.product.js"), "html", null, true);
        echo "\"></script>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    public function getTemplateName()
    {
        return "catalog/catalog.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  452 => 219,  442 => 218,  429 => 214,  419 => 213,  406 => 206,  401 => 202,  398 => 200,  395 => 198,  392 => 196,  388 => 194,  384 => 192,  378 => 191,  367 => 181,  359 => 175,  356 => 174,  348 => 168,  345 => 167,  337 => 161,  334 => 160,  326 => 154,  323 => 153,  315 => 147,  312 => 146,  304 => 140,  301 => 139,  293 => 133,  290 => 132,  282 => 126,  279 => 125,  271 => 119,  268 => 118,  260 => 112,  257 => 111,  249 => 105,  247 => 104,  241 => 101,  236 => 99,  231 => 97,  227 => 96,  222 => 94,  218 => 92,  216 => 91,  212 => 90,  209 => 89,  207 => 88,  204 => 87,  202 => 86,  197 => 82,  186 => 77,  182 => 76,  175 => 74,  169 => 72,  165 => 71,  157 => 66,  149 => 60,  145 => 57,  142 => 55,  139 => 53,  131 => 47,  125 => 44,  119 => 41,  113 => 38,  107 => 35,  94 => 24,  92 => 23,  76 => 8,  72 => 5,  70 => 4,  60 => 3,  37 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("{% extends 'core/base.html.twig' %}

{% block body %}
\t{# Top section #}
\t<div
\t\tclass=\"row bg-dark\">
\t\t{# Text #}
\t\t<div class=\"col-7 text-white my-1\">
\t\t\t<h1 class=\"display-5 text-warning\" style=\"letter-spacing: 1rem; margin-top: -2px; margin-bottom: -2px; margin-left: 4.5em; font-family: 'Raleway', sans-serif\">
\t\t\t\tIN</h1>
\t\t\t<h1 class=\"display-5 text-warning\" style=\"letter-spacing: 1rem; margin-top: -2px; margin-bottom: -2px; margin-left: 5em; font-family: 'Raleway', sans-serif\">
\t\t\t\tCORPORE</h1>
\t\t\t<h1 class=\"display-5 text-warning\" style=\"letter-spacing: 1rem; margin-top: -2px; margin-bottom: -2px; margin-left: 5.5em; font-family: 'Raleway', sans-serif\">
\t\t\t\tSANO</h1>
\t\t\t<h1 class=\"display-5 text-warning\" style=\"letter-spacing: 1rem; margin-top: -2px; margin-bottom: -2px; margin-left: 6em; font-family: 'Raleway', sans-serif;\">
\t\t\t\tIN</h1>
\t\t\t<h1 class=\"display-5 text-warning\" style=\"letter-spacing: 1rem; margin-top: -2px; margin-bottom: -2px; margin-left: 6.5em; font-family: 'Raleway', sans-serif\">
\t\t\t\tMENTE</h1>
\t\t\t<h1 class=\"display-5 text-warning\" style=\"letter-spacing: 1rem; margin-top: -2px; margin-bottom: -2px; margin-left: 7em; font-family: 'Raleway', sans-serif\">
\t\t\t\tSANA</h1>
\t\t</div>
\t\t{# Text #}
\t\t{# Carousel #}
\t\t<div class=\"col-5\" id=\"divCarousel\">
\t\t\t<div id=\"carousel\" class=\"carousel slide w-50\" data-bs-ride=\"true\">
\t\t\t\t<div class=\"carousel-indicators\">
\t\t\t\t\t<button type=\"button\" data-bs-target=\"#carousel\" data-bs-slide-to=\"0\" class=\"active\" aria-current=\"true\" aria-label=\"Slide 1\"></button>
\t\t\t\t\t<button type=\"button\" data-bs-target=\"#carousel\" data-bs-slide-to=\"1\" aria-label=\"Slide 2\"></button>
\t\t\t\t\t<button type=\"button\" data-bs-target=\"#carousel\" data-bs-slide-to=\"2\" aria-label=\"Slide 3\"></button>
\t\t\t\t\t<button type=\"button\" data-bs-target=\"#carousel\" data-bs-slide-to=\"3\" aria-label=\"Slide 4\"></button>
\t\t\t\t\t<button type=\"button\" data-bs-target=\"#carousel\" data-bs-slide-to=\"4\" aria-label=\"Slide 5\"></button>
\t\t\t\t</div>
\t\t\t\t<div class=\"carousel-inner\">
\t\t\t\t\t<div class=\"carousel-item active\">
\t\t\t\t\t\t<img src=\"{{ asset('images/products/proteinPowderRevolutionNutritionHighWhey.png') }}\" class=\"w-100\">
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"carousel-item\">
\t\t\t\t\t\t<img src=\"{{ asset('images/products/preWorkoutRevolutionNutritionPlayer.png') }}\" class=\"w-100\">
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"carousel-item\">
\t\t\t\t\t\t<img src=\"{{ asset('images/products/hydratationMixRevolutionNutritionBCAASplash.png') }}\" class=\"w-100\">
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"carousel-item\">
\t\t\t\t\t\t<img src=\"{{ asset('images/products/healthAndWellbeingRevolutionNutritionIsolateSplash.png') }}\" class=\"w-100\">
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"carousel-item\">
\t\t\t\t\t\t<img src=\"{{ asset('images/products/weightControlRevolutionNutritionAminoBurn.png') }}\" class=\"w-100\">
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t</div>
\t\t</div>
\t\t{# Carousel #}
\t</div>
\t{# Top section #}

\t{# Middle section #}
\t<section
\t\tclass=\"row\">
\t\t{# Left section #}
\t\t<div class=\"col-4 bg-warning pt-3\">
\t\t\t<div class=\"text-dark fw-bold fs-1\">
\t\t\t\tMagasinez
\t\t\t</div>
\t\t\t<span class=\"fs-2 mt-1 ms-4\">Catégories</span>
\t\t\t<hr>
\t\t\t<a href=\"{{ path('catalog.route') }}\" class=\"btn btn-outline-dark border-0 text-decoration-none fs-4 ms-5\">
\t\t\t\t<i class=\"fas fa-filter-circle-xmark me-1\"></i>Toutes les catégories</a>
\t\t\t<hr>
\t\t\t<div class=\"ms-5\">
\t\t\t\t<ul class=\"list-unstyled ms-5\">
\t\t\t\t\t{% for category in categories %}
\t\t\t\t\t\t<a href=\"{{ path('catalog.route', { categories: category.idCategory }) }}\" class=\"text-decoration-none text-black fs-5\">
\t\t\t\t\t\t\t<li class=\"my-4\">
\t\t\t\t\t\t\t\t<input class=\"form-check-input\" type=\"checkbox\" {% if app.request.query.get('categories') == category.idCategory %} checked {% endif %}>
\t\t\t\t\t\t\t\t<span class=\"ms-3\">
\t\t\t\t\t\t\t\t\t{{ category.categoryName }}
\t\t\t\t\t\t\t\t\t[{{ category.products|length }}]
\t\t\t\t\t\t\t\t</span>
\t\t\t\t\t\t\t</li>
\t\t\t\t\t\t</a>
\t\t\t\t\t{% endfor %}
\t\t\t\t</ul>
\t\t\t</div>
\t\t</div>
\t\t{# Left section #}
\t\t{# Right section (catalog) #}
\t\t<div class=\"col-8 overflow-auto bg-white mx-auto\" style=\"height: 1000px\">
\t\t\t{% if products|length > 0 %}
\t\t\t\t<div class=\"row row-cols-xxl-4 row-cols-xl-3 row-cols-lg-2 row-cols-md-1 row-cols-sm-1 g-2 my-3\">
\t\t\t\t\t{% for key, product in products %}
\t\t\t\t\t\t{# Product card #}
\t\t\t\t\t\t<div class=\"col\">
\t\t\t\t\t\t\t<div class=\"card text-center border border-3 border-secondary w-100\">
\t\t\t\t\t\t\t\t<form action=\"{{ path('cart.add', { idProduct: product.idProduct }) }}\" method=\"POST\">
\t\t\t\t\t\t\t\t\t<div id=\"viewProduct\">
\t\t\t\t\t\t\t\t\t\t<a class=\"product-modal text-decoration-none\" href=\"{{ path('product_modal', { idProduct: product.idProduct }) }}\">
\t\t\t\t\t\t\t\t\t\t\t<img name=\"imgProductImage\" src=\"{{ asset_if(product.imagePath, 'images/products/imageNotAvailable.png') }}\" style=\"width: 175px; height: 150px\" alt=\"Produit\">
\t\t\t\t\t\t\t\t\t\t\t<div class=\"card-body text-black\">
\t\t\t\t\t\t\t\t\t\t\t\t<span name=\"txtPoductName\" class=\"card-title fw-bold text-nowrap\">{{ product.name }}</span>
\t\t\t\t\t\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t\t\t\t\t\t<span name=\"txtProductPrice\" class=\"card-text\">{{ product.price|number_format(2,',','') }}
\t\t\t\t\t\t\t\t\t\t\t\t\t\$</span>
\t\t\t\t\t\t\t\t\t\t\t\t<br>
\t\t\t\t\t\t\t\t\t\t\t\t{% if product.rating == 0 %}
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t\t\t\t\t\t\t{% if product.rating == 0.5 %}
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t\t\t\t\t\t\t{% if product.rating == 1 %}
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t\t\t\t\t\t\t{% if product.rating == 1.5 %}
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t\t\t\t\t\t\t{% if product.rating == 2 %}
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t\t\t\t\t\t\t{% if product.rating == 2.5 %}
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t\t\t\t\t\t\t{% if product.rating == 3 %}
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t\t\t\t\t\t\t{% if product.rating == 3.5 %}
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t\t\t\t\t\t\t{% if product.rating == 4 %}
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t\t\t\t\t\t\t{% if product.rating == 4.5 %}
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t\t\t\t\t\t\t{% if product.rating == 5 %}
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t\t\t\t\t</a>
\t\t\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t\t\t\t<div class=\"card-footer border-0 bg-transparent\">
\t\t\t\t\t\t\t\t\t\t<button type=\"submit\" id=\"addToCartBtn\" class=\"m-2 p-2\">Ajouter au panier</button>
\t\t\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t\t\t</form>
\t\t\t\t\t\t\t</div>
\t\t\t\t\t\t</div>
\t\t\t\t\t\t{# Product card #}
\t\t\t\t\t{% endfor %}
\t\t\t\t</div>
\t\t\t{% else %}
\t\t\t\t<p class=\"display-6 mt-4\" id=\"txtRaleway\">Aucun produit dans cette catégorie.</p>
\t\t\t{% endif %}
\t\t</div>
\t\t{# Right section (catalog) #}
\t</section>
\t{# Middle section #}

\t{# Product modal #}
\t<div class=\"modal fade\" id=\"product-modal\" tabindex=\"-1\">
\t\t<div class=\"modal-dialog modal-dialog-centered\">
\t\t\t<div
\t\t\t\tid=\"product-modal-content\" class=\"modal-content\">{# Product content  #}
\t\t\t</div>
\t\t</div>
\t</div>
\t{# Product modal #}
{% endblock %}

{# Includes a style sheet #}
{% block stylesheets %}
\t<link rel=\"stylesheet\" href=\"{{ asset('styles/catalog.css') }}\">
{% endblock %}
{# Includes a style sheet #}

{% block javascripts %}
\t<script defer src=\"{{ asset('scripts/modal.product.js') }}\"></script>
{% endblock %}
", "catalog/catalog.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\catalog\\catalog.html.twig");
    }
}
