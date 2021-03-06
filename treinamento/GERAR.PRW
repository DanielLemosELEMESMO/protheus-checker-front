#include "protheus.ch"
#include "rwmake.ch"

#DEFINE CRLF CHR(13) + CHR(10)

/*
DATA:

DESC:   Gerando arquivo Texto - Cadastro de Cliente

AUTOR:
*/
User Function GTXTCLI()

	Local aArea := GetArea()

	If MsgYesNo("Deseja Exportar Dados do Cliente?")

		GeraTXT()

	EndIf

	RestArea(aArea)

Return


Static Function GeraTXT()

	//Cria o arquivo texto
	Local cArqTxt   := "\SA1\CADASTRO_de_CLIENTE.TXT"
	Local nHdl	    := fCreate(cArqTxt)

	If nHdl == -1
		MsgAlert("O arquivo de nome " + cArqTxt + " n�o pode ser executado! Verifique os Par�metros.","Aten��o!")
		Return
	Endif

	//Inicializa o processamento processamento
	RunCont(nHdl)

	MsgInfo("Arquivo Exportado com sucesso!!!")

Return Nil

Static Function RunCont(nHdl)

	Local cLinha
	Local lPrim:=.T.

	DbSelectArea("SA1")
	SA1->(DbGoTop())

	While !SA1->(Eof())

		if lPrim
			cLinha := "A1_COD;A1_LOJA;A1_NOME;A1_NREDUZ;A1_TIPO;A1_END;A1_BAIRRO;A1_EST;A1_MUN" + CRLF
			If fWrite(nHdl,cLinha,Len(cLinha)) != Len(cLinha)

				MsgAlert("O Disco R�gido est� Cheio ou Ocorreu Erro na Grava��o do Arquivo.")
				Return .F.

			Endif
			lPrim := .F.
		EndIf

		cLinha := AllTrim(SA1->A1_COD)    + ";"
		cLinha += AllTrim(SA1->A1_LOJA)   + ";"
		cLinha += AllTrim(SA1->A1_NOME)   + ";"
		cLinha += AllTrim(SA1->A1_NREDUZ) + ";"
		cLinha += AllTrim(SA1->A1_TIPO)   + ";"
		cLinha += AllTrim(SA1->A1_END)    + ";"
		cLinha += AllTrim(SA1->A1_BAIRRO) + ";"
		cLinha += AllTrim(SA1->A1_EST)    + ";"
		cLinha += AllTrim(SA1->A1_MUN)    + CRLF

		//Iniciar a Grava��o no Arquivo .txt
		If fWrite(nHdl,cLinha,Len(cLinha)) != Len(cLinha)

			MsgAlert("O Disco R�gido est� Cheio ou Ocorreu Erro na Grava��o do Arquivo.")
			Return .F.

		Endif

		SA1->(DbSkip())
	EndDo

	//O arquivo texto deve ser fechado
	fClose(nHdl)

Return .T.
