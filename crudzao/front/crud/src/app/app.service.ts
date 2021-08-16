import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";

@Injectable({
    providedIn:"root"
})

export class AppService {
    public readonly url:string = "http://localhost:8090/rest/clientes"
    
    constructor(private http:HttpClient){
    }
    
    public get():Observable<any>{
        const token:string = `Basic ${btoa("admin:123")}`
        let httpheaders:HttpHeaders = new HttpHeaders()
        httpheaders = httpheaders.set("Authorization", token)
        return this.http.get<any>(this.url, {headers: httpheaders})
    }
}