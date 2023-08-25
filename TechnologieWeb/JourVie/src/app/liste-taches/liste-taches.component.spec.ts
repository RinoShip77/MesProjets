import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListeTachesComponent } from './liste-taches.component';

describe('ListeTachesComponent', () => {
  let component: ListeTachesComponent;
  let fixture: ComponentFixture<ListeTachesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ListeTachesComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ListeTachesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
