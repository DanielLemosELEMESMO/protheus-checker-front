import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { Verification } from 'src/app/models/verification.model';

@Component({
  selector: 'app-inputs-verification',
  templateUrl: './inputs-verification.component.html',
  styleUrls: ['./inputs-verification.component.scss']
})
export class InputsVerificationComponent implements OnInit {

  @Input() verification:Verification = {
  }
  @Input() botoes:string[] = ['save', 'close'];
  @Input() botoesTextos:any = ['Enviar', 'Fechar'];
  @Input() buttonsDisplay:string = "flex";
  @Input() buttonsFlex:string = "row-reverse";

  @Output() saveEvent             = new EventEmitter<any>();
  @Output() closeEvent            = new EventEmitter<boolean>();
  @Output() verificationEvent     = new EventEmitter<Verification>();

  constructor() { }

  ngOnInit(): void {
    // setTimeout(() => {console.table(this.verification)}, 2000)
  }

  save(){
    this.verificationEvent.emit(this.verification);
  }
  
  close(){
    this.closeEvent.emit();
  }
}
