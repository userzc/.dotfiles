Feature: get-link-and-description-references
  In order to generate a Word report from my org notes
  As a user
  I want to get link and description for the references

  Scenario: Mixed references
    Given I am in buffer "org-doc-sample.org"
    When I insert:
    """
    * Verificación de datos

      En una primera instancia el programa pidió verificar la dirección de
      correo electrónico: se proporcionó la dirección del trabajo
      =rene.zurita@societao.com=, sin embargo no parece que utilice esa
      dirección de correo para la sincronización de calendarios. El iphone
      utiliza el calendario asociado a la cuenta *ICloud*:
      =veureka@icloud.com=. Este pase parece crear una cuenta de *Timeful*
      asociando el correo provisto a la cuenta.

    * Funcionalidades

    ** Sincronización con calendarios en cuentas de correo

       [[http://www.timeful.com/][Timeful]] se sincroniza con los calendarios que están declarados en
       el teléfono, como los pertenecientes a [[https://www.icloud.com/][iCloud]] o de algún otro
       proveedor como [[https://www.google.com.mx][Google]], esta sincronización permite hacer
       modificaciones en la interfaz web que son reflejadas en la interfaz
       del iphone y viceversa. Esta funcionalidad permite que otros
       dispositivos que no son compatibles con *Timeful* puedan ver las
       sugerencias para programar eventos que realiza.

    ** Vistas de Calendarios

       Para poder visualizar la información con la que se trabaja, se
       tienen principalmente dos vistas: una de calendario y otra donde se
       listan los TODOs o hábitos.

       #+CAPTION: Vista de Calendario (Vacío)
       #+NAME: fig:VistaCalendarioVacio
       #+attr_html: :width 400px :height 400px
       [[./CapturasDePantalla/VistaCalendario.PNG]]


       #+CAPTION: Vista de Calendario con Hábito y TODO
       #+NAME: fig:VistaCalendarioHábitoTODO
       #+attr_html: :width 400px :height 400px
       [[./CapturasDePantalla/DíaConHábitoYTODO.PNG]]

    """

    And I go to word "Vistas"
    And I start an action chain
    And I press "M-x"
    And I type "org-get-references-used"
    And I execute the action chain

    Then I should see pattern:
    """
    * Referencias

    - [0-9]\{4\}.[0-9]\{2\}.[0-9]\{2\}, Timeful

      http://www.timeful.com/

    - [0-9]\{4\}.[0-9]\{2\}.[0-9]\{2\}, iCloud

      https://www.icloud.com/

    - [0-9]\{4\}.[0-9]\{2\}.[0-9]\{2\}, Google

      https://www.google.com.mx
    """
