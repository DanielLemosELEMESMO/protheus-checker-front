import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InputsVerificationComponent } from './inputs-verification.component';

describe('InputsVerificationComponent', () => {
  let component: InputsVerificationComponent;
  let fixture: ComponentFixture<InputsVerificationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ InputsVerificationComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(InputsVerificationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
