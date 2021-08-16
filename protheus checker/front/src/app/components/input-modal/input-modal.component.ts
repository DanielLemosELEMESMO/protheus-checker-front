import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { Verification } from 'src/app/models/verification.model';
import { VerificationService } from 'src/app/services/verification.service';

@Component({
  selector: 'app-input-modal',
  templateUrl: './input-modal.component.html',
  styleUrls: ['./input-modal.component.scss']
})
export class InputModalComponent implements OnInit {

  constructor(private verificationService: VerificationService) { }
  @Input() mode:string='edit';
  @Input() id:number = -1;
  @Input() register:Verification = {
    id: this.id,
    email: '',
    cnpj: '',
    corporate_name: '',
    frequency: '',
    query_sql: '',
    last_verification: '',
    next_verification: '',
    description: ''
  }
  
  @Output() closeEvent = new EventEmitter<boolean>();
  @Output() editVerificationEvent = new EventEmitter<Verification>();
  @Output() newVerificationEvent = new EventEmitter<Verification>();

  tituloModal:string = 'Atualizar verificação';
  option:string = 'dadosCliente';

  ngOnInit(): void {
    this.id = this.register.id;
    this.tituloModal = (this.mode=='create')?'Cadastre o cliente que você deseja verificar':'Atualizar verificação';
    // setTimeout(() => {console.table(this.register)}, 2000)
  }
  funcao(){
    alert('foi')
  }
  close(){
    this.closeEvent.emit(false);
  }
  salvar(verification:Verification){
    this.register = verification;
    this.editVerificationEvent.emit(this.register);
    // console.log("SEGUINTE: "+this.register);
    // console.log(this.register);
  }
}
