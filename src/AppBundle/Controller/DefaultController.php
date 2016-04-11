<?php

namespace AppBundle\Controller;

use AppBundle\Entity\User;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\RedirectResponse;

use Symfony\Component\Serializer\Serializer;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;


class DefaultController extends Controller
{
    /** @var  User */
    private $user;

    /**
     * @Route("/", name="homepage")
     */
    public function indexAction()
    {
        $this->initUser();
        $handler = $this->get('frontend.form_handlers.user')->setModel($this->user);

        $encoders = array(new JsonEncoder());
        $normalizers = array(new ObjectNormalizer());

        $serializer = new Serializer($normalizers, $encoders);
        
        return $this->render('default/index.html.twig', array(
            'form' => $handler->getBuiltFormView(),
            'user' => $serializer->serialize($this->user, 'json'),
        ));
    }


    /**
     * Handles user form ajax submission
     *
     * @return RedirectResponse|\Symfony\Component\HttpFoundation\Response
     *
     * @Route("/process-form", name="process.form", options={"expose"=true})
     */
    public function processFormAction()
    {
        $this->initUser();
        $handler = $this->get('frontend.form_handlers.user')->setModel($this->user);

        return $handler->handle();
    }

    /**
     * Inits current user
     */
    private function initUser()
    {
        $userRepo = $this->get('doctrine')->getRepository('AppBundle:User');
        $user = $userRepo->findOneBy(array('idToken' => '5dsf4dsf5sdf4'));
        if (!$user instanceof User) {
            throw $this->createNotFoundException('User not found, please load fixtures');
        }

        $this->user = $user;
    }
}
