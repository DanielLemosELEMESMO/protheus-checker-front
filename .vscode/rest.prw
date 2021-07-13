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


//PUT


//DELETE


//============================================================
//                                                           =
//                          FUNCOES                          =
//                                                           =
//============================================================

Static Function ConsultaClientes( oSelf )
    Local cAliasSA1     := GetNextAlias()
    Local aListaDeClientes := {}
    Local oJsonCli := ''
    Local cJsonCli := ''
    Local nCount := 0

    
    // Realiza a query para selecionar clientes
	BEGINSQL Alias cAliasSA1
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

    While ( cAliasSA1 )->( ! Eof() )
        nCount++

        aAdd(  aListaDeClientes[nCount]['cod'],    (cAliasSA1)->   A1_COD)
        aAdd(  aListaDeClientes[nCount]['loja'],   (cAliasSA1)->   A1_LOJA)
        aAdd(  aListaDeClientes[nCount]['nome'],   (cAliasSA1)->   A1_NOME)
        aAdd(  aListaDeClientes[nCount]['end'],    (cAliasSA1)->   A1_END)
        aAdd(  aListaDeClientes[nCount]['nreduz'], (cAliasSA1)->   A1_NREDUZ)
        aAdd(  aListaDeClientes[nCount]['tipo'],   (cAliasSA1)->   A1_TIPO)
        aAdd(  aListaDeClientes[nCount]['est'],    (cAliasSA1)->   A1_EST)
        aAdd(  aListaDeClientes[nCount]['mun'],    (cAliasSA1)->   A1_MUN)

        ( cAliasSA1 )->( DBSkip() )
    END

    oSelf:SetResponse('pegasus')
Return .T.
