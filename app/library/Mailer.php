<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Mailer.php 2016/4/11 20:10 $
 */
namespace YZOI;

use Phalcon\Mvc\User\Component;

require_once __DIR__ . '/SwiftMailer/swift_required.php';

class Mailer extends Component
{
    public function send($to, $subject, $content)
    {
        //Settings
        $mailSettings = $this->config->mailer;

        // Create the message
        $message = \Swift_Message::newInstance()
            ->setSubject($subject)
            ->setTo($to)
            ->setFrom(array(
                $mailSettings->smtp_username => $mailSettings->smtp_mainame
            ))
            ->setBody($content, 'text/html', 'utf-8');
        if (!$this->_transport) {
            $this->_transport = \Swift_SmtpTransport::newInstance($mailSettings->smtp_host)
                ->setUsername($mailSettings->smtp_username)
                ->setPassword($mailSettings->smtp_password);
        }
        // Create the Mailer using your created Transport
        $mailer = \Swift_Mailer::newInstance($this->_transport);
        return $mailer->send($message);
    }
}