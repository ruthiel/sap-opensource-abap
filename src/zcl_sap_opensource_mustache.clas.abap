CLASS zcl_sap_opensource_mustache DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES:
      BEGIN OF ty_beer_type,
        name TYPE string,
        abv  TYPE p LENGTH 2 DECIMALS 1,
      END OF ty_beer_type,

      ty_beer_type_tt TYPE STANDARD TABLE OF ty_beer_type WITH DEFAULT KEY,

      BEGIN OF ty_beer,
        Beer_type TYPE string,
        items     TYPE ty_beer_type_tt,
      END OF ty_beer.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA list_of_beers TYPE STANDARD TABLE OF ty_beer WITH DEFAULT KEY.
    DATA o_mustache TYPE REF TO zcl_mustache.

ENDCLASS.



CLASS zcl_sap_opensource_mustache IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    list_of_beers =
        VALUE #( ( beer_type = `Lager`
                   items     = VALUE #( ( name = `Pilsner`     abv = `5.0` )
                                        ( name = `Oktoberfest` abv = `6.0` )
                                        ( name = `Bock`        abv = `7.0` )
                                        ( name = `Dunkel`      abv = `5.0` ) ) )
                 ( beer_type = `Ale`
                   items     = VALUE #( ( name = `Porter`    abv = `6.5` )
                                        ( name = `Stout`     abv = `6.0` )
                                        ( name = `Amber`     abv = `6.0` )
                                        ( name = `Irish Ale` abv = `5.0` )
                                        ( name = `Pale Ale`  abv = `5.0` )
                                        ( name = `IPA`       abv = `6.5` ) ) ) ).

    TRY.
        o_mustache = zcl_mustache=>create(
          `List of types of Beer!`      && cl_abap_char_utilities=>newline &&
                                           cl_abap_char_utilities=>newline &&
          `{{beer_type}}`               && cl_abap_char_utilities=>newline &&
          `{{#items}}`                  && cl_abap_char_utilities=>newline &&
          `-> {{name}} (ABV: {{abv}}%)` && cl_abap_char_utilities=>newline &&
          `{{/items}}` ).

        out->write( o_mustache->render( list_of_beers ) ).

      CATCH zcx_mustache_error INTO DATA(o_exception).
        out->write( o_exception->get_text( ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
