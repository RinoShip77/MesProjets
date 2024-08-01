let apiKey = 'bd5e378503939ddaee76f12ad7a97608';

document.getElementById('dark-mode-toggle').addEventListener('click', () => {
   document.body.dataset.theme = document.body.dataset.theme === 'dark' ? 'light' : 'dark';
});

document.getElementById('theme-toggle').addEventListener('click', () => {
   document.body.dataset.theme = document.body.dataset.theme === 'custom' ? 'light' : 'custom';
});

document.getElementById('city-input').addEventListener('keypress', function (event) {
   if (event.key === "Enter") {
      event.preventDefault();
      fetchWeatherData();
   }
});

function getLocation() {
   if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(showCity);
   } else {
      x.innerHTML = "Geolocation is not supported by this browser.";
   }
}

function showCity(position) {
   let latitude = position.coords.latitude;
   let longitude = position.coords.longitude;

   let url = `https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${latitude}&longitude=${longitude}&localityLanguage=en`;

   fetch(url)
      .then((response) => response.json())
      .then((data) => {
         document.getElementById('city-input').value = data.city
         fetchWeatherData(data.city);
      })
}

function fetchWeatherData() {
   let city = document.getElementById('city-input').value
   let url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric`;
   
   if(city !== '') {
      document.getElementById('info').classList.add('fade-in')
      document.getElementById('invalid-message').classList.remove('fade-in')
      fetch(url)
         .then(response => response.json())
         .then(data => {
            updateWeatherInfo(data);
            fetchHourlyForecast(city);
         })
         .catch(error => console.error('Error fetching weather data:', error));
   } else {
      document.getElementById('invalid-message').classList.add('fade-in')
   }
}

function updateWeatherInfo(data) {
   let city = document.getElementById('city');
   let countryFlag = document.getElementById('country-flag')
   let weatherIcon = document.getElementById('weather-icon');
   let temperature = document.getElementById('temperature');
   let description = document.getElementById('description');
   let sunriseSunset = document.getElementById('sunrise-sunset');
   let iconUrl = `http://openweathermap.org/img/wn/${data.weather[0].icon}@2x.png`;

   city.textContent = data.name;
   countryFlag.src = `https://flagcdn.com/48x36/${(data.sys.country).toLowerCase()}.png`;
   countryFlag.alt = data.sys.country;
   weatherIcon.innerHTML = `<img src="${iconUrl}" alt="Weather Icon">`;
   temperature.textContent = `Temperature: ${data.main.temp}°C`;
   description.textContent = `Description: ${data.weather[0].description}`;
   sunriseSunset.textContent = `Sunrise: ${new Date(data.sys.sunrise * 1000).toLocaleTimeString()} | Sunset: ${new Date(data.sys.sunset * 1000).toLocaleTimeString()}`;

   initMap(data.coord.lat, data.coord.lon);
}

function initMap(lat, lon) {
   let map = L.map('map').setView([lat, lon], 13);
   L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap contributors'
   }).addTo(map);
}

function fetchHourlyForecast(city) {
   let url = `https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=${apiKey}&units=metric`;
   fetch(url)
      .then(response => response.json())
      .then(data => updateHourlyForecast(data))
      .catch(error => console.error('Error fetching hourly forecast:', error));
}

function updateHourlyForecast(data) {
   let ctx = document.getElementById('hourly-chart').getContext('2d');
   let labels = data.list.slice(0, 8).map(item => new Date(item.dt * 1000).toLocaleTimeString());
   let temps = data.list.slice(0, 8).map(item => item.main.temp);

   new Chart(ctx, {
      type: 'line',
      data: {
         labels: labels,
         datasets: [{
            label: 'Temperature (°C)',
            data: temps,
            borderColor: 'rgba(75, 192, 192, 1)',
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            borderWidth: 1
         }]
      },
      options: {
         scales: {
            x: {
               beginAtZero: true
            },
            y: {
               beginAtZero: true
            }
         }
      }
   });
}

document.getElementById('share-twitter').addEventListener('click', () => {
   let city = document.getElementById('city-input').value;
   let url = `https://twitter.com/intent/tweet?text=Check out the weather in ${city}!`;
   window.open(url, '_blank');
});

document.getElementById('share-facebook').addEventListener('click', () => {
   let city = document.getElementById('city-input').value;
   let url = `https://www.facebook.com/sharer/sharer.php?u=https://openweathermap.org/city/${city}`;
   window.open(url, '_blank');
});
