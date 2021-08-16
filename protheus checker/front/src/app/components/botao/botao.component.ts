import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-botao',
  templateUrl: './botao.component.html',
  styleUrls: ['./botao.component.scss']
})
export class BotaoComponent implements OnInit {

  @Input()texto:string = 'CLIQUE';
  @Input()width:string = '100%';
  @Input()height:string = '100%';
  @Input()bradius:string = '6px';
  @Input()bcolor:string = '#0897e9';
  @Input()color:string = '#ffffff';
  @Input()pbottom:string = '7px';
  @Input()ptop:string = '7px';
  @Input()fsize:string = 'auto';
  @Input()tipo:string = 'normal';
  @Input()bwidth:string = 'auto';
  @Input()borderColor:string = '#363636';

  constructor() { }

  ngOnInit(): void {
    console.log("botao iniciado")
  }

}
