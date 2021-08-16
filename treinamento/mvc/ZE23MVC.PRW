#INCLUDE 'Totvs.ch'
#INCLUDE 'Protheus.ch'
#INCLUDE 'FwMVCDef.ch'

Static cTitulo:='Pedido de Venda'

User Function ZE23MVC()
    //Cria browse
    Local oBrowse := FWMBrowse():new()
    
    //Seta tabela
    oBrowse:SetAlias('ZE2')

    //Menu
    oBrowse:SetMenuDef('ZE23MVC')

    //Setando a descrição da rotina
	oBrowse:SetDescription(cTitulo)
    
    //Legendas

    //Ativação
    oBrowse:Activate()
Return

Static Function MenuDef()
    //Cria array para as rotinas
    Local aRotina:= {}

    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.ZE23MVC' OPERATION MODEL_OPERATION_VIEW     ACCESS 0 //OPERATION 1
    ADD OPTION aRotina TITLE 'Incluir'      ACTION 'VIEWDEF.ZE23MVC' OPERATION MODEL_OPERATION_INSERT   ACCESS 0 //OPERATION 3
    ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.ZE23MVC' OPERATION MODEL_OPERATION_DELETE   ACCESS 0 //OPERATION 4
    ADD OPTION aRotina TITLE 'Excluir'      ACTION 'VIEWDEF.ZE23MVC' OPERATION MODEL_OPERATION_DELETE   ACCESS 0 //OPERATION 5

Return aRotina

Static Function ModelDef()
    Local oModel
    Local oStructZE2 := FWFormStruct(1, 'ZE2')
    Local oStructZE3 := FWFormStruct(1, 'ZE3')

    //Instanciando o modelo
    oModel :=  MPFormModel():New('ZE23MVCM')

    //Form ZE2
    oModel:AddFields('ZE2MASTER', , oStructZE2)

    //Grid
    oModel:AddGrid('ZE3DETAIL', 'ZE2MASTER', oStructZE3)

  	//Criando a Relação entre as Tabelas ZE2 e ZE3
	oModel:SetRelation("ZE3DETAIL", {{"ZE3_FILIAL", "xFilial('ZE3')"}, {"ZE3_NUM", "ZE2_NUM"}}, ZE3->(IndexKey(1)))

    //Setando a Chave Primaria
	oModel:SetPrimaryKey({"ZE2_FILIAL","ZE2_NUM"})

    //Setando as descrições
	oModel:SetDescription(cTitulo)
	oModel:GetModel("ZE2MASTER"):SetDescription("Cab. Orçamento")
	oModel:GetModel("ZE3DETAIL"):SetDescription("Itens do Orçamento")

Return oModel

Static Function ViewDef()
    Local oView
    Local oModel := FWLoadModel("ZE23MVC")
    Local oStructZE2 := FWFormStruct(2, 'ZE2')
    Local oStructZE3 := FWFormStruct(1, 'ZE3')

    //Seta a view
    oView:=FWFormView():New()

    //Setando o Modelo de Dados na View
    oView:SetModel(oModel)

	//Adicionando os campos do cabeçalho e o grid dos filhos
	oView:AddField("VIEW_ZE2", oStructZE2, "ZE2MASTER") //Formulario
	oView:AddGrid("VIEW_ZE3" , oStructZE3, "ZE3DETAIL") //Grid
    
    //Setando o dimensionamento de tamanho das telas
	oView:CreateHorizontalBox("TELAZE2", 30)
    oView:CreateHorizontalBox("TELAZE3", 70)

    //O formulário da interface será colocado dentro do container
	oView:SetOwnerView('View_ZE2', "TELAZE2")
	oView:SetOwnerView("VIEW_ZE3", "TELAZE3")
    
    //Colocando título do formulário
	oView:EnableTitleView('View_ZE2', "Dados - " + cTitulo)
	oView:EnableTitleView("VIEW_ZE3", "Itens do Orçamento")

    //Fechamento da janela na confirmação
	oView:SetCloseOnOk({|| .T.})
	
Return oView
