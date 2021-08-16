import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Verification } from '../models/verification.model';
import { TokenStorageService } from 'src/app/services/token-storage.service';


const baseUrl = 'http://10.1.4.220:8000/api/verification';

@Injectable({
  providedIn: 'root'
})

export class VerificationService {
  constructor(private http: HttpClient, private tokenStorageService:TokenStorageService) { }
  
  pede(id?:number, per_page?:number): Observable<any> {
    const token = this.tokenStorageService.getToken()
    id?.toString()
    per_page = per_page?per_page:15;
    const per_page_param = `?per_page= ${per_page}`;
    const url = id?(baseUrl+'/'+id + per_page_param):(baseUrl + per_page_param);
    return this.http.get(
      url, { headers: {"Authorization":[`Bearer ${token}`]} })
  }

  envia(data:Verification): Observable<any> {
    const token = this.tokenStorageService.getToken()
    return this.http.post(
      baseUrl, data, { headers: {"accept":'application/json', "Authorization":[`Bearer ${token}`]} })
  }
  atualiza(data:Verification, id:number){
    const token = this.tokenStorageService.getToken()
    return this.http.put(
      baseUrl+'/'+id, data, { headers: {"Authorization":[`Bearer ${token}`]} })
    }
    deleta(id:number){
      const token = this.tokenStorageService.getToken();
      return this.http.delete(
        baseUrl+'/'+id, { headers: {"Authorization":[`Bearer ${token}`]}}
    )
  }
}