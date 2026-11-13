<?php

namespace App\Twig;

use Symfony\Component\Asset\Packages;
use Symfony\Component\HttpKernel\KernelInterface;
use Twig\Extension\AbstractExtension;
use Twig\TwigFunction;

class ConditionalAssetExtension extends AbstractExtension
{
    private Packages $packages;
    private KernelInterface $kernel;

    public function __construct(Packages $packages, KernelInterface $kernel)
    {
        $this->packages = $packages;
        $this->kernel = $kernel;
    }

    public function getFunctions()
    {
        //Returns the functions created in the file
        return [
            new TwigFunction('asset_if', [$this, 'asset_if'])
        ];
    }

    //Extension function for the whole application
    public function asset_if($path, $fallbackPath, $packageName = null)
    {
        //Check if the path exists
        $pathToCheck = realpath($this->kernel->getProjectDir() . '/public') . '/' . $path;

        if (!file_exists($pathToCheck) || $path == null) {
            //Returns an alternate path
            return $this->packages->getUrl($fallbackPath, $packageName);
        }

        //Return the desired path
        return $this->packages->getUrl($path, $packageName);
    }
}
