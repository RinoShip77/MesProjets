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

/* core/base.html.twig */
class __TwigTemplate_304019a6e2653c63bed5338a6478bd98 extends Template
{
    private $source;
    private $macros = [];

    public function __construct(Environment $env)
    {
        parent::__construct($env);

        $this->source = $this->getSourceContext();

        $this->parent = false;

        $this->blocks = [
            'stylesheets' => [$this, 'block_stylesheets'],
            'body' => [$this, 'block_body'],
            'javascripts' => [$this, 'block_javascripts'],
        ];
    }

    protected function doDisplay(array $context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "core/base.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "core/base.html.twig"));

        // line 1
        echo "<!DOCTYPE html>
<html>
\t<head>
\t\t<meta charset=\"UTF-8\">
\t\t<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
\t\t<meta
\t\tname=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
\t\t";
        // line 9
        echo "\t\t<title>EVOMEAL</title>
\t\t";
        // line 11
        echo "\t\t";
        // line 12
        echo "\t\t";
        // line 13
        echo "\t\t<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65\" crossorigin=\"anonymous\"> ";
        // line 14
        echo "\t\t";
        // line 15
        echo "\t\t<link rel=\"preconnect\" href=\"https://fonts.googleapis.com\"> <link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin>
\t\t<link href=\"https://fonts.googleapis.com/css2?family=Raleway:ital,wght@1,900&display=swap\" rel=\"stylesheet\">
\t\t";
        // line 18
        echo "\t\t";
        // line 19
        echo "\t\t<link rel=\"icon\" type=\"image/x-icon\" href=\"";
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("icons/favicon.ico"), "html", null, true);
        echo "\"> ";
        // line 20
        echo "\t\t";
        // line 21
        echo "\t\t<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css\" integrity=\"sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==\" crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\"/> ";
        // line 22
        echo "
\t\t";
        // line 24
        echo "\t\t<link rel=\"stylesheet\" href=\"";
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("styles/base.css"), "html", null, true);
        echo "\"> ";
        // line 25
        echo "
\t\t";
        // line 27
        echo "\t\t";
        // line 28
        echo "\t\t\t";
        $this->displayBlock('stylesheets', $context, $blocks);
        // line 31
        echo "\t\t";
        // line 32
        echo "\t</head>

\t<body
\t\tclass=\"container-fluid\">
\t\t";
        // line 37
        echo "\t\t";
        $this->loadTemplate("core/navbar.html.twig", "core/base.html.twig", 37)->display($context);
        // line 38
        echo "\t\t";
        // line 39
        echo "
\t\t";
        // line 40
        $this->displayBlock('body', $context, $blocks);
        // line 42
        echo "\t\t";
        // line 43
        echo "
\t\t";
        // line 44
        $this->loadTemplate("core/footer.html.twig", "core/base.html.twig", 44)->display($context);
        // line 45
        echo "\t\t";
        // line 46
        echo "
\t\t";
        // line 47
        echo "<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js\" integrity=\"sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4\" crossorigin=\"anonymous\"> </script>
\t\t";
        // line 49
        echo "\t\t";
        // line 50
        echo "\t\t<script src=\"https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js\" integrity=\"sha512-uMtXmF28A2Ab/JJO2t/vYhlaa/3ahUOgj1Zf27M5rOo8/+fcTUVH0/E0ll68njmjrLqOBjXM3V9NiPFL5ywWPQ==\" crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\"></script>
\t\t";
        // line 52
        echo "\t\t";
        // line 53
        echo "\t\t<script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js\" integrity=\"sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==\" crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\"></script>
\t\t";
        // line 55
        echo "\t\t";
        // line 56
        echo "\t\t<script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/0.9.0/jquery.mask.min.js\" integrity=\"sha512-oJCa6FS2+zO3EitUSj+xeiEN9UTr+AjqlBZO58OPadb2RfqwxHpjTU8ckIC8F4nKvom7iru2s8Jwdo+Z8zm0Vg==\" crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\"></script>
\t\t";
        // line 58
        echo "
\t\t";
        // line 60
        echo "\t\t";
        $this->displayBlock('javascripts', $context, $blocks);
        // line 63
        echo "\t\t";
        // line 64
        echo "\t</body>
</html>
";
        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

    }

    // line 28
    public function block_stylesheets($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "stylesheets"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "stylesheets"));

        // line 29
        echo "\t\t";
        echo twig_escape_filter($this->env, $this->env->getFunction('encore_entry_link_tags')->getCallable()("app"), "html", null, true);
        echo "
\t";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    // line 40
    public function block_body($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "body"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "body"));

        // line 41
        echo "\t\t";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    // line 60
    public function block_javascripts($context, array $blocks = [])
    {
        $macros = $this->macros;
        $__internal_5a27a8ba21ca79b61932376b2fa922d2 = $this->extensions["Symfony\\Bundle\\WebProfilerBundle\\Twig\\WebProfilerExtension"];
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "block", "javascripts"));

        // line 61
        echo "\t\t\t";
        echo twig_escape_filter($this->env, $this->env->getFunction('encore_entry_script_tags')->getCallable()("app"), "html", null, true);
        echo "
\t\t";
        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

    }

    public function getTemplateName()
    {
        return "core/base.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  216 => 61,  206 => 60,  196 => 41,  186 => 40,  173 => 29,  163 => 28,  151 => 64,  149 => 63,  146 => 60,  143 => 58,  140 => 56,  138 => 55,  135 => 53,  133 => 52,  130 => 50,  128 => 49,  125 => 47,  122 => 46,  120 => 45,  118 => 44,  115 => 43,  113 => 42,  111 => 40,  108 => 39,  106 => 38,  103 => 37,  97 => 32,  95 => 31,  92 => 28,  90 => 27,  87 => 25,  83 => 24,  80 => 22,  78 => 21,  76 => 20,  72 => 19,  70 => 18,  66 => 15,  64 => 14,  62 => 13,  60 => 12,  58 => 11,  55 => 9,  46 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("<!DOCTYPE html>
<html>
\t<head>
\t\t<meta charset=\"UTF-8\">
\t\t<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
\t\t<meta
\t\tname=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
\t\t{# Yannick - Correction #10 #}
\t\t<title>EVOMEAL</title>
\t\t{# I remove the 'TM' #}
\t\t{# Yannick - Correction #10 #}
\t\t{# Bootstrap: CSS #}
\t\t<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65\" crossorigin=\"anonymous\"> {# Bootstrap: CSS #}
\t\t{# Google Fonts : Raleway #}
\t\t<link rel=\"preconnect\" href=\"https://fonts.googleapis.com\"> <link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin>
\t\t<link href=\"https://fonts.googleapis.com/css2?family=Raleway:ital,wght@1,900&display=swap\" rel=\"stylesheet\">
\t\t{# Google Fonts : Raleway #}
\t\t{# Favico #}
\t\t<link rel=\"icon\" type=\"image/x-icon\" href=\"{{ asset('icons/favicon.ico') }}\"> {# Favico #}
\t\t{# Font-awesome #}
\t\t<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css\" integrity=\"sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==\" crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\"/> {# Font-awesome #}

\t\t{# Base CSS #}
\t\t<link rel=\"stylesheet\" href=\"{{ asset('styles/base.css') }}\"> {# Base CSS #}

\t\t{# Run `composer require symfony/webpack-encore-bundle` to start using Symfony UX #}
\t\t{# Block for style sheets #}
\t\t\t{% block stylesheets %}
\t\t{{ encore_entry_link_tags('app') }}
\t{% endblock %}
\t\t{# Block for style sheets #}
\t</head>

\t<body
\t\tclass=\"container-fluid\">
\t\t{# NavBar #}
\t\t{% include \"core/navbar.html.twig\" %}
\t\t{# NavBar #}

\t\t{# Page content #}{% block body %}
\t\t{% endblock %}
\t\t{# Page content #}

\t\t{# Footer #}{% include \"core/footer.html.twig\" %}
\t\t{# Footer #}

\t\t{# Bootstrap: JS #}<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js\" integrity=\"sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4\" crossorigin=\"anonymous\"> </script>
\t\t{# Bootstrap: JS #}
\t\t{# Axios: JS #}
\t\t<script src=\"https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js\" integrity=\"sha512-uMtXmF28A2Ab/JJO2t/vYhlaa/3ahUOgj1Zf27M5rOo8/+fcTUVH0/E0ll68njmjrLqOBjXM3V9NiPFL5ywWPQ==\" crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\"></script>
\t\t{# Axios: JS #}
\t\t{# JQuery: JS #}
\t\t<script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js\" integrity=\"sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==\" crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\"></script>
\t\t{# JQuery: JS #}
\t\t{# JQuery mask: JS #}
\t\t<script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/0.9.0/jquery.mask.min.js\" integrity=\"sha512-oJCa6FS2+zO3EitUSj+xeiEN9UTr+AjqlBZO58OPadb2RfqwxHpjTU8ckIC8F4nKvom7iru2s8Jwdo+Z8zm0Vg==\" crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\"></script>
\t\t{# JQuery mask: JS #}

\t\t{# Block for javascript sheets #}
\t\t{% block javascripts %}
\t\t\t{{ encore_entry_script_tags('app') }}
\t\t{% endblock %}
\t\t{# Block for javascript sheets #}
\t</body>
</html>
", "core/base.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\core\\base.html.twig");
    }
}
