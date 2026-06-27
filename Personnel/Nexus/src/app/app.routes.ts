import { Routes } from '@angular/router';
import { FeedComponent } from './features/feed/feed.component';
import { PostDetailComponent } from './features/post-detail/post-detail.component';
import { UserProfileComponent } from "./features/user-profile/user-profile.component";
import { LoginComponent } from "./features/login/login.component";
import { FriendRequestsComponent } from "./features/friend-requests/friend-requests.component";

export const routes: Routes = [
  {
    path: '',
    component: FeedComponent, // Parent
    children: [
      { path: 'post/:id', component: PostDetailComponent } // Child (The Modal)
    ]
  },
  { path: 'login', component: LoginComponent },
  { path: 'user/:id', component: UserProfileComponent },
  { path: 'requests', component: FriendRequestsComponent },
  { path: '**', redirectTo: '' }
];