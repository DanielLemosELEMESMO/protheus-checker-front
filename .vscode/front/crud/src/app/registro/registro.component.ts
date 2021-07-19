import { Component, OnInit, Input } from '@angular/core';
import { camposRegistro } from './registro.model';

@Component({
  selector: 'app-registro',
  templateUrl: './registro.component.html',
  styleUrls: ['./registro.component.scss']
})


export class RegistroComponent implements OnInit {
  @Input()public aCampos:camposRegistro[]=[
    {field:'codigo', value:'codigo', enabled:true},
    {field:'loja', value:'loja', enabled:true},
    {field:'nome', value:'nome', enabled:true},
    {field:'nreduz', value:'nreduz', enabled:false},
    {field:'tipo', value:'X', enabled:false},
    {field:'est', value:'estado', enabled:true},
    {field:'mun', value:'municipio', enabled:false},
    {field:'end', value:'endereço', enabled:true},
  ]

  /*@Input()aCampos:camposRegistro={
    codigo:'codigo',
    loja:'123456',
    nome:20,
    est:'ES',
    end:'Rua Cinco'
  }*/

  constructor() { }

  ngOnInit(): void {}
}
