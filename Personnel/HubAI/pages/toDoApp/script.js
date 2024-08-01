document.getElementById('addTaskBtn').addEventListener('click', addTask);
document.getElementById('toggleThemeBtn').addEventListener('click', toggleTheme);
document.getElementById('sortOptions').addEventListener('change', sortTasks);
document.getElementById('searchInput').addEventListener('input', filterTasks);
document.getElementById('exportTasksBtn').addEventListener('click', exportTasks);
document.getElementById('importTasksInput').addEventListener('change', importTasks);
document.getElementById('themeOptions').addEventListener('change', changeTheme);

function addTask() {
   const taskInput = document.getElementById('taskInput');
   const dueDateInput = document.getElementById('dueDateInput');
   const priorityInput = document.getElementById('priorityInput');
   const taskText = taskInput.value.trim();
   const dueDate = dueDateInput.value;
   const priority = priorityInput.value;

   if (taskText !== '') {
      const taskList = document.getElementById('taskList');
      const li = document.createElement('li');

      li.innerHTML = `
            <span>${taskText} (Due: ${dueDate}, Priority: ${priority})</span>
            <button class="deleteBtn">Delete</button>
            <button class="addSubtaskBtn">Add Subtask</button>
            <ul class="subtaskList"></ul>
        `;

      li.dataset.name = taskText;
      li.dataset.dueDate = dueDate;
      li.dataset.priority = priority;
      li.dataset.completed = false;

      li.addEventListener('click', function () {
         li.classList.toggle('completed');
         li.dataset.completed = li.classList.contains('completed');
         saveTasks();
      });

      li.querySelector('.deleteBtn').addEventListener('click', function () {
         taskList.removeChild(li);
         saveTasks();
      });

      li.querySelector('.addSubtaskBtn').addEventListener('click', function () {
         addSubtask(li);
      });

      taskList.appendChild(li);
      taskInput.value = '';
      dueDateInput.value = '';
      priorityInput.value = 'low';

      saveTasks();
      checkReminders();
   }
}

function addSubtask(taskElement) {
   const subtaskInput = document.createElement('input');
   subtaskInput.type = 'text';
   subtaskInput.placeholder = 'Add a subtask...';
   subtaskInput.className = 'subtaskInput';

   const subtaskList = taskElement.querySelector('.subtaskList');
   subtaskList.appendChild(subtaskInput);

   subtaskInput.addEventListener('keypress', function (event) {
      if (event.key === 'Enter') {
         const subtaskText = subtaskInput.value.trim();
         if (subtaskText !== '') {
            const subtask = document.createElement('li');
            subtask.className = 'subtask';
            subtask.innerHTML = `
                    <span>${subtaskText}</span>
                    <button class="deleteBtn">Delete</button>
                `;

            subtask.querySelector('.deleteBtn').addEventListener('click', function () {
               subtaskList.removeChild(subtask);
               saveTasks();
            });

            subtaskList.appendChild(subtask);
            subtaskInput.value = '';

            saveTasks();
         }
      }
   });
}

function toggleTheme() {
   document.body.classList.toggle('dark');
   localStorage.setItem('theme', document.body.classList.contains('dark') ? 'dark' : 'light');
}

function sortTasks() {
   const sortOption = document.getElementById('sortOptions').value;
   const taskList = document.getElementById('taskList');
   const tasks = Array.from(taskList.children);

   tasks.sort((a, b) => {
      if (sortOption === 'name') {
         return a.dataset.name.localeCompare(b.dataset.name);
      } else if (sortOption === 'status') {
         return a.dataset.completed - b.dataset.completed;
      } else if (sortOption === 'dueDate') {
         return new Date(a.dataset.dueDate) - new Date(b.dataset.dueDate);
      } else if (sortOption === 'priority') {
         const priorities = { low: 1, medium: 2, high: 3 };
         return priorities[a.dataset.priority] - priorities[b.dataset.priority];
      }
   });

   tasks.forEach(task => taskList.appendChild(task));
}

function filterTasks() {
   const searchQuery = document.getElementById('searchInput').value.toLowerCase();
   const taskList = document.getElementById('taskList');
   const tasks = Array.from(taskList.children);

   tasks.forEach(task => {
      const taskText = task.dataset.name.toLowerCase();
      if (taskText.includes(searchQuery)) {
         task.style.display = '';
      } else {
         task.style.display = 'none';
      }
   });
}

function checkReminders() {
   const taskList = document.getElementById('taskList');
   const tasks = Array.from(taskList.children);
   const reminderContainer = document.getElementById('reminderContainer');
   reminderContainer.innerHTML = '';

   const today = new Date().toISOString().split('T')[0];

   tasks.forEach(task => {
      const dueDate = task.dataset.dueDate;
      if (dueDate && dueDate <= today && !task.dataset.completed) {
         const reminder = document.createElement('div');
         reminder.className = 'reminder';
         reminder.textContent = `Reminder: Task "${task.dataset.name}" is due today or overdue!`;
         reminderContainer.appendChild(reminder);
      }
   });

   reminderContainer.style.display = reminderContainer.children.length > 0 ? 'block' : 'none';
}

function saveTasks() {
   const taskList = document.getElementById('taskList');
   const tasks = Array.from(taskList.children);
   const taskData = tasks.map(task => {
      const subtasks = Array.from(task.querySelector('.subtaskList').children).map(subtask => ({
         text: subtask.querySelector('span').textContent,
         completed: subtask.classList.contains('completed')
      }));
      return {
         name: task.dataset.name,
         dueDate: task.dataset.dueDate,
         priority: task.dataset.priority,
         completed: task.dataset.completed === 'true',
         subtasks: subtasks
      };
   });
   localStorage.setItem('tasks', JSON.stringify(taskData));
}

function loadTasks() {
   const taskData = JSON.parse(localStorage.getItem('tasks')) || [];
   const taskList = document.getElementById('taskList');
   taskList.innerHTML = '';

   taskData.forEach(task => {
      const li = document.createElement('li');

      li.innerHTML = `
            <span>${task.name} (Due: ${task.dueDate}, Priority: ${task.priority})</span>
            <button class="deleteBtn">Delete</button>
            <button class="addSubtaskBtn">Add Subtask</button>
            <ul class="subtaskList"></ul>
        `;

      li.dataset.name = task.name;
      li.dataset.dueDate = task.dueDate;
      li.dataset.priority = task.priority;
      li.dataset.completed = task.completed;

      if (task.completed) {
         li.classList.add('completed');
      }

      li.addEventListener('click', function () {
         li.classList.toggle('completed');
         li.dataset.completed = li.classList.contains('completed');
         saveTasks();
      });

      li.querySelector('.deleteBtn').addEventListener('click', function () {
         taskList.removeChild(li);
         saveTasks();
      });

      li.querySelector('.addSubtaskBtn').addEventListener('click', function () {
         addSubtask(li);
      });

      const subtaskList = li.querySelector('.subtaskList');
      task.subtasks.forEach(subtask => {
         const subtaskLi = document.createElement('li');
         subtaskLi.className = 'subtask';
         subtaskLi.innerHTML = `
                <span>${subtask.text}</span>
                <button class="deleteBtn">Delete</button>
            `;

         if (subtask.completed) {
            subtaskLi.classList.add('completed');
         }

         subtaskLi.querySelector('.deleteBtn').addEventListener('click', function () {
            subtaskList.removeChild(subtaskLi);
            saveTasks();
         });

         subtaskList.appendChild(subtaskLi);
      });

      taskList.appendChild(li);
   });
}

function changeTheme() {
   const theme = document.getElementById('themeOptions').value;
   document.body.className = theme;
   localStorage.setItem('theme', theme);
}

function loadTheme() {
   const theme = localStorage.getItem('theme') || 'default';
   document.body.className = theme;
}

// function loadTheme() {
//     const theme = localStorage.getItem('theme');
//     if (theme === 'dark') {
//         document.body.classList.add('dark');
//     }
// }

function exportTasks() {
   const taskData = JSON.parse(localStorage.getItem('tasks')) || [];
   const dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(taskData));
   const downloadAnchorNode = document.createElement('a');
   downloadAnchorNode.setAttribute("href", dataStr);
   downloadAnchorNode.setAttribute("download", "tasks.json");
   document.body.appendChild(downloadAnchorNode);
   downloadAnchorNode.click();
   downloadAnchorNode.remove();
}

function importTasks(event) {
   const file = event.target.files[0];
   if (file) {
       const reader = new FileReader();
       reader.onload = function(e) {
           const tasks = JSON.parse(e.target.result);
           localStorage.setItem('tasks', JSON.stringify(tasks));
           loadTasks();
           checkReminders();
       };
       reader.readAsText(file);
   }
}

// Load tasks and theme on page load
loadTasks();
loadTheme();
checkReminders();
