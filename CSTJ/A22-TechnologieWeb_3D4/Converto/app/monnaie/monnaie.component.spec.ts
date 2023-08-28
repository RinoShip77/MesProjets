import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MonnaieComponent } from './monnaie.component';

describe('MonnaieComponent', () => {
  let component: MonnaieComponent;
  let fixture: ComponentFixture<MonnaieComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MonnaieComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MonnaieComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
