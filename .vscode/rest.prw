#include "TOTVS.CH"
#Include "RWMAKE.CH"
#Include "RESTFUL.CH"

//============================================================
//                                                           =
//            Define os métodos rest e o endereco            =
//                                                           =
//============================================================


WSRESTFUL clientes DESCRIPTION "Clientes API" FORMAT APPLICATION_JSON
    WSMETHOD GET DESCRIPTION 'Lista de clientes' WSSYNTAX '/clientes'
    WSMETHOD POST DESCRIPTION 'Inserção de clientes' WSSYNTAX '/clientes'
END WSRESTFUL

//============================================================
//                                                           =
//                    CONSULTA DE CLIENTE                    =
//                           (GET)                           =
//                                                           =
//============================================================

WSMETHOD GET WSREST clientes
    Local lRet:=.T.
    //Funcao que da a resposta (SetResponse) e retorna com .T. ou .F. se foi tudo certo
    lRet := ConsultaClientes( self )
return (lRet)

//=============================================================
//                                                            =
//                   INSERÇÃO DE CLIENTE(S)                   =
//                           (POST)                           =
//                                                            =
//=============================================================

WSMETHOD POST WSREST clientes

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

return lRet


//PUT


//DELETE


//============================================================
//                                                           =
//                          FUNCOES                          =
//                                                           =
//============================================================

Static Function ConsultaClientes( oSelf )
    Local ctabela     := GetNextAlias()
    Local aListaDeClientes := {}
    Local nCount := 0   
    Local oJsonClientes := JsonObject():New()
    Local cJsonClientes := ''

// Realiza a query para selecionar clientes
	BEGINSQL Alias ctabela
		SELECT
			SA1.A1_COD,
			SA1.A1_LOJA,
			SA1.A1_NOME,
			SA1.A1_END,
			A1_NREDUZ,
			A1_TIPO,
			A1_EST,
			A1_MUN
		FROM
			%table:SA1% SA1
		WHERE
			SA1.D_E_L_E_T_ != '*'
	ENDSQL

    While ( ctabela )->( ! Eof() )
        nCount++
        
        aAdd(aListaDeClientes, JsonObject():New())


        aListaDeClientes[nCount]['cod'] := (ctabela)-> A1_COD
        aListaDeClientes[nCount]['loja'] := (ctabela)-> A1_LOJA
        aListaDeClientes[nCount]['nome'] := Alltrim( EncodeUTF8( ( ctabela )->A1_NOME ) )
        aListaDeClientes[nCount]['end'] := Alltrim( EncodeUTF8( (ctabela)-> A1_END) )
        aListaDeClientes[nCount]['nreduz'] := Alltrim( EncodeUTF8((ctabela)-> A1_NREDUZ) )
        aListaDeClientes[nCount]['tipo'] := (ctabela)-> A1_TIPO
        aListaDeClientes[nCount]['est'] := (ctabela)-> A1_EST
        aListaDeClientes[nCount]['mun'] := Alltrim( EncodeUTF8((ctabela)-> A1_MUN) )

        /*conout("Cod: " + (ctabela)-> A1_COD)
        conout("Loja: " + (ctabela)-> A1_LOJA)
        conout("Nome: " + (ctabela)-> A1_NOME)
        conout("Endereco: " + (ctabela)-> A1_END)
        conout("Nome Fantasia: " + (ctabela)-> A1_NREDUZ)
        conout("Tipo: " + (ctabela)-> A1_TIPO)
        conout("Estado: " + (ctabela)-> A1_EST)
        conout("Mun: " + (ctabela)-> A1_MUN)
        conout("-----------------------")*/

        ( ctabela )->( DBSkip() )
    End

    oJsonClientes['clientes'] := aListaDeClientes
    cJsonClientes:= FwJsonSerialize( oJsonClientes )

    FreeObj(oJsonClientes)

    oSelf:SetResponse(cJsonClientes)
Return .T.


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
