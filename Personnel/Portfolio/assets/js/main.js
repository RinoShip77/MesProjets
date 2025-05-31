/**
* Template Name: EasyFolio
* Template URL: https://bootstrapmade.com/easyfolio-bootstrap-portfolio-template/
* Updated: Feb 21 2025 with Bootstrap v5.3.3
* Author: BootstrapMade.com
* License: https://bootstrapmade.com/license/
*/

/**
 * Initiate glightbox
 */
const glightbox = GLightbox({
  selector: '.glightbox'
});

/**
 * Animation on scroll function and init
 */
function aosInit() {
  AOS.init({
    duration: 600,
    easing: 'ease-in-out',
    once: true,
    mirror: false
  });
}

/**
  * On page load
  */
window.addEventListener('load', function (e) {
  setTimeout(() => {
    document.getElementById("spinner").classList.add("d-none");
    document.getElementById("page").classList.remove("d-none");
    main();
  }, 3000);
});

/**
  * On scroll
  */
document.addEventListener('scroll', function (e) {
  navmenuScrollspy();
  toggleScrolled();
  toggleScrollTop();
});

/**
  * Hide the spinner and show the page
  */
function main() {
  if (location.href.includes("https")) {
    document.getElementById("projects").innerHTML = 0;

    getData('https://api.github.com/users/rinoship77');
    getData('https://api.github.com/repos/rinoship77/mesprojets');
  }

  adjustSkills("languages");
  adjustSkills("softwares");
  scrollPosition();
  toggleScrolled();
  aosInit();
  navmenuScrollspy();
}

/**
 * Init isotope layout and filters
 */
document.querySelectorAll('.isotope-layout').forEach(function (isotopeItem) {
  let layout = isotopeItem.getAttribute('data-layout') ?? 'masonry';
  let filter = isotopeItem.getAttribute('data-default-filter') ?? '*';
  let sort = isotopeItem.getAttribute('data-sort') ?? 'original-order';
  let initIsotope;

  imagesLoaded(isotopeItem.querySelector('.isotope-container'), function () {
    initIsotope = new Isotope(isotopeItem.querySelector('.isotope-container'), {
      itemSelector: '.isotope-item',
      layoutMode: layout,
      filter: filter,
      sortBy: sort
    });
  });

  isotopeItem.querySelectorAll('.isotope-filters li').forEach(function (filters) {
    filters.addEventListener('click', function () {
      isotopeItem.querySelector('.isotope-filters .filter-active').classList.remove('filter-active');
      this.classList.add('filter-active');
      initIsotope.arrange({
        filter: this.getAttribute('data-filter')
      });
      if (typeof aosInit === 'function') {
        aosInit();
      }
    }, false);
  });
});

/**
 * Navmenu Scrollspy
 */
function navmenuScrollspy() {
  document.querySelectorAll('.navmenu a').forEach(navmenulink => {
    if (!navmenulink.hash) return;
    let section = document.querySelector(navmenulink.hash);
    if (!section) return;
    let position = window.scrollY + 200;
    if (position >= section.offsetTop && position <= (section.offsetTop + section.offsetHeight)) {
      document.querySelectorAll('.navmenu a.active').forEach(link => link.classList.remove('active'));
      navmenulink.classList.add('active');
    } else {
      navmenulink.classList.remove('active');
    }
  })
}

/**
 * Hide mobile nav on same-page/hash links
 */
document.querySelectorAll('#navmenu a').forEach(navmenu => {
  navmenu.addEventListener('click', () => {
    if (document.querySelector('.mobile-nav-active')) {
      mobileNavToogle();
    }
  });
});

/**
 * Toggle mobile nav dropdowns
 */
document.querySelectorAll('.navmenu .toggle-dropdown').forEach(navmenu => {
  navmenu.addEventListener('click', function (e) {
    e.preventDefault();
    this.parentNode.classList.toggle('active');
    this.parentNode.nextElementSibling.classList.toggle('dropdown-active');
    e.stopImmediatePropagation();
  });
});

/**
 * Mobile nav toggle
 */
function mobileNavToogle() {
  document.body.classList.toggle('mobile-nav-active');
  document.querySelector('.mobile-nav-toggle').classList.toggle('bi-list');
  document.querySelector('.mobile-nav-toggle').classList.toggle('bi-x');
}
if (document.querySelector('.mobile-nav-toggle')) {
  document.querySelector('.mobile-nav-toggle').addEventListener('click', mobileNavToogle);
}

/**
 * Manage the color modes (light AND dark)
 */
function switchTheme(themeSwitch) {
  if (!themeSwitch) {
    document.getElementById("themeSwitcher").classList.replace("bi-moon-stars-fill", "bi-sun-fill");
    document.body.setAttribute("data-bs-theme", "dark");
    document.getElementById("logo").src = `assets/img/logo/dark.png`;
  } else {
    document.getElementById("themeSwitcher").classList.replace("bi-sun-fill", "bi-moon-stars-fill");
    document.body.removeAttribute("data-bs-theme");
    document.getElementById("logo").src = `assets/img/logo/light.png`;
  }

  document.body.classList.toggle("dark");
}

/**
 * Animate the skills items on reveal
 */
let skillsAnimation = document.querySelectorAll('.skills-animation');
skillsAnimation.forEach((item) => {
  new Waypoint({
    element: item,
    offset: '80%',
    handler: function (direction) {
      let progress = item.querySelectorAll('.progress .progress-bar');
      progress.forEach(el => {
        el.style.width = el.getAttribute('aria-valuenow') + '%';
      });
    }
  });
});

/**
 * Correct scrolling position upon page load for URLs containing hash links.
 */
function scrollPosition() {
  if (window.location.hash) {
    if (document.querySelector(window.location.hash)) {
      setTimeout(() => {
        let section = document.querySelector(window.location.hash);
        let scrollMarginTop = getComputedStyle(section).scrollMarginTop;
        window.scrollTo({
          top: section.offsetTop - parseInt(scrollMarginTop),
          behavior: 'smooth'
        });
      }, 100);
    }
  }
};

/**
 * Show the data that was fetch
 */
function displayData(url, data) {
  const date = new Date();

  if (url.includes("rinoship77")) {
    switch (url.slice(0, url.indexOf("/"))) {
      case 'users':
        document.getElementById('avatar').src = data.avatar_url;
        document.getElementById('bio').innerHTML = data.bio;
        document.getElementById('experience').innerHTML = diffDate(new Date(data.created_at), date);
        document.getElementById('age').innerHTML = diffDate(new Date("2001-05-08"), date);
        break;

      case 'repos':
        getData(data.contents_url.slice(0, (data.contents_url.lastIndexOf("/") + 1)));
    }
  } else {
    for (let index = 0; index < data.length - 1; index++) {
      getData(data[index].url);
    }
  }
}

/**
 * Apply .scrolled class to the body as the page is scrolled down
 */
function toggleScrolled() {
  if (!document.querySelector('#header').classList.contains('scroll-up-sticky') && !document.querySelector('#header').classList.contains('sticky-top') && !document.querySelector('#header').classList.contains('fixed-top')) return;
  window.scrollY > 100 ? document.body.classList.add('scrolled') : document.body.classList.remove('scrolled');
}

/**
 * Show scroll top button
 */
function toggleScrollTop() {
  if (document.querySelector('.scroll-top')) {
    window.scrollY > 100 ? document.querySelector('.scroll-top').classList.add('active') : document.querySelector('.scroll-top').classList.remove('active');
  }
}

/**
 * Scroll to top button
 */
document.querySelector('.scroll-top').addEventListener('click', (e) => {
  e.preventDefault();
  window.scrollTo({
    top: 0,
    behavior: 'smooth'
  });
});

/**
 * Add a margin to erach skill
*/
function adjustSkills(category) {
  for (let index = 0; index < document.getElementById(category).children[0].children[0].children.length; index++) {
    document.getElementById(category).children[0].children[0].children[index].classList.add("m-1");
  }
}

/**
 * Open the email client with the correct parameters
 */
function sendEmail() {
  if (document.getElementsByName('message')[0].value.length !== 0) {
    window.location.href = `mailto:bourgault.olivier8501@gmail.com&subject=Contact de ${document.getElementsByName('name')[0].value} pour ${document.getElementsByName('subject')[0].value.toLowerCase()}&body=${document.getElementsByName('message')[0].value}`;
  }
}

/**
 * Return the difference between two dates
 */
function diffDate(date1, date2) {
  return Math.abs(Math.round((((date2.getTime() - date1.getTime()) / 1000) / 86400) / 365.25));
}

/**
 * Retrieve the data from Github
 */
async function getData(url) {
  try {
    const response = await fetch(url);

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const data = await response.json();

    if (!url.includes("?")) {
      displayData(url.substring((url.indexOf("github.com/") + 11)), data);
    } else {
      if (document.getElementById("projects").innerHTML.length !== 0) {
        data.forEach(projects => {
          if (projects.type === "dir") {
            document.getElementById("projects").innerHTML = parseInt(document.getElementById("projects").innerHTML) + 1;
          }
        });
      }
      document.getElementById("projects").innerHTML = parseInt(document.getElementById("projects").innerHTML);
    }

  } catch (error) {
    console.error('There was an error!', error);
  }
}