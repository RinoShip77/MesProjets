// Loader
setTimeout(() => {
  document.getElementById("spinner").style.display = "none";
  document.getElementById("page").style.display = "block";
  document.getElementById("page").style.background = "var(--blank)";

  adjustThemeSwitcher();
}, 1000);

// Scroll animation
const fadeElements = document.querySelectorAll(".fade-up");

const observer = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("active");
      }
    });
  },
  { threshold: 0.1 }
);

fadeElements.forEach((element) => {
  observer.observe(element);
});

// Header scroll effect
window.addEventListener("scroll", () => {
  const header = document.querySelector("header");
  const nav = document.getElementById("navbar");

  if (window.scrollY > 60) {
    header.style.padding = "10px 0";
    header.style.boxShadow = "0 5px 20px rgba(0, 0, 0, 0.1)";
    nav.style.animation = "fadeUp .25s ease forwards";
    nav.style.display = "block";
    nav.style.display = "flex";
  } else {
    header.style.padding = "20px 0";
    header.style.boxShadow = "0 2px 20px rgba(0, 0, 0, 0.1)";
    nav.style.animation = "fadeDown .1s ease forwards";
    nav.style.display = "none";
  }
});

// Form animation
const formInputs = document.querySelectorAll(".form-input, .form-textarea");

formInputs.forEach((input) => {
  input.addEventListener("focus", () => {
    input.parentElement.classList.add("active");
  });

  input.addEventListener("blur", () => {
    if (input.value === "") {
      input.parentElement.classList.remove("active");
    }
  });
});

// Set up social media links
const socialLinks = {
  Linkedin: "https://www.linkedin.com/in/olivier-bourgault-5b950428a",
  Github: "https://github.com/RinoShip77/MesProjets",
};

// Update social media links to open in new tab
document.querySelectorAll(".social-link").forEach((link, index) => {
  const platform = Object.keys(socialLinks)[index];
  link.href = socialLinks[platform];
  link.target = "_blank";
  link.rel = "noopener noreferrer";
  link.setAttribute("aria-label", `Visit ${platform} profile`);
});

// Handle contact form submission
document
  .querySelector(".contact-form")
  .addEventListener("submit", function (e) {
    e.preventDefault();

    const name = document.getElementById("name").value;
    const email = document.getElementById("email").value;
    const subject = document.getElementById("subject").value;
    const message = document.getElementById("message").value;

    // Here you would typically send the form data to a server
    // For now, we'll just log it and show a success message
    console.log("Form submitted:", { name, email, subject, message });

    // Create success message
    const successMessage = document.createElement("div");
    successMessage.textContent = `Merci ${name}! Votre message a été envoyé vers votre appliucation de courriel par défault.`;
    successMessage.style.color = "#4e54c8";
    successMessage.style.padding = "15px";
    successMessage.style.marginTop = "20px";
    successMessage.style.backgroundColor = "rgba(78, 84, 200, 0.1)";
    successMessage.style.borderRadius = "10px";
    successMessage.style.textAlign = "center";

    // Clear form
    this.reset();

    // Add success message to form
    this.appendChild(successMessage);

    // Remove success message after 5 seconds
    setTimeout(() => {
      successMessage.remove();
    }, 5000);

    // Send the email
    window.location.href = `mailto:${email}&subject=Contact de ${name} pour ${subject.toLowerCase()}&body=${message}`;
  });

// Ensure images take up their entire container
document.addEventListener("DOMContentLoaded", () => {
  // Fix hero image
  const heroImage = document.querySelector(".hero-image img");
  if (heroImage) {
    heroImage.style.width = "100%";
    heroImage.style.height = "100%";
    heroImage.style.objectFit = "cover";
    heroImage.style.objectPosition = "center";
  }

  // Fix about image
  const aboutImage = document.querySelector(".about-image img");
  if (aboutImage) {
    aboutImage.style.width = "100%";
    aboutImage.style.height = "100%";
    aboutImage.style.objectFit = "cover";
    aboutImage.style.objectPosition = "center";
  }

  // Fix portfolio images
  const portfolioImages = document.querySelectorAll(".portfolio-image img");
  portfolioImages.forEach((img) => {
    img.style.width = "100%";
    img.style.height = "100%";
    img.style.objectFit = "cover";
    img.style.objectPosition = "center";
  });

  // Make sure portfolio items have consistent height
  const portfolioItems = document.querySelectorAll(".portfolio-item");
  portfolioItems.forEach((item) => {
    const image = item.querySelector(".portfolio-image");
    if (image) {
      image.style.height = "250px"; // Ensure consistent height
    }
  });

  // Fix any other images in the document
  const allImages = document.querySelectorAll("img");
  allImages.forEach((img) => {
    if (!img.style.objectFit) {
      img.style.maxWidth = "100%";
      img.style.objectFit = "cover";
    }
  });

  // Update copyright
  let date = new Date();
  document.getElementsByClassName(
    "footer-text"
  )[0].innerHTML = `© ${date.getFullYear()} Olivier Bourgault`;

  // Update theme switcher position
  adjustThemeSwitcher();
});

// Adjust image sizes on window resize
window.addEventListener("resize", () => {
  const portfolioItems = document.querySelectorAll(".portfolio-item");
  portfolioItems.forEach((item) => {
    const image = item.querySelector(".portfolio-image");
    if (image) {
      image.style.height = "250px"; // Maintain consistent height on resize
    }
  });

  adjustThemeSwitcher();
});

let mybutton = document.getElementById("topBtn");

// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function () {
  scrollFunction();
};

function scrollFunction() {
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}

// Adjust theme switcher position
function adjustThemeSwitcher() {
  setTimeout(() => {
    document.getElementById("nightowl-switcher-default").style.left =
      "calc(-75px + 100vw)";

    let height =
      (document.getElementById("header").clientHeight -
        document.getElementById("nightowl-switcher-default").clientHeight) /
      2;
    document.getElementById("nightowl-switcher-default").style.top = height;
  }, 50);
}