import { TestBed } from '@angular/core/testing';

import { JourvieService } from './jourvie.service';

describe('JourvieService', () => {
  let service: JourvieService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(JourvieService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
