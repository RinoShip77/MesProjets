import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CreationPartieComponent } from './creation-partie.component';

describe('CreationPartieComponent', () => {
  let component: CreationPartieComponent;
  let fixture: ComponentFixture<CreationPartieComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [CreationPartieComponent]
    });
    fixture = TestBed.createComponent(CreationPartieComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
