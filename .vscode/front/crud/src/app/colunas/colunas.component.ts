import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';
import { camposRegistro } from '../registro/registro.model';
@Component({
  selector: 'app-colunas',
  templateUrl: './colunas.component.html',
  styleUrls: ['./colunas.component.scss']
})
export class ColunasComponent implements OnInit {

  @Input()public aColunas:camposRegistro[]=[
    {field:"codigo", value:"codigo", enabled:true},
    {field:"loja", value:"loja", enabled:true},
    {field:"nome", value:"nome", enabled:true},
    {field:"nreduz", value:"nreduz", enabled:false},
    {field:"tipo", value:"X", enabled:false},
    {field:"est", value:"estado", enabled:true},
    {field:"end", value:"endereço", enabled:true},
    {field:"mun", value:"municipio", enabled:false},
  ]

  @Output()out:EventEmitter<any> = new EventEmitter()
  
  constructor() { }

  ngOnInit(): void {
  }

  novacoisa(){
    this.out.emit("amor")
  }
}
