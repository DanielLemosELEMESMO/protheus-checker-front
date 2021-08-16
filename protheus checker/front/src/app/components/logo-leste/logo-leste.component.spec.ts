import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LogoLesteComponent } from './logo-leste.component';

describe('LogoLesteComponent', () => {
  let component: LogoLesteComponent;
  let fixture: ComponentFixture<LogoLesteComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LogoLesteComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(LogoLesteComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
