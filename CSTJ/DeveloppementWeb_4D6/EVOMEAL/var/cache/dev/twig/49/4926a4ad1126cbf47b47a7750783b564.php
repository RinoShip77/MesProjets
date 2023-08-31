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

/* admin/product/product.html.twig */
class __TwigTemplate_ad44c275c0377f023fd11f6934adabe5 extends Template
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "admin/product/product.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "admin/product/product.html.twig"));

        // line 2
        if (array_key_exists("add_product_form", $context)) {
            // line 3
            $this->env->getRuntime("Symfony\\Component\\Form\\FormRenderer")->setTheme((isset($context["add_product_form"]) || array_key_exists("add_product_form", $context) ? $context["add_product_form"] : (function () { throw new RuntimeError('Variable "add_product_form" does not exist.', 3, $this->source); })()), [0 => "bootstrap_5_layout.html.twig"], true);
        }
        // line 5
        if (array_key_exists("modify_product_form", $context)) {
            // line 6
            $this->env->getRuntime("Symfony\\Component\\Form\\FormRenderer")->setTheme((isset($context["modify_product_form"]) || array_key_exists("modify_product_form", $context) ? $context["modify_product_form"] : (function () { throw new RuntimeError('Variable "modify_product_form" does not exist.', 6, $this->source); })()), [0 => "bootstrap_5_layout.html.twig"], true);
        }
        // line 1
        $this->parent = $this->loadTemplate("core/base.html.twig", "admin/product/product.html.twig", 1);
        $this->parent->display($context, array_merge($this->blocks, $blocks));
        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

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
        echo "\t";
        $context['_parent'] = $context;
        $context['_seq'] = twig_ensure_traversable(twig_get_attribute($this->env, $this->source, (isset($context["app"]) || array_key_exists("app", $context) ? $context["app"] : (function () { throw new RuntimeError('Variable "app" does not exist.', 10, $this->source); })()), "flashes", [0 => "product_update"], "method", false, false, false, 10));
        foreach ($context['_seq'] as $context["_key"] => $context["flash"]) {
            // line 11
            echo "\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center bg-dark rounded ";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "color", [], "any", false, false, false, 11), "html", null, true);
            echo "\">";
            echo twig_escape_filter($this->env, twig_get_attribute($this->env, $this->source, $context["flash"], "content", [], "any", false, false, false, 11), "html", null, true);
            echo "</div>
\t";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['flash'], $context['_parent'], $context['loop']);
        $context = array_intersect_key($context, $_parent) + $_parent;
        // line 13
        echo "\t<div class=\"mx-auto py-5 w-75\">
\t\t";
        // line 14
        if (array_key_exists("add_product_form", $context)) {
            // line 15
            echo "\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-circle-plus me-2\"></i>
\t\t\t\tAjouter un nouveau produit
\t\t\t</p>
\t\t\t";
            // line 19
            echo             $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderBlock((isset($context["add_product_form"]) || array_key_exists("add_product_form", $context) ? $context["add_product_form"] : (function () { throw new RuntimeError('Variable "add_product_form" does not exist.', 19, $this->source); })()), 'form_start');
            echo "
\t\t\t\t<div class=\"row\">
\t\t\t\t\t<div class=\"col-5\">
\t\t\t\t\t\t";
            // line 22
            echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["add_product_form"]) || array_key_exists("add_product_form", $context) ? $context["add_product_form"] : (function () { throw new RuntimeError('Variable "add_product_form" does not exist.', 22, $this->source); })()), "name", [], "any", false, false, false, 22), 'row');
            echo "
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-3\">
\t\t\t\t\t\t";
            // line 25
            echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["add_product_form"]) || array_key_exists("add_product_form", $context) ? $context["add_product_form"] : (function () { throw new RuntimeError('Variable "add_product_form" does not exist.', 25, $this->source); })()), "categoryName", [], "any", false, false, false, 25), 'row');
            echo "
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-2\">
\t\t\t\t\t\t";
            // line 28
            echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["add_product_form"]) || array_key_exists("add_product_form", $context) ? $context["add_product_form"] : (function () { throw new RuntimeError('Variable "add_product_form" does not exist.', 28, $this->source); })()), "price", [], "any", false, false, false, 28), 'row');
            echo "
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-2\">
\t\t\t\t\t\t";
            // line 31
            echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["add_product_form"]) || array_key_exists("add_product_form", $context) ? $context["add_product_form"] : (function () { throw new RuntimeError('Variable "add_product_form" does not exist.', 31, $this->source); })()), "quantityInStock", [], "any", false, false, false, 31), 'row');
            echo "
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t";
            // line 34
            echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["add_product_form"]) || array_key_exists("add_product_form", $context) ? $context["add_product_form"] : (function () { throw new RuntimeError('Variable "add_product_form" does not exist.', 34, $this->source); })()), "description", [], "any", false, false, false, 34), 'row');
            echo "
\t\t\t\t<div class=\"row d-flex justify-content-between align-items-center\">
\t\t\t\t\t<div class=\"col-7 me-5\">
\t\t\t\t\t\t";
            // line 37
            echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["add_product_form"]) || array_key_exists("add_product_form", $context) ? $context["add_product_form"] : (function () { throw new RuntimeError('Variable "add_product_form" does not exist.', 37, $this->source); })()), "imagePath", [], "any", false, false, false, 37), 'row');
            echo "
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-3\">
\t\t\t\t\t\t<img src=\"";
            // line 40
            echo twig_escape_filter($this->env, $this->extensions['App\Twig\ConditionalAssetExtension']->asset_if(twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 40, $this->source); })()), "imagePath", [], "any", false, false, false, 40), "images/products/imageNotAvailable.png"), "html", null, true);
            echo "\" class=\"mt-3 d-block img-thumbnail\" style=\"width: 175px; height: 150px\" alt=\"Image du produit\">
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<div class=\"row d-flex justify-content-center\">
\t\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t\t";
            // line 45
            echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["add_product_form"]) || array_key_exists("add_product_form", $context) ? $context["add_product_form"] : (function () { throw new RuntimeError('Variable "add_product_form" does not exist.', 45, $this->source); })()), "rating", [], "any", false, false, false, 45), 'row');
            echo "
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-3 ms-5 my-auto\">
\t\t\t\t\t\t";
            // line 48
            if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 48, $this->source); })()), "rating", [], "any", false, false, false, 48) == 0)) {
                // line 49
                echo "\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
            }
            // line 55
            echo "\t\t\t\t\t\t";
            if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 55, $this->source); })()), "rating", [], "any", false, false, false, 55) == 0.5)) {
                // line 56
                echo "\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
            }
            // line 62
            echo "\t\t\t\t\t\t";
            if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 62, $this->source); })()), "rating", [], "any", false, false, false, 62) == 1)) {
                // line 63
                echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
            }
            // line 69
            echo "\t\t\t\t\t\t";
            if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 69, $this->source); })()), "rating", [], "any", false, false, false, 69) == 1.5)) {
                // line 70
                echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
            }
            // line 76
            echo "\t\t\t\t\t\t";
            if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 76, $this->source); })()), "rating", [], "any", false, false, false, 76) == 2)) {
                // line 77
                echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
            }
            // line 83
            echo "\t\t\t\t\t\t";
            if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 83, $this->source); })()), "rating", [], "any", false, false, false, 83) == 2.5)) {
                // line 84
                echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
            }
            // line 90
            echo "\t\t\t\t\t\t";
            if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 90, $this->source); })()), "rating", [], "any", false, false, false, 90) == 3)) {
                // line 91
                echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
            }
            // line 97
            echo "\t\t\t\t\t\t";
            if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 97, $this->source); })()), "rating", [], "any", false, false, false, 97) == 3.5)) {
                // line 98
                echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
            }
            // line 104
            echo "\t\t\t\t\t\t";
            if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 104, $this->source); })()), "rating", [], "any", false, false, false, 104) == 4)) {
                // line 105
                echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
            }
            // line 111
            echo "\t\t\t\t\t\t";
            if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 111, $this->source); })()), "rating", [], "any", false, false, false, 111) == 4.5)) {
                // line 112
                echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t";
            }
            // line 118
            echo "\t\t\t\t\t\t";
            if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 118, $this->source); })()), "rating", [], "any", false, false, false, 118) == 5)) {
                // line 119
                echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t";
            }
            // line 125
            echo "\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<div class=\"d-flex justify-content-center m-3\">
\t\t\t\t\t";
            // line 128
            echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["add_product_form"]) || array_key_exists("add_product_form", $context) ? $context["add_product_form"] : (function () { throw new RuntimeError('Variable "add_product_form" does not exist.', 128, $this->source); })()), "save", [], "any", false, false, false, 128), 'row', ["attr" => ["class" => "btn-outline-warning fs-4"]]);
            echo "
\t\t\t\t</div>
\t\t\t\t";
            // line 130
            echo             $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderBlock((isset($context["add_product_form"]) || array_key_exists("add_product_form", $context) ? $context["add_product_form"] : (function () { throw new RuntimeError('Variable "add_product_form" does not exist.', 130, $this->source); })()), 'form_end');
            echo "
\t\t";
        } else {
            // line 132
            echo "\t\t\t";
            if (array_key_exists("modify_product_form", $context)) {
                // line 133
                echo "\t\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t\t<i class=\"fas fa-box me-2\"></i>
\t\t\t\t\tModifier le produit
\t\t\t\t</p>
\t\t\t\t";
                // line 137
                echo                 $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderBlock((isset($context["modify_product_form"]) || array_key_exists("modify_product_form", $context) ? $context["modify_product_form"] : (function () { throw new RuntimeError('Variable "modify_product_form" does not exist.', 137, $this->source); })()), 'form_start');
                echo "
\t\t\t\t<div class=\"row\">
\t\t\t\t\t<div class=\"col-5\">
\t\t\t\t\t\t";
                // line 140
                echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["modify_product_form"]) || array_key_exists("modify_product_form", $context) ? $context["modify_product_form"] : (function () { throw new RuntimeError('Variable "modify_product_form" does not exist.', 140, $this->source); })()), "name", [], "any", false, false, false, 140), 'row');
                echo "
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-3\">
\t\t\t\t\t\t";
                // line 143
                echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["modify_product_form"]) || array_key_exists("modify_product_form", $context) ? $context["modify_product_form"] : (function () { throw new RuntimeError('Variable "modify_product_form" does not exist.', 143, $this->source); })()), "categoryName", [], "any", false, false, false, 143), 'row');
                echo "
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-2\">
\t\t\t\t\t\t";
                // line 146
                echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["modify_product_form"]) || array_key_exists("modify_product_form", $context) ? $context["modify_product_form"] : (function () { throw new RuntimeError('Variable "modify_product_form" does not exist.', 146, $this->source); })()), "price", [], "any", false, false, false, 146), 'row');
                echo "
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-2\">
\t\t\t\t\t\t";
                // line 149
                echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["modify_product_form"]) || array_key_exists("modify_product_form", $context) ? $context["modify_product_form"] : (function () { throw new RuntimeError('Variable "modify_product_form" does not exist.', 149, $this->source); })()), "quantityInStock", [], "any", false, false, false, 149), 'row');
                echo "
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t";
                // line 152
                echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["modify_product_form"]) || array_key_exists("modify_product_form", $context) ? $context["modify_product_form"] : (function () { throw new RuntimeError('Variable "modify_product_form" does not exist.', 152, $this->source); })()), "description", [], "any", false, false, false, 152), 'row');
                echo "
\t\t\t\t<div class=\"row d-flex justify-content-between align-items-center\">
\t\t\t\t\t<div class=\"col-7 me-5\">
\t\t\t\t\t\t";
                // line 155
                echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["modify_product_form"]) || array_key_exists("modify_product_form", $context) ? $context["modify_product_form"] : (function () { throw new RuntimeError('Variable "modify_product_form" does not exist.', 155, $this->source); })()), "imagePath", [], "any", false, false, false, 155), 'row');
                echo "
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-3\">
\t\t\t\t\t\t<img src=\"";
                // line 158
                echo twig_escape_filter($this->env, $this->extensions['App\Twig\ConditionalAssetExtension']->asset_if(twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 158, $this->source); })()), "imagePath", [], "any", false, false, false, 158), "images/products/imageNotAvailable.png"), "html", null, true);
                echo "\" class=\"mt-3 d-block img-thumbnail\" style=\"width: 175px; height: 150px\" alt=\"Image du produit\">
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<div class=\"row d-flex justify-content-center\">
\t\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t\t";
                // line 163
                echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["modify_product_form"]) || array_key_exists("modify_product_form", $context) ? $context["modify_product_form"] : (function () { throw new RuntimeError('Variable "modify_product_form" does not exist.', 163, $this->source); })()), "rating", [], "any", false, false, false, 163), 'row');
                echo "
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-3 ms-5 my-auto\">
\t\t\t\t\t\t";
                // line 166
                if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 166, $this->source); })()), "rating", [], "any", false, false, false, 166) == 0)) {
                    // line 167
                    echo "\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
                }
                // line 173
                echo "\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 173, $this->source); })()), "rating", [], "any", false, false, false, 173) == 0.5)) {
                    // line 174
                    echo "\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
                }
                // line 180
                echo "\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 180, $this->source); })()), "rating", [], "any", false, false, false, 180) == 1)) {
                    // line 181
                    echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
                }
                // line 187
                echo "\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 187, $this->source); })()), "rating", [], "any", false, false, false, 187) == 1.5)) {
                    // line 188
                    echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
                }
                // line 194
                echo "\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 194, $this->source); })()), "rating", [], "any", false, false, false, 194) == 2)) {
                    // line 195
                    echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
                }
                // line 201
                echo "\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 201, $this->source); })()), "rating", [], "any", false, false, false, 201) == 2.5)) {
                    // line 202
                    echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
                }
                // line 208
                echo "\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 208, $this->source); })()), "rating", [], "any", false, false, false, 208) == 3)) {
                    // line 209
                    echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
                }
                // line 215
                echo "\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 215, $this->source); })()), "rating", [], "any", false, false, false, 215) == 3.5)) {
                    // line 216
                    echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
                }
                // line 222
                echo "\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 222, $this->source); })()), "rating", [], "any", false, false, false, 222) == 4)) {
                    // line 223
                    echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t";
                }
                // line 229
                echo "\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 229, $this->source); })()), "rating", [], "any", false, false, false, 229) == 4.5)) {
                    // line 230
                    echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t";
                }
                // line 236
                echo "\t\t\t\t\t\t";
                if ((twig_get_attribute($this->env, $this->source, (isset($context["product"]) || array_key_exists("product", $context) ? $context["product"] : (function () { throw new RuntimeError('Variable "product" does not exist.', 236, $this->source); })()), "rating", [], "any", false, false, false, 236) == 5)) {
                    // line 237
                    echo "\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t";
                }
                // line 243
                echo "\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<div class=\"d-flex justify-content-center m-3\">
\t\t\t\t\t";
                // line 246
                echo $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->searchAndRenderBlock(twig_get_attribute($this->env, $this->source, (isset($context["modify_product_form"]) || array_key_exists("modify_product_form", $context) ? $context["modify_product_form"] : (function () { throw new RuntimeError('Variable "modify_product_form" does not exist.', 246, $this->source); })()), "save", [], "any", false, false, false, 246), 'row', ["attr" => ["class" => "btn-outline-warning fs-4"]]);
                echo "
\t\t\t\t</div>
\t\t\t\t";
                // line 248
                echo                 $this->env->getRuntime('Symfony\Component\Form\FormRenderer')->renderBlock((isset($context["modify_product_form"]) || array_key_exists("modify_product_form", $context) ? $context["modify_product_form"] : (function () { throw new RuntimeError('Variable "modify_product_form" does not exist.', 248, $this->source); })()), 'form_end');
                echo "
\t\t\t";
            }
            // line 250
            echo "\t\t";
        }
        // line 251
        echo "\t</div>
";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    public function getTemplateName()
    {
        return "admin/product/product.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  500 => 251,  497 => 250,  492 => 248,  487 => 246,  482 => 243,  474 => 237,  471 => 236,  463 => 230,  460 => 229,  452 => 223,  449 => 222,  441 => 216,  438 => 215,  430 => 209,  427 => 208,  419 => 202,  416 => 201,  408 => 195,  405 => 194,  397 => 188,  394 => 187,  386 => 181,  383 => 180,  375 => 174,  372 => 173,  364 => 167,  362 => 166,  356 => 163,  348 => 158,  342 => 155,  336 => 152,  330 => 149,  324 => 146,  318 => 143,  312 => 140,  306 => 137,  300 => 133,  297 => 132,  292 => 130,  287 => 128,  282 => 125,  274 => 119,  271 => 118,  263 => 112,  260 => 111,  252 => 105,  249 => 104,  241 => 98,  238 => 97,  230 => 91,  227 => 90,  219 => 84,  216 => 83,  208 => 77,  205 => 76,  197 => 70,  194 => 69,  186 => 63,  183 => 62,  175 => 56,  172 => 55,  164 => 49,  162 => 48,  156 => 45,  148 => 40,  142 => 37,  136 => 34,  130 => 31,  124 => 28,  118 => 25,  112 => 22,  106 => 19,  100 => 15,  98 => 14,  95 => 13,  84 => 11,  79 => 10,  69 => 9,  58 => 1,  55 => 6,  53 => 5,  50 => 3,  48 => 2,  35 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("{% extends 'core/base.html.twig' %}
{% if add_product_form is defined %}
\t{% form_theme add_product_form 'bootstrap_5_layout.html.twig' %}
{% endif %}
{% if modify_product_form is defined %}
\t{% form_theme modify_product_form 'bootstrap_5_layout.html.twig' %}
{% endif %}

{% block body %}
\t{% for flash in app.flashes('product_update') %}
\t\t<div class=\"fs-3 fw-bold fst-italic m-3 p-3 text-center bg-dark rounded {{ flash.color }}\">{{ flash.content }}</div>
\t{% endfor %}
\t<div class=\"mx-auto py-5 w-75\">
\t\t{% if add_product_form is defined %}
\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t<i class=\"fas fa-circle-plus me-2\"></i>
\t\t\t\tAjouter un nouveau produit
\t\t\t</p>
\t\t\t{{ form_start(add_product_form) }}
\t\t\t\t<div class=\"row\">
\t\t\t\t\t<div class=\"col-5\">
\t\t\t\t\t\t{{ form_row(add_product_form.name) }}
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-3\">
\t\t\t\t\t\t{{ form_row(add_product_form.categoryName) }}
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-2\">
\t\t\t\t\t\t{{ form_row(add_product_form.price) }}
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-2\">
\t\t\t\t\t\t{{ form_row(add_product_form.quantityInStock) }}
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t{{ form_row(add_product_form.description) }}
\t\t\t\t<div class=\"row d-flex justify-content-between align-items-center\">
\t\t\t\t\t<div class=\"col-7 me-5\">
\t\t\t\t\t\t{{ form_row(add_product_form.imagePath) }}
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-3\">
\t\t\t\t\t\t<img src=\"{{ asset_if(product.imagePath, 'images/products/imageNotAvailable.png') }}\" class=\"mt-3 d-block img-thumbnail\" style=\"width: 175px; height: 150px\" alt=\"Image du produit\">
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<div class=\"row d-flex justify-content-center\">
\t\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t\t{{ form_row(add_product_form.rating) }}
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-3 ms-5 my-auto\">
\t\t\t\t\t\t{% if product.rating == 0 %}
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 0.5 %}
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 1 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 1.5 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 2 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 2.5 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 3 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 3.5 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 4 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 4.5 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 5 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<div class=\"d-flex justify-content-center m-3\">
\t\t\t\t\t{{ form_row(add_product_form.save, {'attr': {'class': 'btn-outline-warning fs-4' }}) }}
\t\t\t\t</div>
\t\t\t\t{{ form_end(add_product_form) }}
\t\t{% else %}
\t\t\t{% if modify_product_form is defined %}
\t\t\t\t<p class=\"h1 text-center mt-3 mb-4 pb-3\">
\t\t\t\t\t<i class=\"fas fa-box me-2\"></i>
\t\t\t\t\tModifier le produit
\t\t\t\t</p>
\t\t\t\t{{ form_start(modify_product_form) }}
\t\t\t\t<div class=\"row\">
\t\t\t\t\t<div class=\"col-5\">
\t\t\t\t\t\t{{ form_row(modify_product_form.name) }}
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-3\">
\t\t\t\t\t\t{{ form_row(modify_product_form.categoryName) }}
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-2\">
\t\t\t\t\t\t{{ form_row(modify_product_form.price) }}
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-2\">
\t\t\t\t\t\t{{ form_row(modify_product_form.quantityInStock) }}
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t{{ form_row(modify_product_form.description) }}
\t\t\t\t<div class=\"row d-flex justify-content-between align-items-center\">
\t\t\t\t\t<div class=\"col-7 me-5\">
\t\t\t\t\t\t{{ form_row(modify_product_form.imagePath) }}
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-3\">
\t\t\t\t\t\t<img src=\"{{ asset_if(product.imagePath, 'images/products/imageNotAvailable.png') }}\" class=\"mt-3 d-block img-thumbnail\" style=\"width: 175px; height: 150px\" alt=\"Image du produit\">
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<div class=\"row d-flex justify-content-center\">
\t\t\t\t\t<div class=\"col-4\">
\t\t\t\t\t\t{{ form_row(modify_product_form.rating) }}
\t\t\t\t\t</div>
\t\t\t\t\t<div class=\"col-3 ms-5 my-auto\">
\t\t\t\t\t\t{% if product.rating == 0 %}
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 0.5 %}
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 1 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 1.5 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 2 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 2.5 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 3 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 3.5 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 4 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 4.5 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"far fa-star-half-stroke text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t\t{% if product.rating == 5 %}
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t\t<i class=\"fas fa-star text-warning\"></i>
\t\t\t\t\t\t{% endif %}
\t\t\t\t\t</div>
\t\t\t\t</div>
\t\t\t\t<div class=\"d-flex justify-content-center m-3\">
\t\t\t\t\t{{ form_row(modify_product_form.save, {'attr': {'class': 'btn-outline-warning fs-4' }}) }}
\t\t\t\t</div>
\t\t\t\t{{ form_end(modify_product_form) }}
\t\t\t{% endif %}
\t\t{% endif %}
\t</div>
{% endblock %}
", "admin/product/product.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\admin\\product\\product.html.twig");
    }
}
