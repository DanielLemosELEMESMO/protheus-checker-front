import { Component, Input, OnInit, Output, EventEmitter} from '@angular/core';

@Component({
  selector: 'app-warn-modal',
  templateUrl: './warn-modal.component.html',
  styleUrls: ['./warn-modal.component.scss']
})
export class WarnModalComponent implements OnInit {

  @Input() content:any = undefined;
  @Input() titulo:any = 'Verificação alterada com sucesso';
  @Input() type:string = 'y/n warn'; //opcoes: 'y/n', 'ok'
  @Output() actionEvent = new EventEmitter<any>();

  constructor() { }

  ngOnInit(): void {
  }

  sendAction(value:any){
    this.actionEvent.emit(value)
  }

}
