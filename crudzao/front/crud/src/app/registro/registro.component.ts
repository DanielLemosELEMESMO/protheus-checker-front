import { Component, OnInit, Input, destroyPlatform } from '@angular/core';
import { camposRegistro } from './registro.model';

@Component({
  selector: 'app-registro',
  templateUrl: './registro.component.html',
  styleUrls: ['./registro.component.scss']
})


export class RegistroComponent implements OnInit {
  @Input() public aCampos: camposRegistro[] = [
    { field: 'cod', value: 'codigo', enabled: true },
    { field: 'loja', value: 'loja', enabled: true },
    { field: 'nome', value: 'nome', enabled: true },
    { field: 'nreduz', value: 'nreduz', enabled: false },
    { field: 'tipo', value: 'X', enabled: false },
    { field: 'est', value: 'estado', enabled: true },
    { field: 'mun', value: 'municipio', enabled: false },
    { field: 'end', value: 'endereço', enabled: true },
  ]

  /*@Input()aCampos:camposRegistro={
    codigo:'codigo',
    loja:'123456',
    nome:20,
    est:'ES',
    end:'Rua Cinco'
  }*/

  isSingleClick: Boolean = true;
  clicks: number = 0
  isSelected: Boolean = false;

  constructor() { }

  ngOnInit(): void { }

  adocica(reg: string) {
    alert(reg)
  }

  coisa() {
    alert("morreu")
  }

  acao() {
    this.clicks++

    if (this.clicks == 2) {
      this.isSingleClick = false;
      this.isSelected = !this.isSelected;
      this.abreRegistro();
    }

    else if (this.clicks == 1) {
      setTimeout(() => {
        this.isSelected = !this.isSelected;
      }, 60)
      setTimeout(() => {
        this.clicks = 0;
      }, 250)
    }
  }

  selecionaRegistro() {
    this.isSelected = true;
  }

  desselecionaRegistro() {
    this.isSelected = false;
  }

  abreRegistro() {
    setTimeout(() => { alert('Abriu registro'); }, 250)
    this.clicks = 0;
  }

  check() {
    var cssClass:string = "unselected-class";
    if (this.isSelected) {
      cssClass = "selected-class";
    }
    return cssClass
  }
}
