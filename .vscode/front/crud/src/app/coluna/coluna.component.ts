import { Component, Input, OnInit, Output, EventEmitter} from '@angular/core';

@Component({
  selector: 'app-coluna',
  templateUrl: './coluna.component.html',
  styleUrls: ['./coluna.component.scss']
})
export class ColunaComponent implements OnInit {

  @Input()public coluna:string = "vazio"

  constructor() { }

  ngOnInit(): void {
  }
}
