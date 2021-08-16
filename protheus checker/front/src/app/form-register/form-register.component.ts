import { Component, OnInit } from '@angular/core';
import { FormControl, Validators } from '@angular/forms';
import { User } from 'src/app/models/user.model';
import { AuthService } from 'src/app/services/auth.service';
import { Router } from '@angular/router';
import { TokenStorageService } from 'src/app/services/token-storage.service';

@Component({
  selector: 'app-form-register',
  templateUrl: './form-register.component.html',
  styleUrls: ['./form-register.component.scss']
})

export class FormRegisterComponent implements OnInit {

  etapaAtual:number = 1
  etapaFinal: number = 2

  constructor(private authService: AuthService, private router: Router, private tokenStorageService: TokenStorageService) { }

  ngOnInit(): void {
  }

  email = new FormControl('', [Validators.required, Validators.email]);
  hidepassword1 = true
  hidepassword2 = true
  password_confirmation:any;

  user: User = {
    name: '',
    email: '',
    password: ''
  }

  register(): void {
    alert('tentarei mandar')
    const data = {
      name: this.user.name,
      email: this.user.email,
      password: this.user.password,
      password_confirmation: this.password_confirmation
    };

    this.authService.envia(data, 'register')
      .subscribe(
        response => {
          console.log(response);
          this.router.navigateByUrl('/dashboard');
          this.tokenStorageService.saveToken(response.access_token)
        },
        error => {
          console.log(error);
        });
  }

  getErrorMessage() {
    if (this.email.hasError('required')) {
      return 'You must enter a value';
    }

    return this.email.hasError('email') ? 'Not a valid email' : '';
  }

  nextStep(){
    this.etapaAtual++
    console.log(this.etapaAtual)
  }
  lastStep(){
    this.etapaAtual--
    console.log(this.etapaAtual)
  }
  enviaForm(){
    alert("Form enviado (ou não)")
  }
}
