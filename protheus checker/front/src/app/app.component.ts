import { Component } from '@angular/core';
import { TokenStorageService } from 'src/app/services/token-storage.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'front';

  isLoggedIn: boolean = false;
  showPopup: boolean = false;

  constructor(private tokenStorageService: TokenStorageService) { }
  
  ngOnInit(): void {
  }

  popupOnOff(value:boolean){
    this.showPopup = value;
  }
}
