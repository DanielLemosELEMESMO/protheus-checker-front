import { Component, OnInit } from '@angular/core';
import { AppProvider } from '../app.provider';
import { camposRegistro } from '../registro/registro.model';

export interface camposcliente{
  codigo:string;
  loja:string;
  nome:string;
  nreduz:string;
  tipo:string;
  est:string;
  mun:string;
  end:string;
}

@Component({
  selector: 'app-tabela',
  templateUrl: './tabela.component.html',
  styleUrls: ['./tabela.component.scss']
})

export class TabelaComponent implements OnInit {
  
  colunas:camposRegistro[]=[
    {field:'cod', value:'codigo', enabled:true},
    {field:'loja', value:'loja', enabled:true},
    {field:'nome', value:'nome', enabled:true},
    {field:'nreduz', value:'nreduz', enabled:false},
    {field:'tipo', value:'X', enabled:false},
    {field:'est', value:'estado', enabled:true},
    {field:'mun', value:'municipio', enabled:true},
    {field:'end', value:'endereço', enabled:true},
  ]

  constructor(private provider:AppProvider) { }

  public async ngOnInit() {
    const res:any = await this.provider.getClientes()
    this.colunas.map((col)=>{
      col.value = res.clientes
    })
  }

  evento(para:any){
    alert(para)
  }

}
