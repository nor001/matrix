CLASS zcleam_13_reporte_matriz DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF gty_sel,
        idmatriz                 TYPE ztbeam_12_matx_c-idmatriz,
        versio                   TYPE ztbeam_12_matx_c-versio,
        variant                  TYPE disvariant-variant,

        r_idmatriz_compare       TYPE RANGE OF ztbeam_12_matx_c-idmatriz,
        r_versio_compare         TYPE RANGE OF ztbeam_12_matx_c-versio,

        r_equnr                  TYPE RANGE OF equi-equnr,
        r_qmnum                  TYPE RANGE OF qmel-qmnum,
        r_eqart                  TYPE RANGE OF equi-eqart,
        r_tplnr                  TYPE RANGE OF iloa-tplnr,
        r_begru                  TYPE RANGE OF equi-begru,
        r_ingrp                  TYPE RANGE OF equz-ingrp,
        r_stort                  TYPE RANGE OF iloa-stort,
        r_zzlotedeenvio          TYPE RANGE OF aufk-zzlotedeenvio,

        crear_o_actualizar_aviso TYPE abap_bool,
      END OF gty_sel.

    TYPES:
      BEGIN OF gty_crear_orden,
        add_eqfnr_in_ktext TYPE xfeld,
        add_tidnr_in_ktext TYPE xfeld,
        add_equnr_in_ktext TYPE xfeld,
        ingrp              TYPE equz-ingrp,
        zzpep              TYPE aufk-zzpep,
        gstrp              TYPE afko-gstrp,
        gltrp              TYPE afko-gltrp,
        responsable        TYPE ihpa-parnr,
        contratista        TYPE ihpa-parnr,
        zzlotedeenvio      TYPE aufk-zzlotedeenvio,
        liberar            TYPE xfeld,
      END OF gty_crear_orden.

    TYPES:
      BEGIN OF gty_modif_campos_masiva_ord,
        plnnr1 TYPE plkz-plnnr,
        plnal1 TYPE plkz-plnal,
        aufkt1 TYPE plpo-aufkt,
        plnnr2 TYPE plkz-plnnr,
        plnal2 TYPE plkz-plnal,
        aufkt2 TYPE plpo-aufkt,
        plnnr3 TYPE plkz-plnnr,
        plnal3 TYPE plkz-plnal,
        aufkt3 TYPE plpo-aufkt,
        plnnr4 TYPE plkz-plnnr,
        plnal4 TYPE plkz-plnal,
        aufkt4 TYPE plpo-aufkt,
        plnnr5 TYPE plkz-plnnr,
        plnal5 TYPE plkz-plnal,
        aufkt5 TYPE plpo-aufkt,
        plnnr6 TYPE plkz-plnnr,
        plnal6 TYPE plkz-plnal,
        aufkt6 TYPE plpo-aufkt,
      END OF gty_modif_campos_masiva_ord.

    METHODS alv_event_modif_campos_crear_o.

    METHODS alv_st
      CHANGING ct_excl TYPE slis_t_extab.

    METHODS alv_uc
      IMPORTING i_ucomm TYPE clike
      CHANGING  cs_sel  TYPE slis_selfield.

    METHODS constructor.

    METHODS main
      IMPORTING  sel_parameter TYPE gty_sel
      EXCEPTIONS error.

  PRIVATE SECTION.
    TYPES:
      " tipos
      BEGIN OF gty_const,
        r_filtro_equipo_status_sistema TYPE RANGE OF string,
        r_filtro_equipo_status_usuario TYPE RANGE OF string,

        aviso_crear_qmart              TYPE qmart,
        aviso_modificar_status_usuario TYPE jest-stat,

        orden_crear_tipo               TYPE aufk-auart,
      END OF gty_const.
    TYPES gtr_status TYPE RANGE OF string.
    TYPES:
      BEGIN OF gty_caracteri_averia,
        equnr          TYPE equi-equnr,
        name           TYPE char200,
        value_para_alv TYPE char200,
        name_and_value TYPE char200,

        matriz         TYPE xfeld,
        peso           TYPE ze_peso_calculado,
      END OF gty_caracteri_averia.
    TYPES gtt_caracteri_averia TYPE TABLE OF gty_caracteri_averia WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_equi,
        equnr TYPE equz-equnr,
        hequi TYPE equz-hequi,
        eqart TYPE equi-eqart,
        objnr TYPE equi-objnr,

        objek TYPE ausp-objek,
      END OF gty_equi.
    TYPES gtt_equi TYPE TABLE OF gty_equi WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_plkz,
        equnr TYPE equi-equnr,
        plnty TYPE plkz-plnty,
        plnnr TYPE plkz-plnnr,
        plnal TYPE plkz-plnal,
        aufkt TYPE plpo-aufkt,
      END OF gty_plkz.
    TYPES gtt_plkz TYPE TABLE OF gty_plkz WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_detail,
        icon                     TYPE icon-id,

        " equipo
        equnr                    TYPE equi-equnr,
        eqktx                    TYPE eqkt-eqktx,
        eqart                    TYPE equi-eqart,
        begru                    TYPE equi-begru,
        herst                    TYPE equi-herst,
        baujj                    TYPE equi-baujj,
        baumm                    TYPE equi-baumm,
        inbdt                    TYPE equi-inbdt,
        matnr                    TYPE equi-matnr,
        sernr                    TYPE equi-sernr,

        ingrp                    TYPE equz-ingrp,
        tidnr                    TYPE equz-tidnr,

        tplnr                    TYPE iloa-tplnr,
        eqfnr                    TYPE iloa-eqfnr,
        stort                    TYPE iloa-stort,

        stat_system              TYPE string,
        stat_user                TYPE string,

        city2                    TYPE adrc-city2,
        post_code1               TYPE adrc-post_code1,

        " aviso
        qmnum                    TYPE qmel-qmnum,
        qmart                    TYPE qmel-qmart,
        zzlegado                 TYPE qmel-zzlegado,
        zzcodleg                 TYPE qmel-zzcodleg,
        zzranking                TYPE qmel-zzranking,
        zzrecomen                TYPE qmel-zzrecomen,
        zzpeso_calculado         TYPE qmel-zzpeso_calculado,
        qmnum_stat_system        TYPE string,
        qmnum_stat_user          TYPE string,

        " orden
        aufnr                    TYPE aufk-aufnr,
        auart                    TYPE aufk-auart,
        zzpep                    TYPE aufk-zzpep,
        zzlotedeenvio            TYPE aufk-zzlotedeenvio,

        gltrp                    TYPE afko-gltrp,
        gstrp                    TYPE afko-gstrp,

        aufnr_planificado        TYPE dmbtr,
        aufnr_real               TYPE dmbtr,

        aufnr_stat_system        TYPE string,
        aufnr_stat_user          TYPE string,

        ilart                    TYPE afih-ilart,

        parnr_ab                 TYPE ihpa-parnr,
        parnr_ab_text            TYPE string,
        parnr_vu                 TYPE ihpa-parnr,
        parnr_vu_text            TYPE string,
        parnr_pr                 TYPE ihpa-parnr,
        parnr_pr_text            TYPE string,
        parnr_vw                 TYPE ihpa-parnr,
        parnr_vw_text            TYPE string,

        " dynamic: características, averías
        peso_calculado           TYPE ze_peso_calculado,
        ranking                  TYPE ze_ranking,
        idrecomendacion          TYPE ztbeam_12_recome-idrecomendacion,
        recomendacion            TYPE ztbeam_12_recome-recomendacion,
        ztbeam_12_hreqpr_ktext   TYPE ztbeam_12_hreqpr-ktext,

        equnr1                   TYPE equi-equnr,
        plnty1                   TYPE afvc-plnty,
        plnnr1                   TYPE afvc-plnnr,
        plnal1                   TYPE afvc-plnal,
        aufkt1                   TYPE plpo-aufkt,
        equnr2                   TYPE zeeam_12_equnr_secundario,
        plnty2                   TYPE afvc-plnty,
        plnnr2                   TYPE afvc-plnnr,
        plnal2                   TYPE afvc-plnal,
        aufkt2                   TYPE plpo-aufkt,
        equnr3                   TYPE zeeam_12_equnr_secundario,
        plnty3                   TYPE afvc-plnty,
        plnnr3                   TYPE afvc-plnnr,
        plnal3                   TYPE afvc-plnal,
        aufkt3                   TYPE plpo-aufkt,
        equnr4                   TYPE zeeam_12_equnr_secundario,
        plnty4                   TYPE afvc-plnty,
        plnnr4                   TYPE afvc-plnnr,
        plnal4                   TYPE afvc-plnal,
        aufkt4                   TYPE plpo-aufkt,
        equnr5                   TYPE zeeam_12_equnr_secundario,
        plnty5                   TYPE afvc-plnty,
        plnnr5                   TYPE afvc-plnnr,
        plnal5                   TYPE afvc-plnal,
        aufkt5                   TYPE plpo-aufkt,
        equnr6                   TYPE zeeam_12_equnr_secundario,
        plnty6                   TYPE afvc-plnty,
        plnnr6                   TYPE afvc-plnnr,
        plnal6                   TYPE afvc-plnal,
        aufkt6                   TYPE plpo-aufkt,

        message                  TYPE messagetext,

        " no mostrar
        box                      TYPE xfeld,
        crear_o_actualizar_aviso TYPE abap_bool,
        plazo                    TYPE ztbeam_12_matx_r-plazo,

        " interno
        objnr                    TYPE equi-objnr,
        qmnum_objnr              TYPE qmel-objnr,
        adrnr                    TYPE iloa-adrnr,
        objek                    TYPE kssk-objek,

        " tablas
        plkz                     TYPE gtt_plkz,
      END OF gty_detail.
    TYPES gtt_detail TYPE TABLE OF gty_detail WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_ausp,
        objek          TYPE ausp-objek,
        atinn          TYPE ausp-atinn,
        atzhl          TYPE ausp-atzhl,
        mafid          TYPE ausp-mafid,
        klart          TYPE ausp-klart,
        adzhl          TYPE ausp-adzhl,
        atwrt          TYPE ausp-atwrt,
        atflv          TYPE ausp-atflv,

        cabn_atnam     TYPE cabn-atnam,
        value_para_alv TYPE gty_caracteri_averia-value_para_alv,
      END OF gty_ausp.
    TYPES gtt_ausp TYPE TABLE OF gty_ausp WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_cabn,
        atinn TYPE cabn-atinn,
        adzhl TYPE cabn-adzhl,
        atnam TYPE cabn-atnam,
        atfor TYPE cabn-atfor,
        anzdz TYPE cabn-anzdz,
        atbez TYPE cabnt-atbez,
      END OF gty_cabn.
    TYPES gtt_cabn TYPE TABLE OF gty_cabn WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_cawnt,
        atinn TYPE cawnt-atinn,
        atzhl TYPE cawnt-atzhl,
        atwtb TYPE cawnt-atwtb,
      END OF gty_cawnt.
    TYPES gtt_cawnt TYPE TABLE OF gty_cawnt WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_qmih,
        qmnum            TYPE qmih-qmnum,
        equnr            TYPE qmih-equnr,
        qmart            TYPE qmel-qmart,
        erdat            TYPE qmel-erdat,
        mzeit            TYPE qmel-mzeit,
        objnr            TYPE qmel-objnr,
        qmdab            TYPE qmel-qmdab,
        zzlegado         TYPE qmel-zzlegado,
        zzcodleg         TYPE qmel-zzcodleg,
        zzranking        TYPE qmel-zzranking,
        zzrecomen        TYPE qmel-zzrecomen,
        zzpeso_calculado TYPE qmel-zzpeso_calculado,
        stat_system      TYPE string,
        stat_user        TYPE string,
      END OF gty_qmih.
    TYPES gtt_qmih TYPE TABLE OF gty_qmih WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_qmfe,
        qmnum          TYPE qmfe-qmnum,
        fenum          TYPE qmfe-fenum,
        fegrp          TYPE qmfe-fegrp,
        fecod          TYPE qmfe-fecod,
        fever          TYPE qmfe-fever,

        value_para_alv TYPE string,
      END OF gty_qmfe.
    TYPES gtt_qmfe TYPE TABLE OF gty_qmfe WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_orden,
        aufnr         TYPE aufk-aufnr,
        auart         TYPE aufk-auart,
        objnr         TYPE aufk-objnr,
        waers         TYPE aufk-waers,
        zzpep         TYPE aufk-zzpep,
        zzlotedeenvio TYPE aufk-zzlotedeenvio,
        gltrp         TYPE afko-gltrp,
        gstrp         TYPE afko-gstrp,
        aufpl         TYPE afko-aufpl,
        planificado   TYPE dmbtr,
        real          TYPE dmbtr,
        stat_system   TYPE string,
        stat_user     TYPE string,
        ilart         TYPE afih-ilart,
        qmnum         TYPE afih-qmnum,
        parnr_ab      TYPE ihpa-parnr,
        parnr_ab_text TYPE string,
        parnr_vu      TYPE ihpa-parnr,
        parnr_vu_text TYPE string,
        parnr_pr      TYPE ihpa-parnr,
        parnr_pr_text TYPE string,
        parnr_vw      TYPE ihpa-parnr,
        parnr_vw_text TYPE string,
      END OF gty_orden.
    TYPES gtt_orden TYPE TABLE OF gty_orden WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_qpgr,
        codegruppe TYPE qpgr-codegruppe,
        kurztext   TYPE qpgt-kurztext,
      END OF gty_qpgr.
    TYPES gtt_qpgr TYPE TABLE OF gty_qpgr WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_qpcd,
        codegruppe TYPE qpcd-codegruppe,
        code       TYPE qpcd-code,
        version    TYPE qpcd-version,
        kurztext   TYPE qpct-kurztext,
      END OF gty_qpcd.
    TYPES:
      BEGIN OF gty_matx_r.
        INCLUDE TYPE ztbeam_12_matx_r.
    TYPES:
        caracteri_averia TYPE gtt_caracteri_averia,
        recomendacion    TYPE ztbeam_12_recome-recomendacion,
        lines            TYPE i,
      END OF gty_matx_r.
    TYPES:
      BEGIN OF gty_hreqpr.
        INCLUDE TYPE ztbeam_12_hreqpr.
    TYPES:
        caracteri_averia TYPE gtt_caracteri_averia,
        lines            TYPE i,
      END OF gty_hreqpr.
    TYPES:
      BEGIN OF gty_hreqse.
        INCLUDE TYPE ztbeam_12_hreqse.
    TYPES:
        caracteri_averia_principal  TYPE gtt_caracteri_averia,
        caracteri_averia_secundario TYPE gtt_caracteri_averia,
        lines_principal             TYPE i,
        lines_secundario            TYPE i,
      END OF gty_hreqse.
    TYPES gtt_qpcd   TYPE TABLE OF gty_qpcd WITH DEFAULT KEY.
    TYPES gtt_matx_d TYPE TABLE OF ztbeam_12_matx_d WITH DEFAULT KEY.
    TYPES gtt_caract TYPE TABLE OF ztbeam_12_caract WITH DEFAULT KEY.
    TYPES gtt_averia TYPE TABLE OF ztbeam_12_averia WITH DEFAULT KEY.
    TYPES gtt_ptomed TYPE TABLE OF ztbeam_12_ptomed WITH DEFAULT KEY.
    TYPES gtt_matx_r TYPE TABLE OF gty_matx_r WITH DEFAULT KEY.
    TYPES gtt_hreqpr TYPE TABLE OF gty_hreqpr WITH DEFAULT KEY.
    TYPES gtt_hreqse TYPE TABLE OF gty_hreqse WITH DEFAULT KEY.
    TYPES:
      BEGIN OF gty_maestro_zpeam0012,
        matx_c             TYPE ztbeam_12_matx_c,
        matx_d             TYPE gtt_matx_d,
        matx_r             TYPE gtt_matx_r,
        hreqpr             TYPE gtt_hreqpr,
        hreqse             TYPE gtt_hreqse,

        matx_d_principal   TYPE gtt_matx_d,
        matx_d_secundario  TYPE gtt_matx_d,

        matx_f             TYPE TABLE OF ztbeam_12_matx_f WITH DEFAULT KEY,
        averia             TYPE gtt_averia,
        caract             TYPE gtt_caract,
        ptomed             TYPE gtt_ptomed,

        averia_code_vacio  TYPE gtt_averia,
        caract_value_vacio TYPE gtt_caract,

        matx_c_compare     TYPE TABLE OF ztbeam_12_matx_c WITH DEFAULT KEY,

        cabn               TYPE gtt_cabn,
        qpgr               TYPE gtt_qpgr,
        qpcd               TYPE gtt_qpcd,
      END OF gty_maestro_zpeam0012.
    TYPES:
      BEGIN OF gty_data,
        qmih_p1          TYPE gtt_qmih,
        qmih_averias     TYPE gtt_qmih,
        qmfe             TYPE gtt_qmfe,
        orden            TYPE gtt_orden,
        ausp             TYPE gtt_ausp,
        cabn             TYPE gtt_cabn,
        cawnt            TYPE gtt_cawnt,

        equi_secundario  TYPE gtt_equi,
        ausp_secundario  TYPE gtt_ausp,
        cabn_secundario  TYPE gtt_cabn,
        cawnt_secundario TYPE gtt_cawnt,
        qmih_secundario  TYPE gtt_qmih,
        qmfe_secundario  TYPE gtt_qmfe,
      END OF gty_data.
    " tipos tablas
    TYPES gtr_aufnr TYPE RANGE OF aufk-aufnr.
    TYPES gtr_qmnum TYPE RANGE OF qmel-qmnum.

    " tablas internas
    " estructuras
    DATA constant_global            TYPE gty_const.
    " variables
    DATA data_sap_global            TYPE gty_data.
    DATA maestro_zpeam0012_global   TYPE gty_maestro_zpeam0012.
    DATA detail_dynamics_global     TYPE REF TO data.
    " objetos
    DATA utilities                  TYPE REF TO zcl_utilities.
    DATA alv_modif_campos_crear_ord TYPE REF TO cl_gui_alv_grid.
    DATA:
      " constantes
      BEGIN OF gs_tipo_objeto_tecnico,
        equipo_principal  TYPE string VALUE 'EQUI_PRIN',
        equipo_secundario TYPE string VALUE 'EQUI_SECU',
        ubicacion         TYPE string VALUE 'UBICACION',
      END OF gs_tipo_objeto_tecnico.

    METHODS alv_main
      IMPORTING variant         TYPE disvariant-variant
      CHANGING  detail_dynamics TYPE REF TO data
                fcats           TYPE lvc_t_fcat.

    METHODS alv_modif_individual_campos
      CHANGING !tables TYPE STANDARD TABLE.

    METHODS alv_modif_masiva_campos
      CHANGING   !tables TYPE STANDARD TABLE
      EXCEPTIONS error.

    METHODS bapi_alm_notif_create
      IMPORTING  matx_c_header TYPE ztbeam_12_matx_c
                 !detail       TYPE gty_detail
      EXPORTING  qmnum         TYPE qmnum
                 returns       TYPE bapirettab
      EXCEPTIONS error.

    METHODS bapi_alm_notif_data_modify
      IMPORTING  matx_c  TYPE ztbeam_12_matx_c
                 !detail TYPE gty_detail
      EXPORTING  returns TYPE bapirettab
      EXCEPTIONS error.

    METHODS bapi_alm_orden_maintain
      IMPORTING  !detail     TYPE gty_detail
                 crear_orden TYPE gty_crear_orden
                 plkzs       TYPE gtt_plkz
      EXPORTING  aufnr       TYPE aufnr
                 returns     TYPE bapirettab
      EXCEPTIONS error.

    METHODS bapi_status_change_intern
      IMPORTING  objnr TYPE qmel-objnr
      EXCEPTIONS error.

    METHODS build_compare
      IMPORTING sel_parameter   TYPE gty_sel
                details         TYPE gtt_detail
                !data           TYPE gty_data
      CHANGING  detail_dynamics TYPE REF TO data.

    METHODS build_list_caracteri_averia
      EXPORTING caracteri_averias TYPE gtt_caracteri_averia
      CHANGING  !line             TYPE any.

    METHODS button_crear_update_avisos
      IMPORTING  matx_c                 TYPE ztbeam_12_matx_c
      CHANGING   detail_dynamics_global TYPE REF TO data
      EXCEPTIONS error.

    METHODS button_crear_ordenes
      CHANGING   detail_dynamic TYPE REF TO data
      EXCEPTIONS error.

    METHODS button_modify_individual_flds
      CHANGING   detail_dynamic TYPE REF TO data
      EXCEPTIONS error.

    METHODS button_modify_mass_flds
      CHANGING   detail_dynamic TYPE REF TO data
      EXCEPTIONS error.

    METHODS check_auth
      IMPORTING  sel_parameter TYPE gty_sel
      EXCEPTIONS error.

    METHODS create_catalogo_dinamico
      IMPORTING maestro_zpeam0012 TYPE gty_maestro_zpeam0012
                cabns             TYPE gtt_cabn
      EXPORTING fcats             TYPE lvc_t_fcat
      CHANGING  details           TYPE gtt_detail.

    METHODS getset_status_dynamic
      IMPORTING status_systems TYPE gtr_status OPTIONAL
                status_users   TYPE gtr_status OPTIONAL
      CHANGING  dynamics       TYPE STANDARD TABLE.

    METHODS get_avisos
      IMPORTING details      TYPE gtt_detail OPTIONAL
                qmnums       TYPE gtr_qmnum  OPTIONAL
                qpcds        TYPE gtt_qpcd   OPTIONAL
      EXPORTING qmih_p1s     TYPE gtt_qmih
                qmih_averias TYPE gtt_qmih
                qmfes        TYPE gtt_qmfe.

    METHODS get_caracteristicas
      IMPORTING details TYPE gtt_detail
      EXPORTING ausps   TYPE gtt_ausp
                cabns   TYPE gtt_cabn
                cawnts  TYPE gtt_cawnt.

    METHODS get_maestro_zpeam0012
      IMPORTING  sel_parameter     TYPE gty_sel
      EXPORTING  maestro_zpeam0012 TYPE gty_maestro_zpeam0012
      EXCEPTIONS error.

    METHODS get_data_sap_para_calcular
      IMPORTING  sel_parameter     TYPE gty_sel
      EXPORTING  !data             TYPE gty_data
                 maestro_zpeam0012 TYPE gty_maestro_zpeam0012
                 details           TYPE gtt_detail
      EXCEPTIONS error.

    METHODS get_equipos_secundarios
      IMPORTING details TYPE gtt_detail
                qpcds   TYPE gtt_qpcd
      EXPORTING equis   TYPE gtt_equi
                ausps   TYPE gtt_ausp
                cabns   TYPE gtt_cabn
                cawnts  TYPE gtt_cawnt
                qmihs   TYPE gtt_qmih
                qmfes   TYPE gtt_qmfe.

    METHODS get_equipos_selection
      IMPORTING  sel_parameter     TYPE gty_sel
      EXPORTING  maestro_zpeam0012 TYPE gty_maestro_zpeam0012
                 details           TYPE gtt_detail
      EXCEPTIONS error.

    METHODS get_hojaruta_dinamica
      IMPORTING detail_dynamic TYPE any
      RETURNING VALUE(plkzs)   TYPE gtt_plkz.

    METHODS get_ordenes
      IMPORTING qmihs  TYPE gtt_qmih  OPTIONAL
                aufnrs TYPE gtr_aufnr OPTIONAL
      EXPORTING orden  TYPE gtt_orden.

    METHODS is_creacion_orden_pendiente
      IMPORTING  details  TYPE gtt_detail
                 !message TYPE clike
      EXCEPTIONS error.

    METHODS is_crear_o_actualizar_aviso
      IMPORTING !detail                           TYPE gty_detail
                matx_c                            TYPE ztbeam_12_matx_c
      RETURNING VALUE(r_crear_o_actualizar_aviso) TYPE xfeld.

    METHODS set_averias
      IMPORTING qmnum             TYPE qmel-qmnum
                equnr             TYPE equi-equnr
                eqart             TYPE equi-eqart
                matx_ds           TYPE gtt_matx_d
                qmfes             TYPE gtt_qmfe
                averias           TYPE gtt_averia
      CHANGING  peso_calculado    TYPE gty_detail-peso_calculado
                caracteri_averias TYPE gtt_caracteri_averia.

    METHODS set_avisos_y_ordenes
      IMPORTING qmihs   TYPE gtt_qmih
                ordens  TYPE gtt_orden
      CHANGING  details TYPE gtt_detail.

    METHODS set_caracteristicas
      IMPORTING objek             TYPE ausp-objek
                equnr             TYPE equi-equnr
                eqart             TYPE equi-eqart
                matx_ds           TYPE gtt_matx_d
                caracts           TYPE gtt_caract
                ausps             TYPE gtt_ausp
      CHANGING  peso_calculado    TYPE gty_detail-peso_calculado
                caracteri_averias TYPE gtt_caracteri_averia.

    METHODS set_caracteri_averias_vacias
      IMPORTING matx_ds           TYPE gtt_matx_d
                cabns             TYPE gtt_cabn
                caracts           TYPE gtt_caract
                averias           TYPE gtt_averia
      CHANGING  peso_calculado    TYPE gty_detail-peso_calculado
                caracteri_averias TYPE gtt_caracteri_averia.

    METHODS set_data_calculo_dinamico
      IMPORTING !data             TYPE gty_data
                maestro_zpeam0012 TYPE gty_maestro_zpeam0012
                comparison_flag   TYPE xfeld OPTIONAL
      EXPORTING fcats             TYPE lvc_t_fcat
                detail_dynamic    TYPE REF TO data
      CHANGING  details           TYPE gtt_detail.

    METHODS set_hojaruta_dynamic
      IMPORTING plkzs             TYPE gtt_plkz
      CHANGING  cs_detail_dynamic TYPE any.

    METHODS set_hojaruta_equipo_principal
      IMPORTING equnr             TYPE equi-equnr
                idrecomendacion   TYPE ztbeam_12_recome-idrecomendacion
                eqart             TYPE eqart
                hreqpr_principals TYPE gtt_hreqpr
                caracteri_averias TYPE gtt_caracteri_averia
      EXPORTING ktext             TYPE ztbeam_12_hreqpr-ktext
      CHANGING  plkzs             TYPE gtt_plkz.

    METHODS set_hojaruta_equipo_secundario
      IMPORTING idrecomendacion              TYPE ztbeam_12_recome-idrecomendacion
                eqart_principal              TYPE eqart
                equnr_secundario             TYPE equi-equnr
                eqart_secundario             TYPE eqart
                hreqse_secundarios           TYPE gtt_hreqse
                caracteri_averia_principals  TYPE gtt_caracteri_averia
                caracteri_averia_secundarios TYPE gtt_caracteri_averia
      CHANGING  plkzs                        TYPE gtt_plkz.

    METHODS set_recomendacion
      IMPORTING matx_rs           TYPE gtt_matx_r
                eqart             TYPE eqart
                caracteri_averias TYPE gtt_caracteri_averia
      EXPORTING idrecomendacion   TYPE ztbeam_12_recome-idrecomendacion
                recomendacion     TYPE ztbeam_12_recome-recomendacion
                plazo             TYPE ztbeam_12_matx_r-plazo.

    METHODS update_data_de_aviso_creada
      IMPORTING qmihs          TYPE gtt_qmih
                !detail        TYPE gty_detail
      CHANGING  detail_dynamic TYPE any.

    METHODS update_data_de_orden_creada
      IMPORTING ordens         TYPE gtt_orden
                !detail        TYPE gty_detail
      CHANGING  detail_dynamic TYPE any.

    METHODS clear_plkz_fields
      CHANGING cs_edit TYPE any.
ENDCLASS.


CLASS zcleam_13_reporte_matriz IMPLEMENTATION.
  METHOD alv_event_modif_campos_crear_o.
    CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
      IMPORTING e_grid = alv_modif_campos_crear_ord.

    alv_modif_campos_crear_ord->register_edit_event( cl_gui_alv_grid=>mc_evt_modified ).
    alv_modif_campos_crear_ord->register_edit_event( cl_gui_alv_grid=>mc_evt_enter ).
  ENDMETHOD.

  METHOD alv_main.
    FIELD-SYMBOLS <detail_dynamics> TYPE STANDARD TABLE.

    ASSIGN detail_dynamics->* TO <detail_dynamics>.

    DESCRIBE TABLE <detail_dynamics>.
    MESSAGE s000(su) WITH 'Se visualizan' sy-tfill 'registro(s)'.

    " layout/variant/catalog
    DATA(layo) = VALUE lvc_s_layo( zebra      = abap_on
                                   cwidth_opt = abap_on
                                   col_opt    = abap_on
                                   box_fname  = 'BOX' ).

    DATA(vari) = VALUE disvariant( username = sy-uname
                                   report   = sy-cprog
                                   handle   = sy-dynnr
                                   variant  = variant ).

    " fcat
    LOOP AT fcats ASSIGNING FIELD-SYMBOL(<fcat>).
      CASE <fcat>-fieldname.
        WHEN 'ICON'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Icon'
                                    CHANGING  cs_fcat = <fcat> ).
          <fcat>-icon    = abap_on.
          <fcat>-key     = abap_on.
          <fcat>-hotspot = abap_on.

        WHEN 'EQUNR'.
          <fcat>-key     = abap_on.
          <fcat>-hotspot = abap_on.

        WHEN 'QMNUM'.
          <fcat>-hotspot = abap_on.

        WHEN 'AUFNR'.
          <fcat>-hotspot = abap_on.

        WHEN 'STAT_SYSTEM'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Estatus de sistema'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'STAT_USER'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Estatus de usuario'
                                    CHANGING  cs_fcat = <fcat> ).

        WHEN 'QMNUM_STAT_SYSTEM'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Estatus de sistema Aviso'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'QMNUM_STAT_USER'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Estatus de usuario Aviso'
                                    CHANGING  cs_fcat = <fcat> ).

        WHEN 'AUFNR_PLANIFICADO'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Total planificado'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'AUFNR_REAL'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Total real'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'AUFNR_STAT_SYSTEM'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Estatus de sistema OM'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'AUFNR_STAT_USER'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Estatus de usuario OM'
                                    CHANGING  cs_fcat = <fcat> ).

        WHEN 'PARNR_AB'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Interloc. Dpto. Responsable'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'PARNR_AB_TEXT'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Interloc. Dpto. Responsable Denominación'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'PARNR_VU'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Interloc. Usu. Responsable'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'PARNR_VU_TEXT'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Interloc. Usu. Responsable Denominación'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'PARNR_PR'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Interloc. Proveedor'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'PARNR_PR_TEXT'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Interloc. Proveedor Denominación'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'PARNR_VW'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Interloc. Responsable'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'PARNR_VW_TEXT'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Interloc. Responsable Denominación'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'ZZPESO_CALCULADO'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Peso Calculado Anterior'
                                    CHANGING  cs_fcat = <fcat> ).
        WHEN 'ZZRANKING'.
          utilities->alv_fcat_name( EXPORTING i_unico = 'Pos.Ranking Anterior'
                                    CHANGING  cs_fcat = <fcat> ).

        WHEN 'BOX'
          OR 'ZTBEAM_12_HREQPR_KTEXT'
          OR 'CREAR_O_ACTUALIZAR_AVISO' OR 'PLAZO'.
          <fcat>-tech = abap_on.
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.

    LOOP AT fcats ASSIGNING <fcat>.
      IF strlen( <fcat>-fieldname ) = 6.
        IF <fcat>-fieldname CS 'EQUNR' OR <fcat>-fieldname CS 'PLNTY' OR <fcat>-fieldname CS 'PLNNR' OR <fcat>-fieldname CS 'PLNAL' OR <fcat>-fieldname CS 'AUFKT'.
          utilities->alv_fcat_name( EXPORTING i_unico = <fcat>-scrtext_m && <fcat>-fieldname+5
                                    CHANGING  cs_fcat = <fcat> ).
        ENDIF.
      ENDIF.
    ENDLOOP.

    " alv
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING  i_bypassing_buffer       = abap_on
                 i_buffer_active          = abap_on
                 i_callback_program       = sy-cprog " ZPEAM0013
                 is_layout_lvc            = layo
                 it_fieldcat_lvc          = fcats
                 i_save                   = 'A'
                 i_callback_pf_status_set = 'ALV_ST'
                 i_callback_user_command  = 'ALV_UC'
                 is_variant               = vari
      TABLES     t_outtab                 = <detail_dynamics>
      EXCEPTIONS program_error            = 1
                 OTHERS                   = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.

  METHOD alv_modif_individual_campos.
    DATA fcats TYPE lvc_t_fcat.

    " layout/variant/catalog
    DATA(layo) = VALUE lvc_s_layo( zebra      = abap_on
                                   cwidth_opt = abap_on
                                   col_opt    = abap_on ).

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING i_structure_name = 'ZSTEAM_13_ALV_EDIT_CREA_ORDEN'
      CHANGING  ct_fieldcat      = fcats.

    " fcat
    LOOP AT fcats ASSIGNING FIELD-SYMBOL(<fcat>).
      IF    <fcat>-fieldname CS 'PLNNR'
         OR <fcat>-fieldname CS 'PLNAL'
         OR <fcat>-fieldname CS 'AUFKT'
         OR <fcat>-fieldname CS 'ZZPEP'
         OR <fcat>-fieldname CS 'ZZLOTEDEENVIO'.
        <fcat>-edit = abap_on.
      ELSEIF    <fcat>-fieldname CS 'EQUNR'
             OR <fcat>-fieldname CS 'PLNTY'.
      ENDIF.
    ENDLOOP.

    DATA(events) = VALUE slis_t_event( ( name = 'CALLER_EXIT' form = 'ALV_EVENT' ) ).

    " alv
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING  i_bypassing_buffer = abap_on
                 i_buffer_active    = abap_on
                 i_callback_program = sy-cprog
                 is_layout_lvc      = layo
                 it_fieldcat_lvc    = fcats
                 it_events          = events
      TABLES     t_outtab           = tables
      EXCEPTIONS program_error      = 1
                 OTHERS             = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.

  METHOD alv_modif_masiva_campos.
    DATA fcats TYPE lvc_t_fcat.

    " layout/variant/catalog
    DATA(layo) = VALUE lvc_s_layo( zebra      = abap_on
                                   cwidth_opt = abap_on
                                   col_opt    = abap_on ).

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING i_structure_name = 'ZSTEAM_13_ALV_EDIT_CREA_ORDEN'
      CHANGING  ct_fieldcat      = fcats.

    " fcat
    LOOP AT fcats ASSIGNING FIELD-SYMBOL(<fcat>).
      IF    <fcat>-fieldname CS 'PLNNR'
         OR <fcat>-fieldname CS 'PLNAL'
         OR <fcat>-fieldname CS 'AUFKT'
         OR <fcat>-fieldname CS 'ZZPEP'
         OR <fcat>-fieldname CS 'ZZLOTEDEENVIO'.
        <fcat>-edit = abap_on.
      ELSEIF <fcat>-fieldname CS 'PLNTY'.
      ELSE.
        <fcat>-tech = abap_on.
      ENDIF.
    ENDLOOP.

    DATA(events) = VALUE slis_t_event( ( name = 'CALLER_EXIT' form = 'ALV_EVENT' ) ).

    " alv
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING  i_bypassing_buffer    = abap_on
                 i_buffer_active       = abap_on
                 i_callback_program    = sy-cprog
                 is_layout_lvc         = layo
                 it_fieldcat_lvc       = fcats
                 it_events             = events
                 i_screen_start_column = 25
                 i_screen_start_line   = 2
                 i_screen_end_column   = 200
                 i_screen_end_line     = 5
      TABLES     t_outtab              = tables
      EXCEPTIONS program_error         = 1
                 OTHERS                = 2.
    IF sy-ucomm <> '&ONT'.
      MESSAGE e000 WITH 'Acción cancelada...' RAISING error.
    ENDIF.
  ENDMETHOD.

  METHOD alv_st.
    SET PF-STATUS 'ALV_ST' EXCLUDING ct_excl OF PROGRAM sy-cprog.
  ENDMETHOD.

  METHOD alv_uc.
    DATA detail TYPE gty_detail.

    FIELD-SYMBOLS <detail_dynamics> TYPE STANDARD TABLE.

    CASE i_ucomm.
      WHEN '&IC1'.
        ASSIGN detail_dynamics_global->* TO <detail_dynamics>.

        ASSIGN <detail_dynamics>[ cs_sel-tabindex ] TO FIELD-SYMBOL(<detail>).
        detail = CORRESPONDING #( <detail> ).
        CASE cs_sel-fieldname.
          WHEN 'EQUNR'.
            SET PARAMETER ID 'EQN' FIELD detail-equnr.
            CALL TRANSACTION 'IE03' AND SKIP FIRST SCREEN.

          WHEN 'QMNUM'.
            IF detail-qmnum IS INITIAL.
              RETURN.
            ENDIF.
            SET PARAMETER ID 'IQM' FIELD detail-qmnum.
            CALL TRANSACTION 'IW23' AND SKIP FIRST SCREEN.

          WHEN 'AUFNR'.
            IF detail-aufnr IS INITIAL.
              RETURN.
            ENDIF.
            SET PARAMETER ID 'ANR' FIELD detail-aufnr.
            CALL TRANSACTION 'IW33' AND SKIP FIRST SCREEN.
        ENDCASE.
      WHEN 'FC01'.
        button_crear_update_avisos( EXPORTING  matx_c                 = maestro_zpeam0012_global-matx_c
                                    CHANGING   detail_dynamics_global = detail_dynamics_global
                                    EXCEPTIONS error                  = 1 ).
        IF sy-subrc <> 0.
          utilities->message_show( ).
        ENDIF.
        utilities->alvlvc_refresh( CHANGING cs_sel = cs_sel ).

      WHEN 'FC02'.
        button_crear_ordenes( CHANGING   detail_dynamic = detail_dynamics_global
                              EXCEPTIONS error          = 1 ).
        IF sy-subrc <> 0.
          utilities->message_show( ).
        ENDIF.
        utilities->alvlvc_refresh( CHANGING cs_sel = cs_sel ).

      WHEN 'FC03'.
        button_modify_individual_flds( CHANGING   detail_dynamic = detail_dynamics_global
                                       EXCEPTIONS error          = 1 ).
        IF sy-subrc <> 0.
          utilities->message_show( ).
        ENDIF.
        utilities->alvlvc_refresh( CHANGING cs_sel = cs_sel ).

      WHEN 'FC04'.
        button_modify_mass_flds( CHANGING   detail_dynamic = detail_dynamics_global
                                 EXCEPTIONS error          = 1 ).
        IF sy-subrc <> 0.
          utilities->message_show( ).
        ENDIF.
        utilities->alvlvc_refresh( CHANGING cs_sel = cs_sel ).
    ENDCASE.
  ENDMETHOD.

  METHOD bapi_alm_notif_create.
    NEW zeamcl_utilitarios( )->crear_aviso(
          EXPORTING  i_qmart        = constant_global-aviso_crear_qmart
                     is_cab         = VALUE #( funct_loc  = detail-tplnr
                                               equipment  = detail-equnr
                                               short_text = detail-recomendacion
                                               desstdate  = sy-datlo
                                               dessttime  = sy-timlo
                                               desenddate = sy-datlo + detail-plazo
                                               desendtm   = sy-timlo )
                     it_extin       = VALUE #(
                         ( structure  = 'ZZLEGADO' valuepart1 = matx_c_header-descr )
                         ( structure  = 'ZZCODLEG' valuepart1 = |{ matx_c_header-idmatriz }-{ matx_c_header-versio }| )
                         ( structure  = 'ZZRANKING' valuepart1 = detail-ranking )
                         ( structure  = 'ZZRECOMEN' valuepart1 = detail-recomendacion )
                         ( structure  = 'ZZPESO_CALCULADO' valuepart1 = CONV #( detail-peso_calculado ) ) )
          IMPORTING  es_notifheader = DATA(ls_cab2)
                     et_return      = returns
          EXCEPTIONS error          = 1 ).

    IF sy-subrc = 0.
      qmnum = ls_cab2-notif_no.
    ELSE.
      RAISE error.
    ENDIF.
  ENDMETHOD.

  METHOD bapi_alm_notif_data_modify.
    NEW zeamcl_utilitarios( )->modificar_aviso(
          EXPORTING  i_qmnum   = detail-qmnum
                     is_cab    = VALUE #( short_text = detail-recomendacion )
                     is_cabx   = VALUE #( short_text = abap_on )
                     it_extin  = VALUE #(
                         ( structure  = 'ZZLEGADO' valuepart1 = matx_c-descr )
                         ( structure  = 'ZZCODLEG' valuepart1 = |{ matx_c-idmatriz }-{ matx_c-versio }| )
                         ( structure  = 'ZZRANKING' valuepart1 = detail-ranking )
                         ( structure  = 'ZZRECOMEN' valuepart1 = detail-recomendacion )
                         ( structure  = 'ZZPESO_CALCULADO' valuepart1 = detail-peso_calculado ) )
          IMPORTING  et_return = returns
          EXCEPTIONS error     = 1 ).

    IF sy-subrc <> 0.
      RAISE error.
    ENDIF.
  ENDMETHOD.

  METHOD bapi_alm_orden_maintain.
    DATA ktext           TYPE aufk-ktext.
    DATA methods         TYPE TABLE OF bapi_alm_order_method.
    DATA partners        TYPE TABLE OF bapi_alm_order_partn_mul.
    DATA tasklists       TYPE TABLE OF bapi_alm_order_tasklists_i.
    DATA partner_ups     TYPE TABLE OF bapi_alm_order_partn_mul_up.
    DATA operations      TYPE TABLE OF bapi_alm_order_operation.
    DATA operation_ups   TYPE TABLE OF bapi_alm_order_operation_up.
    DATA olist_relations TYPE TABLE OF bapi_alm_olist_relation.

    ktext = detail-ztbeam_12_hreqpr_ktext.
    IF crear_orden-add_eqfnr_in_ktext IS NOT INITIAL.
      ktext = |{ ktext }-{ detail-eqfnr }|.
    ENDIF.
    IF crear_orden-add_equnr_in_ktext IS NOT INITIAL.
      DATA(l_equnr) = CONV string( |{ detail-equnr ALPHA = OUT }| ).
      ktext = |{ ktext }-{ l_equnr }|.
    ENDIF.
    IF crear_orden-add_tidnr_in_ktext IS NOT INITIAL.
      ktext = |{ ktext }-{ detail-tidnr }|.
    ENDIF.

    " header
    methods = VALUE #( ( refnumber  = '000001'
                         objecttype = 'HEADER'
                         method     = 'CREATETONOTIF'
                         objectkey  = |%00000000001{ detail-qmnum }| ) ).

    DATA(headers) = VALUE bapi_alm_order_header_t( ( orderid     = '%00000000001'
                                                     order_type  = constant_global-orden_crear_tipo
                                                     start_date  = crear_orden-gstrp
                                                     finish_date = crear_orden-gltrp
                                                     short_text  = ktext
                                                     notif_no    = detail-qmnum
                                                     notif_type  = detail-qmart ) ).

    " partner
    IF crear_orden-contratista IS NOT INITIAL.
      APPEND VALUE #( refnumber  = '000001'
                      objecttype = 'PARTNER'
                      method     = 'CREATE'
                      objectkey  = '%00000000001' ) TO methods.

      APPEND VALUE #( partner    = crear_orden-contratista
                      partn_role = 'LF' ) TO partners.
    ENDIF.

    " hoja de ruta
    LOOP AT plkzs ASSIGNING FIELD-SYMBOL(<plkz>).
      APPEND VALUE #( refnumber  = CONV #( lines( tasklists ) + 1 )
                      objecttype = 'TASKLIST'
                      method     = 'ADD'
                      objectkey  = '%00000000001' ) TO methods.

      APPEND VALUE #( task_list_type  = <plkz>-plnty
                      task_list_group = <plkz>-plnnr
                      group_counter   = <plkz>-plnal ) TO tasklists.
    ENDLOOP.

    " aviso
    DATA(objectlists) = VALUE bapi_alm_order_objectlist_t( ( notif_no = detail-qmnum ) ).

    " extension
    DATA(zzlotedeenvio) = crear_orden-zzlotedeenvio.
    IF zzlotedeenvio IS INITIAL.
      utilities->get_snro( EXPORTING  is_inri  = VALUE #( object = 'ZLOTEDEENV'  )
                           IMPORTING  r_number = zzlotedeenvio
                           EXCEPTIONS error    = 1 ).
      IF sy-subrc <> 0.
        RAISE error.
      ENDIF.
    ENDIF.

    DATA(extension_ins) = VALUE bapiparex_tab( ( structure = 'ZZPEP' valuepart1 = crear_orden-zzpep )
                                               ( structure = 'ZZLOTEDEENVIO' valuepart1 = zzlotedeenvio ) ).

    APPEND VALUE #( refnumber = '000001'
                    method    = 'SAVE'
                    objectkey = '%00000000001' ) TO methods.

    NEW zeamcl_utilitarios( )->crear_orden( EXPORTING it_methods      = methods
                                                      it_header       = headers
                                                      it_partner      = partners
                                                      it_tasklist     = tasklists
                                                      it_extension_in = extension_ins
                                                      it_objectlist   = objectlists
                                            IMPORTING ep_aufnr        = aufnr
                                                      et_return       = returns ).

    IF aufnr IS INITIAL.
      MESSAGE e000(su) WITH 'No se ha creado la orden' RAISING error.
    ELSE.
      CLEAR returns.
    ENDIF.

    CLEAR methods.
    CLEAR partners.

    IF crear_orden-responsable IS NOT INITIAL.
      SELECT SINGLE parnr
        FROM aufk AS a
               INNER JOIN
                 ihpa AS b ON b~objnr = a~objnr
        WHERE aufnr = @aufnr
          AND parvw = 'VU'
        INTO @DATA(l_parnr).

      APPEND VALUE #( refnumber  = '000001'
                      objecttype = 'PARTNER'
                      method     = 'CHANGE'
                      objectkey  = aufnr ) TO methods.

      APPEND VALUE #( orderid        = aufnr
                      partn_role     = 'VU'
                      partn_role_old = 'VU'
                      partner        = crear_orden-responsable
                      partner_old    = l_parnr ) TO partners.

      APPEND VALUE #( orderid        = aufnr
                      partn_role     = abap_on
                      partn_role_old = 'VU'
                      partner        = abap_on
                      partner_old    = l_parnr ) TO partner_ups.
    ENDIF.

    IF plkzs IS NOT INITIAL.
      " now operations
      SELECT SINGLE aufpl INTO @DATA(aufpl) FROM afko WHERE aufnr = @aufnr.

      SELECT aufpl, plnty, plnnr, plnal, plnkn, aplzl, vornr
        INTO TABLE @DATA(afvc_nows)
        FROM afvc
        WHERE aufpl = @aufpl.

      " build update operation with data
      LOOP AT afvc_nows ASSIGNING FIELD-SYMBOL(<afvc_now>).
        ASSIGN plkzs[ plnty = <afvc_now>-plnty
                      plnnr = <afvc_now>-plnnr
                      plnal = <afvc_now>-plnal ] TO FIELD-SYMBOL(<bloque>).
        IF sy-subrc <> 0.
          MESSAGE e000(su) WITH 'No se encontró la hoja de ruta' INTO DATA(l_message) ##NEEDED.
          utilities->return_from_sy( CHANGING ct_return = returns ).
        ENDIF.

        " update equipo y factor de ejecución
        IF <bloque>-equnr IS INITIAL AND <bloque>-aufkt <= 1.
          CONTINUE.
        ENDIF.

        APPEND VALUE #( refnumber  = lines( operations ) + 1
                        objecttype = 'OPERATION'
                        method     = 'CHANGE'
                        objectkey  = aufnr && <afvc_now>-vornr ) TO methods.

        APPEND VALUE #( activity   = <afvc_now>-vornr
                        equipment  = <bloque>-equnr
                        execfactor = <bloque>-aufkt ) TO operations.

        APPEND VALUE #( activity   = abap_on
                        equipment  = COND #( WHEN <bloque>-equnr IS NOT INITIAL
                                             THEN abap_on
                                             ELSE space )
                        execfactor = COND #( WHEN <bloque>-aufkt > 1
                                             THEN abap_on
                                             ELSE space ) ) TO operation_ups.
      ENDLOOP.
    ENDIF.

    IF operations IS NOT INITIAL OR crear_orden-liberar IS NOT INITIAL.
      APPEND VALUE #( refnumber = '000001'
                      method    = 'SAVE'
                      objectkey = aufnr ) TO methods.
    ENDIF.

    IF crear_orden-liberar IS NOT INITIAL.
      APPEND VALUE #( refnumber  = '000001'
                      objecttype = 'HEADER'
                      method     = 'RELEASE'
                      objectkey  = aufnr ) TO methods.
    ENDIF.

    IF returns IS INITIAL.
      NEW zeamcl_utilitarios( )->actualizar_factor_operacion( EXPORTING it_methods        = methods
                                                                        it_partner        = partners
                                                                        it_partner_up     = partner_ups
                                                                        it_olist_relation = olist_relations
                                                                        it_operation      = operations
                                                                        it_operation_up   = operation_ups
                                                              IMPORTING et_return         = returns ).
    ENDIF.
  ENDMETHOD.

  METHOD bapi_status_change_intern.
    IF constant_global-aviso_modificar_status_usuario IS INITIAL.
      MESSAGE e000 WITH 'No se ha definido el estatus a modificar' RAISING error.
    ENDIF.

    NEW zeamcl_utilitarios( )->modificar_aviso_status_usuario(
          EXPORTING  i_objnr       = objnr
                     i_user_status = constant_global-aviso_modificar_status_usuario
          EXCEPTIONS error         = 1 ).
    IF sy-subrc <> 0.
      RAISE error.
    ENDIF.
  ENDMETHOD.

  METHOD build_compare.
    FIELD-SYMBOLS <detail_dynamics> TYPE STANDARD TABLE.

    IF sel_parameter-r_idmatriz_compare IS INITIAL OR sel_parameter-r_versio_compare IS INITIAL.
      RETURN.
    ENDIF.

    DATA(sel_parameter_local) = sel_parameter.

    ASSIGN detail_dynamics->* TO <detail_dynamics>.

    SELECT * INTO TABLE @DATA(matx_c_header)
      FROM ztbeam_12_matx_c
      WHERE idmatriz IN @sel_parameter-r_idmatriz_compare AND versio IN @sel_parameter-r_versio_compare.

    LOOP AT matx_c_header ASSIGNING FIELD-SYMBOL(<matx_c>).
      DATA(detail_locals) = details.

      CLEAR sel_parameter_local.
      sel_parameter_local-idmatriz = <matx_c>-idmatriz.
      sel_parameter_local-versio   = <matx_c>-versio.

      get_maestro_zpeam0012( EXPORTING  sel_parameter     = sel_parameter_local
                             IMPORTING  maestro_zpeam0012 = DATA(maestro_zpeam0012)
                             EXCEPTIONS error             = 1 ).
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      set_data_calculo_dinamico( EXPORTING comparison_flag   = abap_on
                                           data              = data
                                           maestro_zpeam0012 = maestro_zpeam0012
                                 CHANGING  details           = detail_locals ).

      LOOP AT <detail_dynamics> ASSIGNING FIELD-SYMBOL(<detail_dynamic>).
        ASSIGN COMPONENT 'equnr' OF STRUCTURE <detail_dynamic> TO FIELD-SYMBOL(<equnr>).

        READ TABLE detail_locals ASSIGNING FIELD-SYMBOL(<detail_local>) WITH KEY equnr = <equnr> BINARY SEARCH.
        IF sy-subrc = 0.
          ASSIGN COMPONENT <matx_c>-idmatriz && <matx_c>-versio OF STRUCTURE <detail_dynamic> TO FIELD-SYMBOL(<peso>).
          ASSIGN COMPONENT |{ <matx_c>-idmatriz }{ <matx_c>-versio }_RANKING| OF STRUCTURE <detail_dynamic> TO FIELD-SYMBOL(<ranking>).

          <peso> = <detail_local>-peso_calculado.
          <ranking> = <detail_local>-ranking.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD build_list_caracteri_averia.
    DATA caracteri_averia LIKE LINE OF caracteri_averias.

    DO 5 TIMES.
      ASSIGN COMPONENT |CODEGRUPPE{ sy-index }| OF STRUCTURE line TO FIELD-SYMBOL(<codegrup>).
      IF sy-subrc = 0.
        IF <codegrup> IS NOT INITIAL.
          ASSIGN COMPONENT |CODE{ sy-index }| OF STRUCTURE line TO FIELD-SYMBOL(<code>).
          IF sy-subrc = 0.
            IF <code> IS NOT INITIAL.
              CONCATENATE <codegrup> <code> INTO caracteri_averia-name_and_value.
              APPEND caracteri_averia TO caracteri_averias.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        EXIT.
      ENDIF.
    ENDDO.

    DO 5 TIMES.
      ASSIGN COMPONENT |ATINN{ sy-index }| OF STRUCTURE line TO FIELD-SYMBOL(<atinn>).
      IF sy-subrc = 0.
        IF <atinn> IS NOT INITIAL.
          ASSIGN COMPONENT |ATINN_VALUE{ sy-index }| OF STRUCTURE line TO FIELD-SYMBOL(<atinn_value>).
          IF sy-subrc = 0.
            CONCATENATE <atinn> <atinn_value> INTO caracteri_averia-name_and_value.
            APPEND caracteri_averia TO caracteri_averias.
          ENDIF.
        ENDIF.
      ELSE.
        EXIT.
      ENDIF.
    ENDDO.

    SORT caracteri_averias.
  ENDMETHOD.

  METHOD button_crear_update_avisos.
    DATA detail_locals TYPE gtt_detail.
    DATA qmnums        TYPE gtr_qmnum.

    FIELD-SYMBOLS <detail_dynamics> TYPE STANDARD TABLE.

    ASSIGN detail_dynamics_global->* TO <detail_dynamics>.
    detail_locals = CORRESPONDING #( <detail_dynamics> ).

    LOOP AT detail_locals TRANSPORTING NO FIELDS WHERE box = abap_on AND crear_o_actualizar_aviso = abap_on.
      EXIT.
    ENDLOOP.
    IF sy-subrc <> 0.
      MESSAGE e000 WITH 'Seleccione registro(s) generable(s) o' 'actualizable(s) de aviso(s)' RAISING error.
    ENDIF.

    LOOP AT detail_locals ASSIGNING FIELD-SYMBOL(<detail>) WHERE box = abap_on AND crear_o_actualizar_aviso = abap_on.
      IF <detail>-qmnum IS INITIAL.
        bapi_alm_notif_create( EXPORTING  matx_c_header = matx_c
                                          detail        = <detail>
                               IMPORTING  qmnum         = <detail>-qmnum
                                          returns       = DATA(lt_return)
                               EXCEPTIONS error         = 1 ).
      ELSE.
        bapi_status_change_intern( EXPORTING  objnr = <detail>-qmnum_objnr
                                   EXCEPTIONS error = 1 ).
        IF sy-subrc = 0.
          bapi_alm_notif_data_modify( EXPORTING  matx_c  = matx_c
                                                 detail  = <detail>
                                      IMPORTING  returns = lt_return
                                      EXCEPTIONS error   = 1 ).
        ENDIF.
      ENDIF.

      " icono
      IF sy-subrc = 0.
        CLEAR <detail>-crear_o_actualizar_aviso.
        <detail>-icon = icon_led_green.

        APPEND VALUE #( sign   = 'I'
                        option = 'EQ'
                        low    = <detail>-qmnum ) TO qmnums.
      ELSE.
        utilities->return_from_sy( CHANGING ct_return = lt_return ).
        <detail>-icon = icon_led_red.
        DATA(l_error) = abap_on.
      ENDIF.

      " mensaje
      IF lt_return IS NOT INITIAL.
        <detail>-message = lt_return[ 1 ]-message.
        CLEAR lt_return.
      ENDIF.
    ENDLOOP.

    " actualizar resultado
    get_avisos( EXPORTING qmnums   = qmnums
                IMPORTING qmih_p1s = DATA(lt_qmih) ).

    LOOP AT detail_locals ASSIGNING <detail> WHERE box = abap_on.
      ASSIGN <detail_dynamics>[ sy-tabix ] TO FIELD-SYMBOL(<detail_dynamic>).
      IF sy-subrc = 0.
        update_data_de_aviso_creada( EXPORTING qmihs          = lt_qmih
                                               detail         = <detail>
                                     CHANGING  detail_dynamic = <detail_dynamic> ).
      ENDIF.
    ENDLOOP.

    IF l_error IS INITIAL.
      MESSAGE s000 WITH 'Avisos creados/actualizados correctamente'.
    ELSE.
      MESSAGE e000 WITH 'Verificar errores obtenidos' RAISING error.
    ENDIF.
  ENDMETHOD.

  METHOD button_crear_ordenes.
    DATA detail_locals TYPE gtt_detail.
    DATA crear_orden   TYPE gty_crear_orden.
    DATA aufnrs        TYPE gtr_aufnr.

    FIELD-SYMBOLS <lt_detail_dynamic> TYPE STANDARD TABLE.

    ASSIGN detail_dynamic->* TO <lt_detail_dynamic>.
    detail_locals = CORRESPONDING #( <lt_detail_dynamic> ).

    is_creacion_orden_pendiente( EXPORTING  details = detail_locals
                                            message = 'generable(s)'
                                 EXCEPTIONS error   = 1 ).
    IF sy-subrc <> 0.
      RAISE error.
    ENDIF.

    PERFORM button_crear_ordenes IN PROGRAM zpeam0013.
    IMPORT ls_crear_orden = crear_orden FROM MEMORY ID sy-cprog.
    FREE MEMORY ID sy-cprog.

    IF crear_orden IS INITIAL.
      MESSAGE e000 WITH 'Acción cancelada...' RAISING error.
    ENDIF.

    LOOP AT detail_locals ASSIGNING FIELD-SYMBOL(<detail>)
         WHERE box = abap_on AND qmnum IS NOT INITIAL AND aufnr IS INITIAL.

      ASSIGN <lt_detail_dynamic>[ sy-tabix ] TO FIELD-SYMBOL(<detail_dynamic>).

      DATA(plkzs) = get_hojaruta_dinamica( detail_dynamic = <detail_dynamic> ).

      bapi_alm_orden_maintain( EXPORTING  detail      = <detail>
                                          crear_orden = crear_orden
                                          plkzs       = plkzs
                               IMPORTING  aufnr       = <detail>-aufnr
                                          returns     = DATA(lt_return)
                               EXCEPTIONS error       = 1 ).

      " icono
      IF sy-subrc = 0.
        CLEAR <detail>-crear_o_actualizar_aviso.
        <detail>-icon = icon_led_green.

        APPEND VALUE #( sign   = 'I'
                        option = 'EQ'
                        low    = <detail>-aufnr ) TO aufnrs.
      ELSE.
        utilities->return_from_sy( CHANGING ct_return = lt_return ).
        <detail>-icon = icon_led_red.
        DATA(l_error) = abap_on.
      ENDIF.

      " mensaje
      IF lt_return IS NOT INITIAL.
        <detail>-message = lt_return[ 1 ]-message.
        CLEAR lt_return.
      ENDIF.
    ENDLOOP.

    " actualizar
    get_ordenes( EXPORTING aufnrs = aufnrs
                 IMPORTING orden  = DATA(lt_orden) ).

    LOOP AT detail_locals ASSIGNING <detail>
         WHERE box = abap_on AND qmnum IS NOT INITIAL.

      ASSIGN <lt_detail_dynamic>[ sy-tabix ] TO <detail_dynamic>.
      IF sy-subrc = 0.
        update_data_de_orden_creada( EXPORTING detail         = <detail>
                                               ordens         = lt_orden
                                     CHANGING  detail_dynamic = <detail_dynamic> ).
      ENDIF.
    ENDLOOP.

    IF l_error IS INITIAL.
      MESSAGE s000 WITH 'Ordenes creados correctamente'.
    ELSE.
      MESSAGE e000 WITH 'Verificar errores obtenidos' RAISING error.
    ENDIF.
  ENDMETHOD.

  METHOD button_modify_individual_flds.
    DATA detail_locals TYPE gtt_detail.
    DATA edits         TYPE TABLE OF zsteam_13_alv_edit_crea_orden.

    FIELD-SYMBOLS <detail_dynamics> TYPE STANDARD TABLE.

    ASSIGN detail_dynamic->* TO <detail_dynamics>.
    detail_locals = CORRESPONDING #( <detail_dynamics> ).
    DATA(details2) = detail_locals.
    DELETE detail_locals WHERE box IS INITIAL.

    is_creacion_orden_pendiente( EXPORTING  details = detail_locals
                                            message = 'editable(s)'
                                 EXCEPTIONS error   = 1 ).
    IF sy-subrc <> 0.
      RAISE error.
    ENDIF.

    edits = CORRESPONDING #( detail_locals ).

    LOOP AT edits ASSIGNING FIELD-SYMBOL(<edit>).
      DO 6 TIMES.
        ASSIGN COMPONENT |PLNTY{ sy-index }| OF STRUCTURE <edit> TO FIELD-SYMBOL(<plnty>).
        IF sy-subrc = 0.
          <plnty> = 'A'.
        ENDIF.
      ENDDO.
    ENDLOOP.

    alv_modif_individual_campos( CHANGING tables = edits ).

    LOOP AT edits ASSIGNING <edit>.
      READ TABLE details2 WITH KEY equnr = <edit>-equnr TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      ASSIGN <detail_dynamics>[ sy-tabix ] TO FIELD-SYMBOL(<detail_dynamic>).
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      " clear
      clear_plkz_fields( CHANGING cs_edit = <edit> ).

      MOVE-CORRESPONDING <edit> TO <detail_dynamic>.
    ENDLOOP.
  ENDMETHOD.

  METHOD button_modify_mass_flds.
    DATA detail_locals TYPE gtt_detail.
    DATA edits         TYPE TABLE OF zsteam_13_pop_edit_crea_orden.

    FIELD-SYMBOLS <lt_detail_dynamic> TYPE STANDARD TABLE.

    ASSIGN detail_dynamic->* TO <lt_detail_dynamic>.
    detail_locals = CORRESPONDING #( <lt_detail_dynamic> ).

    " validar
    is_creacion_orden_pendiente( EXPORTING  details = detail_locals
                                            message = 'editable(s)'
                                 EXCEPTIONS error   = 1 ).

    " ingresar
    APPEND INITIAL LINE TO edits ASSIGNING FIELD-SYMBOL(<edit>).
    DO 6 TIMES.
      ASSIGN COMPONENT |PLNTY{ sy-index }| OF STRUCTURE <edit> TO FIELD-SYMBOL(<plnty_init>).
      IF sy-subrc = 0.
        <plnty_init> = 'A'.
      ENDIF.
    ENDDO.

    alv_modif_masiva_campos( CHANGING   tables = edits
                             EXCEPTIONS error  = 1 ).
    IF sy-subrc <> 0.
      RAISE error.
    ENDIF.

    " clear
    LOOP AT edits ASSIGNING <edit>.
      clear_plkz_fields( CHANGING cs_edit = <edit> ).
    ENDLOOP.

    LOOP AT detail_locals TRANSPORTING NO FIELDS WHERE box = abap_on.
      ASSIGN <lt_detail_dynamic>[ sy-tabix ] TO FIELD-SYMBOL(<detail_dynamic>).
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      MOVE-CORRESPONDING <edit> TO <detail_dynamic>.
    ENDLOOP.
  ENDMETHOD.

  METHOD check_auth.
  ENDMETHOD.

  METHOD constructor.
    utilities = NEW #( ).

    TRY.
        DATA(lo_ce) = NEW zcl_admin_constants( pi_modul = 'EAM'
                                               pi_repid = 'ZPEAM0013' ).
        lo_ce->get_range( EXPORTING pi_fieldname = 'FILTRO_EQUIPO_STATUS_SISTEMA'
                          CHANGING  pt_range     = constant_global-r_filtro_equipo_status_sistema ).
        lo_ce->get_range( EXPORTING pi_fieldname = 'FILTRO_EQUIPO_STATUS_USUARIO'
                          CHANGING  pt_range     = constant_global-r_filtro_equipo_status_usuario ).

        lo_ce->get_value( EXPORTING pi_fieldname = 'AVISO_CREAR_QMART'
                          CHANGING  pc_value     = constant_global-aviso_crear_qmart ).
        lo_ce->get_value( EXPORTING pi_fieldname = 'AVISO_MODIFICAR_STATUS_USUARIO'
                          CHANGING  pc_value     = constant_global-aviso_modificar_status_usuario ).

        lo_ce->get_value( EXPORTING pi_fieldname = 'ORDEN_CREAR_TIPO'
                          CHANGING  pc_value     = constant_global-orden_crear_tipo ).

      CATCH cx_root INTO DATA(lx_root).
        MESSAGE lx_root->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.

  METHOD create_catalogo_dinamico.
    utilities->alv_fcat_gen( IMPORTING et_fcat  = fcats
                             CHANGING  ct_table = details ).

    LOOP AT fcats ASSIGNING FIELD-SYMBOL(<fcat>).
      CLEAR <fcat>-ref_field.
    ENDLOOP.

    " borrar campos internos
    READ TABLE fcats WITH KEY fieldname = 'OBJNR' TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      DELETE fcats FROM sy-tabix.
    ENDIF.

    " campos a mostrar al final del reporte
    DATA(lt_fcat_final) = fcats.
    READ TABLE fcats WITH KEY fieldname = 'PESO_CALCULADO' TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      DELETE fcats FROM sy-tabix.
      DELETE lt_fcat_final FROM 1 TO sy-tabix - 1.
    ENDIF.

    " características y averías de matriz de detalle
    LOOP AT maestro_zpeam0012-matx_d ASSIGNING FIELD-SYMBOL(<matx_d>).

      READ TABLE maestro_zpeam0012-cabn ASSIGNING FIELD-SYMBOL(<cabn>) WITH KEY atnam = <matx_d>-varname BINARY SEARCH.
      IF sy-subrc = 0.
        APPEND VALUE #( fieldname = <cabn>-atnam
                        datatype  = COND #( WHEN <cabn>-atfor = 'NUM'  THEN ''
                                            WHEN <cabn>-atfor = 'TIME' THEN 'TIMS'
                                            WHEN <cabn>-atfor = 'DATE' THEN 'DATS'
                                            ELSE                            'STRG' )
                        inttype   = COND #( WHEN <cabn>-atfor = 'NUM' THEN 'P' )
                        intlen    = COND #( WHEN <cabn>-atfor = 'NUM' THEN '13' )
                        decimals  = COND #( WHEN <cabn>-atfor = 'NUM' THEN <cabn>-anzdz )
                        emphasize = 'C500'
                        seltext   = <cabn>-atbez
                        scrtext_l = <cabn>-atbez ) TO fcats.
      ENDIF.

      READ TABLE maestro_zpeam0012-qpgr ASSIGNING FIELD-SYMBOL(<qpgr>) WITH KEY codegruppe = <matx_d>-varname BINARY SEARCH.
      IF sy-subrc = 0.
        APPEND VALUE #( fieldname = |{ <matx_d>-varname }|
                        datatype  = 'STRG'
                        emphasize = 'C300'
                        seltext   = <qpgr>-kurztext
                        scrtext_l = <qpgr>-kurztext ) TO fcats.
      ENDIF.
    ENDLOOP.

    " peso calculado
    LOOP AT maestro_zpeam0012-matx_d ASSIGNING <matx_d>.
      READ TABLE maestro_zpeam0012-cabn ASSIGNING <cabn> WITH KEY atnam = <matx_d>-varname BINARY SEARCH.
      IF sy-subrc = 0.
        DATA(l_name) = |{ <cabn>-atbez }|.
      ELSE.
        READ TABLE maestro_zpeam0012-qpgr ASSIGNING <qpgr> WITH KEY codegruppe = <matx_d>-varname BINARY SEARCH.
        IF sy-subrc = 0.
          l_name = |{ <qpgr>-kurztext }|.
        ENDIF.
      ENDIF.
      IF sy-subrc = 0.
        APPEND VALUE #( fieldname = |{ <matx_d>-varname }_PESO|
                        datatype  = 'CMM_MTM_FACT_OPEN'
                        emphasize = 'C100'
                        seltext   = |P-{ l_name }|
                        scrtext_l = |P-{ l_name }| ) TO fcats.
      ENDIF.
    ENDLOOP.

    " características restantes
    LOOP AT cabns ASSIGNING <cabn>.
      IF line_exists( fcats[ fieldname = <cabn>-atnam ] ).
        CONTINUE.
      ENDIF.

      APPEND VALUE #( fieldname = <cabn>-atnam
                      datatype  = COND #( WHEN <cabn>-atfor = 'NUM'  THEN ''
                                          WHEN <cabn>-atfor = 'TIME' THEN 'TIMS'
                                          WHEN <cabn>-atfor = 'DATE' THEN 'DATS'
                                          ELSE                            'STRG' )
                      inttype   = COND #( WHEN <cabn>-atfor = 'NUM' THEN 'P' )
                      intlen    = COND #( WHEN <cabn>-atfor = 'NUM' THEN '13' )
                      decimals  = COND #( WHEN <cabn>-atfor = 'NUM' THEN <cabn>-anzdz )
                      emphasize = 'C400'
                      seltext   = <cabn>-atbez
                      scrtext_l = <cabn>-atbez ) TO fcats.
    ENDLOOP.

    " peso y ranking para comparación
    LOOP AT maestro_zpeam0012-matx_c_compare ASSIGNING FIELD-SYMBOL(<matx_c>).
      IF line_exists( fcats[ fieldname = <matx_c>-idmatriz && <matx_c>-versio ] ).
        CONTINUE.
      ENDIF.

      APPEND VALUE #( fieldname = <matx_c>-idmatriz && <matx_c>-versio
                      datatype  = 'ZE_PESO_CALCULADO'
                      emphasize = 'C100'
                      seltext   = |{ <matx_c>-idmatriz } { <matx_c>-versio } { 'Peso Calculado' }|
                      scrtext_l = |{ <matx_c>-idmatriz } { <matx_c>-versio } { 'Peso Calculado' }| ) TO fcats.

      APPEND VALUE #( fieldname = |{ <matx_c>-idmatriz }{ <matx_c>-versio }_RANKING|
                      datatype  = 'ZE_RANKING'
                      emphasize = 'C100'
                      seltext   = |{ <matx_c>-idmatriz } { <matx_c>-versio } { 'Posición en el ranking' } |
                      scrtext_l = |{ <matx_c>-idmatriz } { <matx_c>-versio } { 'pos. Rank' } | ) TO fcats.
    ENDLOOP.

    " campos finales
    APPEND LINES OF lt_fcat_final TO fcats.

    LOOP AT fcats ASSIGNING <fcat>.
      <fcat>-col_pos = sy-tabix.
    ENDLOOP.
  ENDMETHOD.

  METHOD getset_status_dynamic.
    TYPES: BEGIN OF ty_status,
             stat_system TYPE string,
             stat_user   TYPE string,
           END OF ty_status.

    DATA statu TYPE ty_status.

    CHECK dynamics IS NOT INITIAL.

    SELECT a~objnr,
           stat,
           inact,
           c~txt04 AS system,
           d~estat,
           d~txt04 AS user
      INTO TABLE @DATA(lt_jest)
      FROM jsto AS a
             INNER JOIN
               jest AS b ON b~objnr = a~objnr
                 LEFT JOIN
                   tj02t AS c ON  c~istat = b~stat
                              AND c~spras = @sy-langu
                     LEFT JOIN
                       tj30t AS d ON  d~stsma = a~stsma
                                  AND d~estat = b~stat
                                  AND d~spras = @sy-langu
      FOR ALL ENTRIES IN @dynamics
      WHERE ('a~objnr = @ct_dinamico-objnr').

    SORT lt_jest BY objnr.
    DELETE lt_jest WHERE inact = abap_on.

    LOOP AT dynamics ASSIGNING FIELD-SYMBOL(<detail>).

      ASSIGN COMPONENT 'objnr' OF STRUCTURE <detail> TO FIELD-SYMBOL(<objnr>).
      IF sy-subrc <> 0.
        EXIT.
      ENDIF.

      READ TABLE lt_jest WITH KEY objnr = <objnr> TRANSPORTING NO FIELDS BINARY SEARCH.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      LOOP AT lt_jest ASSIGNING FIELD-SYMBOL(<jest>) FROM sy-tabix.
        IF <jest>-objnr <> <objnr>.
          EXIT.
        ENDIF.

        IF <jest>-user IS INITIAL.
          IF status_systems IS NOT INITIAL.
            IF <jest>-system NOT IN status_systems.
              CLEAR <objnr>.
              EXIT.
            ENDIF.
          ENDIF.

          IF statu-stat_system IS INITIAL.
            statu-stat_system = <jest>-system.
          ELSE.
            statu-stat_system = |{ statu-stat_system } { <jest>-system }|.
          ENDIF.
        ELSE.
          IF status_users IS NOT INITIAL.
            IF <jest>-user NOT IN status_users.
              CLEAR <objnr>.
              EXIT.
            ENDIF.
          ENDIF.

          IF statu-stat_user IS INITIAL.
            statu-stat_user = <jest>-user.
          ELSE.
            statu-stat_user = |{ statu-stat_user } { <jest>-user }|.
          ENDIF.
        ENDIF.
      ENDLOOP.

      MOVE-CORRESPONDING statu TO <detail>.
      CLEAR statu.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_avisos.
    IF details IS NOT INITIAL.
      SELECT a~qmnum
             a~equnr
             b~qmart
             b~erdat
             b~mzeit
             b~objnr
             b~qmdab
             b~zzlegado
             b~zzcodleg
             b~zzranking
             b~zzrecomen
             b~zzpeso_calculado
        INTO TABLE qmih_p1s
        FROM qmih AS a
               INNER JOIN
                 qmel AS b ON a~qmnum = b~qmnum
        FOR ALL ENTRIES IN details
        WHERE equnr = details-equnr.

    ELSEIF qmnums IS NOT INITIAL.
      SELECT a~qmnum
             a~equnr
             b~qmart
             b~erdat
             b~mzeit
             b~objnr
             b~qmdab
             b~zzlegado
             b~zzcodleg
             b~zzranking
             b~zzrecomen
             b~zzpeso_calculado
        INTO TABLE qmih_p1s
        FROM qmih AS a
               INNER JOIN
                 qmel AS b ON a~qmnum = b~qmnum
        FOR ALL ENTRIES IN qmnums
        WHERE a~qmnum = qmnums-low.
    ENDIF.

    " excluir avisos cerrados
    DELETE qmih_p1s WHERE qmdab IS NOT INITIAL.

    getset_status_dynamic( CHANGING dynamics = qmih_p1s ).

    SORT qmih_p1s BY qmnum
                     qmart
                     erdat DESCENDING
                     mzeit DESCENDING.
    DELETE ADJACENT DUPLICATES FROM qmih_p1s COMPARING qmnum.

    IF qmih_p1s IS NOT INITIAL.
      SELECT qmnum fenum fegrp fecod fever
        INTO TABLE qmfes
        FROM qmfe
        FOR ALL ENTRIES IN qmih_p1s
        WHERE qmnum = qmih_p1s-qmnum.
    ENDIF.

    qmih_averias = qmih_p1s.
    DELETE qmih_p1s WHERE qmart <> constant_global-aviso_crear_qmart.
    DELETE qmih_averias WHERE qmart = constant_global-aviso_crear_qmart.

    LOOP AT qmfes ASSIGNING FIELD-SYMBOL(<qmfe>).
      READ TABLE qpcds ASSIGNING FIELD-SYMBOL(<qpcd>) WITH KEY codegruppe = <qmfe>-fegrp
                                                               code       = <qmfe>-fecod BINARY SEARCH.
      IF sy-subrc = 0.
        <qmfe>-value_para_alv = |{ <qmfe>-fecod } { <qpcd>-kurztext }|.
      ENDIF.
    ENDLOOP.

    SORT qmih_p1s BY equnr
                     qmnum DESCENDING.
    SORT qmih_averias BY equnr
                         qmnum DESCENDING.
    SORT qmfes BY qmnum
                  fenum.
  ENDMETHOD.

  METHOD get_caracteristicas.
    DATA dec TYPE p LENGTH 8 DECIMALS 0.

    SELECT * INTO CORRESPONDING FIELDS OF TABLE ausps
      FROM ausp
      FOR ALL ENTRIES IN details
      WHERE objek = details-objek.

    DATA(ausp_atinns) = ausps.
    SORT ausp_atinns BY atinn
                        atwrt
                        atflv.
    DELETE ADJACENT DUPLICATES FROM ausp_atinns COMPARING atinn.
    DELETE ausp_atinns WHERE atwrt IS INITIAL AND atflv IS INITIAL.

    IF ausp_atinns IS NOT INITIAL.
      SELECT a~atinn
             a~adzhl
             atnam
             atfor
             anzdz
             atbez
        INTO TABLE cabns
        FROM cabn AS a
               LEFT JOIN
                 cabnt AS b ON b~atinn = a~atinn AND b~spras = sy-langu
        FOR ALL ENTRIES IN ausp_atinns
        WHERE a~atinn = ausp_atinns-atinn.

      SELECT atinn atzhl atwtb INTO TABLE cawnts
        FROM cawnt
        FOR ALL ENTRIES IN cabns
        WHERE atinn = cabns-atinn
          AND spras = sy-langu.
    ENDIF.

    SORT ausps BY objek.
    SORT cabns BY atinn.
    SORT cawnts BY atinn
                   atzhl.

    LOOP AT ausps ASSIGNING FIELD-SYMBOL(<ausp>).
      READ TABLE cabns ASSIGNING FIELD-SYMBOL(<cabn>) WITH KEY atinn = <ausp>-atinn BINARY SEARCH.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      <ausp>-cabn_atnam = <cabn>-atnam.

      CASE <cabn>-atfor.
        WHEN 'CHAR'.
          READ TABLE cawnts ASSIGNING FIELD-SYMBOL(<cawt>) WITH KEY atinn = <ausp>-atinn
                                                                    atzhl = <ausp>-atzhl BINARY SEARCH.
          IF sy-subrc = 0.
            <ausp>-value_para_alv = <cawt>-atwtb.
          ELSE.
            <ausp>-value_para_alv = <ausp>-atwrt.
          ENDIF.

        WHEN 'NUM'.
          CATCH SYSTEM-EXCEPTIONS import_mismatch_errors = 1.
            dec = <ausp>-atflv.
            <ausp>-value_para_alv = dec.
            CONDENSE <ausp>-value_para_alv.
          ENDCATCH.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_maestro_zpeam0012.
    DATA hreqse_principal LIKE LINE OF maestro_zpeam0012-hreqse.

    SELECT SINGLE * INTO maestro_zpeam0012-matx_c
      FROM ztbeam_12_matx_c
      WHERE idmatriz = sel_parameter-idmatriz
        AND versio   = sel_parameter-versio.
    IF sy-subrc <> 0.
      MESSAGE e000 WITH 'No hay matriz seleccionada...' RAISING error.
    ENDIF.

    " get
    SELECT * INTO TABLE maestro_zpeam0012-averia
      FROM ztbeam_12_averia
      WHERE idmatriz = sel_parameter-idmatriz AND versio = sel_parameter-versio.
    SELECT * INTO TABLE maestro_zpeam0012-caract
      FROM ztbeam_12_caract
      WHERE idmatriz = sel_parameter-idmatriz AND versio = sel_parameter-versio.
    SELECT * INTO TABLE maestro_zpeam0012-ptomed
      FROM ztbeam_12_ptomed
      WHERE idmatriz = sel_parameter-idmatriz AND versio = sel_parameter-versio.

    SELECT * INTO TABLE maestro_zpeam0012-matx_d
      FROM ztbeam_12_matx_d
      WHERE idmatriz = sel_parameter-idmatriz AND versio = sel_parameter-versio.
    SELECT * INTO TABLE maestro_zpeam0012-matx_f
      FROM ztbeam_12_matx_f
      WHERE idmatriz = sel_parameter-idmatriz AND versio = sel_parameter-versio.
    SELECT * INTO CORRESPONDING FIELDS OF TABLE maestro_zpeam0012-matx_r
      FROM ztbeam_12_matx_r
      WHERE idmatriz = sel_parameter-idmatriz AND versio = sel_parameter-versio.
    SELECT * INTO CORRESPONDING FIELDS OF TABLE maestro_zpeam0012-hreqpr
      FROM ztbeam_12_hreqpr
      WHERE idmatriz = sel_parameter-idmatriz AND versio = sel_parameter-versio.
    SELECT * INTO CORRESPONDING FIELDS OF TABLE maestro_zpeam0012-hreqse
      FROM ztbeam_12_hreqse
      WHERE idmatriz = sel_parameter-idmatriz AND versio = sel_parameter-versio.

    IF maestro_zpeam0012-caract IS NOT INITIAL.
      SELECT a~atinn
             a~adzhl
             atnam
             atfor
             anzdz
             atbez
        INTO TABLE maestro_zpeam0012-cabn
        FROM cabn AS a
               LEFT JOIN
                 cabnt AS b ON b~atinn = a~atinn AND b~spras = sy-langu
        FOR ALL ENTRIES IN maestro_zpeam0012-caract
        WHERE a~atinn = maestro_zpeam0012-caract-atinn.
    ENDIF.

    IF maestro_zpeam0012-averia IS NOT INITIAL.
      SELECT a~codegruppe
             kurztext
        INTO TABLE maestro_zpeam0012-qpgr
        FROM qpgr AS a
               LEFT JOIN
                 qpgt AS b ON  b~katalogart = a~katalogart
                           AND b~codegruppe = a~codegruppe
                           AND b~sprache    = sy-langu
        FOR ALL ENTRIES IN maestro_zpeam0012-averia
        WHERE a~katalogart = 'C'
          AND a~codegruppe = maestro_zpeam0012-averia-codegruppe.

      SELECT a~codegruppe
             a~code
             a~version
             kurztext
        INTO TABLE maestro_zpeam0012-qpcd
        FROM qpcd AS a
               LEFT JOIN
                 qpct AS b ON  b~katalogart = a~katalogart
                           AND b~codegruppe = a~codegruppe
                           AND b~code       = a~code
                           AND b~sprache    = sy-langu
                           AND b~version    = a~version
        FOR ALL ENTRIES IN maestro_zpeam0012-averia
        WHERE a~katalogart = 'C'
          AND a~codegruppe = maestro_zpeam0012-averia-codegruppe
          AND a~code       = maestro_zpeam0012-averia-code.
    ENDIF.

    " tipo de objeto
    maestro_zpeam0012-matx_d_principal = maestro_zpeam0012-matx_d.
    DELETE maestro_zpeam0012-matx_d_principal WHERE tipo_objeto_tecnico <> gs_tipo_objeto_tecnico-equipo_principal.

    maestro_zpeam0012-matx_d_secundario = maestro_zpeam0012-matx_d.
    DELETE maestro_zpeam0012-matx_d_secundario WHERE tipo_objeto_tecnico <> gs_tipo_objeto_tecnico-equipo_secundario.

    " build
    LOOP AT maestro_zpeam0012-matx_r ASSIGNING FIELD-SYMBOL(<matx_r>).
      build_list_caracteri_averia( IMPORTING caracteri_averias = <matx_r>-caracteri_averia
                                   CHANGING  line              = <matx_r> ).

      SELECT SINGLE recomendacion INTO <matx_r>-recomendacion
        FROM ztbeam_12_recome
        WHERE idrecomendacion = <matx_r>-idrecomendacion.

      <matx_r>-lines = lines( <matx_r>-caracteri_averia ).
    ENDLOOP.

    LOOP AT maestro_zpeam0012-hreqpr ASSIGNING FIELD-SYMBOL(<hreqpr>).
      build_list_caracteri_averia( IMPORTING caracteri_averias = <hreqpr>-caracteri_averia
                                   CHANGING  line              = <hreqpr> ).

      <hreqpr>-lines = lines( <hreqpr>-caracteri_averia ).
    ENDLOOP.

    " equipo secundario
    LOOP AT maestro_zpeam0012-hreqse ASSIGNING FIELD-SYMBOL(<hreqse>).

      " característica principal
      hreqse_principal = VALUE #( atinn1       = <hreqse>-atinn1
                                  atinn_value1 = <hreqse>-atinn_value1 ).
      build_list_caracteri_averia( IMPORTING caracteri_averias = <hreqse>-caracteri_averia_principal
                                   CHANGING  line              = hreqse_principal ).

      " característica secundario
      CLEAR <hreqse>-atinn1.
      CLEAR <hreqse>-atinn_value1.
      build_list_caracteri_averia( IMPORTING caracteri_averias = <hreqse>-caracteri_averia_secundario
                                   CHANGING  line              = <hreqse> ).

      <hreqse>-lines_principal  = lines( <hreqse>-caracteri_averia_principal ).
      <hreqse>-lines_secundario = lines( <hreqse>-caracteri_averia_secundario ).
    ENDLOOP.

    " sort
    SORT maestro_zpeam0012-matx_d BY posnr.
    SORT maestro_zpeam0012-matx_r BY eqart
                                     matx_r_pos.
    SORT maestro_zpeam0012-hreqpr BY idrecomendacion
                                     eqart.
    SORT maestro_zpeam0012-hreqse BY idrecomendacion
                                     eqart_principal
                                     eqart_secundario.

    SORT maestro_zpeam0012-averia BY codegruppe
                                     code.
    SORT maestro_zpeam0012-caract BY atinn
                                     atinn_value.

    SORT maestro_zpeam0012-cabn BY atnam.
    SORT maestro_zpeam0012-qpgr BY codegruppe.
    SORT maestro_zpeam0012-qpcd BY codegruppe
                                   code.
    SORT maestro_zpeam0012-matx_d_principal BY eqart
                                               varname.
    SORT maestro_zpeam0012-matx_d_secundario BY eqart
                                                varname.

    maestro_zpeam0012-averia_code_vacio  = maestro_zpeam0012-averia.
    maestro_zpeam0012-caract_value_vacio = maestro_zpeam0012-caract.

    DELETE maestro_zpeam0012-averia_code_vacio WHERE code IS NOT INITIAL.
    DELETE maestro_zpeam0012-caract_value_vacio WHERE atinn_value IS NOT INITIAL.

    DELETE maestro_zpeam0012-averia WHERE code IS INITIAL.
    DELETE maestro_zpeam0012-caract WHERE atinn_value IS INITIAL.

    " compare
    IF sel_parameter-r_idmatriz_compare IS NOT INITIAL.
      SELECT * INTO TABLE maestro_zpeam0012-matx_c_compare
        FROM ztbeam_12_matx_c
        WHERE idmatriz IN sel_parameter-r_idmatriz_compare AND versio IN sel_parameter-r_versio_compare.
    ENDIF.
  ENDMETHOD.

  METHOD get_data_sap_para_calcular.
    get_equipos_selection( EXPORTING  sel_parameter     = sel_parameter
                           IMPORTING  maestro_zpeam0012 = maestro_zpeam0012
                                      details           = details
                           EXCEPTIONS error             = 1 ).
    IF sy-subrc <> 0.
      RAISE error.
    ENDIF.

    get_avisos( EXPORTING details      = details
                          qpcds        = maestro_zpeam0012-qpcd
                IMPORTING qmih_p1s     = data-qmih_p1
                          qmih_averias = data-qmih_averias
                          qmfes        = data-qmfe ).

    get_ordenes( EXPORTING qmihs = data-qmih_p1
                 IMPORTING orden = data-orden ).

    get_caracteristicas( EXPORTING details = details
                         IMPORTING ausps   = data-ausp
                                   cabns   = data-cabn
                                   cawnts  = data-cawnt ).

    get_equipos_secundarios( EXPORTING details = details
                                       qpcds   = maestro_zpeam0012-qpcd
                             IMPORTING equis   = data-equi_secundario
                                       ausps   = data-ausp_secundario
                                       cabns   = data-cabn_secundario
                                       cawnts  = data-cawnt_secundario
                                       qmihs   = data-qmih_secundario
                                       qmfes   = data-qmfe_secundario ).

    set_avisos_y_ordenes( EXPORTING qmihs   = data-qmih_p1
                                    ordens  = data-orden
                          CHANGING  details = details ).
  ENDMETHOD.

  METHOD get_equipos_secundarios.
    DATA details_local TYPE gtt_detail.

    SELECT a~equnr
           a~hequi
           b~eqart
           b~objnr
      INTO CORRESPONDING FIELDS OF TABLE equis
      FROM equz AS a
             INNER JOIN
               equi AS b ON b~equnr = a~equnr
      FOR ALL ENTRIES IN details
      WHERE a~hequi  = details-equnr
        AND a~datbi >= sy-datlo.

    " excluir equipos cerrados
    IF equis IS NOT INITIAL.
      SELECT objnr, inact INTO TABLE @DATA(lt_jest)
        FROM jest
        FOR ALL ENTRIES IN @equis
        WHERE objnr = @equis-objnr
          AND stat  = 'I0072'.

      SORT lt_jest BY objnr.
      DELETE lt_jest WHERE inact = abap_on.

      LOOP AT equis ASSIGNING FIELD-SYMBOL(<detail>).
        READ TABLE lt_jest WITH KEY objnr = <detail>-objnr BINARY SEARCH TRANSPORTING NO FIELDS.
        IF sy-subrc <> 0.
          <detail>-objek = <detail>-equnr.
        ENDIF.
      ENDLOOP.

      DELETE equis WHERE objek IS INITIAL.
    ENDIF.

    IF equis IS INITIAL.
      RETURN.
    ENDIF.

    details_local = CORRESPONDING #( equis ).

    get_caracteristicas( EXPORTING details = details_local
                         IMPORTING ausps   = ausps
                                   cabns   = cabns
                                   cawnts  = cawnts ).

    get_avisos( EXPORTING details      = details_local
                          qpcds        = qpcds
                IMPORTING qmih_averias = qmihs
                          qmfes        = qmfes ).

    SORT equis BY hequi.
    SORT qmfes BY qmnum
                  fenum.
  ENDMETHOD.

  METHOD get_equipos_selection.
    DATA eqart_filters TYPE RANGE OF equi-eqart.
    DATA tplnr_filters TYPE RANGE OF iloa-tplnr.
    DATA begru_filters TYPE RANGE OF equi-begru.
    DATA ingrp_filters TYPE RANGE OF equz-ingrp.
    DATA stort_filters TYPE RANGE OF iloa-stort.

    get_maestro_zpeam0012( EXPORTING  sel_parameter     = sel_parameter
                           IMPORTING  maestro_zpeam0012 = maestro_zpeam0012
                           EXCEPTIONS error             = 1 ).
    IF sy-subrc <> 0.
      RAISE error.
    ENDIF.

    " filtro
    DATA(equnrs) = sel_parameter-r_equnr.
    DATA(eqarts) = sel_parameter-r_eqart.
    DATA(tplnrs) = sel_parameter-r_tplnr.
    DATA(begrus) = sel_parameter-r_begru.
    DATA(ingrps) = sel_parameter-r_ingrp.
    DATA(storts) = sel_parameter-r_stort.

    LOOP AT maestro_zpeam0012-matx_f ASSIGNING FIELD-SYMBOL(<matx_f>).
      APPEND VALUE #( sign   = 'I'
                      option = 'EQ'
                      low    = <matx_f>-eqart ) TO eqart_filters.
      IF <matx_f>-tplnr CS '*'.
        APPEND VALUE #( sign   = 'I'
                        option = 'CP'
                        low    = <matx_f>-tplnr ) TO tplnr_filters.
      ELSE.
        APPEND VALUE #( sign   = 'I'
                        option = 'EQ'
                        low    = <matx_f>-tplnr ) TO tplnr_filters.
      ENDIF.
      APPEND VALUE #( sign   = 'I'
                      option = 'EQ'
                      low    = <matx_f>-begru ) TO begru_filters.
      APPEND VALUE #( sign   = 'I'
                      option = 'EQ'
                      low    = <matx_f>-ingrp ) TO ingrp_filters.
      APPEND VALUE #( sign   = 'I'
                      option = 'EQ'
                      low    = <matx_f>-stort ) TO stort_filters.
    ENDLOOP.

    DELETE eqart_filters WHERE low IS INITIAL.
    DELETE tplnr_filters WHERE low IS INITIAL.
    DELETE begru_filters WHERE low IS INITIAL.
    DELETE ingrp_filters WHERE low IS INITIAL.
    DELETE stort_filters WHERE low IS INITIAL.
    IF eqarts IS INITIAL.
      APPEND LINES OF eqart_filters TO eqarts.
    ENDIF.
    IF tplnrs IS INITIAL.
      APPEND LINES OF tplnr_filters TO tplnrs.
    ENDIF.
    IF begrus IS INITIAL.
      APPEND LINES OF begru_filters TO begrus.
    ENDIF.
    IF ingrps IS INITIAL.
      APPEND LINES OF ingrp_filters TO ingrps.
    ENDIF.
    IF storts IS INITIAL.
      APPEND LINES OF stort_filters TO storts.
    ENDIF.

    " aviso filter
    IF sel_parameter-r_qmnum IS NOT INITIAL.
      SELECT qmnum, equnr INTO TABLE @DATA(lt_qmih)
        FROM qmih
        WHERE qmnum IN @sel_parameter-r_qmnum.

      equnrs = VALUE #( FOR ls IN lt_qmih
                        ( sign = 'I' option = 'EQ' low = ls-equnr ) ).
    ENDIF.

    " equipo
    SELECT a~equnr
           a~eqart
           a~begru
           a~herst
           a~baujj
           a~baumm
           a~inbdt
           a~objnr
           a~matnr
           a~sernr
           d~eqktx
           b~ingrp
           b~tidnr
           c~tplnr
           c~stort
           c~adrnr
      INTO CORRESPONDING FIELDS OF TABLE details
      FROM equi AS a
             INNER JOIN
               eqkt AS d ON  d~equnr = a~equnr
                         AND d~spras = sy-langu
                 INNER JOIN
                   equz AS b ON  b~equnr  = a~equnr
                             AND b~datbi >= sy-datlo
                             AND b~eqlfn  = a~eqlfn
                     INNER JOIN
                       iloa AS c ON c~iloan = b~iloan
      WHERE a~equnr IN equnrs
        AND a~eqart IN eqarts
        AND c~tplnr IN tplnrs
        AND a~begru IN begrus
        AND b~ingrp IN ingrps
        AND c~stort IN storts.

    DELETE details WHERE     eqart NOT IN eqart_filters
                         AND tplnr NOT IN tplnr_filters
                         AND begru NOT IN begru_filters
                         AND ingrp NOT IN ingrp_filters
                         AND stort NOT IN stort_filters.

    " excluir equipos cerrados
    getset_status_dynamic( EXPORTING status_systems = constant_global-r_filtro_equipo_status_sistema
                                     status_users   = constant_global-r_filtro_equipo_status_usuario
                           CHANGING  dynamics       = details ).
    DELETE details WHERE objnr IS INITIAL.

    IF details IS INITIAL.
      MESSAGE e000 WITH 'No se encontraron datos para el reporte' RAISING error.
    ENDIF.

    SELECT addrnumber, city2, post_code1
      INTO TABLE @DATA(lt_adrc)
      FROM adrc
      FOR ALL ENTRIES IN @details
      WHERE addrnumber = @details-adrnr.

    SORT lt_adrc BY addrnumber.

    LOOP AT details ASSIGNING FIELD-SYMBOL(<detail>).
      <detail>-objek = <detail>-equnr.

      READ TABLE lt_adrc ASSIGNING FIELD-SYMBOL(<adrc>) WITH KEY addrnumber = <detail>-adrnr BINARY SEARCH.
      IF sy-subrc = 0.
        <detail>-city2      = <adrc>-city2.
        <detail>-post_code1 = <adrc>-post_code1.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_hojaruta_dinamica.
    DATA plkz LIKE LINE OF plkzs.

    DO 6 TIMES.
      ASSIGN COMPONENT |equnr{ sy-index }| OF STRUCTURE detail_dynamic TO FIELD-SYMBOL(<equnr>).
      IF sy-subrc = 0.
        plkz-equnr = <equnr>.
      ENDIF.
      ASSIGN COMPONENT |plnty{ sy-index }| OF STRUCTURE detail_dynamic TO FIELD-SYMBOL(<plnty>).
      IF sy-subrc = 0.
        plkz-plnty = <plnty>.
      ENDIF.
      ASSIGN COMPONENT |plnnr{ sy-index }| OF STRUCTURE detail_dynamic TO FIELD-SYMBOL(<plnnr>).
      IF sy-subrc = 0.
        plkz-plnnr = <plnnr>.
      ENDIF.
      ASSIGN COMPONENT |plnal{ sy-index }| OF STRUCTURE detail_dynamic TO FIELD-SYMBOL(<plnal>).
      IF sy-subrc = 0.
        plkz-plnal = <plnal>.
      ENDIF.
      ASSIGN COMPONENT |aufkt{ sy-index }| OF STRUCTURE detail_dynamic TO FIELD-SYMBOL(<aufkt>).
      IF sy-subrc = 0.
        plkz-aufkt = <aufkt>.
      ENDIF.

      IF plkz-equnr IS NOT INITIAL AND plkz-plnty IS NOT INITIAL AND plkz-plnnr IS NOT INITIAL AND plkz-plnal IS NOT INITIAL.
        APPEND plkz TO plkzs.
      ENDIF.
      CLEAR plkz.
    ENDDO.
  ENDMETHOD.

  METHOD get_ordenes.
    TYPES: BEGIN OF ty_total,
             aufnr                  TYPE aufk-aufnr,
             cocur                  TYPE pmco_op-cocur,
             wrttp                  TYPE pmco_op-wrttp,
             gjahr                  TYPE pmco_op-gjahr,
             monat                  TYPE monat,
             aufnr_planificado_real TYPE dmbtr,
           END OF ty_total.

    DATA totals TYPE TABLE OF ty_total.
    DATA total  LIKE LINE OF totals.

    IF qmihs IS NOT INITIAL.
      SELECT a~aufnr
             qmnum
             auart
             objnr
             waers
             zzpep
             zzlotedeenvio
             gltrp
             gstrp
             aufpl
             ilart
        INTO CORRESPONDING FIELDS OF TABLE orden
        FROM afih AS a
               INNER JOIN
                 aufk AS b ON b~aufnr = a~aufnr
                   INNER JOIN
                     afko AS c ON c~aufnr = a~aufnr
        FOR ALL ENTRIES IN qmihs
        WHERE a~qmnum = qmihs-qmnum.
    ELSEIF aufnrs IS NOT INITIAL.
      SELECT a~aufnr
             auart
             objnr
             waers
             zzpep
             zzlotedeenvio
             gltrp
             gstrp
             aufpl
        INTO CORRESPONDING FIELDS OF TABLE orden
        FROM aufk AS a
               INNER JOIN
                 afko AS b ON b~aufnr = a~aufnr
        FOR ALL ENTRIES IN aufnrs
        WHERE a~aufnr = aufnrs-low.
    ENDIF.

    IF orden IS INITIAL.
      RETURN.
    ENDIF.

    SELECT objnr, parvw, counter, parnr
      INTO TABLE @DATA(ihpas)
      FROM ihpa
      FOR ALL ENTRIES IN @orden
      WHERE objnr = @orden-objnr.

    IF ihpas IS NOT INITIAL.
      SELECT lifnr, name1, name2 INTO TABLE @DATA(lfa1s)
        FROM lfa1
        FOR ALL ENTRIES IN @ihpas
        WHERE lifnr = @ihpas-parnr(10).

      SELECT bname, name_text INTO TABLE @DATA(usr21s)
        FROM usr21 AS a
               INNER JOIN
                 adrp AS b ON b~persnumber = a~persnumber
        FOR ALL ENTRIES IN @ihpas
        WHERE bname = @ihpas-parnr.
    ENDIF.

    SELECT aufpl, aplzl, objnr INTO TABLE @DATA(afvcs)
      FROM afvc
      FOR ALL ENTRIES IN @orden
      WHERE aufpl = @orden-aufpl.

    IF afvcs IS NOT INITIAL.
      SELECT * INTO TABLE @DATA(pmcos)
        FROM pmco_op
        FOR ALL ENTRIES IN @afvcs
        WHERE objnr = @afvcs-objnr.
    ENDIF.

    getset_status_dynamic( CHANGING dynamics = orden ).

    SORT lfa1s BY lifnr.
    SORT usr21s BY bname.
    SORT afvcs BY aufpl.
    SORT pmcos BY objnr.

    LOOP AT orden ASSIGNING FIELD-SYMBOL(<orden>).

      READ TABLE ihpas WITH KEY objnr = <orden>-objnr TRANSPORTING NO FIELDS BINARY SEARCH.
      IF sy-subrc = 0.
        LOOP AT ihpas ASSIGNING FIELD-SYMBOL(<ihpa>) FROM sy-tabix.
          IF <ihpa>-objnr <> <orden>-objnr.
            EXIT.
          ENDIF.

          READ TABLE lfa1s ASSIGNING FIELD-SYMBOL(<lfa1>) WITH KEY lifnr = <ihpa>-parnr(10) BINARY SEARCH.
          IF sy-subrc <> 0.
            READ TABLE usr21s ASSIGNING FIELD-SYMBOL(<usr21>) WITH KEY bname = <ihpa>-parnr BINARY SEARCH.
            IF sy-subrc = 0.
              DATA(l_full_name) = <usr21>-name_text.
            ENDIF.
          ELSE.
            l_full_name = |{ <lfa1>-name1 } { <lfa1>-name2 }|.
          ENDIF.

          IF <ihpa>-parvw = 'AB'.
            <orden>-parnr_ab      = <ihpa>-parnr.
            <orden>-parnr_ab_text = l_full_name.
          ELSEIF <ihpa>-parvw = 'VU'.
            <orden>-parnr_vu      = <ihpa>-parnr.
            <orden>-parnr_vu_text = l_full_name.
          ELSEIF <ihpa>-parvw = 'LF'.
            <orden>-parnr_pr      = <ihpa>-parnr.
            <orden>-parnr_pr_text = l_full_name.
          ELSEIF <ihpa>-parvw = 'VW'.
            <orden>-parnr_vw      = <ihpa>-parnr.
            <orden>-parnr_vw_text = l_full_name.
          ENDIF.
        ENDLOOP.
      ENDIF.

      READ TABLE afvcs WITH KEY aufpl = <orden>-aufpl TRANSPORTING NO FIELDS BINARY SEARCH.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      LOOP AT afvcs ASSIGNING FIELD-SYMBOL(<afvc>) FROM sy-tabix.
        IF <afvc>-aufpl <> <orden>-aufpl.
          EXIT.
        ENDIF.

        READ TABLE pmcos ASSIGNING FIELD-SYMBOL(<pmco>) WITH KEY objnr = <afvc>-objnr BINARY SEARCH.
        IF sy-subrc <> 0.
          CONTINUE.
        ENDIF.

        total-cocur = <pmco>-cocur.
        total-wrttp = <pmco>-wrttp.
        total-gjahr = <pmco>-gjahr.

        DO 16 TIMES.
          total-monat = sy-index.
          ASSIGN COMPONENT |WRT{ total-monat }| OF STRUCTURE <pmco> TO FIELD-SYMBOL(<wrt>).
          total-aufnr_planificado_real = <wrt>.
          CLEAR total-monat.
          COLLECT total INTO totals.
        ENDDO.
      ENDLOOP.

      SORT totals BY cocur
                     wrttp
                     gjahr DESCENDING
                     monat DESCENDING.
      READ TABLE totals ASSIGNING FIELD-SYMBOL(<total>) WITH KEY cocur = <orden>-waers
                                                                 wrttp = '01' BINARY SEARCH.
      IF sy-subrc = 0.
        <orden>-planificado = <total>-aufnr_planificado_real.
      ENDIF.

      READ TABLE totals ASSIGNING <total> WITH KEY cocur = <orden>-waers
                                                   wrttp = '04' BINARY SEARCH.
      IF sy-subrc = 0.
        <orden>-real = <total>-aufnr_planificado_real.
      ENDIF.

      CLEAR totals.
    ENDLOOP.

    SORT orden BY qmnum.
  ENDMETHOD.

  METHOD is_creacion_orden_pendiente.
    LOOP AT details TRANSPORTING NO FIELDS WHERE box = abap_on AND qmnum IS NOT INITIAL.
      EXIT.
    ENDLOOP.
    IF sy-subrc = 0.
      LOOP AT details TRANSPORTING NO FIELDS WHERE box = abap_on AND aufnr IS NOT INITIAL.
        EXIT.
      ENDLOOP.
      IF sy-subrc = 0.
        MESSAGE e000 WITH 'Seleccione registro(s)' message 'de orden(es)' RAISING error.
      ENDIF.
    ELSE.
      MESSAGE e000 WITH 'Seleccione registro(s)' message 'de orden(es)' RAISING error.
    ENDIF.
  ENDMETHOD.

  METHOD is_crear_o_actualizar_aviso.
    IF    detail-zzcodleg         <> |{ matx_c-idmatriz }-{ matx_c-versio }|
       OR detail-zzpeso_calculado <> detail-peso_calculado.
      r_crear_o_actualizar_aviso = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD main.
    FIELD-SYMBOLS <detail_dynamics> TYPE STANDARD TABLE.

    CLEAR data_sap_global.

    " auth
    check_auth( EXPORTING  sel_parameter = sel_parameter
                EXCEPTIONS error         = 1 ).
    IF sy-subrc <> 0.
      RAISE error.
    ENDIF.

    " build
    get_data_sap_para_calcular( EXPORTING  sel_parameter     = sel_parameter
                                IMPORTING  data              = data_sap_global
                                           maestro_zpeam0012 = maestro_zpeam0012_global
                                           details           = DATA(details)
                                EXCEPTIONS error             = 1 ).
    IF sy-subrc = 0.
      DATA(lt_det2) = details.

      set_data_calculo_dinamico( EXPORTING data              = data_sap_global
                                           maestro_zpeam0012 = maestro_zpeam0012_global
                                 IMPORTING fcats             = DATA(fcats)
                                           detail_dynamic    = detail_dynamics_global
                                 CHANGING  details           = details ).

      build_compare( EXPORTING sel_parameter   = sel_parameter
                               details         = lt_det2
                               data            = data_sap_global
                     CHANGING  detail_dynamics = detail_dynamics_global ).

      FREE data_sap_global.
      FREE details.
      FREE lt_det2.
    ELSE.
      RAISE error.
    ENDIF.

    IF sel_parameter-crear_o_actualizar_aviso IS NOT INITIAL.
      ASSIGN detail_dynamics_global->* TO <detail_dynamics>.
      DELETE <detail_dynamics> WHERE ('crear_o_actualizar_aviso IS INITIAL').

      LOOP AT <detail_dynamics> ASSIGNING FIELD-SYMBOL(<detail_dynamic>).
        ASSIGN COMPONENT 'box' OF STRUCTURE <detail_dynamic> TO FIELD-SYMBOL(<box>).
        <box> = abap_on.
      ENDLOOP.

      button_crear_update_avisos( EXPORTING  matx_c                 = maestro_zpeam0012_global-matx_c
                                  CHANGING   detail_dynamics_global = detail_dynamics_global
                                  EXCEPTIONS error                  = 1 ).
      IF sy-subrc <> 0.
        RAISE error.
      ENDIF.
    ENDIF.

    " alv
    alv_main( EXPORTING variant         = sel_parameter-variant
              CHANGING  detail_dynamics = detail_dynamics_global
                        fcats           = fcats ).
  ENDMETHOD.

  METHOD set_averias.
    READ TABLE qmfes WITH KEY qmnum = qmnum BINARY SEARCH TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    LOOP AT qmfes ASSIGNING FIELD-SYMBOL(<qmfe>) FROM sy-tabix.
      IF <qmfe>-qmnum <> qmnum.
        EXIT.
      ENDIF.

      READ TABLE matx_ds ASSIGNING FIELD-SYMBOL(<matx_d>) WITH KEY eqart   = eqart
                                                                   varname = <qmfe>-fegrp BINARY SEARCH.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      " peso y peso calculado
      READ TABLE averias ASSIGNING FIELD-SYMBOL(<averia>) WITH KEY codegruppe = <qmfe>-fegrp
                                                                   code       = <qmfe>-fecod BINARY SEARCH.
      IF sy-subrc <> 0.
        READ TABLE averias ASSIGNING <averia> WITH KEY codegruppe = <qmfe>-fegrp
                                                       code       = space BINARY SEARCH.
      ENDIF.
      IF sy-subrc = 0.
        peso_calculado += <averia>-peso * <matx_d>-peso / 100.
      ENDIF.

      " append listado
      APPEND VALUE #( equnr          = equnr
                      name           = <qmfe>-fegrp
                      value_para_alv = <qmfe>-value_para_alv
                      name_and_value = <qmfe>-fegrp && <qmfe>-fecod
                      peso           = <averia>-peso ) TO caracteri_averias.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_avisos_y_ordenes.
    LOOP AT details ASSIGNING FIELD-SYMBOL(<detail>).

      READ TABLE qmihs ASSIGNING FIELD-SYMBOL(<qmih>) WITH KEY equnr = <detail>-equnr BINARY SEARCH.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      <detail>-qmnum             = <qmih>-qmnum.
      <detail>-qmart             = <qmih>-qmart.
      <detail>-qmnum_objnr       = <qmih>-objnr.
      <detail>-zzlegado          = <qmih>-zzlegado.
      <detail>-zzcodleg          = <qmih>-zzcodleg.
      <detail>-zzranking         = <qmih>-zzranking.
      <detail>-zzrecomen         = <qmih>-zzrecomen.
      <detail>-zzpeso_calculado  = <qmih>-zzpeso_calculado.
      <detail>-qmnum_stat_system = <qmih>-stat_system.
      <detail>-qmnum_stat_user   = <qmih>-stat_user.

      READ TABLE ordens ASSIGNING FIELD-SYMBOL(<orden>) WITH KEY qmnum = <qmih>-qmnum BINARY SEARCH.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      <detail>-aufnr             = <orden>-aufnr.
      <detail>-auart             = <orden>-auart.
      <detail>-zzpep             = <orden>-zzpep.
      <detail>-zzlotedeenvio     = <orden>-zzlotedeenvio.
      <detail>-gltrp             = <orden>-gltrp.
      <detail>-gstrp             = <orden>-gstrp.

      <detail>-aufnr_planificado = <orden>-planificado.
      <detail>-aufnr_real        = <orden>-real.

      <detail>-aufnr_stat_system = <orden>-stat_system.
      <detail>-aufnr_stat_user   = <orden>-stat_user.
      <detail>-ilart             = <orden>-ilart.

      <detail>-parnr_ab          = <orden>-parnr_ab.
      <detail>-parnr_ab_text     = <orden>-parnr_ab_text.
      <detail>-parnr_vu          = <orden>-parnr_vu.
      <detail>-parnr_vu_text     = <orden>-parnr_vu_text.
      <detail>-parnr_pr          = <orden>-parnr_pr.
      <detail>-parnr_pr_text     = <orden>-parnr_pr_text.
      <detail>-parnr_vw          = <orden>-parnr_vw.
      <detail>-parnr_vw_text     = <orden>-parnr_vw_text.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_caracteristicas.
    READ TABLE ausps WITH KEY objek = objek BINARY SEARCH TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    DATA l_peso TYPE ze_peso_calculado.

    LOOP AT ausps ASSIGNING FIELD-SYMBOL(<ausp>) FROM sy-tabix.
      IF <ausp>-objek <> objek.
        EXIT.
      ENDIF.

      CLEAR l_peso.

      " peso y peso calculado
      READ TABLE matx_ds ASSIGNING FIELD-SYMBOL(<matx_d>) WITH KEY eqart   = eqart
                                                                   varname = <ausp>-cabn_atnam BINARY SEARCH.
      IF sy-subrc = 0.
        READ TABLE caracts ASSIGNING FIELD-SYMBOL(<caract>) WITH KEY atinn       = <ausp>-atinn
                                                                     atinn_value = <ausp>-value_para_alv BINARY SEARCH.
        IF sy-subrc <> 0.
          READ TABLE caracts ASSIGNING <caract> WITH KEY atinn       = <ausp>-atinn
                                                         atinn_value = space BINARY SEARCH.
        ENDIF.
        IF sy-subrc = 0.
          l_peso = <caract>-peso.
          peso_calculado += <caract>-peso * <matx_d>-peso / 100.
        ENDIF.
      ENDIF.

      APPEND VALUE #( equnr          = equnr
                      name           = <ausp>-cabn_atnam
                      value_para_alv = <ausp>-value_para_alv
                      name_and_value = <ausp>-atinn && <ausp>-value_para_alv
                      peso           = l_peso ) TO caracteri_averias.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_caracteri_averias_vacias.
    LOOP AT matx_ds ASSIGNING FIELD-SYMBOL(<matx_d>).

      IF line_exists( caracteri_averias[ name = <matx_d>-varname ] ).
        CONTINUE.
      ENDIF.

      READ TABLE cabns ASSIGNING FIELD-SYMBOL(<cabn>) WITH KEY atnam = <matx_d>-varname BINARY SEARCH.
      IF sy-subrc = 0.
        READ TABLE caracts ASSIGNING FIELD-SYMBOL(<caract>) WITH KEY atinn = <cabn>-atinn BINARY SEARCH.
        IF sy-subrc = 0.
          peso_calculado += <caract>-peso * <matx_d>-peso / 100.

          APPEND VALUE #( name = <matx_d>-varname
                          peso = <caract>-peso ) TO caracteri_averias.
        ENDIF.
      ELSE.
        READ TABLE averias ASSIGNING FIELD-SYMBOL(<averia>) WITH KEY codegruppe = <matx_d>-varname BINARY SEARCH.
        IF sy-subrc = 0.
          peso_calculado += <averia>-peso * <matx_d>-peso / 100.

          APPEND VALUE #( name = <matx_d>-varname
                          peso = <averia>-peso ) TO caracteri_averias.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_data_calculo_dinamico.
    DATA caracteri_averias            TYPE gtt_caracteri_averia.
    DATA caracteri_averia_secundarios TYPE gtt_caracteri_averia.
    FIELD-SYMBOLS <detail_dynamics> TYPE STANDARD TABLE.
    FIELD-SYMBOLS <detail_dynamic>  TYPE any.

    create_catalogo_dinamico( EXPORTING maestro_zpeam0012 = maestro_zpeam0012
                                        cabns             = data-cabn
                              IMPORTING fcats             = fcats
                              CHANGING  details           = details ).

    IF comparison_flag IS INITIAL.
      cl_alv_table_create=>create_dynamic_table( EXPORTING  it_fieldcatalog           = fcats
                                                 IMPORTING  ep_table                  = detail_dynamic
                                                 EXCEPTIONS generate_subpool_dir_full = 1 ).

      ASSIGN detail_dynamic->* TO <detail_dynamics>.
    ENDIF.

    " set caracteristicas y averias
    SORT details BY equnr.

    LOOP AT details ASSIGNING FIELD-SYMBOL(<detail>).
      CLEAR caracteri_averias.
      CLEAR caracteri_averia_secundarios.

      set_caracteristicas( EXPORTING objek             = <detail>-objek
                                     equnr             = <detail>-equnr
                                     eqart             = <detail>-eqart
                                     matx_ds           = maestro_zpeam0012-matx_d_principal
                                     caracts           = maestro_zpeam0012-caract
                                     ausps             = data-ausp
                           CHANGING  peso_calculado    = <detail>-peso_calculado
                                     caracteri_averias = caracteri_averias ).

      READ TABLE data-qmih_averias ASSIGNING FIELD-SYMBOL(<qmih>) WITH KEY equnr = <detail>-equnr BINARY SEARCH.
      IF sy-subrc = 0.
        set_averias( EXPORTING qmnum             = <qmih>-qmnum
                               equnr             = <detail>-equnr
                               eqart             = <detail>-eqart
                               matx_ds           = maestro_zpeam0012-matx_d_principal
                               qmfes             = data-qmfe
                               averias           = maestro_zpeam0012-averia
                     CHANGING  peso_calculado    = <detail>-peso_calculado
                               caracteri_averias = caracteri_averias ).
      ENDIF.

      SORT caracteri_averias BY name_and_value.

      set_recomendacion( EXPORTING matx_rs           = maestro_zpeam0012-matx_r
                                   eqart             = <detail>-eqart
                                   caracteri_averias = caracteri_averias
                         IMPORTING idrecomendacion   = <detail>-idrecomendacion
                                   recomendacion     = <detail>-recomendacion
                                   plazo             = <detail>-plazo ).

      IF comparison_flag IS INITIAL.
        set_hojaruta_equipo_principal( EXPORTING equnr             = <detail>-equnr
                                                 idrecomendacion   = <detail>-idrecomendacion
                                                 eqart             = <detail>-eqart
                                                 hreqpr_principals = maestro_zpeam0012-hreqpr
                                                 caracteri_averias = caracteri_averias
                                       IMPORTING ktext             = <detail>-ztbeam_12_hreqpr_ktext
                                       CHANGING  plkzs             = <detail>-plkz ).
      ENDIF.

      " equipo_secundario
      READ TABLE data-equi_secundario WITH KEY hequi = <detail>-equnr TRANSPORTING NO FIELDS BINARY SEARCH.
      IF sy-subrc = 0.
        LOOP AT data-equi_secundario ASSIGNING FIELD-SYMBOL(<equi_secundario>) FROM sy-tabix.
          IF <equi_secundario>-hequi <> <detail>-equnr.
            EXIT.
          ENDIF.

          set_caracteristicas( EXPORTING objek             = <equi_secundario>-objek
                                         equnr             = <equi_secundario>-equnr
                                         eqart             = <equi_secundario>-eqart
                                         matx_ds           = maestro_zpeam0012-matx_d_secundario
                                         caracts           = maestro_zpeam0012-caract
                                         ausps             = data-ausp_secundario
                               CHANGING  peso_calculado    = <detail>-peso_calculado
                                         caracteri_averias = caracteri_averia_secundarios ).

          READ TABLE data-qmih_secundario ASSIGNING <qmih> WITH KEY equnr = <equi_secundario>-equnr BINARY SEARCH.
          IF sy-subrc = 0.
            set_averias( EXPORTING qmnum             = <qmih>-qmnum
                                   equnr             = <equi_secundario>-equnr
                                   eqart             = <equi_secundario>-eqart
                                   matx_ds           = maestro_zpeam0012-matx_d_secundario
                                   qmfes             = data-qmfe_secundario
                                   averias           = maestro_zpeam0012-averia
                         CHANGING  peso_calculado    = <detail>-peso_calculado
                                   caracteri_averias = caracteri_averia_secundarios ).
          ENDIF.

          IF comparison_flag IS INITIAL.
            SORT caracteri_averia_secundarios BY equnr
                                                 name_and_value.

            set_hojaruta_equipo_secundario( EXPORTING idrecomendacion              = <detail>-idrecomendacion
                                                      eqart_principal              = <detail>-eqart
                                                      equnr_secundario             = <equi_secundario>-equnr
                                                      eqart_secundario             = <equi_secundario>-eqart
                                                      hreqse_secundarios           = maestro_zpeam0012-hreqse
                                                      caracteri_averia_principals  = caracteri_averias
                                                      caracteri_averia_secundarios = caracteri_averia_secundarios
                                            CHANGING  plkzs                        = <detail>-plkz ).
          ENDIF.
        ENDLOOP.
      ENDIF.

      APPEND LINES OF caracteri_averia_secundarios TO caracteri_averias.

      set_caracteri_averias_vacias( EXPORTING matx_ds           = maestro_zpeam0012-matx_d
                                              cabns             = maestro_zpeam0012-cabn
                                              caracts           = maestro_zpeam0012-caract_value_vacio
                                              averias           = maestro_zpeam0012-averia_code_vacio
                                    CHANGING  peso_calculado    = <detail>-peso_calculado
                                              caracteri_averias = caracteri_averias ).

      SORT caracteri_averias BY name_and_value.

      IF comparison_flag IS INITIAL.
        IF <detail>-idrecomendacion IS NOT INITIAL.
          <detail>-crear_o_actualizar_aviso = is_crear_o_actualizar_aviso( detail = <detail>
                                                                           matx_c = maestro_zpeam0012-matx_c ).
          IF <detail>-crear_o_actualizar_aviso = abap_true.
            <detail>-icon = icon_led_inactive.
          ENDIF.
        ENDIF.

        APPEND INITIAL LINE TO <detail_dynamics> ASSIGNING <detail_dynamic>.
        <detail_dynamic> = CORRESPONDING #( <detail> ).

        LOOP AT caracteri_averias ASSIGNING FIELD-SYMBOL(<caracteri_averia>).
          ASSIGN COMPONENT <caracteri_averia>-name OF STRUCTURE <detail_dynamic> TO FIELD-SYMBOL(<atnam>).
          IF sy-subrc = 0 AND <caracteri_averia>-value_para_alv IS NOT INITIAL.
            <atnam> = <caracteri_averia>-value_para_alv.
          ENDIF.
          ASSIGN COMPONENT |{ <caracteri_averia>-name }_PESO| OF STRUCTURE <detail_dynamic> TO FIELD-SYMBOL(<peso>).
          IF sy-subrc = 0.
            <peso> = <caracteri_averia>-peso.
          ENDIF.
        ENDLOOP.

        set_hojaruta_dynamic( EXPORTING plkzs             = <detail>-plkz
                              CHANGING  cs_detail_dynamic = <detail_dynamic> ).
      ENDIF.
    ENDLOOP.

    SORT details BY peso_calculado DESCENDING.

    LOOP AT details ASSIGNING <detail>.
      IF <detail>-peso_calculado IS NOT INITIAL.
        <detail>-ranking = sy-tabix.
      ENDIF.
    ENDLOOP.

    SORT details BY equnr.

    IF comparison_flag IS INITIAL.
      LOOP AT details ASSIGNING <detail>.
        ASSIGN <detail_dynamics>[ sy-tabix ] TO <detail_dynamic>.
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'ranking' OF STRUCTURE <detail_dynamic> TO FIELD-SYMBOL(<ranking>).
          IF sy-subrc = 0.
            <ranking> = <detail>-ranking.
          ENDIF.
        ENDIF.
      ENDLOOP.

      SORT <detail_dynamics> BY ('ranking') DESCENDING.
    ENDIF.
  ENDMETHOD.

  METHOD set_hojaruta_dynamic.
    DO 6 TIMES.
      DATA(idx) = sy-index.

      READ TABLE plkzs INDEX idx ASSIGNING FIELD-SYMBOL(<plkz>).
      IF sy-subrc <> 0.
        EXIT.
      ENDIF.

      ASSIGN COMPONENT |EQUNR{ idx }| OF STRUCTURE cs_detail_dynamic TO FIELD-SYMBOL(<equnr>).
      IF sy-subrc = 0.
        <equnr> = <plkz>-equnr.
      ENDIF.
      ASSIGN COMPONENT |PLNTY{ idx }| OF STRUCTURE cs_detail_dynamic TO FIELD-SYMBOL(<plnty>).
      IF sy-subrc = 0.
        <plnty> = <plkz>-plnty.
      ENDIF.
      ASSIGN COMPONENT |PLNNR{ idx }| OF STRUCTURE cs_detail_dynamic TO FIELD-SYMBOL(<plnnr>).
      IF sy-subrc = 0.
        <plnnr> = <plkz>-plnnr.
      ENDIF.
      ASSIGN COMPONENT |PLNAL{ idx }| OF STRUCTURE cs_detail_dynamic TO FIELD-SYMBOL(<plnal>).
      IF sy-subrc = 0.
        <plnal> = <plkz>-plnal.
      ENDIF.
      ASSIGN COMPONENT |AUFKT{ idx }| OF STRUCTURE cs_detail_dynamic TO FIELD-SYMBOL(<aufkt>).
      IF sy-subrc = 0.
        <aufkt> = <plkz>-aufkt.
      ENDIF.
    ENDDO.
  ENDMETHOD.

  METHOD set_hojaruta_equipo_principal.
    DATA total TYPE i.

    READ TABLE hreqpr_principals WITH KEY idrecomendacion = idrecomendacion
                                          eqart           = eqart BINARY SEARCH TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    LOOP AT hreqpr_principals ASSIGNING FIELD-SYMBOL(<hreqpr>) FROM sy-tabix.

      IF    <hreqpr>-idrecomendacion <> idrecomendacion
         OR <hreqpr>-eqart           <> eqart.
        EXIT.
      ENDIF.

      LOOP AT <hreqpr>-caracteri_averia ASSIGNING FIELD-SYMBOL(<caracteri_averia>).
        READ TABLE caracteri_averias WITH KEY name_and_value = <caracteri_averia>-name_and_value
             BINARY SEARCH TRANSPORTING NO FIELDS.
        IF sy-subrc = 0.
          total += 1.
        ENDIF.
      ENDLOOP.

      IF <hreqpr>-lines = total.
        APPEND VALUE #( equnr = equnr
                        plnty = <hreqpr>-plnty
                        plnnr = <hreqpr>-plnnr
                        plnal = <hreqpr>-plnal
                        aufkt = 1 ) TO plkzs.

        ktext = <hreqpr>-ktext.
        EXIT.
      ENDIF.
      CLEAR total.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_hojaruta_equipo_secundario.
    DATA total TYPE i.

    READ TABLE hreqse_secundarios ASSIGNING FIELD-SYMBOL(<hreqse>)
         WITH KEY idrecomendacion  = idrecomendacion
                  eqart_principal  = eqart_principal
                  eqart_secundario = eqart_secundario BINARY SEARCH.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    LOOP AT hreqse_secundarios ASSIGNING <hreqse> FROM sy-tabix.
      IF    <hreqse>-idrecomendacion  <> idrecomendacion
         OR <hreqse>-eqart_principal  <> eqart_principal
         OR <hreqse>-eqart_secundario <> eqart_secundario.
        EXIT.
      ENDIF.

      LOOP AT <hreqse>-caracteri_averia_principal ASSIGNING FIELD-SYMBOL(<caracteri_averia>).
        READ TABLE caracteri_averia_principals WITH KEY name_and_value = <caracteri_averia>-name_and_value
             BINARY SEARCH TRANSPORTING NO FIELDS.
        IF sy-subrc = 0.
          total += 1.
        ENDIF.
      ENDLOOP.

      LOOP AT <hreqse>-caracteri_averia_secundario ASSIGNING <caracteri_averia>.
        READ TABLE caracteri_averia_secundarios WITH KEY equnr          = equnr_secundario
                                                         name_and_value = <caracteri_averia>-name_and_value
             BINARY SEARCH TRANSPORTING NO FIELDS.
        IF sy-subrc = 0.
          total += 1.
        ENDIF.
      ENDLOOP.

      IF <hreqse>-lines_principal + <hreqse>-lines_secundario = total.
        APPEND VALUE #( equnr = equnr_secundario
                        plnty = <hreqse>-plnty
                        plnnr = <hreqse>-plnnr
                        plnal = <hreqse>-plnal
                        aufkt = 1 ) TO plkzs.
        EXIT.
      ENDIF.
      CLEAR total.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_recomendacion.
    DATA total TYPE i.

    READ TABLE matx_rs WITH KEY eqart = eqart BINARY SEARCH TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    LOOP AT matx_rs ASSIGNING FIELD-SYMBOL(<matx_r>) FROM sy-tabix.
      IF <matx_r>-eqart <> eqart.
        EXIT.
      ENDIF.

      LOOP AT <matx_r>-caracteri_averia ASSIGNING FIELD-SYMBOL(<caracteri_averia>).
        READ TABLE caracteri_averias WITH KEY name_and_value = <caracteri_averia>-name_and_value
             BINARY SEARCH TRANSPORTING NO FIELDS.
        IF sy-subrc = 0.
          total += 1.
        ENDIF.
      ENDLOOP.

      IF <matx_r>-lines = total.
        idrecomendacion = <matx_r>-idrecomendacion.
        recomendacion = <matx_r>-recomendacion.
        plazo = <matx_r>-plazo.
        EXIT.
      ENDIF.
      CLEAR total.
    ENDLOOP.
  ENDMETHOD.

  METHOD update_data_de_aviso_creada.
    TYPES: BEGIN OF ty_aviso,
             icon              TYPE gty_detail-icon,
             qmnum             TYPE gty_detail-qmnum,
             qmart             TYPE gty_detail-qmart,
             zzlegado          TYPE gty_detail-zzlegado,
             zzcodleg          TYPE gty_detail-zzcodleg,
             zzranking         TYPE gty_detail-zzranking,
             zzrecomen         TYPE gty_detail-zzrecomen,
             zzpeso_calculado  TYPE gty_detail-zzpeso_calculado,
             qmnum_stat_system TYPE gty_detail-qmnum_stat_system,
             qmnum_stat_user   TYPE gty_detail-qmnum_stat_user,
             message           TYPE gty_detail-message,
           END OF ty_aviso.

    DATA aviso TYPE ty_aviso.

    READ TABLE qmihs ASSIGNING FIELD-SYMBOL(<qmih>) WITH KEY qmnum = detail-qmnum BINARY SEARCH.
    IF sy-subrc = 0.
      aviso = CORRESPONDING #( <qmih> ).
    ENDIF.

    aviso-icon    = detail-icon.
    aviso-message = detail-message.
    MOVE-CORRESPONDING aviso TO detail_dynamic.
  ENDMETHOD.

  METHOD update_data_de_orden_creada.
    TYPES: BEGIN OF ty_orden,
             icon              TYPE gty_detail-icon,
             aufnr             TYPE gty_detail-aufnr,
             auart             TYPE gty_detail-auart,
             zzpep             TYPE gty_detail-zzpep,
             zzlotedeenvio     TYPE gty_detail-zzlotedeenvio,
             gltrp             TYPE gty_detail-gltrp,
             gstrp             TYPE gty_detail-gstrp,
             aufnr_planificado TYPE gty_detail-aufnr_planificado,
             aufnr_real        TYPE gty_detail-aufnr_real,
             aufnr_stat_system TYPE gty_detail-aufnr_stat_system,
             aufnr_stat_user   TYPE gty_detail-aufnr_stat_user,
             ilart             TYPE gty_detail-ilart,
             parnr_ab          TYPE gty_detail-parnr_ab,
             parnr_ab_text     TYPE gty_detail-parnr_ab_text,
             parnr_vu          TYPE gty_detail-parnr_vu,
             parnr_vu_text     TYPE gty_detail-parnr_vu_text,
             parnr_pr          TYPE gty_detail-parnr_pr,
             parnr_pr_text     TYPE gty_detail-parnr_pr_text,
             parnr_vw          TYPE gty_detail-parnr_vw,
             parnr_vw_text     TYPE gty_detail-parnr_vw_text,
             message           TYPE gty_detail-message,
           END OF ty_orden.

    DATA orden TYPE ty_orden.

    READ TABLE ordens ASSIGNING FIELD-SYMBOL(<orden>) WITH KEY aufnr = detail-aufnr BINARY SEARCH.
    IF sy-subrc = 0.
      orden = CORRESPONDING #( <orden> ).
    ENDIF.

    orden-icon    = detail-icon.
    orden-message = detail-message.
    MOVE-CORRESPONDING orden TO detail_dynamic.
  ENDMETHOD.

  METHOD clear_plkz_fields.
    DO 6 TIMES.
      DATA(idx) = sy-index.

      ASSIGN COMPONENT |PLNNR{ idx }| OF STRUCTURE cs_edit TO FIELD-SYMBOL(<plnnr>).
      IF sy-subrc <> 0.
        EXIT.
      ENDIF.
      ASSIGN COMPONENT |PLNAL{ idx }| OF STRUCTURE cs_edit TO FIELD-SYMBOL(<plnal>).
      IF sy-subrc <> 0.
        EXIT.
      ENDIF.
      ASSIGN COMPONENT |PLNTY{ idx }| OF STRUCTURE cs_edit TO FIELD-SYMBOL(<plnty>).
      IF sy-subrc <> 0.
        EXIT.
      ENDIF.
      ASSIGN COMPONENT |AUFKT{ idx }| OF STRUCTURE cs_edit TO FIELD-SYMBOL(<aufkt>).
      IF sy-subrc <> 0.
        EXIT.
      ENDIF.

      IF idx > 1.
        ASSIGN COMPONENT |EQUNR{ idx }| OF STRUCTURE cs_edit TO FIELD-SYMBOL(<equnr>).
        IF sy-subrc = 0 AND <equnr> IS INITIAL.
          CLEAR <plnty>.
          CLEAR <plnnr>.
          CLEAR <plnal>.
          CLEAR <aufkt>.
          CONTINUE.
        ENDIF.
      ENDIF.

      IF <plnnr> IS INITIAL OR <plnal> IS INITIAL.
        CLEAR <plnty>.
        CLEAR <plnnr>.
        CLEAR <plnal>.
        CLEAR <aufkt>.
      ELSEIF <aufkt> IS INITIAL.
        <aufkt> = 1.
      ENDIF.
    ENDDO.
  ENDMETHOD.
ENDCLASS.
