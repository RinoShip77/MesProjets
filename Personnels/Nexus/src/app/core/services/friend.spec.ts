import { TestBed } from '@angular/core/testing';

import { Friend } from './friend';

describe('Friend', () => {
  let service: Friend;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(Friend);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
