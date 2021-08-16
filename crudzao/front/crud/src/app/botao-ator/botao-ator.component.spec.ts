import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BotaoAtorComponent } from './botao-ator.component';

describe('BotaoAtorComponent', () => {
  let component: BotaoAtorComponent;
  let fixture: ComponentFixture<BotaoAtorComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BotaoAtorComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BotaoAtorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
