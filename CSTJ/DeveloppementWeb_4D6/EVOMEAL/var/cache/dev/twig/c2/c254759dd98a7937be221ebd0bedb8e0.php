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

/* core/footer.html.twig */
class __TwigTemplate_7574524deeb733206d1a50769ffb75bb extends Template
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
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->enter($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "core/footer.html.twig"));

        $__internal_6f47bbe9983af81f1e7450e9a3e3768f = $this->extensions["Symfony\\Bridge\\Twig\\Extension\\ProfilerExtension"];
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->enter($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof = new \Twig\Profiler\Profile($this->getTemplateName(), "template", "core/footer.html.twig"));

        // line 1
        echo "<div
\tclass=\"bg-dark text-white row text-center p-4\">
\t";
        // line 4
        echo "\t<section>
\t\t<div class=\"col-auto py-2\">
\t\t\t<a class=\"btn btn-floating border border-0\" role=\"button\" href=\"mailto:1875009@cstj.qc.ca\" target=\"_blank\">
\t\t\t\t<img class=\"w-50\" src=\"";
        // line 7
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("icons/outlook.png"), "html", null, true);
        echo "\" title=\"Outlook\">
\t\t\t</a>
\t\t</div>
\t\t<hr>
\t</section>
\t";
        // line 13
        echo "\t";
        // line 14
        echo "\t<section class=\"d-flex justify-content-center\">
\t\t<div class=\"col-lg-4 col-md-7\">
\t\t\t<h4 class=\"text-uppercase my-3\">Olivier Bourgault (1875009)</h4>
\t\t\t<div>
\t\t\t\t<ul class=\"list-unstyled\">
\t\t\t\t\t<li>
\t\t\t\t\t\t<p>Étudiant en
\t\t\t\t\t\t\t<a href=\"https://www.cstj.qc.ca/programmes/techniques-de-linformatique/\" target=\"_blank\" class=\"text-white\">techniques de l'informatique</a>
\t\t\t\t\t\t\t<br>au Cégep de Saint-Jérôme.</p>
\t\t\t\t\t</li>
\t\t\t\t\t<li>
\t\t\t\t\t\t<a href=\"https://www.cstj.qc.ca/\" target=\"_blank\"><img class=\"shadow-lg p-3 bg-body rounded\" src=\"";
        // line 25
        echo twig_escape_filter($this->env, $this->extensions['Symfony\Bridge\Twig\Extension\AssetExtension']->getAssetUrl("images/companiesLogos/cstjLogo.png"), "html", null, true);
        echo "\" title=\"Cégep de Saint-Jérôme\"></a>
\t\t\t\t\t</li>
\t\t\t\t\t<li>
\t\t\t\t\t\t<p class=\"my-3\">Ce site à été produit dans un cadre pédagogique pour un cours. Les produits affichés ne sont pas disponibles à l'achat. Il s'agit d'un commerce fictif.</p>
\t\t\t\t\t</li>
\t\t\t\t</ul>
\t\t\t</div>
\t\t</div>
\t</section>
\t";
        // line 35
        echo "\t";
        // line 36
        echo "\t<div class=\"bg-black text-center p-3\">
\t\t©EVOMEAL - 2023
\t</div>
\t";
        // line 40
        echo "</div>
";
        
        $__internal_5a27a8ba21ca79b61932376b2fa922d2->leave($__internal_5a27a8ba21ca79b61932376b2fa922d2_prof);

        
        $__internal_6f47bbe9983af81f1e7450e9a3e3768f->leave($__internal_6f47bbe9983af81f1e7450e9a3e3768f_prof);

    }

    public function getTemplateName()
    {
        return "core/footer.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  94 => 40,  89 => 36,  87 => 35,  75 => 25,  62 => 14,  60 => 13,  52 => 7,  47 => 4,  43 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("<div
\tclass=\"bg-dark text-white row text-center p-4\">
\t{# Top section #}
\t<section>
\t\t<div class=\"col-auto py-2\">
\t\t\t<a class=\"btn btn-floating border border-0\" role=\"button\" href=\"mailto:1875009@cstj.qc.ca\" target=\"_blank\">
\t\t\t\t<img class=\"w-50\" src=\"{{ asset('icons/outlook.png') }}\" title=\"Outlook\">
\t\t\t</a>
\t\t</div>
\t\t<hr>
\t</section>
\t{# Top section #}
\t{# Middle section #}
\t<section class=\"d-flex justify-content-center\">
\t\t<div class=\"col-lg-4 col-md-7\">
\t\t\t<h4 class=\"text-uppercase my-3\">Olivier Bourgault (1875009)</h4>
\t\t\t<div>
\t\t\t\t<ul class=\"list-unstyled\">
\t\t\t\t\t<li>
\t\t\t\t\t\t<p>Étudiant en
\t\t\t\t\t\t\t<a href=\"https://www.cstj.qc.ca/programmes/techniques-de-linformatique/\" target=\"_blank\" class=\"text-white\">techniques de l'informatique</a>
\t\t\t\t\t\t\t<br>au Cégep de Saint-Jérôme.</p>
\t\t\t\t\t</li>
\t\t\t\t\t<li>
\t\t\t\t\t\t<a href=\"https://www.cstj.qc.ca/\" target=\"_blank\"><img class=\"shadow-lg p-3 bg-body rounded\" src=\"{{ asset('images/companiesLogos/cstjLogo.png') }}\" title=\"Cégep de Saint-Jérôme\"></a>
\t\t\t\t\t</li>
\t\t\t\t\t<li>
\t\t\t\t\t\t<p class=\"my-3\">Ce site à été produit dans un cadre pédagogique pour un cours. Les produits affichés ne sont pas disponibles à l'achat. Il s'agit d'un commerce fictif.</p>
\t\t\t\t\t</li>
\t\t\t\t</ul>
\t\t\t</div>
\t\t</div>
\t</section>
\t{# Middle section #}
\t{# Bottom section #}
\t<div class=\"bg-black text-center p-3\">
\t\t©EVOMEAL - 2023
\t</div>
\t{# Bottom section #}
</div>
", "core/footer.html.twig", "C:\\Users\\olivi\\Documents\\GitHub\\travaux-pratiques-Olivier1875009\\templates\\core\\footer.html.twig");
    }
}
