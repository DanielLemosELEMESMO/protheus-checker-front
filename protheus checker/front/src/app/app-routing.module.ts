import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

/*/AUTH + CHILDREN/*/
import { AuthLayoutComponent } from 'src/app/auth-layout/auth-layout.component';
import { FormComponent } from 'src/app/form-login/form-login.component';
import { FormRegisterComponent } from 'src/app/form-register/form-register.component';

/*/DASHBOARD + CHILDREN/*/
import { DashboardComponent } from 'src/app/dashboard/dashboard.component';
import { DbRegisterComponent } from 'src/app/db-register/db-register.component';
import { DbHomeComponent } from 'src/app/db-home/db-home.component';
import { DbTableComponent } from 'src/app/db-table/db-table.component';

/*/OUTROS/*/
import { Error404LayoutComponent } from 'src/app/error404-layout/error404-layout.component';

const routes: Routes = [
  /*/AUTHORIZATION (layout + children)/*/
  {
    path: 'auth' ,
    component: AuthLayoutComponent,
    children: [
      { path: '',         redirectTo: 'login', pathMatch:'full'},
      { path: 'login',    component:FormComponent},
      { path: 'register', component:FormRegisterComponent}
    ]
  },

  /*/DASHBOARD (layout + children)/*/
  {
    path: 'dashboard' ,
    component: DashboardComponent,
    children: [
      { path: '',         redirectTo: 'home', pathMatch:'full'},
      { path: 'home',     component: DbHomeComponent},
      { path: 'register', component: DbRegisterComponent},
      { path: 'table',    component: DbTableComponent}
    ]
  },
  /*/404/*/
  {
    path: '404', component:Error404LayoutComponent
  },
  /*/REDIRECTS/*/
  { path:'register',  redirectTo: 'auth',       pathMatch:'full'},
  { path:'login',     redirectTo: 'auth',       pathMatch:'full'},
  { path: '' ,        redirectTo: 'dashboard',  pathMatch:'full' },
  { path: 'dash' ,    redirectTo: 'dashboard',  pathMatch:'full' },
  { path: 'board' ,   redirectTo: 'dashboard',  pathMatch:'full' },
  { path: 'db' ,   redirectTo: 'dashboard',  pathMatch:'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
