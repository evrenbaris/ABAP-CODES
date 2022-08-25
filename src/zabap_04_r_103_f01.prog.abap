*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_103_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form listbox
*&---------------------------------------------------------------------*
FORM listbox .

  money = 'P_PARA'.

  CLEAR list.
  CLEAR value.

  value-key = 'USD'.
  value-text = 'USD'.
  APPEND value TO list.

  CLEAR value.

  value-key = 'EUR'.
  value-text = 'EUR'.
  APPEND value TO list.

  CLEAR value.


  value-key = 'TRY'.
  value-text = 'TRY'.
  APPEND value TO list.


  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = money
      values = list.

ENDFORM. "endform listbox.
*&---------------------------------------------------------------------*
*& Form kontrol
*&---------------------------------------------------------------------*
FORM kontrol .


  toplam_gider = p_yemek + p_yol + p_konak.
*  tel_no_full  =  '+90' && p_tel_string.
  kalan_avans  = p_avans - toplam_gider.
  ahy          = toplam_gider * 100 / p_avans.


  CLEAR : gv_ad, gv_soyad.

  gv_ad = p_ad.
  gv_soyad = p_soyad.

  IF  NOT gv_ad  CO 'abcçdefghıijklmnoöprsştuüxvwyzABCÇDEFGĞHIİJKLMNOÖPRSŞTUXWÜVUZY' OR NOT gv_soyad CO 'abcçdefghıijklmnoöprsştxwuüvyzABCÇDEFGĞHIXWİJKLMNOÖPRSŞTUÜVUZY' .
    MESSAGE 'Geçerli bir ad ve soy ad giriniz!' TYPE 'E'.
  ENDIF.

  IF p_email = '' AND p_tel = ' '.
    MESSAGE 'Mail veya Telefon Numarasından en az birini giriniz!' TYPE 'E'.

  ENDIF.

  "gun farkı hesabı
  CLEAR no_days.

  IF s_tarih-high IS INITIAL.
    no_days = 0.
  ELSE.
    no_days = s_tarih-high - s_tarih-low.
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form tablobaslık
*&---------------------------------------------------------------------*
FORM tablobaslık .

  ULINE AT 0(190).
  WRITE  AT /  '|'.
  WRITE  AT 70  'Personel Masraf Raporu' .
  WRITE  AT 190 '|'.
  ULINE AT /0(190).

  WRITE:/ '|' ,'   AD        ' INTENSIFIED COLOR = 4,
           '  |','   SOYAD         ' INTENSIFIED COLOR = 5,
           '|','EMAIL                                      ' INTENSIFIED COLOR = 4,
           '|',' TELEFON OPERATÖRÜ 'INTENSIFIED COLOR = 5 ,
           '|' ,' TELEFON          'INTENSIFIED COLOR = 4 ,
           '|','  ALINAN AVANS   ' INTENSIFIED COLOR = 5,'|',
           'PARA BİRİMİ'INTENSIFIED COLOR = 4 ,'      |','SEYAHAT SÜRESİ'INTENSIFIED COLOR = 5,'     |'.
  ULINE AT /0(190).



  p_tel_two = p_tel+0(2).
  p_tel_string = p_tel.

  IF  p_tel_two = 53.
    operator = 'Turkcell' .
  ELSEIF p_tel_two = 54.
    operator = 'Vodafone'.

  ELSEIF p_tel_two = 50 OR p_tel_two = 55.
    operator = 'TTelekom'.
  ELSEIF p_tel_two = ''.
    operator = '--------'.
    tel_no_full = '------'.
  ELSE.
    operator = '--------'.

    PERFORM error_op.

  ENDIF .
  tel_no_full  =  '+90' && p_tel_string.

ENDFORM.
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form AHY_RENK
*&---------------------------------------------------------------------*
FORM ahy_renk .
  IF  ahy GE 0 AND  ahy LT 50.
    col = 5.

  ELSEIF ahy GT 50 AND  ahy LT 70.
    col = 3.

  ELSEIF ahy GT 70 AND  ahy LT 100.
    col = 6.

    MESSAGE 'AHY Kritik seviyede dikkat ediniz' TYPE 'I' DISPLAY LIKE 'W'.

  ELSE.
    MESSAGE 'Geçersiz AHY.Lütfen tekrar deneyiniz!' TYPE 'E' .
*    BACK.

  ENDIF .
ENDFORM.
*&---------------------------------------------------------------------*
*& Form BOSLUK_SIL
*&---------------------------------------------------------------------*

FORM bosluk_sil .

  CLEAR lv_yemek.
  lv_yemek = p_yemek.
  SHIFT lv_yemek LEFT DELETING LEADING space.


  CLEAR lv_yol.
  lv_yol = p_yol.
  SHIFT lv_yol LEFT DELETING LEADING space.


  CLEAR lv_konak.
  lv_konak = p_konak.
  SHIFT lv_konak LEFT DELETING LEADING space.


  CLEAR lv_tpgıder.
  lv_tpgıder  = toplam_gider.
  SHIFT lv_tpgıder LEFT DELETING LEADING space.


  CLEAR lv_kalanavans.
  lv_kalanavans = kalan_avans.
  SHIFT lv_kalanavans LEFT DELETING LEADING space.


  CLEAR lv_ahy.
  lv_ahy = ahy.
  SHIFT lv_ahy LEFT DELETING LEADING space.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALT_TABLO
*&---------------------------------------------------------------------*

FORM alt_tablo .

  WRITE:/ '|',p_ad ,'|',
             p_soyad,'',
           '|',p_email,'   |'
           ,operator,
           '           |',
            tel_no_full,'  ',
            '  |',
            p_avans CENTERED,'|'
            ,p_para CENTERED,'       |'
            ,no_days,'        |'.
  ULINE AT 0(190).

  WRITE  AT /.

  ULINE AT 0(190).
  WRITE  AT /  '|'.
  WRITE  AT 70  'Gider Detayı' .
  WRITE  AT 190 '|'.
  ULINE AT /0(190).


  WRITE:/ '|','Yemek gideri     ',':',lv_yemek,p_para,120'Toplam gider:',lv_tpgıder,' ',p_para,190'|'.
  WRITE:/ '|','Yol gideri        :',lv_yol,p_para,120'Kalan avans :',lv_kalanavans,' ', p_para,190'|'.
  WRITE:/ '|','Konaklama gideri  :',lv_konak,p_para,120'AHY         :','%',lv_ahy INTENSIFIED COLOR = col,p_para ,190'|'.
  ULINE AT /0(190).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form error_op
*&---------------------------------------------------------------------*
FORM error_op .

  IF  p_tel_two <> 50 OR p_tel_two <> 55 OR p_tel_two <> 53 OR p_tel_two <> 53 OR p_tel_two <> ' '.
    MESSAGE 'GEÇERSİZ OPERATÖR!' TYPE 'I' DISPLAY LIKE 'W'.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form tel_sıfır
*&---------------------------------------------------------------------*

FORM tel_sıfır .

  gv_tel_fr = p_tel+0(1).

  IF p_tel = ''.
  ELSEIF gv_tel_fr = 0.
    MESSAGE 'telefon numarası 11 haneli olmalı ve 0 ile başlamamalı ' TYPE 'E'.
  ENDIF.

ENDFORM.
