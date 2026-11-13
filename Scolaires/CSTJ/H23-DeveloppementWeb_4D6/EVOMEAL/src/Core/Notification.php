<?php

namespace App\Core;

class Notification
{
    private $priority;
    private $content;
    private $color;

    public function __construct($priority, $content, $color = NotificationColor::WARNING)
    {
        $this->priority = $priority;
        $this->content = $content;
        $this->color = $color;
    }

    public function getPriority()
    {
        return $this->priority;
    }

    public function getContent()
    {
        return $this->content;
    }

    public function getColor()
    {
        return $this->color;
    }
}

abstract class NotificationColor
{
    public const PRIMARY = "text-primary";
    public const SECONDARY = "text-secondary";
    public const SUCCESS = "text-success";
    public const DANGER = "text-danger";
    public const WARNING = "text-warning";
    public const INFO = "text-info";
    public const LIGHT = "text-light";
    public const DARK = "text-dark";
}
