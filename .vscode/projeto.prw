/*/{Protheus.doc} User Function nomeFunction
    (long_description)
    @type  Function
    @author user
    @since 05/07/2021
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)


    um input onde os 6 primeiros digitos são o cod do prod,
    os 3 seguintes a qtd e os 3 ultimos o valor do produto

    mostrar o codigo
    mostrar a qtd
    mostrar o valor por unidade
    mostrar o valor total

    PS.: TRATAR O CÓDIGO! (msg de erro etc)
    
    /*/

#DEFINE br Chr(13)+Chr(10)

User Function leCompra(compra)
    if len(compra) == 12
            codigo := SubStr(compra, 1, 6)
            qtd := SubStr(compra, 7, 3)
            valor := SubStr(compra, 10, 3)
            MSGINFO( 'Codigo: '+codigo+br+'Quantidade: '+qtd+br+'Valor: '+valor, 'any' )
    
    else
        MSGINFO('Compra inválida', 'Erro')
    endif

Return


User Function first()
    // Input + leitura da compra
    LOCAL compra
    continuar := .T.

    while continuar
        compra := AllTrim(FWInputBox(""))
        U_leCompra(compra)
        continuar := MSGYESNO( "Adicionar Outro?", "TOTVS" )
    EndDo

    // Quantidade (3 próximos)
    // Valor (3 últimos)
Return
