import { Component, Input, OnInit } from '@angular/core';
import { AppProvider } from '../app.provider';

@Component({
  selector: 'app-botao-ator',
  templateUrl: './botao-ator.component.html',
  styleUrls: ['./botao-ator.component.scss']
})
export class BotaoAtorComponent implements OnInit {
  
  @Input()acao:string=""
  agindo:boolean=false;
  constructor(private provider:AppProvider) { }
  
  ngOnInit(): void {
  }
  
  public async chamada(){
    
  }
  
  agir(){
    this.agindo=true
    switch(this.acao){
      case 'edit':
        alert("editar");
        break;
      case 'add':
        break;
      default:
        alert('Outro');
        break;
    }
  }
  
}
