import { ComponentFixture, TestBed } from '@angular/core/testing';

import { IdeSqlComponent } from './ide-sql.component';

describe('IdeSqlComponent', () => {
  let component: IdeSqlComponent;
  let fixture: ComponentFixture<IdeSqlComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ IdeSqlComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(IdeSqlComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
