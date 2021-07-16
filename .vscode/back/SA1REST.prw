#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FWMVCDEF.CH"

/*
DATA:

DESC:

AUTOR:
*/

WSRESTFUL SA1REST DESCRIPTION "CRUD de Cadastro de Cliente"

	WSMETHOD GET DESCRIPTION "Para mais detalhes consultar a documentação." WSSYNTAX "/SA1REST"

	WSMETHOD POST DESCRIPTION "Para mais detalhes consultar a documentação." WSSYNTAX "/SA1REST"

	WSMETHOD PUT DESCRIPTION "Para mais detalhes consultar a documentação." WSSYNTAX "/SA1REST"

	WSMETHOD DELETE DESCRIPTION "Para mais detalhes consultar a documentação." WSSYNTAX "/SA1REST"

END WSRESTFUL


//========================
//CONSULTA DE CLIENTE    =
//========================
WSMETHOD GET WSSERVICE SA1REST

	Local lRet := .T.

	lRet := GetCli(self)

Return lRet
Static Function GetCli(oSelf)

	Local lRet := .T.

Return lRet


//========================
//INCLUSÃO DE CLIENTE    =
//========================
WSMETHOD POST WSSERVICE SA1REST

	Local lRet  	:= .T.
	Local cBody 	:= ""
	Local oObj  	:= Nil
	Local aRet
	Local cErro		:= "Erro ao Deserializar o Body"
	Local nOpcAuto	:= 3 //POST - Inclusao

	::setContentType("application/json")

	cBody := ::getContent()
	lOk := fWJsonDeserialize(cBody, @oObj)

	If lOk
		aRet := MCliente(self,oObj,nOpcAuto)

		lRet := aRet[1]

		If lRet
			::setResponse(EncodeUtf8(FwNoAccent(aRet[2], .T.)))
		Else
			setRestFault(500, aRet[2])
		EndIf

	Else
		::setResponse(EncodeUtf8(FwNoAccent(cErro, .T.)))
	EndIF

Return lRet


//========================
//ALTERAÇÃO DE CLIENTE   =
//========================
WSMETHOD PUT WSSERVICE SA1REST

	Local lRet  	:= .T.
	Local cBody 	:= ""
	Local oObj  	:= Nil
	Local aRet
	Local cErro		:= "Erro ao Deserializar o Body"
	Local nOpcAuto	:= 4 //PUT - Alteração

	::setContentType("application/json")

	cBody := ::getContent()
	lOk := fWJsonDeserialize(cBody, @oObj)

	If lOk
		aRet := MCliente(self,oObj,nOpcAuto)

		lRet := aRet[1]

		If lRet
			::setResponse(EncodeUtf8(FwNoAccent(aRet[2], .T.)))
		Else
			setRestFault(500, aRet[2])
		EndIf

	Else
		::setResponse(EncodeUtf8(FwNoAccent(cErro, .T.)))
	EndIF

Return lRet


//========================
//DELETA O CLIENTE       =
//========================
WSMETHOD DELETE WSSERVICE SA1REST

	Local lRet  	:= .T.
	Local cBody 	:= ""
	Local oObj  	:= Nil
	Local aRet
	Local cErro		:= "Erro ao Deserializar o Body"
	Local nOpcAuto	:= 5 //DELETE - Exclusão

	::setContentType("application/json")

	cBody := ::getContent()
	lOk := fWJsonDeserialize(cBody, @oObj)

	If lOk
		aRet := MCliente(self,oObj,nOpcAuto)

		lRet := aRet[1]

		If lRet
			::setResponse(EncodeUtf8(FwNoAccent(aRet[2], .T.)))
		Else
			setRestFault(500, aRet[2])
		EndIf

	Else
		::setResponse(EncodeUtf8(FwNoAccent(cErro, .T.)))
	EndIF

Return lRet


//===================================
//ROTINA DE MANUTENÇÃO DO CLIENTE	=
//CRUD								=
//===================================
Static Function MCliente(oSelf,oObj,nOpcAuto)

	Local aRet  	:= {.T.," "}
	Local lOkEmp	:= .F.
	Local aStData
	Local aSA1Auto	:= {}
	Local cJsonRet	:= ""
	Local i

	Private lMsErroAuto	   := .F.
	Private lMsHelpAuto	   := .T.
	Private lAutoErrNoFile := .T.

	RPCSetType(3)  //Nao consome licensas

	lOkEmp := RpcSetEnv("99","01",,,,GetEnvServer(),{}) //Abertura do ambiente em rotinas automáticas

	If lOkEmp

		Conout("Abertura do ambiente em rotinas automáticas - OK")

		aStData := ClassDataArr(oObj:Data)
		For i := 1 To Len(aStData)
			aAdd(aSA1Auto, {aStData[i,1], aStData[i,2], Nil})
		Next i

		//------------------------------------
		// Chamada para cadastrar o cliente.
		//------------------------------------
		Conout("Chamada para cadastrar o cliente.")
		MSExecAuto({|a,b| CRMA980(a,b)}, aSA1Auto, nOpcAuto)

		If lMsErroAuto
			aRet[1] := .F.

			If nOpcAuto == 3
				Conout("Erro ao Incluir o Cliente.")
			ElseIf nOpcAuto == 4
				Conout("Erro ao Alterar o Cliente.")
			ElseIf nOpcAuto == 5
				Conout("Erro ao Excluir o Cliente.")
			EndIf

			cJsonRet := GetErro()

		Else
			aRet[1] := .T.

			If nOpcAuto == 3
				Conout("Cliente incluído com sucesso!")
				cJsonRet := '"message": "Cliente Incluido com Sucesso."'
			ElseIf nOpcAuto == 4
				Conout("Cliente Alterado com sucesso!")
				cJsonRet := '"message": "Cliente Alterado com Sucesso."'
			ElseIf nOpcAuto == 5
				Conout("Cliente Excluido com sucesso!")
				cJsonRet := '"message": "Cliente Excluido com Sucesso."'
			EndIf

		EndIf

		Conout("Retorno Json: " + cJsonRet)
		aRet[2] := cJsonRet

	EndIf

	//RpcClearEnv()

Return aRet


//===========================
//BUSCA O ERRO DO EXECAUTO	=
//===========================
Static Function GetErro()

	Local aError := {}
	Local cError := ""
	Local nX     := 0

	aError := GetAutoGRLog()

	For nX := 1 To Len(aError)
		If SubString(aError[nX], 1, 10) == "----------"
			cError += SubString(aError[nX], 1, 56) + chr(10)
		Else
			cError += aError[nX] + chr(10)
		EndIf
	Next nX

Return cError
