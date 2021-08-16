import { Component, OnInit } from '@angular/core';
import { FormControl, Validators } from '@angular/forms';
import { User } from 'src/app/models/user.model';
import { AuthService } from 'src/app/services/auth.service';
import { Router } from '@angular/router';
import { TokenStorageService } from 'src/app/services/token-storage.service';


@Component({
  selector: 'app-form-login',
  templateUrl: './form-login.component.html',
  styleUrls: ['./form-login.component.scss']
})

export class FormComponent implements OnInit {

  email = new FormControl('', [Validators.required, Validators.email]);
  hidepassword = true

  user: User = {
    email: '',
    password: ''
  }

  getErrorMessage() {
    if (this.email.hasError('required')) {
      return 'You must enter a value';
    }

    return this.email.hasError('email') ? 'Not a valid email' : '';
  }

  constructor(private authService: AuthService, private router: Router, private tokenStorageService: TokenStorageService ) { }

  ngOnInit(): void {
    localStorage.getItem('access_token')
  }

  login(): void {
    const data = {
      email: this.user.email,
      password: this.user.password
    };

    this.authService.envia(data, 'login')
      .subscribe(
        response => {
          console.log(response);
          this.tokenStorageService.saveToken(response.access_token);
          this.router.navigateByUrl('/dashboard');
        },
        error => {
          console.log(error);
        });
  }

}
