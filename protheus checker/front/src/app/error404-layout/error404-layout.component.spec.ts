import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Error404LayoutComponent } from './error404-layout.component';

describe('Error404LayoutComponent', () => {
  let component: Error404LayoutComponent;
  let fixture: ComponentFixture<Error404LayoutComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ Error404LayoutComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(Error404LayoutComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
