import { Component, OnInit, Output, EventEmitter} from '@angular/core';
import { Verification } from 'src/app/models/verification.model';
import { VerificationService } from 'src/app/services/verification.service';

@Component({
  selector: 'app-db-register',
  templateUrl: './db-register.component.html',
  styleUrls: ['./db-register.component.scss']
})

export class DbRegisterComponent implements OnInit {
  
  verification:Verification = {
    email: '',
    cnpj: '',
    corporate_name: '',
    frequency: '',
    query_sql: ''
  }

  constructor(private verificationService:VerificationService) { }
  
  ngOnInit(): void {
  }
  
  sendVerification() {
    var data = this.verification

    this.verificationService.envia(data)
    .subscribe(
      response => {
        console.log(response);
        alert("verification enviada!")
      },
      error =>{
        console.log(error);
        alert("o envio falhou!")
      }
    )
  }
}
