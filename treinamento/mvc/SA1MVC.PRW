#Include 'Protheus.ch'
#Include 'Totvs.ch'
#Include 'FWMVCDef.ch'

Static cTitulo      := "Cadastro de Cliente"
Static cMasterSA1   := "MASTERSA1"
Static cVIEW_SA1    := "VIEW_SA1"

/*
DATA:   

DESC:   

AUTOR:
*/
User Function SA1MVC()

	//Inst�nciando FWMBrowse - Somente com dicion�rio de dados
	Local oBrowse := FWMBrowse():New()


	//Setando a tabela de cadastro de Autor/Interprete
	oBrowse:SetAlias("SA1")

	//Posiciona o MenuDef
	oBrowse:SetMenuDef("SA1MVC")

	//Setando a descri��o da rotina
	oBrowse:SetDescription(cTitulo)

	//Adicionando Legendas
	oBrowse:AddLegend("SA1->A1_PESSOA == 'F'"  , "GREEN" ,"P.Fisica")
	oBrowse:AddLegend("SA1->A1_PESSOA == 'J'"  , "BLACK" ,"P.Juridica")

	//Ativa a Browse
	oBrowse:Activate()

Return


//======================
//CRIA��O DOS MENUS    =
//======================
Static Function MenuDef()

	Local aRotina := {}

	ADD OPTION aRotina TITLE 'Visualizar' 	ACTION 'VIEWDEF.SA1MVC' 	OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1
	ADD OPTION aRotina TITLE 'Incluir'    	ACTION 'VIEWDEF.SA1MVC' 	OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
	ADD OPTION aRotina TITLE 'Alterar'    	ACTION 'VIEWDEF.SA1MVC' 	OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
	ADD OPTION aRotina TITLE 'Excluir'    	ACTION 'VIEWDEF.SA1MVC' 	OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5
	ADD OPTION aRotina Title 'Imprimir'   	ACTION "VIEWDEF.SA1MVC" 	OPERATION 8                      ACCESS 0 //OPERATION 8
	ADD OPTION aRotina Title 'Copiar'     	ACTION "VIEWDEF.SA1MVC" 	OPERATION 9                      ACCESS 0 //OPERATION 9

Return aRotina


//===============================
//Defini��o do Modelo de Dados	=
//===============================
Static Function ModelDef()

	//Cria��o do objeto do modelo de dados
	Local oModel := Nil

	//Cria��o da estrutura de dados utilizada na interface
	Local oStSA1 := FWFormStruct(1, "SA1")

	//Valida��o de Execu��o
	//Local bCommit 	:= {|oModel| SaveModel(oModel)}
	//Local bPos		:= {|oModel| ModelTOK(oModel)}

	//Instanciando o modelo, n�o � recomendado colocar nome da user function (por causa do u_), respeitando 10 caracteres
	oModel := MPFormModel():New("SA1MVCM",/*bPre*/, /*bPos*/,/*bCommit*/,/*bCancel*/)
	//oModel := MPFormModel():New("M1ZE101M",/*bPre*/, /*bPos*/, bCommit, /*bCancel*/)
	//oModel := MPFormModel():New("M1ZE101M", /*bPre*/, bPos, bCommit, /*bCancel*/)

	//Atribuindo formul�rios para o modelo
	oModel:AddFields(cMasterSA1,/*cOwner*/,oStSA1)

	//Setando a chave prim�ria da rotina
	oModel:SetPrimaryKey({"A1_FILIAL","A1_COD"})

	//Adicionando descri��o ao modelo
	oModel:SetDescription("Modelo de Dados do Cadastro " + cTitulo)

	//Setando a descri��o do formul�rio
	oModel:GetModel(cMasterSA1):SetDescription("Formul�rio do Cadastro " + cTitulo)

Return oModel


//===================
//Defini��o da View	=
//===================
Static Function ViewDef()

	//Cria��o do objeto do modelo de dados da Interface do Cadastro de Autor/Interprete (Nome do PRW)
	Local oModel := FWLoadModel("SA1MVC")

	//Cria��o da estrutura de dados utilizada na interface do cadastro de Autor
	Local oStSA1 := FWFormStruct(2, "SA1")  //pode se usar um terceiro par�metro para filtrar os campos exibidos { |cCampo| cCampo $ 'ZE1_COD|'}

	//Criando oView
	Local oView := FWFormView():New()

	//Adicionando o modelo a view
	oView:SetModel(oModel)

	//Atribuindo formul�rios para interface
	oView:AddField(cVIEW_SA1, oStSA1, cMasterSA1)

	//Criando um container com nome tela com 100%
	oView:CreateHorizontalBox("TELA", 100)

    //O formul�rio da interface ser� colocado dentro do container
	oView:SetOwnerView(cVIEW_SA1, "TELA")

    //Colocando t�tulo do formul�rio
	oView:EnableTitleView(cVIEW_SA1, "Dados - " + cTitulo)

    //Fechamento da janela na confirma��o
	oView:SetCloseOnOk({|| .T.})

Return oView
