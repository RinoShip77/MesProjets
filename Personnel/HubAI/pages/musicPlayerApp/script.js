const audio = document.getElementById('audio');
const title = document.getElementById('title');
const artist = document.getElementById('artist');
const albumIconContainer = document.getElementById('albumIconContainer');
const albumIcon = document.getElementById('albumIcon');
const controlButton = document.getElementById('control');
const volumeSlider = document.getElementById('volume');
const shuffleBtn = document.getElementById('shuffle');
const repeatBtn = document.getElementById('repeat');
const playlistContainer = document.getElementById('playlist');
const progressBar = document.getElementById('progress');
const currentTime = document.getElementById('currentTime');
const duration = document.getElementById('duration');

let isShuffle = false;
let isRepeat = false;
let currentSongIndex;
let songs = [
   {
      title: 'Any Way You Want It',
      artist: 'Journey'
   },
   {
      title: 'Bad Moon Rising',
      artist: 'Creedence Clearwater Revival'
   },
   {
      title: 'Bohemian Rhapsody - Remastered 2011',
      artist: 'Queen'
   },
   {
      title: 'Boogie Wonderland',
      artist: 'Earth; Wind & Fire;'
   },
   {
      title: 'Born This Way',
      artist: 'Lady Gaga'
   },
   {
      title: 'Bye Bye Bye - From Deadpool and Wolverine Soundtrack',
      artist: 'NSYNC'
   },
   {
      title: 'Careless Whisper',
      artist: 'George Michael'
   },
   {
      title: 'Coton ouate',
      artist: 'Bleu Jeans Bleu'
   },
   {
      title: 'Daddy Cool',
      artist: 'Boney M.'
   },
   {
      title: 'Dancing Queen',
      artist: 'ABBA'
   },
   {
      title: 'Dream On',
      artist: 'Aerosmith'
   },
   {
      title: 'Fantasy',
      artist: 'Mariah Carey'
   },
   {
      title: 'I Want It That Way',
      artist: 'Backstreet Boys'
   },
   {
      title: "I'm Still Standing",
      artist: 'Elton John'
   },
   {
      title: 'In The End',
      artist: 'Linkin Park'
   },
   {
      title: 'My Heart Will Go On - Love Them from "Titanic"',
      artist: 'Céline Dion'
   },
   {
      title: "Toune d'automne",
      artist: 'Les Cowboys Fringuants'
   },
   {
      title: 'Welcome To The Jungle',
      artist: "Guns N' Roses"
   },
   {
      title: 'You Give Love A Bad Name',
      artist: 'Bon Jovi'
   },
   {
      title: 'Zombie',
      artist: 'The Cranberries'
   }
];

async function loadSong(index) {
   currentSongIndex = index;
   const song = songs[index];
   title.textContent = song.title;
   artist.textContent = song.artist;
   audio.src = `songs/${song.title}.mp3`;
   setColor();
   updatePlaylist();
}

function updatePlaylist() {
   playlistContainer.innerHTML = '';
   songs.forEach((song, index) => {
      const li = document.createElement('li');
      li.textContent = `${song.title} - ${song.artist}`;
      li.classList.toggle('active', index === currentSongIndex);
      li.addEventListener('click', () => {
         currentSongIndex = index;
         loadSong(currentSongIndex);
         trackControl('play')
      });
      playlistContainer.appendChild(li);
   });
}

function formatTime(seconds) {
   const minutes = Math.floor(seconds / 60);
   const secs = Math.floor(seconds % 60);
   return `${minutes}:${secs < 10 ? '0' : ''}${secs}`;
}

function saveState() {
   const state = {
      currentSongIndex,
      currentTime: audio.currentTime,
      isShuffle,
      isRepeat,
      volume: audio.volume,
   };
   localStorage.setItem('musicPlayerState', JSON.stringify(state));
}

function loadState() {
   const state = JSON.parse(localStorage.getItem('musicPlayerState'));
   if (state) {
      currentSongIndex = state.currentSongIndex;
      audio.currentTime = state.currentTime;
      isShuffle = state.isShuffle;
      isRepeat = state.isRepeat;
      audio.volume = state.volume;
      volumeSlider.value = state.volume;
      if (isShuffle) shuffleBtn.style.backgroundColor = '#28a745';
      if (isRepeat) repeatBtn.style.backgroundColor = '#28a745';
      loadSong(currentSongIndex);
   }
}

function trackControl(action) {
   switch (action) {
      case 'play':
         controlButton.children[0].classList.replace('fa-circle-play', 'fa-circle-pause');
         albumIcon.style.animation = 'rotation 3s infinite linear .5s';
         audio.play();
         break;
      case 'pause':
         controlButton.children[0].classList.replace('fa-circle-pause', 'fa-circle-play');
         albumIcon.style.animation = 'none';
         audio.pause();
         break;
      case 'forward':
         if (isShuffle) {
            loadSong(Math.floor(Math.random() * songs.length));
         } else {
            if (currentSongIndex >= 3) {
               loadSong(0);
            } else {
               loadSong(currentSongIndex + 1);
            }
         }
         audio.play();
         break;
      case 'backward':
         if (isShuffle) {
            loadSong(Math.floor(Math.random() * songs.length));
         } else {
            if (currentSongIndex <= 0) {
               loadSong(songs.length - 1);
            } else {
               loadSong(currentSongIndex - 1);
            }
         }
         audio.play();
         break;
   }
}

async function setColor() {
   await fetch('https://x-colors.yurace.pro/api/random?type=dark')
      .then(response => response.json())
      .then(data => {
         albumIcon.style.color = `${data.hex}`;
      })
}

volumeSlider.addEventListener('input', (event) => {
   audio.volume = event.target.value;
   saveState();
});

shuffleBtn.addEventListener('click', () => {
   isShuffle = !isShuffle;
   shuffleBtn.style.backgroundColor = isShuffle ? '#28a745' : '';
   saveState();
});

repeatBtn.addEventListener('click', () => {
   isRepeat = !isRepeat;
   repeatBtn.style.backgroundColor = isRepeat ? '#28a745' : '';
   saveState();
});

audio.addEventListener('timeupdate', () => {
   const progressPercent = (audio.currentTime / audio.duration) * 100;
   progressBar.value = progressPercent;
   currentTime.textContent = formatTime(audio.currentTime);
   duration.textContent = formatTime(audio.duration);
});

progressBar.addEventListener('input', (event) => {
   const seekTime = (event.target.value / 100) * audio.duration;
   audio.currentTime = seekTime;
});

audio.addEventListener('ended', () => {
   if (isRepeat) {
      audio.currentTime = 0;
      audio.play();
   } else if (isShuffle) {
      currentSongIndex = Math.floor(Math.random() * songs.length);
      loadSong(currentSongIndex);
      audio.play();
   } else {
      currentSongIndex = (currentSongIndex + 1) % songs.length;
      loadSong(currentSongIndex);
      audio.play();
   }
});
