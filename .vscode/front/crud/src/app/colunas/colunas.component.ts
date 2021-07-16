import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-colunas',
  templateUrl: './colunas.component.html',
  styleUrls: ['./colunas.component.scss']
})
export class ColunasComponent implements OnInit {

  @Input()aColunas:string[] = []

  @Output()out:EventEmitter<any> = new EventEmitter()
  
  constructor() { }

  ngOnInit(): void {
  }

  novacoisa(){
    this.out.emit("amor")
  }
}
