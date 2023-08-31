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

/* catalog/product.modal.twig */
class __TwigTemplate_4ffeaa14ff6a168e7bc7a1427f3a7751 extends Template
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "catalog/product.modal.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "catalog/product.modal.twig"));

        // line 2
        echo "<div class=\"modal-body\">
\t<div class=\"card\">
\t\t<form action=\"";
        // line 4
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\RoutingExtension']->getPath("cart.add", ["idProduct" => twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 4, $this->source); })()), "idProduct", [], "any", false, false, false, 4)]), "html", null, true);
        echo "\" method=\"POST\">
\t\t\t<div class=\"text-center\">
\t\t\t\t<div>
\t\t\t\t\t<img src=\"";
        // line 7
        echo twig_escape_filter($this->env, $this->extensions['App\Twig\ConditionalAssetExtension']->asset_if(twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 7, $this->source); })()), "imagePath", [], "any", false, false, false, 7), "images/products/imageNotAvailable.png"), "html", null, true);
        echo "\" class=\"card-img-top\" style=\"width: 200px; height: 200px\" alt=\"Produit\">
\t\t\t\t\t<div class=\"card-body\">
\t\t\t\t\t\t<p class=\"card-title fs-5\">";
        // line 9
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 9, $this->source); })()), "name", [], "any", false, false, false, 9), "html", null, true);
        echo "</p>
\t\t\t\t\t\t<p class=\"card-text\">
\t\t\t\t\t\t\t<h1>";
        // line 11
        echo twig_escape_filter($this->env, twig_number_format_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 11, $this->source); })()), "price", [], "any", false, false, false, 11), 2, ",", ""), "html", null, true);
        echo "
\t\t\t\t\t\t\t\t\$</h1>
\t\t\t\t\t\t</p>
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<hr>
\t\t\t\t<div>
\t\t\t\t\t<span class=\"fs-1\">
\t\t\t\t\t\t";
        // line 19
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 19, $this->source); })()), "rating", [], "any", false, false, false, 19), "html", null, true);
        echo "
\t\t\t\t\t</span>
\t\t\t\t\t<br>
\t\t\t\t\t";
        // line 22
        if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 22, $this->source); })()), "rating", [], "any", false, false, false, 22) == 0)) {
            // line 23
            echo "\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t";
        }
        // line 29
        echo "\t\t\t\t\t";
        if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 29, $this->source); })()), "rating", [], "any", false, false, false, 29) == 0.5)) {
            // line 30
            echo "\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t";
        }
        // line 36
        echo "\t\t\t\t\t";
        if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 36, $this->source); })()), "rating", [], "any", false, false, false, 36) == 1)) {
            // line 37
            echo "\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t";
        }
        // line 43
        echo "\t\t\t\t\t";
        if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 43, $this->source); })()), "rating", [], "any", false, false, false, 43) == 1.5)) {
            // line 44
            echo "\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t";
        }
        // line 50
        echo "\t\t\t\t\t";
        if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 50, $this->source); })()), "rating", [], "any", false, false, false, 50) == 2)) {
            // line 51
            echo "\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t";
        }
        // line 57
        echo "\t\t\t\t\t";
        if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 57, $this->source); })()), "rating", [], "any", false, false, false, 57) == 2.5)) {
            // line 58
            echo "\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t";
        }
        // line 64
        echo "\t\t\t\t\t";
        if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 64, $this->source); })()), "rating", [], "any", false, false, false, 64) == 3)) {
            // line 65
            echo "\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t";
        }
        // line 71
        echo "\t\t\t\t\t";
        if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 71, $this->source); })()), "rating", [], "any", false, false, false, 71) == 3.5)) {
            // line 72
            echo "\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t";
        }
        // line 78
        echo "\t\t\t\t\t";
        if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 78, $this->source); })()), "rating", [], "any", false, false, false, 78) == 4)) {
            // line 79
            echo "\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t";
        }
        // line 85
        echo "\t\t\t\t\t";
        if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 85, $this->source); })()), "rating", [], "any", false, false, false, 85) == 4.5)) {
            // line 86
            echo "\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t";
        }
        // line 92
        echo "\t\t\t\t\t";
        if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 92, $this->source); })()), "rating", [], "any", false, false, false, 92) == 5)) {
            // line 93
            echo "\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t";
        }
        // line 99
        echo "\t\t\t\t\t<br>
\t\t\t\t\t<br>
\t\t\t\t\t<h5>";
        // line 101
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 101, $this->source); })()), "categoryName", [], "any", false, false, false, 101), "categoryName", [], "any", false, false, false, 101), "html", null, true);
        echo "</h5>
\t\t\t\t\t<p class=\"m-2\">";
        // line 102
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 102, $this->source); })()), "description", [], "any", false, false, false, 102), "html", null, true);
        echo "</p>
\t\t\t\t\t<h6 class=\"mt-4 mb-3\">Quantité en inventaire :
\t\t\t\t\t\t";
        // line 104
        echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 104, $this->source); })()), "quantityInStock", [], "any", false, false, false, 104), "html", null, true);
        echo "</h6>
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<button type=\"submit\" class=\"btn btn-warning w-100 border border-0 p-3 rounded-0 rounded-bottom\">Ajouter au panier</button>
\t\t</form>
\t</div>
</div>
";
        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

    }

    public function getTemplateName()
    {
        return "catalog/product.modal.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  213 => 104,  208 => 102,  204 => 101,  200 => 99,  192 => 93,  189 => 92,  181 => 86,  178 => 85,  170 => 79,  167 => 78,  159 => 72,  156 => 71,  148 => 65,  145 => 64,  137 => 58,  134 => 57,  126 => 51,  123 => 50,  115 => 44,  112 => 43,  104 => 37,  101 => 36,  93 => 30,  90 => 29,  82 => 23,  80 => 22,  74 => 19,  63 => 11,  58 => 9,  53 => 7,  47 => 4,  43 => 2,);
    }

    public function getSourceContext()
    {
        return new Source("{# Product modal content #}
<div class=\"modal-body\">
\t<div class=\"card\">
\t\t<form action=\"{{ path('cart.add', { idProduct: product.idProduct }) }}\" method=\"POST\">
\t\t\t<div class=\"text-center\">
\t\t\t\t<div>
\t\t\t\t\t<img src=\"{{ asset_if(product.imagePath, 'images/products/imageNotAvailable.png') }}\" class=\"card-img-top\" style=\"width: 200px; height: 200px\" alt=\"Produit\">
\t\t\t\t\t<div class=\"card-body\">
\t\t\t\t\t\t<p class=\"card-title fs-5\">{{ product.name }}</p>
\t\t\t\t\t\t<p class=\"card-text\">
\t\t\t\t\t\t\t<h1>{{ product.price | number_format(2,',','') }}
\t\t\t\t\t\t\t\t\$</h1>
\t\t\t\t\t\t</p>
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<hr>
\t\t\t\t<div>
\t\t\t\t\t<span class=\"fs-1\">
\t\t\t\t\t\t{{ product.rating }}
\t\t\t\t\t</span>
\t\t\t\t\t<br>
\t\t\t\t\t{% if product.rating == 0 %}
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t{% endif %}
\t\t\t\t\t{% if product.rating == 0.5 %}
\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t{% endif %}
\t\t\t\t\t{% if product.rating == 1 %}
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t{% endif %}
\t\t\t\t\t{% if product.rating == 1.5 %}
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t{% endif %}
\t\t\t\t\t{% if product.rating == 2 %}
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t{% endif %}
\t\t\t\t\t{% if product.rating == 2.5 %}
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t{% endif %}
\t\t\t\t\t{% if product.rating == 3 %}
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t{% endif %}
\t\t\t\t\t{% if product.rating == 3.5 %}
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t{% endif %}
\t\t\t\t\t{% if product.rating == 4 %}
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t{% endif %}
\t\t\t\t\t{% if product.rating == 4.5 %}
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t{% endif %}
\t\t\t\t\t{% if product.rating == 5 %}
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t{% endif %}
\t\t\t\t\t<br>
\t\t\t\t\t<br>
\t\t\t\t\t<h5>{{ product.categoryName.categoryName }}</h5>
\t\t\t\t\t<p class=\"m-2\">{{ product.description }}</p>
\t\t\t\t\t<h6 class=\"mt-4 mb-3\">Quantité en inventaire :
\t\t\t\t\t\t{{ product.quantityInStock }}</h6>
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<button type=\"submit\" class=\"btn btn-warning w-100 border border-0 p-3 rounded-0 rounded-bottom\">Ajouter au panier</button>
\t\t</form>
\t</div>
</div>
{# Product modal content #}
", "catalog/product.modal.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\catalog\\product.modal.twig");
    }
}
