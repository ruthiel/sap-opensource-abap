CLASS zcl_abap2ui5_week2 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ABAP2UI5_WEEK2 IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    z2ui5_cl_http_handler=>client = VALUE #(
          t_header = request->get_header_fields( )
          t_param  = request->get_form_fields( )
          body     = request->get_text( ) ).

    DATA(lv_resp) = SWITCH #( request->get_method( )
       WHEN 'GET'  THEN z2ui5_cl_http_handler=>http_get( )
       WHEN 'POST' THEN z2ui5_cl_http_handler=>http_post( ) ).

    response->set_status( 200 )->set_text( lv_resp ).

  ENDMETHOD.
ENDCLASS.
