import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { User } from '../models/user.model';

const baseUrl = 'http://10.1.4.220:8000/api/';

@Injectable({
  providedIn: 'root'
})

export class AuthService {

  constructor(private http: HttpClient) { }

  envia(data: any, fun:string): Observable<any> {
    return this.http.post(baseUrl+fun, data);
  }
}
