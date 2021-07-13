#include "TOTVS.CH"
#Include "RWMAKE.CH"
#Include "RESTFUL.CH"

//WSRESTFUL - Cria os métodos rest
//WSDATA - parâmetros passados por url
//SPCliente é o nome API provavelmente
//FORMAT declara o formato que a api vai trabalhar (não sei de que forma)
WSRESTFUL SPCliente DESCRIPTION "Clientes API" FORMAT APPLICATION_JSON
	WSDATA page                 AS INTEGER  OPTIONAL
	WSDATA pageSize             AS INTEGER  OPTIONAL
	WSDATA searchKey            AS STRING   OPTIONAL
	WSDATA branch               AS STRING   OPTIONAL
	WSDATA byId                 AS BOOLEAN  OPTIONAL

	//Endereco para pegar os dados:
	//http://localhost:8090/rest/api/v1/spcliente
	//WSMETHOD GET customers DESCRIPTION 'SP Lista de Clientes' WSSYNTAX '/api/v1/spcliente' PATH '/api/v1/spcliente' TTALK 'V1' PRODUCES APPLICATION_JSON  //-- Retorna lista de clientes, com possibilidade de paginacao e filtros.
	
	//WSMETHOD GET Cria o método GET, mas não sei pq tem o "customers" ali
	//WSSYNTAX e o link pra fazer o request
	//PATH tbm
	//PRODUCES
	WSMETHOD GET  customers DESCRIPTION 'SP Lista de Clientes' WSSYNTAX '/api/v1/spcliente' PATH '/api/v1/spcliente' PRODUCES APPLICATION_JSON  //-- Retorna lista de clientes, com possibilidade de paginacao e filtros.
	//WSMETHOD POST cria o método POST
	//WSSYNTAX eh o link para fazer o request
	//PATH tbm
	WSMETHOD POST  customers DESCRIPTION 'SP Lista de Clientes' WSSYNTAX '/api/v1/spcliente' PATH '/api/v1/spcliente'

END WSRESTFUL
//termina de definir os métodos rest


//============================================================
//                                                           =
//                    CONSULTA DE CLIENTE                    =
//                                                           =
//============================================================



//WSMETHOD Declara o método
//WSRECEIVE define os parâmetros recebidos
//WREST define a qual api (pelo nome) o método pertence
WSMETHOD GET customers WSRECEIVE searchKey, page, pageSize, branch WSREST SPCliente
	Local lRet:= .T.
	//Funcao costumers retorna
	lRet := Customers( self )
Return( lRet )





//============================================================
//                                                           =
//                     INCLUSÃO DE CLIENTE                   =
//                                                           =
//============================================================

WSMETHOD POST customers WSREST SPCLIENTE

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


/*WSMETHOD POST customers WSREST SPCliente

	Local lRet  	:= .T.
	Local cBody 	:= ""
	Local oObj  	:= Nil
	Local aRet
	Local cErro		:= "Erro ao Deserializar o Body"
	Local nOpcAuto  := 3 //POST - Inclusao

	//Define o tipo de retorno do metodo (?)
	::SetContentType("application/json")

	//Pega o body da requisicao
	cBody := ::GetContent()
	lmilk := fWJsonDeserialize(cBody, @oObj)

	if lmilk
		aRet := MCliente(self, oObj, nOpcAuto)

		lRet := aRet[1]

		if lRet
			::setResponse(EncodeUtf8(FwNoAccent(aRet[2], .T.)))
		else
			setRestFault(500, aRet[2])
		endif

	else
		::setResponse(EncodeUtf8(FwNoAccent(cErro, .T.)))

	endif

Return*/


























//=============================================================
//                                                            =
//                         Função do GET                      =
//                                                            =
//=============================================================



Static Function Customers( oSelf )
	Local aListCli  := {}
	Local cJsonCli      := ''
	Local oJsonCli  := JsonObject():New()
	Local cSearch       := ''
	Local cWhere        := "AND SA1.A1_FILIAL = '"+xFilial('SA1')+"'"
	Local nCount        := 0
	Local nStart        := 1
	Local nReg          := 0
	Local nAux          := 0
	Local cAliasSA1     := GetNextAlias()

	Default oself:searchKey     := ''
	Default oself:branch        := ''
	Default oself:page      := 1
	Default oself:pageSize  := 20
	Default oself:byId      :=.F.

	// Tratativas para realizar os filtros
	If !Empty(oself:searchKey) //se tiver chave de busca no request
		cSearch := Upper( oself:SearchKey )
		If oself:byId //se filtra somente por ID
			cWhere += " AND SA1.A1_COD = '" + cSearch + "'"
		Else//busca chave nos campos abaixo
			cWhere += " AND ( SA1.A1_COD LIKE   '%" + cSearch + "%' OR "
			cWhere  += " SA1.A1_LOJA LIKE       '%" + cSearch + "%' OR "
			cWhere  += " SA1.A1_NOME LIKE       '%" + FwNoAccent( cSearch ) + "%' OR "
			cWhere  += " SA1.A1_NREDUZ LIKE     '%" + FwNoAccent( cSearch ) + "%' OR "
			cWhere  += " SA1.A1_NREDUZ LIKE     '%" + cSearch  + "%' OR "
			cWhere  += " SA1.A1_NOME LIKE       '%" + cSearch + "%' ) "
		EndIf
	EndIf

	If !Empty(oself:branch) //se filtra a loja
		cWhere += " AND SA1.A1_LOJA = '"+oself:branch+"'"
	EndIf

	dbSelectArea('SA1')
	DbSetOrder(1)
	If SA1->( Columnpos('A1_MSBLQL') > 0 ) //verifica se o campo de controle de bloqueio existe, se sim filtra esse caso
		cWhere += " AND SA1.A1_MSBLQL <> '1'"
	EndIf

	cWhere := '%'+cWhere+'%' //monta a expressao where

	// Realiza a query para selecionar clientes
	BEGINSQL Alias cAliasSA1
        SELECT SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, SA1.A1_END
        FROM    %table:SA1% SA1
        WHERE   SA1.%NotDel%
        %exp:cWhere%
        ORDER BY A1_COD
	ENDSQL

	If ( cAliasSA1 )->( ! Eof() )
		//-------------------------------------------------------------------
		// Identifica a quantidade de registro no alias temporÃ¡rio
		//-------------------------------------------------------------------
		COUNT TO nRecord
		//-------------------------------------------------------------------
		// nStart -> primeiro registro da pagina
		// nReg -> numero de registros do inicio da pagina ao fim do arquivo
		//-------------------------------------------------------------------
		If oself:page > 1
			nStart := ( ( oself:page - 1 ) * oself:pageSize ) + 1
			nReg := nRecord - nStart + 1
		Else
			nReg := nRecord
		EndIf

		//-------------------------------------------------------------------
		// Posiciona no primeiro registro.
		//-------------------------------------------------------------------
		( cAliasSA1 )->( DBGoTop() )

		//-------------------------------------------------------------------
		// Valida a exitencia de mais paginas
		//-------------------------------------------------------------------
		If nReg  > oself:pageSize
			oJsonCli['hasNext'] := .T.
		Else
			oJsonCli['hasNext'] := .F.
		EndIf
	Else
		//-------------------------------------------------------------------
		// Nao encontrou registros
		//-------------------------------------------------------------------
		oJsonCli['hasNext'] := .F.
	EndIf

	//-------------------------------------------------------------------
	// Alimenta array de clientes
	//-------------------------------------------------------------------
	While ( cAliasSA1 )->( ! Eof() )
		nCount++
		If nCount >= nStart
			nAux++
			aAdd( aListCli , JsonObject():New() )
			aListCli[nAux]['id']    := ( cAliasSA1 )->A1_COD
			aListCli[nAux]['name']  := Alltrim( EncodeUTF8( ( cAliasSA1 )->A1_NOME ) )
			aListCli[nAux]['branch']    := ( cAliasSA1 )->A1_LOJA
			aListCli[nAux]['address']   := ( cAliasSA1 )->A1_END
			If Len(aListCli) >= oself:pageSize
				Exit
			EndIf
		EndIf
		( cAliasSA1 )->( DBSkip() )
	End
	( cAliasSA1 )->( DBCloseArea() )
	oJsonCli['clients'] := aListCli

	//-------------------------------------------------------------------
	// Serializa objeto Json
	//-------------------------------------------------------------------
	cJsonCli:= FwJsonSerialize( oJsonCli )

	//-------------------------------------------------------------------
	// Elimina objeto da memoria
	//-------------------------------------------------------------------
	FreeObj(oJsonCli)
	oself:SetResponse( cJsonCli ) //-- Seta resposta
Return .T.

















//=============================================================
//                                                            =
//              ROTINA DE MANUTENÇÃO DO CLIENTE               =
//                            CRUD                            =
//                                                            =
//=============================================================



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





//===========================================================
//                                                          =
//                 BUSCA O ERRO DO EXECAUTO                 =
//                                                          =
//===========================================================
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
