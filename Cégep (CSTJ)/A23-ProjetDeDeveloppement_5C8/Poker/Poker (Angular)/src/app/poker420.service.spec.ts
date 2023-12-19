import { TestBed } from '@angular/core/testing';

import { Poker420Service } from './poker420.service';

describe('Poker420Service', () => {
  let service: Poker420Service;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(Poker420Service);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
