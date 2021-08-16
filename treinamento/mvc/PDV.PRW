#INCLUDE 'Totvs.ch'
#INCLUDE 'Protheus.ch'
#INCLUDE 'FwMVCDef.ch'


Static cTitulo := 'Pedido de venda'
Static cVIEWZE2 := "viewidZE2"
Static cMASTERZE2:= "masterZE2"

User Function PDV()

	//Instânciando FWMBrowse - Somente com dicionário de dados
	Local oBrowse := FWMBrowse():New()

	//Setando a tabela de cadastro de Autor/Interprete
	oBrowse:SetAlias("ZE2")

	//Posiciona o MenuDef
	oBrowse:SetMenuDef("PDV")

	//Setando a descrição da rotina
	oBrowse:SetDescription(cTitulo)

	//Legendas
	oBrowse:AddLegend("ZE2->ZE2_STATUS == 'A'", "GREEN", "Aberto")
	oBrowse:AddLegend("ZE2->ZE2_STATUS == 'F'", "BLACK", "Faturado")
	oBrowse:AddLegend("ZE2->ZE2_STATUS == 'C'", "RED"  , "Cancelado")

	//Ativa a Browse
	oBrowse:Activate()

Return

Static Function MenuDef()
    /*/ ? Rotinas ? /*/
    Local aRotina := {}
    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.PDV'     OPERATION MODEL_OPERATION_VIEW      ACCESS 0//OP 1
    ADD OPTION aRotina TITLE 'Incluir'      ACTION 'VIEWDEF.PDV'     OPERATION MODEL_OPERATION_INSERT    ACCESS 0//OP 3
    ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.PDV'     OPERATION MODEL_OPERATION_UPDATE    ACCESS 0//OP 4
    ADD OPTION aRotina TITLE 'Excluir'      ACTION 'VIEWDEF.PDV'     OPERATION MODEL_OPERATION_DELETE    ACCESS 0//OP 5
    ADD OPTION aRotina TITLE 'Imprimir'     ACTION 'VIEWDEF.PDV'     OPERATION 8                         ACCESS 0//OP 8
    ADD OPTION aRotina TITLE 'Copiar'       ACTION 'VIEWDEF.PDV'     OPERATION 9                         ACCESS 0//OP 9

Return

Static Function ModelDef()

	Local oModel
	Local oStructZE2    := FWFormStruct(1, "ZE2")
	Local oStructZE3    := FWFormStruct(1, "ZE3")
	Local aGatilhos := {}
	Local cFuncao
	Local i

	//Adicionando um gatilho, da estrutura oStructZE2
	cFuncao := 'Posicione("SA1",1,xFilial("SA1") + FwFldGet("ZE2_CODCLI") + FwFldGet("ZE2_LOJA"), "A1_NOME")'
	aAdd(aGatilhos, FWStruTriggger("ZE2_LOJA","ZE2_NOMCLI",cFuncao,.F.,"",0,'',NIL,"01"))

	//Percorrendo os gatilhos e adicionando da estrutura oStructZE2
	For i := 1 To Len(aGatilhos)
		oStructZE2:AddTrigger(aGatilhos[i][01],aGatilhos[i][02],aGatilhos[i][03],aGatilhos[i][04])
	Next i

	//Adicionando um gatilho, da estrutura oStructZE3
	aGatilhos := {}
	cFuncao := 'Posicione("SB1",1,xFilial("SB1") + FwFldGet("ZE3_PROD"), "B1_DESC")'
	aAdd(aGatilhos, FWStruTriggger("ZE3_PROD","ZE3_DESC",cFuncao,.F.,"",0,'',NIL,"01"))

	cFuncao := 'FwFldGet("ZE3_QTD") * FwFldGet("ZE3_PRECO")'
	aAdd(aGatilhos, FWStruTriggger("ZE3_QTD","ZE3_TOTAL",cFuncao,.F.,"",0,'',NIL,"01"))

	cFuncao := 'FwFldGet("ZE3_QTD") * FwFldGet("ZE3_PRECO")'
	aAdd(aGatilhos, FWStruTriggger("ZE3_PRECO","ZE3_TOTAL",cFuncao,.F.,"",0,'',NIL,"01"))

    cFuncao := 'ROUND((FwFldGet("ZE3_DESCON")/100) * (FwFldGet("ZE3_QTD") * FwFldGet("ZE3_PRECO")),2)'
	aAdd(aGatilhos, FWStruTriggger("ZE3_DESCON","ZE3_VLDESC",cFuncao,.F.,"",0,'',NIL,"01"))
	aAdd(aGatilhos, FWStruTriggger("ZE3_PRECO" ,"ZE3_VLDESC",cFuncao,.F.,"",0,'',NIL,"02"))
    aAdd(aGatilhos, FWStruTriggger("ZE3_QTD"   ,"ZE3_VLDESC",cFuncao,.F.,"",0,'',NIL,"02"))

    cFuncao := '(FwFldGet("ZE3_QTD") * FwFldGet("ZE3_PRECO")) - FwFldGet("ZE3_VLDESC")'
	aAdd(aGatilhos, FWStruTriggger("ZE3_QTD"   ,"ZE3_TOTAL",cFuncao,.F.,"",0,'',NIL,"03"))
	aAdd(aGatilhos, FWStruTriggger("ZE3_PRECO" ,"ZE3_TOTAL",cFuncao,.F.,"",0,'',NIL,"03"))
    aAdd(aGatilhos, FWStruTriggger("ZE3_VLDESC","ZE3_TOTAL",cFuncao,.F.,"",0,'',NIL,"01"))

	//Percorrendo os gatilhos e adicionando à estrutura oStructZE3
	For i := 1 To Len(aGatilhos)
		oStructZE3:AddTrigger(aGatilhos[i][01],aGatilhos[i][02],aGatilhos[i][03],aGatilhos[i][04])
	Next i

    oModel := MPFormModel:new("PDVM")
    oModel:AddField(cMASTERZE2, cOwner , oStructZE2)
    oModel:SetDescription("Modelo de Dados do Cadastro"+cTitulo)
    oModel:GetModel(cMASTERZE2):SetDescription("descricao loca")

Return oModel

Static Function ViewDef()
    Local oView := FWFormView():new()
    Local oModel := FWLoadModel("PDV")
    Local oStructZE2 := FWFormStruct(2, "ZE2")
    Local oStructZE3 := FWFormStruct(2, "ZE3")

    oStructZE3:RemoveField("ZE3_NUM")

    oView:SetModel(oModel)

    oView:AddField(cVIEWZE2, oStructZE2, cMASTERZE2)
    
    oView:CreateHorizontalBox("Tela1", 100)
    
    oView:SetOwnerView(cVIEWZE2)
    
    oView:EnableTitleView(cVIEWZE2, "Tela1")
    
    oView:SetCloseOnOk({|| .T.})
Return oView
