import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { TokenStorageService } from 'src/app/services/token-storage.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  constructor(public router: Router, private tokenService: TokenStorageService ) { }
  loggedIn:boolean = !!this.tokenService.getToken();
  saindo:boolean = false //para mudar alguns styles quando o user estiver saindo
  ngOnInit(): void {
    this.loggedIn = !!this.tokenService.getToken();

    if (!this.loggedIn){
      this.router.navigateByUrl('/auth/login');
    }
  }

  goHome(){
    this.router.navigateByUrl('/dashboard/home');
  }
  
  goRegister(){
    this.router.navigateByUrl('/dashboard/register');
  }
  
  goTable(){
    this.router.navigateByUrl('/dashboard/table');
  }
  doLogout(){
    this.saindo = true;
    this.router.navigateByUrl('/auth/login');
  }
}
