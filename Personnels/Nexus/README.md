# Nexus 🌐

**Nexus** is a modern, single-page social media application built with **Angular** and **Firebase**. It features real-time data updates, secure authentication, and a dynamic friend system, designed to connect users seamlessly.

## 🚀 Live Demo

Access the production build here:
**https://nexus-bc8e9.web.app/**

## ✨ Key Features

### 👤 User Identity & Profiles

* **Authentication:** Secure login via Google or Email/Password.
* **Dynamic Profiles:** Customizable user profiles with cover photos, avatars, bios, and stats.
* **Role Management:** specialized **Admin** role with elevated privileges (e.g., content moderation).

### 🤝 Social Connections

* **Friend System:** Complete workflow to send, cancel, and accept friend requests.
* **Real-time Status:** UI updates instantly to show "Add Friend," "Request Sent," or "Friends" based on database state.
* **Network Graph:** View friends and mutual connections (in progress).

### 📝 Content & Interaction

* **News Feed:** Create and view rich text posts.
* **Interactions:** Like and comment functionality on user posts.
* **Media Support:** (Planned) Photo and video uploads.

## 🛠️ Tech Stack

* **Frontend:** Angular 17+ (Standalone Components)
* **Styling:** SCSS, Responsive Flexbox/Grid Layouts
* **State Management:** RxJS (Observables & Streams)
* **Backend as a Service:** Firebase
* **Authentication:** Identity management
* **Firestore:** NoSQL Database
* **Hosting:** Global CDN deployment



## ⚙️ Installation & Setup

1. **Clone the repository**
```bash
git clone https://github.com/your-username/nexus.git
cd nexus

```


2. **Install Dependencies**
```bash
npm install

```


3. **Configure Firebase**
* Create a project in the [Firebase Console](https://console.firebase.google.com/).
* Copy your web app configuration (apiKey, authDomain, etc.).
* Update `src/environments/environment.ts`.


4. **Run Locally**
```bash
ng serve

```


Navigate to `http://localhost:4200/`.

## 🔐 Role Management (Admin Guide)

By default, all new users are assigned the `user` role.

**To promote a user to Admin:**

1. Go to the Firebase Console > Firestore Database.
2. Navigate to the `users` collection.
3. Find the target user's document ID.
4. Add/Edit the field:
* **Field:** `role`
* **Value:** `admin`



## 📦 Deployment

This project is configured for **Firebase Hosting**.

To deploy a new version:

```bash
# 1. Build the production files
ng build

# 2. Deploy to Firebase
firebase deploy

```