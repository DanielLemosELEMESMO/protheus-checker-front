import { stringify } from '@angular/compiler/src/util';
import { Attribute, Component, OnInit, ValueProvider, Output, EventEmitter, ViewChild } from '@angular/core';
import { Verification } from 'src/app/models/verification.model';
import { VerificationService } from 'src/app/services/verification.service';

var VERIFICATION_DATA: Verification[] = [];

@Component({
  selector: 'app-table',
  templateUrl: './table.component.html',
  styleUrls: ['./table.component.scss']
})
export class TableComponent implements OnInit {
  per_page = 15;
  verification: Verification = {
    id: null,
    email: '',
    cnpj: '',
    corporate_name: '',
    frequency: '',
    query_sql: '',
    last_verification: '',
    next_verification: '',
    description: ''
  }

  editing: Verification = this.verification;

  dataSource: Verification[] = [];

  displayedColumns: string[] = [];
  orderColumns: string[] = [];
  allColumns: string[] = [];
  extraColumns: string[] = ['actions'];
  showModal: boolean = false;
  createModal: boolean = false;
  toDo:string = 'create';
  
  constructor(private verificationService: VerificationService) { }

  ngOnInit(): void {
    this.getVerifications()
  }

  getVerifications() {
    this.verificationService.pede(undefined, this.per_page)
      .subscribe(
        response => {
          this.dataSource = response.verification.data;
          console.table(this.dataSource);
          this.allColumns = Object.keys(this.dataSource[0]).concat(this.extraColumns);
          this.orderColumns = Object.keys(this.dataSource[0]);
          this.displayColumns();
          this.testeMudaOrdem();
        },
        error => {
          console.log(error);
        });
  }

  displayColumns() {
    this.displayedColumns = this.orderColumns.filter(obj =>
      obj !== 'id' &&
      obj !== 'user_id' &&
      obj !== 'created_at' &&
      obj !== 'updated_at' &&
      obj !== 'description'
    );
  }

  setOrder() {
    this.orderColumns = this.orderColumns.concat(this.allColumns.filter(item => !this.orderColumns.includes(item)));
    this.displayColumns();
  }

  testeMudaOrdem() {
    this.orderColumns = ['cnpj', 'email', 'corporate_name', 'frequency', 'query_sql'];
    this.setOrder();
  }

  openEditor(action:string, editing?: Verification) {
    this.toDo = action;
    this.editing = editing?editing:{};
    this.showModal = true;
  }

  closeEditor(value:boolean) {
    this.showModal = value;
    this.getVerifications()
  }

  atualizar(data: Verification) {
    console.table(data);
    this.verificationService.atualiza(data, data.id).subscribe(
      response => {
        this.getVerifications()
        console.log(response)
      },
      error =>{ console.log(error) }
    );
  }

  newRegister(data: Verification){
    console.table(data)
    this.verificationService.envia(data).subscribe(
      response => {
        this.getVerifications();
        console.log(response);
      },
      error => {
        console.log(error);
      }
    )
  }

  deletaRegistro(id:number){
    alert('chegamos aqui')
    this.verificationService.deleta(id).subscribe(
      response => {
        this.getVerifications();
        console.log(response);
      },
      error => {console.log(error)}
      )
    }
    
  atualizaOuCria(value:Verification){
    if(this.toDo == 'create'){
      this.newRegister(value)
    }
    else if(this.toDo == 'edit'){
      this.atualizar(value)
    }
  }

}
