import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { TabelaComponent } from './tabela/tabela.component';
import { RegistroComponent } from './registro/registro.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { BotaoAtorComponent } from './botao-ator/botao-ator.component';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { ColunaComponent } from './coluna/coluna.component';
import { ColunasComponent } from './colunas/colunas.component';
import { MatTableModule } from '@angular/material/table';

@NgModule({
  declarations: [
    AppComponent,
    TabelaComponent,
    RegistroComponent,
    BotaoAtorComponent,
    ColunaComponent,
    ColunasComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MatCardModule,
    MatButtonModule,
    MatTableModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
