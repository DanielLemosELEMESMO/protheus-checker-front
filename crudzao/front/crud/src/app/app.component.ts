import { Component } from '@angular/core';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'crud';
  toppings = new FormControl();
  toppingList: string[] = ['Código', 'Loja', 'Nome', 'Nome Fantasia', 'Tipo', 'Estado', 'Município', 'Endereço', ];
  selected:string[] = ['Código', 'Loja', 'Nome', 'Estado', 'Município', 'Endereço'];
}
