import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RetroactionComponent } from './retroaction.component';

describe('RetroactionComponent', () => {
  let component: RetroactionComponent;
  let fixture: ComponentFixture<RetroactionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RetroactionComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RetroactionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
