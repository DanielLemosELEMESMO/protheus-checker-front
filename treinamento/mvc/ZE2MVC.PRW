#Include 'Protheus.ch'
#Include 'Totvs.ch'
#Include 'FWMVCDef.ch'

static cTitulo := "Cabeçalho de Orçamento"

User Function ZE2MVC
    //Instanciando FWMBrowse - Somente com dicionário de dados
    Local oBrowse := FWMBrowse():New()

    //Setando a tabela de cadastro de Autor/Interprete
    oBrowse:SetAlias("ZE2")

    //Posiciona o MenuDef
    oBrowse:SetMenuDef("ZE2MVC")

    //Setando a descrição da rotina
    oBrowse:SetDescription(cTitulo)

    //Ativa a Browse
	oBrowse:Activate()
Return


//======================
//CRIAÇÃO DOS MENUS    =
//======================

Static Function MenuDef()

    Local aRotina := {}
    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.ZE1MVC'     OPERATION MODEL_OPERATION_VIEW      ACCESS 0//OP 1
    ADD OPTION aRotina TITLE 'Incluir'      ACTION 'VIEWDEF.ZE1MVC'     OPERATION MODEL_OPERATION_INSERT    ACCESS 0//OP 3
    ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.ZE1MVC'     OPERATION MODEL_OPERATION_UPDATE    ACCESS 0//OP 4
    ADD OPTION aRotina TITLE 'Excluir'      ACTION 'VIEWDEF.ZE1MVC'     OPERATION MODEL_OPERATION_DELETE    ACCESS 0//OP 5
    ADD OPTION aRotina TITLE 'Imprimir'     ACTION 'VIEWDEF.ZE1MVC'     OPERATION 8                         ACCESS 0//OP 8
    ADD OPTION aRotina TITLE 'Copiar'       ACTION 'VIEWDEF.ZE1MVC'     OPERATION 9                         ACCESS 0//OP 9

Return

//===============================
//Definição do Modelo de Dados	=
//===============================

Static Function ModelDef()

    //Criação do objeto do modelo de dados
	Local oModel     := Nil

	//Local oStrMaster
    Local oStrDetail := FWFormStruct(1, "ZE2")

	//Local oStrMaster
    Local oStrMaster
 
	//Cria uma estrutura, sera o cabeçalho

	//Adicionando os campos do cabeçalho

	//Instanciando o modelo, não é recomendado colocar nome da user function (por causa do u_), respeitando 10 caracteres
    oModel := MPFormModel():new("ZE2MVCM")

    //Informando se o campo pode ser alterado (Campo fica cinza)
    
	//Atribuindo formulários para o modelo
    oModel:AddField()

	//Atribuindo Grid para o modelo ZE1MASTER
    
	//Adiciona o relacionamento da grid com o cabeçalho
    
	//Setando a chave primária da rotina

	//Adicionando descrição ao modelo

Return

//===================
//Definição da View	=
//===================
