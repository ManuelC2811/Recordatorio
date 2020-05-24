(defun recordatorio()
		 (setq archivo (load_dialog (findfile "recor.DCL")));Carga el archivo donde se encuentran las dos cajas de di�logo
(setq lst '("Enero" "Febrero" "Marzo" "Abril" "Mayo" "Junio" "Julio" "Agosto" "Septiembre" "Octubre" "Noviembre" "Diciembre"));Nombres de los meses
(setq d28 '("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28"));D�as del mes de febrero
(setq d29 '("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29"));D�as del mes de febrero (si el a�o es bisiesto
(setq d30 '("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30"));D�as de los meses con 30 d�as
(setq d31 '("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31"));D�as de los meses con 31 d�as
(setq years '("2020" "2021" "2022" "2023" "2024" "2025" "2026" "2027" "2028" "2029" "2030")) 
(setq mes_r 0);Establece por defecto el mes de Enero s� no se selecciona alg�n mes en la caja de di�logo
(setq dia_r 0);Establece por defecto el d�a 1 s� no se selecciona alg�n d�a en la caja de di�logo (Caja de di�logo #2)
(setq year_r 0);Establece por defecto el a�o 2020 s� no se selecciona alg�n a�o en la caja de di�logo
(setq record_r "");Establece por defecto vac�o el recordatorio s� no se coloca alguno 
(setq cerrada 0);Verifica por cu�l bot�n se cierra la caja (se mantendr� en 0 si la caja se cierra por el bot�n cancel y se le asignar� el valor de 1 s� la caja se cierra por el bot�n "Guardar y establecer d�a"

(new_dialog "record" archivo);Abre la primera caja de dialogo donde se selecciona el mes, el a�o y se a�ade el recordatorio

(start_list "mes")
(mapcar 'add_list lst) ;Llena el popup_list de los meses
(end_list)

(start_list "year")
(mapcar 'add_list years) ;Llena el popup_list de los a�os
(end_list)

(action_tile "save" "(setq cerrada 1) (done_dialog)");Cierra la caja cuando se presione el bot�n "Guardar y establecer d�a"
(action_tile "mes" "(setq mes_r (atoi $value))");Guarda la posici�n seleccionada de la lista de meses en la variable mes_r
(action_tile "year" "(setq year_r (atoi $value))");Guarda la posici�n seleccionada de la lista de years en la variable year_r
(action_tile "rec" "(setq record_r (get_tile \"rec\"))");Guarda el valor introducido en la edit_box de etiqueta en la variable recordatorio

(start_dialog)

(cond ((= mes_r 0) (progn (setq nm "Enero") (setq dias d31)))
		((= mes_r 1) (progn (setq nm "Febrero") (setq dias d28)))
      ((= mes_r 2) (progn (setq nm "Marzo") (setq dias d31)))
      ((= mes_r 3) (progn (setq nm "Abril") (setq dias d30)))
      ((= mes_r 4) (progn (setq nm "Mayo") (setq dias d31)))
      ((= mes_r 5) (progn (setq nm "Junio") (setq dias d30)))
      ((= mes_r 6) (progn (setq nm "Julio") (setq dias d31)))
      ((= mes_r 7) (progn (setq nm "Agosto") (setq dias d31)))
      ((= mes_r 8) (progn (setq nm "Septiembre") (setq dias d30)))
      ((= mes_r 9) (progn (setq nm "Octubre") (setq dias d31)))
      ((= mes_r 10) (progn (setq nm "Noviembre") (setq dias d30)))
      ((= mes_r 11) (progn (setq nm "Diciembre") (setq dias d31)))
      );Establece la cantidad de d�as que tiene el mes dependiendo del mes seleccionado

(cond ((= year_r 0) (setq year_r 2020))
		((= year_r 1) (setq year_r 2021))
		((= year_r 2) (setq year_r 2022))
		((= year_r 3) (setq year_r 2023))
		((= year_r 4) (setq year_r 2024))
		((= year_r 5) (setq year_r 2025))
		((= year_r 6) (setq year_r 2026))
		((= year_r 7) (setq year_r 2027))
		((= year_r 8) (setq year_r 2028))
		((= year_r 9) (setq year_r 2029))
		((= year_r 10) (setq year_r 2030))
		);Establece el a�o dependiendo de la posici�n de la lista que haya retornado la caja de di�logo 1

(if (and (= mes_r 1) (or (= year_r 2020) (= year_r 2024) (= year_r 2028))) (progn (setq nm "Febrero") (setq dias d29))
  );Establece la lista de d29 a la list_box de d�as si el a�o es bisiesto (2020,2024 o 2028) y el mes seleccionado fue Febrero

(setq cerrada2 0);Verifica por cu�l bot�n se cierra la caja (se mantendr� en 0 si la caja se cierra por el bot�n cancel y se le asignar� el valor de 1 s� la caja se cierra por el bot�n "Guardar"
(if (= cerrada 1);Solo s� la caja 1 fue cerrada con el bot�n "Guardar y establecer d�a" se cargar� la caja 2
(progn (new_dialog "dias" archivo);Abre la caja de di�logo 2, aqu� solo se establece el d�a (se creo otra caja de di�logo para establecer el d�a debido a que no encontr� la manera de cambiar la cantidad de d�as (cambiar la lista) una vez la caja es abierta, por ejemplo si selecciono el mes de febrero, quer�a que los d�as pasar�n de 31 a 29, pero no encontr� la manera

(start_list "dia")
(mapcar 'add_list dias);Llena el list_box de los d�as
(end_list)

(action_tile "save" "(setq cerrada2 1) (done_dialog)");Cierra la caja cuando se presione el bot�n "Guardar"
(action_tile "dia" "(setq dia_r (atoi $value))");Guarda la posici�n seleccionada de la lista de d�as en la variable dia_r
(start_dialog))
  )

(if (= cerrada2 1) 
(alert (strcat "Recordatorio" " " "*" record_r "*" " " "establecido para el" " " (itoa (+ dia_r 1)) " " "de" " " nm " " "de" " " (itoa year_r)))
  )
 )
  
