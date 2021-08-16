import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { Fundo1Component } from './fundo1/fundo1.component';
import { FormComponent } from './form-login/form-login.component';
import { MatCardModule } from '@angular/material/card';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { ReactiveFormsModule } from '@angular/forms';
import {MatIconModule} from '@angular/material/icon';
import { FormRegisterComponent } from './form-register/form-register.component';
import { LogoLesteComponent } from './components/logo-leste/logo-leste.component';
import { BotaoComponent } from './components/botao/botao.component';
import { InputComponent } from './input/input.component';
import { DashboardComponent } from 'src/app/dashboard/dashboard.component';
import { DbRegisterComponent } from './db-register/db-register.component';
import { DbHomeComponent } from './db-home/db-home.component';
import { DbTableComponent } from './db-table/db-table.component';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
import { TableComponent } from './components/table/table.component';
import { MatTableModule } from '@angular/material/table';
import { AuthLayoutComponent } from './auth-layout/auth-layout.component';
import { Error404LayoutComponent } from './error404-layout/error404-layout.component';
import { InputModalComponent } from './components/input-modal/input-modal.component';
import { InputsVerificationComponent } from './components/inputs-verification/inputs-verification.component';
import { IdeSqlComponent } from './components/ide-sql/ide-sql.component';
import { WarnModalComponent } from './components/warn-modal/warn-modal.component';
import { ModalCreateComponent } from './components/modal-create/modal-create.component';

@NgModule({
  declarations: [
    AppComponent,
    Fundo1Component,
    FormComponent,
    FormRegisterComponent,
    LogoLesteComponent,
    BotaoComponent,
    InputComponent,
    DashboardComponent,
    DbRegisterComponent,
    DbHomeComponent,
    DbTableComponent,
    TableComponent,
    AuthLayoutComponent,
    Error404LayoutComponent,
    InputModalComponent,
    InputsVerificationComponent,
    IdeSqlComponent,
    WarnModalComponent,
    ModalCreateComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MatCardModule,
    MatInputModule,
    MatButtonModule,
    ReactiveFormsModule,
    MatIconModule,
    HttpClientModule,
    FormsModule,
    MatTableModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
