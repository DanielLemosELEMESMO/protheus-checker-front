#include 'protheus.ch'
#include 'parmtype.ch'

/*
DATA:

DESC:   Ler arquivo Texto - Cadastro de Cliente

AUTOR:
*/
User Function LTXTCLI(lPrim)

	Local cLinha  	:= ""
	Local aCampos 	:= {}
	Local aDados  	:= {}
	Local i,nX
	Local aSA1		:= {}
	Local cArqTxt   := "\SA1\CADASTRO_de_CLIENTE.TXT"
	Local cGetDeli  := ";"
	Local cAliasTab := "SA1"
	Private lMsErroAuto := .F.

	Default lPrim   := .T.

	//Verifica se o Arquivo Existe.
	If !File(cArqTxt)
		MsgStop("O arquivo " + cArq + " n�o foi Encontrado!")
		Return
	EndIf

	//Abre o Arquivo
	//Retorna o manipulador de controle do arquivo. Em caso de falha na abertura, a fun��o retornar� -1.
	If FT_FUSE(cArqTxt) == - 1
		MsgStop("Erro ao abrir o Arquivo: " + cArqTxt)
		Return
	EndIf

	//Posiciona no in�cio (primeiro caracter da primeira linha) do arquivo texto aberto pela fun��o FT_FUSE().
	FT_FGOTOP()

	//Indica se o ponteiro est� posicionado no fim do arquivo texto.
	While !FT_FEOF()

		//L� e retorna uma linha de texto do arquivo aberto pela fun��o FT_FUse().
		//As linhas do texto, s�o delimitadas pela sequ�ncia de caracteres CRLF (chr(13)+chr(10)) ou apenas LF (chr(10)),
		//e o tamanho m�ximo de cada linha � 1022 bytes.
		cLinha := FT_FREADLN()

		//Indico se a Primeira linha corresponde algum layout a ser seguido
		If lPrim
			aCampos := Separa(cLinha,cGetDeli,.T.)
			lPrim := .F.
		Else
			aAdd(aDados, Separa(cLinha,cGetDeli,.T.))
		EndIf

		//Move o ponteiro, do arquivo texto aberto pela fun��o FT_FUse(), para uma nova posi��o.
		FT_FSKIP()
	EndDo

	//Fecha o arquivo aberto
	FT_FUSE()

	//Caso indique que temos um controle de inser��o de dados.
	//aCampos tem que ser diferente de vazio
	If !Empty(aCampos)

		For i := 1 to Len(aDados)

			DbSelectArea(cAliasTab)
			(cAliasTab)->(DbSetOrder(1))
			(cAliasTab)->(DbGoTop())

			aSA1 := {}

			For nX := 1 To Len(aCampos)

				cCampo  := cAliasTab + "->" + aCampos[nX]

				If ValType(&cCampo) == "N"

					aAdd(aSA1, {aCampos[nX], Val(aDados[i,nX]) ,Nil})

				ElseIf ValType(&cCampo) == "D"

					aAdd(aSA1, {aCampos[nX], StoD(aDados[i,nX]),Nil})

				Else

					aAdd(aSA1, {aCampos[nX], AllTrim(aDados[i,nX]),Nil})

				EndIf

			Next nX
			//executa o execauto cadastrando cliente ...
			lMsErroAuto:=.F.
			MSExecAuto({|a,b| CRMA980(a,b)}, aSA1, 3)
		
			if lMsErroAuto
				MostraErro()
			endif

		Next i

	EndIf

Return
