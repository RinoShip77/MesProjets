const initQuizData = [
    {
        question: "What is the capital of France?",
        a: "Berlin",
        b: "Madrid",
        c: "Paris",
        d: "Lisbon",
        correct: "c"
    },
    {
        question: "Who is the CEO of Tesla?",
        a: "Jeff Bezos",
        b: "Elon Musk",
        c: "Bill Gates",
        d: "Tony Stark",
        correct: "b"
    },
    {
        question: "What is the largest planet in our solar system?",
        a: "Earth",
        b: "Mars",
        c: "Jupiter",
        d: "Saturn",
        correct: "c"
    },
    {
        question: "What year did the Titanic sink?",
        a: "1912",
        b: "1905",
        c: "1918",
        d: "1925",
        correct: "a"
    },
    {
        question: "What is the smallest country in the world?",
        a: " Monaco",
        b: " Vatican City",
        c: " San Marino",
        d: " Liechtenstein",
        correct: "b",
    },
    {
        question: "Who wrote the play “Romeo and Juliet”?",
        a: " William Shakespeare",
        b: " Charles Dickens",
        c: " Mark Twain",
        d: " Jane Austen",
        correct: "a",
    },
    {
        question: "What is the chemical symbol for gold?",
        a: " Au",
        b: " Ag",
        c: " Pb",
        d: " Fe",
        correct: "a",
    },
    {
        question: "What planet is known as the Red Planet?",
        a: " Venus",
        b: " Mars",
        c: " Jupiter",
        d: " Saturn",
        correct: "b",
    },
    {
        question: "Who was the first President of the United States?",
        a: " Thomas Jefferson",
        b: " Abraham Lincoln",
        c: " George Washington",
        d: " John Adams",
        correct: "c",
    },
    {
        question: "In which year did the Berlin Wall fall?",
        a: " 1987",
        b: " 1989",
        c: " 1991",
        d: " 1993",
        correct: "b",
    },
    {
        question: "Which river is the longest in the world?",
        a: " Amazon River",
        b: " Nile River",
        c: " Yangtze River",
        d: " Mississippi River",
        correct: "b",
    },
    {
        question: "What is the capital city of Australia?",
        a: " Sydney",
        b: " Melbourne",
        c: " Canberra",
        d: " Brisbane",
        correct: "c",
    },
    {
        question: "Who is the author of “1984”?",
        a: " George Orwell",
        b: " Aldous Huxley",
        c: " J.K. Rowling",
        d: " Ernest Hemingway",
        correct: "a",
    },
    {
        question: "What is the largest mammal in the world?",
        a: "Elephant",
        b: "Blue Whale",
        c: "Giraffe",
        d: "Hippopotamus",
        correct: "b"
    },
    {
        question: "Which element has the atomic number 1?",
        a: "Helium",
        b: "Oxygen",
        c: "Hydrogen",
        d: "Carbon",
        correct: "c"
    },
    {
        question: "What is the hardest natural substance on Earth?",
        a: "Gold",
        b: "Iron",
        c: "Diamond",
        d: "Platinum",
        correct: "c"
    },
    {
        question: "Who painted the Mona Lisa?",
        a: "Vincent van Gogh",
        b: "Pablo Picasso",
        c: "Leonardo da Vinci",
        d: "Claude Monet",
        correct: "c"
    },
    {
        question: "What is the capital of Japan?",
        a: "Kyoto",
        b: "Osaka",
        c: "Tokyo",
        d: "Hiroshima",
        correct: "c"
    }
];

function shuffle(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
}

const quizData = shuffle(initQuizData);
const quiz = document.getElementById('quiz');
const submitBtn = document.getElementById('submit');
const nextBtn = document.getElementById('next');
const results = document.getElementById('results');
const timerContainer = document.createElement('span');
timerContainer.id = 'timer';
timerContainer.innerHTML = 'Time left: <span id="time">30</span> seconds';
quiz.parentNode.insertBefore(timerContainer, quiz);
const progressContainer = document.createElement('div');
progressContainer.className = 'progress-container';
const progressBar = document.createElement('div');
progressBar.className = 'progress-bar';
progressContainer.appendChild(progressBar);
timerContainer.parentNode.insertBefore(progressContainer, timerContainer);

let currentQuiz = localStorage.getItem('currentQuiz') ? parseInt(localStorage.getItem('currentQuiz')) : 0;
let score = localStorage.getItem('score') ? parseInt(localStorage.getItem('score')) : 0;
let timer;
let timeLeft = 30; // Set the time limit for each question

loadQuiz();

function loadQuiz() {
    loadAudio();
    const currentQuizData = quizData[currentQuiz];
    quiz.innerHTML = `
        <div class="quiz-question">${currentQuizData.question} (${currentQuiz + 1}/${quizData.length})</div>
        <label class="option">
        <input type="radio" name="answer" value="a">
        ${currentQuizData.a}
        </label>
        <label class="option">
        <input type="radio" name="answer" value="b">
        ${currentQuizData.b}
        </label>
        <label class="option">
        <input type="radio" name="answer" value="c">
        ${currentQuizData.c}
        </label>
        <label class="option">
        <input type="radio" name="answer" value="d">
        ${currentQuizData.d}
        </label>
        `;
    quiz.classList.add('fade-in');
    updateProgressBar();
    nextBtn.style.display = 'none';
    submitBtn.style.display = 'inline-block';
    startTimer();
}

function moveToNextQuestion() {
    loadAudio();
    currentQuiz++;
    localStorage.setItem('currentQuiz', currentQuiz);
    if (currentQuiz < quizData.length) {
        quiz.classList.remove('fade-in');
        setTimeout(() => {
            loadQuiz();
        }, 300);
    } else {
        submitBtn.disabled = true;
        nextBtn.disabled = true;
        results.classList.add('bounce');
        localStorage.removeItem('currentQuiz');
        localStorage.removeItem('score');

        switch (score) {
            case 1:
                results.innerHTML = `You scored ${score} out of ${quizData.length}<i class="fa-solid fa-face-frown-open"></i>`;
            case 2:
                results.innerHTML = `You scored ${score} out of ${quizData.length}<i class="fa-solid fa-face-meh"></i>`;
            case 3:
                results.innerHTML = `You scored ${score} out of ${quizData.length}<i class="fa-solid fa-face-smile-beam"></i>`;
            case 4:
                results.innerHTML = `You scored ${score} out of ${quizData.length}<i class="fa-solid fa-face-laugh-beam"></i>`;
        }

        nextBtn.remove();
        document.getElementById('retry').style.display = 'inline-block';
    }
}

function startTimer() {
    timeLeft = 30; // Reset the timer for each question
    document.getElementById('time').textContent = timeLeft;
    document.getElementById('time').style.animation = 'none';
    document.getElementById('timer').style.animation = 'none';
    setTimeout(() => {
        document.getElementById('time').style.animation = ''; // Restart animation
    }, 10);
    timer = setInterval(() => {
        timeLeft--;
        document.getElementById('time').textContent = timeLeft;
        if (timeLeft <= 10) {
            if(timeLeft <= 3) {
                document.getElementById('timer').style.backgroundColor = '#f7cccc';
                document.getElementById('timer').style.animation = 'none';
            } else {
                document.getElementById('timer').style.animation = '';
            }
        }
        if (timeLeft <= 0) {
            clearInterval(timer);
            moveToNextQuestion();
        }
    }, 1000);
}

function updateProgressBar() {
    const progressPercentage = ((currentQuiz + 1) / quizData.length) * 100;
    progressBar.style.width = `${progressPercentage - 2.5}%`;
}

function loadAudio() {
    let music = document.getElementById('music')
    music.controls = true;
    music.load();
}

submitBtn.addEventListener('click', () => {
    clearInterval(timer);
    const answer = document.querySelector('input[name="answer"]:checked');
    if (answer) {
        const correctAnswer = quizData[currentQuiz].correct;
        const labels = quiz.querySelectorAll('label');
        labels.forEach(label => {
            if (label.querySelector('input').value === correctAnswer) {
                label.classList.add('correct-answer', 'fade-in');
                label.innerHTML += ' <i class="fas fa-circle-check"></i>';
            } else if (label.querySelector('input').value === answer.value) {
                label.classList.add('incorrect-answer', 'fade-in');
                label.innerHTML += ' <i class="fas fa-circle-xmark"></i>';
            }
        });
        if (answer.value === correctAnswer) {
            score++;
        }
        localStorage.setItem('score', score);
        submitBtn.style.display = 'none';
        nextBtn.style.display = 'inline-block';
    }
});

nextBtn.addEventListener('click', () => {
    clearInterval(timer);
    moveToNextQuestion();
});