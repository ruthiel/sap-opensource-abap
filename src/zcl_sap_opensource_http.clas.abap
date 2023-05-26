CLASS zcl_sap_opensource_http DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA user  TYPE string.
    DATA date TYPE string.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sap_opensource_http IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      user  = 'Ruthiel Trevisan'.
    ENDIF.

    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        client->popup_message_toast( |App executed on{ date } by { user }!| ).
      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-id_prev_app_stack  ) ).
    ENDCASE.

    client->set_next( VALUE #( xml_main = z2ui5_cl_xml_view=>factory(
        )->shell(
        )->page(
                title          = 'abap2UI5 - Ruthiel example'
                navbuttonpress = client->_event( 'BACK' )
                shownavbutton  = abap_true
            )->header_content(
                )->link(
                    text = 'Source_Code'
                    href = z2ui5_cl_xml_view=>hlp_get_source_code_url( app = me get = client->get( ) )
                    target = '_blank'
            )->get_parent(
            )->simple_form( title = 'Form Title'
                            editable = abap_true
                )->content( 'form'
                    )->title( 'Input'
                    )->label( 'User Name'
                    )->input( value = client->_bind( user )

                    )->label( 'Date'
                    )->date_picker( client->_bind( date )
                    )->input(
                        value   = date
                        enabled = abap_false
                    )->button(
                        text  = 'Post'
                        press = client->_event( 'BUTTON_POST' )
         )->get_root( )->xml_get( ) ) ).

  ENDMETHOD.
ENDCLASS.
