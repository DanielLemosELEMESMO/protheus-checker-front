import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Fundo1Component } from './fundo1.component';

describe('Fundo1Component', () => {
  let component: Fundo1Component;
  let fixture: ComponentFixture<Fundo1Component>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ Fundo1Component ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(Fundo1Component);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
