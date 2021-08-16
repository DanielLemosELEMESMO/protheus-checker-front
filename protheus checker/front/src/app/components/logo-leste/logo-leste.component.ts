import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-logo-leste',
  templateUrl: './logo-leste.component.html',
  styleUrls: ['./logo-leste.component.scss']
})
export class LogoLesteComponent implements OnInit {

  @Input()size:string = '364px';
  constructor() { }

  ngOnInit(): void {
  }

}
