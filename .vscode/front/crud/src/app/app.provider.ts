import { Injectable } from "@angular/core";
import { AppService } from "./app.service";

@Injectable({providedIn:"root"})

export class AppProvider{
    constructor(public appService:AppService){
        
    }
    
    public getClientes():Promise<any>{

        return new Promise<any>((resolve, reject)=>{
            this.appService.get().subscribe(
                (cliente:any[]) => {
                    cliente.forEach((c)=>{
//                         {field:'cod',
// {field:'loja'
// {field:'nome'
// {field:'nredu
// {field:'tipo'
// {field:'est',
// {field:'mun',
// {field:'end',
                        const meuCliente = {
                            cod: c.cod,
                            nome: c.nome,
                            nreduz: c.nreduz,
                            tipo: c.tipo,
                            est: c.est,
                            mun: c.mun,
                            end: c.end
                        }
                    })
                    resolve(cliente)
                
                },
                (erro) => {reject(erro)}
            )
        })
    }
}